.export keyboard_pet_business_40_screen, keyboard_pet_calculator_40_screen, keyboard_pet_graphics_40_screen, reset_keyboard

.macpack utility

.include "defines.inc"

.rodata

keyboard_pet_business_40_screen:
    ;.incbin "keyboard-pet-business-40.bin"

keyboard_pet_calculator_40_screen:
    .incbin "keyboard-pet-calculator-40.bin"

keyboard_pet_graphics_40_screen:
    ;.incbin "keyboard-pet-graphics-40.bin"

.code

reset_keyboard:
.scope
	; make all non-inverted square corners round
	; TODO: also restore horizontal/vertical lines
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

reset_row:
    .res 1

reset_leftright:
    .res 1
