.autoimport +

.export reset_keyboard_40, reset_row
.export keyboard_pet_business_40_screen, keyboard_pet_calculator_40_screen, keyboard_pet_graphics_40_screen

.macpack utility

.include "defines.inc"

.rodata

keyboard_pet_business_40_screen:
    .incbin "keyboard-pet-business-40.bin"

keyboard_pet_calculator_40_screen:
    .incbin "keyboard-pet-calculator-40.bin"

keyboard_pet_graphics_40_screen:
    .incbin "keyboard-pet-graphics-40.bin"

.code

reset_keyboard_40:
.scope
	store_word screen + 40 * 2, ptr1
	lda left_list
	sta ptr2
	lda left_list + 1
	sta ptr2 + 1
    ldy #0
    ldx #0
left_loop:
    lda (ptr2,x)
    beq left_done
    tya
    clc
    adc (ptr2,x)
    bcc :+
    inc ptr1 + 1
:   tay
    lda (ptr1),y
    cmp #SQUARE_VERTICAL
    bne :+
    lda #ROUND_LEFT
    sta (ptr1),y
:   inc_16 ptr2
    bne left_loop
left_done:

	store_word screen + 40 * 2, ptr1
	ldx #0
	stx reset_row
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
    bne not_horizontal
    lda #ROUND_BOTTOM
    ldx reset_row
    bne :+
    lda #ROUND_TOP
:   sta (ptr1),y
    bne column_loop
not_horizontal:
	cmp #SQUARE_VERTICAL
    bne column_loop
    lda #ROUND_RIGHT
    sta (ptr1),y
    bpl column_loop

column_end:
    ldx reset_row
    inx
    cpx #(5*3)
    bne :+
    rts
:   stx reset_row
    add_word ptr1, 40
    jmp row_loop
.endscope

.bss

reset_row:
    .res 1
