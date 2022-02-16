.export keyboard_pet_screen, reset_keyboard

.macpack utility

.include "defines.inc"

.rodata

keyboard_pet_screen:
	.incbin "keyboard-pet.bin"

.code

reset_keyboard:
.scope
	; make all non-inverted square corners round
	store_word screen + 80 * 2, ptr1
	ldx #5
row_loop:
	ldy #0
top_loop:
	lda (ptr1),y
	cmp #SQUARE_TOP_LEFT
	bne :+
	lda #ROUND_TOP_LEFT
	sta (ptr1),y
:	iny
	iny
	iny
	lda (ptr1),y
	cmp #SQUARE_TOP_RIGHT
	bne :+
	lda #ROUND_TOP_RIGHT
	sta (ptr1),y
	cpy #80
	bne top_loop
	ldy #160
bottom_loop:
	lda (ptr1),y
	cmp #SQUARE_BOTTOM_LEFT
	bne :+
	lda #ROUND_BOTTOM_LEFT
	sta (ptr1),y
:	iny
	iny
	iny
	lda (ptr1),y
	cmp #SQUARE_BOTTOM_RIGHT
	bne :+
	lda #ROUND_BOTTOM_LEFT
	sta (ptr1),y
:	cpy #240
	bne bottom_loop
	tya
	clc
	adc_16 ptr1
	dex
	bpl row_loop
	rts
.endscope
