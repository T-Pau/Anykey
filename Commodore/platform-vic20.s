.autoimport +
.macpack utility
.include "platform.inc"

.export charset

.export display_help_screen, display_main_screen, reset_keyboard

POSITION_LEFT = 12
POSITION_RIGHT = 13

.segment "CODE_LOW"

display_help_screen:
    rts

display_main_screen:
    ldx #12
    stx $9000
    store_word main_screen, ptr1
    store_word screen, ptr2
    jsr rl_expand
    store_word main_color, ptr1
    store_word color_ram, ptr2
    jsr rl_expand
    ldx #<main_vic20_irq_table
    ldy #>main_vic20_irq_table
    lda main_vic20_irq_table_length
    jsr set_irq_table
    jsr init_restore
    rts

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
    rts

.code

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
:
    rts

reset_keyboard:
    rts


.segment "CHARSET"

charset:
	.incbin "charset-vic20.bin"

.rodata

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

.bss

.export nmi_vector
nmi_vector:
    .res 2
