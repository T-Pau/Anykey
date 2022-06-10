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
    ldx #12
    stx $9000
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
    ldx #<main_vic20_irq_table
    ldy #>main_vic20_irq_table
    lda main_vic20_irq_table_length
    jsr set_irq_table
    jsr init_restore
    rts

.export top_keyboard
top_keyboard:
.scope
    inc $9000
    lda #SCREEN_TOP + 4 - 1
    jsr wait_line
    jsr wait_20
    ldx #(BACKGROUND_COLOR << 4) | $8 | FRAME_COLOR
    ldy #$cd
    stx VIC_COLOR
    sty $9005
    lda #SCREEN_TOP + 4 * 4 -1
    ldx $9000
    ldy #2
shift_loop:
    dex
    jsr wait_line
    stx $9000
    clc
    adc #8
    inx
    jsr wait_line
    stx $9000
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
    lda #SCREEN_TOP + 4 * 13 - 1
    jsr wait_line
    stx VIC_COLOR
    sty $9005
    rts

.export top_joystick
top_joystick:
    ldx #(BACKGROUND_COLOR << 4) | $8 | FRAME_COLOR
    ldy #$cd
    lda #SCREEN_TOP + 15 * 4 - 1
    jsr wait_line
    stx VIC_COLOR
    sty $9005
    jsr read_joystick
    rts

.code

; waits for 20 cycles
wait_20:
    nop
    nop
    nop
    nop
    rts

; waits for border of raster line a
wait_line:
:   cmp VIC_HLINE
    bne :-
    jsr wait_20
    jsr wait_20
    jsr wait_20
    jsr wait_20
    jsr wait_20
    rts

.export bottom_joystick
bottom_joystick:
    ldx #(LABEL_COLOR << 4) | FRAME_COLOR
    ldy #$cf
    lda #SCREEN_TOP + 19 * 4 - 1
    jsr wait_line
    stx VIC_COLOR
    sty $9005
    dec $9000

    ; TODO: move to keyboard skip code
  	lda #$ff
  	sta VIA2_DDRA
;  	sta VIA2_DDRB
   	lda #$00
  	sta VIA2_DDRB
;  	sta VIA2_DDRA

    jsr read_keyboard
    jsr read_restore
	lda command
	bne :+
	jsr display_keyboard
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
    ldx $9008
    bpl :+
    ora #$20
:   ldx $9009
    bpl :+
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
    ldx #<help_vic20_irq_table
    ldy #>help_vic20_irq_table
    lda help_vic20_irq_table_length
    jsr set_irq_table
    rts

.export help_top
help_top:
    lda #SCREEN_TOP + 4 - 1
    jsr wait_line
    ldx #(BACKGROUND_COLOR << 4) | $8 | FRAME_COLOR
    stx VIC_COLOR
    rts

.export help_bottom
help_bottom:
    lda #SCREEN_TOP + 4 * 19 - 1
    jsr wait_line
    ldx #(LABEL_COLOR << 4) | FRAME_COLOR
    stx VIC_COLOR

    jsr read_keyboard
    jsr handle_help_keys
    rts


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
    .byte 32, COMMAND_HELP_NEXT ; +
    .byte 47, COMMAND_HELP_PREVIOUS; -
    .byte 1, COMMAND_HELP_EXIT ; left arrow
    .byte $ff

.bss

.export nmi_vector
nmi_vector:
    .res 2

joystick_value:
    .res 1
