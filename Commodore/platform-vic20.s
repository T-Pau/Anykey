.autoimport +
.macpack utility
;.include "platform.inc"
.include "defines.inc"


POSITION_LEFT = 12
POSITION_RIGHT = 13

DPAD_OFFSET = 15 * 22 + 7
BUTTONS_OFFSET = DPAD_OFFSET + 22 + 3

KEYBOARD_OFFSET = 22 * 2
KEYBOARD_SIZE = 22 * 10

.segment "CODE_LOW"

.export display_main_screen
display_main_screen:
.scope
    ldx is_ntsc
    beq pal
    ldx #<main_ntsc_irq_table
    ldy #>main_ntsc_irq_table
    lda main_ntsc_irq_table_length
    bne both
pal:
    ldx #<main_pal_irq_table
    ldy #>main_pal_irq_table
    lda main_pal_irq_table_length
both:
    jsr set_irq_table
    ldx is_ntsc
    lda main_h_pos,x
    sta VIC_H_POS
    store_word main_screen, ptr1
    store_word screen, ptr2
    jsr rl_expand
    ldx #0
:   lda main_color_save,x
    sta color_ram,x
    lda main_color_save + 250,x
    sta color_ram + 250,x
    dex
    bne :-
    rts
.endscope

.export top_keyboard
top_keyboard:
.scope
    inc VIC_H_POS
    lda #SCREEN_TOP_PAL + 4 - 1
    jsr wait_line
    jsr wait_20
    nop
    nop
    ldx #(BACKGROUND_COLOR << 4) | $8 | FRAME_COLOR
    ldy #$cd
    stx VIC_COLOR
    sty VIC_VIDEO_ADR
    lda #SCREEN_TOP_PAL + 4 * 4 -1
    ldx VIC_H_POS
    ldy #2
shift_loop:
    dex
    jsr wait_line
    stx VIC_H_POS
    clc
    adc #8
    inx
    jsr wait_line
    stx VIC_H_POS
    clc
    adc #8
    dey
    bne shift_loop
    rts
.endscope

.export bottom_keyboard
bottom_keyboard:
    ldx #(LABEL_COLOR << 4) | FRAME_COLOR
    ldy #$cf
    lda #SCREEN_TOP_PAL + 4 * 13 - 1
    jsr wait_line
    stx VIC_COLOR
    sty VIC_VIDEO_ADR
    rts

.code

.export top_joystick
top_joystick:
    ldx #(BACKGROUND_COLOR << 4) | $8 | FRAME_COLOR
    ldy #$cd
    lda #SCREEN_TOP_PAL + 15 * 4 - 1
    jsr wait_line
    stx VIC_COLOR
    sty VIC_VIDEO_ADR
    jsr read_restore
    jsr read_joystick
    rts


; waits for 20 cycles
wait_20:
    nop
wait_18:
    nop
    nop
    nop
wait_12:
    rts

; waits for border of raster line a
wait_line:
    pha
    sec
    sbc hline_offset
:   cmp VIC_HLINE
    bne :-
    jsr wait_20
    jsr wait_20
    jsr wait_20
    jsr wait_18
    jsr wait_12
    lda is_ntsc
    beq :+
    jsr wait_18
:   pla
    rts

.export bottom_joystick
bottom_joystick:
    ldx #(LABEL_COLOR << 4) | FRAME_COLOR
    ldy #$cf
    lda #SCREEN_TOP_PAL + 19 * 4 - 1
    jsr wait_line
    stx VIC_COLOR
    sty VIC_VIDEO_ADR
    dec VIC_H_POS

    jsr read_restore

    ; TODO: move to keyboard skip code
  	lda #$ff
  	sta VIA2_DDRA
   	lda #$00
  	sta VIA2_DDRB

    lda #$ff
    sta VIA2_PA1
  	lda VIA2_PB
  	sta port_b

    jsr read_keyboard

    lda #$ff
    sta VIA2_PA1
    lda VIA2_PB
    and port_b
    and #$80
    bne no_skip

    lda key_state + $07
    sta new_key_state + $07
    lda key_state + $0f
    sta new_key_state + $0f
    lda key_state + $17
    sta new_key_state + $17
    lda key_state + $1f
    sta new_key_state + $1f
    lda key_state + $27
    sta new_key_state + $27
    lda key_state + $2f
    sta new_key_state + $2f
    lda key_state + $37
    sta new_key_state + $37
    lda key_state + $3f
    sta new_key_state + $3f

no_skip:
    jsr process_restore
	lda command
	bne :+
	ldx #0
	ldy num_keys
	jsr display_keyboard
	jsr process_command_keys
	jsr display_joystick
:
    rts

.export reset_keyboard
reset_keyboard:
.scope
    ; y runs from KEYBOARD_SIZE to 1, so offset address by -1
    ldy #KEYBOARD_SIZE + 1
loop:
    lda color_ram + KEYBOARD_OFFSET -1,y
    and #$0f
    cmp #CHECKED_COLOR
    bne :+
    lda #UNCHECKED_COLOR
    sta color_ram + KEYBOARD_OFFSET - 1,y
:   dey
    bne loop
    rts
.endscope

read_joystick:
    lda #$ff
    sta VIA2_DDRA
    sta VIA2_PA1
    lda #0
    sta VIA2_DDRB
    sta VIA1_DDRA
    lda VIA1_PA1
    lsr
    and #$1e
    eor #$1e
    tax
    lda VIA2_PB
    bmi :+
    inx
:   txa
    ldx VIC_POT_X
    bmi :+
    ora #$20
:   ldx VIC_POT_Y
    bmi :+
    ora #$40
:   sta joystick_value
    rts

display_joystick:
    lda joystick_value
    and #$0f
    asl
    tax
    lda dpad_vic20,x
    inx
    sta ptr1
    lda dpad_vic20,x
    sta ptr1 + 1
    store_word screen + DPAD_OFFSET, ptr2
    jsr rl_expand

    lda joystick_value
    and #$70
    lsr
    lsr
    lsr
    tax
    lda buttons_vic20,x
    inx
    sta ptr1
    lda buttons_vic20,x
    sta ptr1 + 1
    store_word screen + BUTTONS_OFFSET, ptr2
    jmp rl_expand


.export display_help_screen
display_help_screen:
    ; x runs from KEYBOARD_SIZE to 1, so offset address by -1
    ldx #KEYBOARD_SIZE + 1
:   lda color_ram + KEYBOARD_OFFSET - 1,x
    and #$0f
    sta main_color_save + KEYBOARD_OFFSET - 1,x
    dex
    bne :-

    ldx is_ntsc
    beq pal
    ldx #<help_ntsc_irq_table
    ldy #>help_ntsc_irq_table
    lda help_ntsc_irq_table_length
    bne both
pal:
    ldx #<help_pal_irq_table
    ldy #>help_pal_irq_table
    lda help_pal_irq_table_length
both:
    jsr set_irq_table

    store_word help_screen, ptr1
    store_word screen, ptr2
    jsr rl_expand
    lda #FRAME_COLOR
    ldy #0
:   sta color_ram,y
    sta color_ram + $100,y
    dey
    bne :-
    sty current_help_page
    jsr display_help_page
    rts

.export help_top
help_top:
    ldx #(BACKGROUND_COLOR << 4) | $8 | FRAME_COLOR
    lda #SCREEN_TOP_PAL + 4 - 1
    jsr wait_line
    stx VIC_COLOR
    ldy #$cf
    sty VIC_VIDEO_ADR
    rts

.export help_bottom
help_bottom:
    ldx #(LABEL_COLOR << 4) | FRAME_COLOR
    lda #SCREEN_TOP_PAL + 4 * 19 - 1
    jsr wait_line
    stx VIC_COLOR

    jsr read_keyboard
    lda command
    bne :+
    jsr handle_help_keys
:   rts


read_restore:
    lda VIA1_IFR
    and #$02
    beq :+
    jsr trigger_restore
:   rts


.segment "CHARSET"

charset:
	.incbin "charset-vic20.bin"

.rodata

.export main_color
main_color:
    .byte $ff, 22 * 2, FRAME_COLOR
    .byte $ff, 21, UNCHECKED_COLOR, FRAME_COLOR
    .byte $ff, 21, UNCHECKED_COLOR, FRAME_COLOR
    .byte FRAME_COLOR, $ff, 20, UNCHECKED_COLOR, FRAME_COLOR
    .byte FRAME_COLOR, $ff, 20, UNCHECKED_COLOR, FRAME_COLOR
    .byte $ff, 21, UNCHECKED_COLOR, FRAME_COLOR
    .byte $ff, 21, UNCHECKED_COLOR, FRAME_COLOR
    .byte FRAME_COLOR, $ff, 20, UNCHECKED_COLOR, FRAME_COLOR
    .byte FRAME_COLOR, $ff, 20, UNCHECKED_COLOR, FRAME_COLOR
    .byte $ff, 21, UNCHECKED_COLOR, FRAME_COLOR
    .byte $ff, 21, UNCHECKED_COLOR, FRAME_COLOR
    .byte $ff, 22 * 11, FRAME_COLOR
    .byte $ff, 0

.export help_keys
help_keys:
    .word help_keys_table

help_keys_table:
    .byte 4, COMMAND_HELP_NEXT ; space
    .byte 40, COMMAND_HELP_NEXT ; +
    .byte 47, COMMAND_HELP_PREVIOUS; -
    .byte 1, COMMAND_HELP_EXIT ; left arrow
    .byte $ff


main_h_pos:
    .byte 12, 4

.bss

port_b:
    .res 1

joystick_value:
    .res 1
