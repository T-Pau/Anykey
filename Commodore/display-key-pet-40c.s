;  display-key-pet.s -- Display current_key_state of key, PET version
;  Copyright (C) 2022 Dieter Baron
;
;  This file is part of Anykey, a keyboard test program for C64.
;  The authors can be contacted at <anykey@tpau.group>.
;
;  Redistribution and use in source and binary forms, with or without
;  modification, are permitted provided that the following conditions
;  are met:
;  1. Redistributions of source code must retain the above copyright
;     notice, this list of conditions and the following disclaimer.
;  2. The names of the authors may not be used to endorse or promote
;     products derived from this software without specific prior
;     written permission.
;
;  THIS SOFTWARE IS PROVIDED BY THE AUTHORS ``AS IS'' AND ANY EXPRESS
;  OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
;  WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
;  ARE DISCLAIMED.  IN NO EVENT SHALL THE AUTHORS BE LIABLE FOR ANY
;  DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
;  DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE
;  GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
;  INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER
;  IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR
;  OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN
;  IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

.autoimport +

.export display_key_s
.export display_key_40_full, display_key_40_top, display_key_40_left, display_key_40_mid
.export display_key_40_mid_3, display_key_40c_ret

.export char_top_left, char_top, char_top_right, char_left, char_right, char_bottom_left, char_bottom, char_bottom_right

.macpack utility

.include "defines.inc"

; display keys of various sizes
; ptr1 points to char_top left character in screen
; x is 0 for unpressed, 1 for pressed
; current_key_state is $00 for unpressed, $80 for pressed

.rodata

char_top_left:
	.byte SQUARE_TOP_LEFT, PRESSED_TOP_LEFT
char_top:
	.byte SQUARE_HORIZONTAL, PRESSED_TOP
char_top_right:
	.byte SQUARE_TOP_RIGHT, PRESSED_TOP_RIGHT
char_left:
	.byte SQUARE_VERTICAL, PRESSED_LEFT
char_right:
	.byte SQUARE_VERTICAL, PRESSED_RIGHT
char_bottom_left:
	.byte SQUARE_BOTTOM_LEFT, PRESSED_BOTTOM_LEFT
char_bottom:
	.byte SQUARE_HORIZONTAL, PRESSED_BOTTOM
char_bottom_right:
	.byte SQUARE_BOTTOM_RIGHT, PRESSED_BOTTOM_RIGHT


.code

display_key_s:
	rts

display_key_40_full:
	lda char_top_left,x
	sta (ptr1),y
	iny
	lda char_top,x
	sta (ptr1),y
	iny
	lda char_top_right,x
	sta (ptr1),y

	clc
	lda #40
	adc_16 ptr1
	ldy #0
display_key_40_left:
	lda char_left,x
	sta (ptr1),y
	iny
	lda (ptr1),y
	and #$7f
	ora current_key_state
	sta (ptr1),y
	iny
	lda char_right,x
	sta (ptr1),y

	ldy #40
	lda char_bottom_left,x
	sta (ptr1),y
	iny
	lda char_bottom,x
	sta (ptr1),y
	iny
	lda char_bottom_right,x
	sta (ptr1),y
	rts


display_key_40_top:
	lda char_top,x
	sta (ptr1),y
	iny
	lda char_top_right,x
	sta (ptr1),y

	clc
	lda #40
	adc_16 ptr1
	dey
display_key_40_mid:
	lda (ptr1),y
	and #$7f
	ora current_key_state
	sta (ptr1),y
	iny
	lda char_right,x
	sta (ptr1),y

	ldy #40
	lda char_bottom,x
	sta (ptr1),y
	iny
	lda char_bottom_right,x
	sta (ptr1),y
	rts

display_key_40_mid_3:
:	lda (ptr1),y
	and #$7f
	ora current_key_state
	sta (ptr1),y
	iny
	cpy #3
	bne :-
	lda char_right,x
	sta (ptr1),y

	ldy #40
:	lda char_bottom,x
	sta (ptr1),y
	iny
	cpy #43
	bne :-
	lda char_bottom_right,x
	sta (ptr1),y
	rts

display_key_40c_ret:
	lda (ptr1),y
	and #$7f
	ora current_key_state
	sta (ptr1),y
	iny
	lda char_right,x
	sta (ptr1),y

    ldy #40
	lda (ptr1),y
	and #$7f
	ora current_key_state
	sta (ptr1),y
	iny
	lda char_right,x
	sta (ptr1),y

    ldy #80
	lda (ptr1),y
	and #$7f
	ora current_key_state
	sta (ptr1),y
	iny
	lda char_right,x
	sta (ptr1),y

	ldy #120
	lda char_bottom,x
	sta (ptr1),y
	iny
	lda char_bottom_right,x
	sta (ptr1),y
	rts
