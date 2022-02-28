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

.export display_key_3, display_key_4, display_key_6, display_key_space_26, display_key_space_27, display_key_h, display_key_n, display_key_w

.export display_key_80b_shl

.macpack utility

.include "defines.inc"

; display keys of various sizes
; ptr1 points to char_top left character in screen
; x is 0 for unpressed, 1 for pressed
; current_key_state is $00 for unpressed, $80 for pressed

.code

display_key_w:
	lda char_top_left,x
	sta (ptr1),y
	iny
	lda char_top,x
:	sta (ptr1),y
	iny
	cpy #9
	bne :-
	lda char_top_right,x
	sta (ptr1),y
	
	ldy #80
	lda char_left,x
	sta (ptr1),y
	iny
:	lda (ptr1),y
	and #$7f
	ora current_key_state
	sta (ptr1),y
	iny
	cpy #89
	bne :-
	lda char_right,x
	sta (ptr1),y

	ldy #160
	lda char_bottom_left,x
	sta (ptr1),y
	iny
	lda char_bottom,x
:	sta (ptr1),y
	iny
	cpy #169
	bne :-
	lda char_bottom_right,x
	sta (ptr1),y
	rts

display_key_n:
	lda char_top_left,x
	sta (ptr1),y
	iny
	lda char_top,x
:	sta (ptr1),y
	iny
	cpy #4
	bne :-
	lda char_top_right,x
	sta (ptr1),y
	
	ldy #80
	lda char_left,x
	sta (ptr1),y
	iny
:	lda (ptr1),y
	and #$7f
	ora current_key_state
	sta (ptr1),y
	iny
	cpy #84
	bne :-
	lda char_right,x
	sta (ptr1),y

	ldy #160
	lda char_bottom_left,x
	sta (ptr1),y
	iny
	lda char_bottom,x
:	sta (ptr1),y
	iny
	cpy #164
	bne :-
	lda char_bottom_right,x
	sta (ptr1),y
	rts

display_key_h:
.scope
	lda char_top_left,x
	sta (ptr1),y
	iny
	lda char_top,x
:	sta (ptr1),y
	iny
	cpy #4
	bne :-
	lda char_top_right,x
	sta (ptr1),y
	
	lda #5
	sta tmp1
row:
	ldy #0
	clc
	lda #80
	adc_16 ptr1
	lda char_left,x
	sta (ptr1),y
	iny
:	lda (ptr1),y
	and #$7f
	ora current_key_state
	sta (ptr1),y
	iny
	cpy #4
	bne :-
	lda char_right,x
	sta (ptr1),y
	dec tmp1
	bne row

	ldy #0
	lda char_bottom_left,x
	sta (ptr1),y
	iny
	lda char_bottom,x
:	sta (ptr1),y
	iny
	cpy #4
	bne :-
	lda char_bottom_right,x
	sta (ptr1),y
	rts
.endscope


display_key_3:
	lda char_top_left,x
	sta (ptr1),y
	iny
	lda char_top,x
	sta (ptr1),y
	iny
	lda char_top_right,x
	sta (ptr1),y

	ldy #80
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

	ldy #160
	lda char_bottom_left,x
	sta (ptr1),y
	iny
	lda char_bottom,x
	sta (ptr1),y
	iny
	lda char_bottom_right,x
	sta (ptr1),y
	rts


display_key_4:
	lda char_top_left,x
	sta (ptr1),y
	iny
	lda char_top,x
	sta (ptr1),y
	iny
	sta (ptr1),y
	iny
	lda char_top_right,x
	sta (ptr1),y

	ldy #80
	lda char_left,x
	sta (ptr1),y
	iny
:	lda (ptr1),y
	and #$7f
	ora current_key_state
	sta (ptr1),y
	iny
	cpy #83
	bne :-
	lda char_right,x
	sta (ptr1),y

	ldy #160
	lda char_bottom_left,x
	sta (ptr1),y
	iny
	lda char_bottom,x
	sta (ptr1),y
	iny
	sta (ptr1),y
	iny
	lda char_bottom_right,x
	sta (ptr1),y
	rts


display_key_6:
	lda char_top_left,x
	sta (ptr1),y
	iny
	lda char_top,x
:	sta (ptr1),y
	iny
	cpy #5
	bne :-
	lda char_top_right,x
	sta (ptr1),y

	ldy #80
	lda char_left,x
	sta (ptr1),y
	iny
:	lda (ptr1),y
	and #$7f
	ora current_key_state
	sta (ptr1),y
	iny
	cpy #85
	bne :-
	lda char_right,x
	sta (ptr1),y

	ldy #160
	lda char_bottom_left,x
	sta (ptr1),y
	iny
	lda char_bottom,x
:	sta (ptr1),y
	iny
	cpy #165
	bne :-
	lda char_bottom_right,x
	sta (ptr1),y
	rts

display_key_space_27:
	lda char_top_left,x
	sta (ptr1),y
	iny
	lda char_top,x
:	sta (ptr1),y
	iny
	cpy #26
	bne :-
	lda char_top_right,x
	sta (ptr1),y

	ldy #80
	lda char_left,x
	sta (ptr1),y
	iny
	lda #$20
	ora current_key_state
:	sta (ptr1),y
	iny
	cpy #106
	bne :-
	lda char_right,x
	sta (ptr1),y

	ldy #160
	lda char_bottom_left,x
	sta (ptr1),y
	iny
	lda char_bottom,x
:	sta (ptr1),y
	iny
	cpy #186
	bne :-
	lda char_bottom_right,x
	sta (ptr1),y
	rts

display_key_space_26:
	lda char_top_left,x
	sta (ptr1),y
	iny
	lda char_top,x
:	sta (ptr1),y
	iny
	cpy #25
	bne :-
	lda char_top_right,x
	sta (ptr1),y

	ldy #80
	lda char_left,x
	sta (ptr1),y
	iny
	lda #$20
	ora current_key_state
:	sta (ptr1),y
	iny
	cpy #105
	bne :-
	lda char_right,x
	sta (ptr1),y

	ldy #160
	lda char_bottom_left,x
	sta (ptr1),y
	iny
	lda char_bottom,x
:	sta (ptr1),y
	iny
	cpy #185
	bne :-
	lda char_bottom_right,x
	sta (ptr1),y
	rts


display_key_80b_shl:
    jsr display_key_3
    add_word ptr1, 240
    ldy #0
    jmp display_key_4
