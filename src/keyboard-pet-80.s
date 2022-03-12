.autoimport +

.export reset_keyboard_80
.export keyboard_pet_business_80_screen, keyboard_pet_calculator_80_screen

.macpack utility

.include "defines.inc"

reset_keyboard_80:
.scope
	store_word screen + 80 * 2, ptr1
	ldx #0
	stx reset_row
	stx reset_leftright
row_loop:
	ldy #80
column_loop:
    dey
    bmi column_end
	lda (ptr1),y
	cmp #SQUARE_TOP_LEFT
	bne :+
	lda #ROUND_TOP_LEFT
	sta (ptr1),y
	bne column_loop
:	cmp #SQUARE_TOP_RIGHT
	bne :+
	lda #ROUND_TOP_RIGHT
	sta (ptr1),y
	bne column_loop
:	cmp #SQUARE_BOTTOM_LEFT
	bne :+
	lda #ROUND_BOTTOM_LEFT
	sta (ptr1),y
	bne column_loop
:	cmp #SQUARE_BOTTOM_RIGHT
	bne :+
	lda #ROUND_BOTTOM_RIGHT
	sta (ptr1),y
	bne column_loop
:	cmp #SQUARE_HORIZONTAL
    bne :+
    ldx reset_row
    lda reset_horizontal,x
    sta (ptr1),y
    bne column_loop
:	cmp #SQUARE_VERTICAL
    bne column_loop
    ldx reset_leftright
    lda reset_vertical,x
    sta (ptr1),y
    dex
    bpl :+
    ldx #1
:   stx reset_leftright
    bpl column_loop

column_end:
    ldx reset_row
    inx
    cpx #(5*3)
    bne :+
    rts
:   stx reset_row
    add_word ptr1, 80
    jmp row_loop
.endscope

.rodata

reset_horizontal:
    .byte ROUND_TOP, 0, ROUND_BOTTOM,  ROUND_TOP, 0, ROUND_BOTTOM,  ROUND_TOP, 0, ROUND_BOTTOM,  ROUND_TOP, 0, ROUND_BOTTOM,  ROUND_TOP, 0, ROUND_BOTTOM

reset_vertical:
    .byte ROUND_RIGHT, ROUND_LEFT

.bss

reset_leftright:
    .res 1

.rodata

keyboard_pet_business_80_screen:
	.incbin "keyboard-pet-business-80.bin"

keyboard_pet_calculator_80_screen:
	.incbin "keyboard-pet-calculator-80.bin"
