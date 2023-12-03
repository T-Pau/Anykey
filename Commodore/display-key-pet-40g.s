;  display-key-pet-40g.s -- Display current_key_state of key, PET version
;  Copyright (C) Dieter Baron
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

; display keys of various sizes
; ptr1 points to char_top left character in screen
; x is 0 for unpressed, 1 for pressed
; current_key_state is $00 for unpressed, $80 for pressed

.section code

.global display_key_40_left_2 {
	lda char_left,x
	sta (ptr1),y
	iny
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
	lda char_bottom_left,x
	sta (ptr1),y
	iny
:	lda char_bottom,x
	sta (ptr1),y
	iny
	cpy #43
	bne :-
	lda char_bottom_right,x
	sta (ptr1),y
	rts
}


.global display_key_40_mid_2 {
:	lda (ptr1),y
	and #$7f
	ora current_key_state
	sta (ptr1),y
	iny
	cpy #2
	bne :-
	lda char_right,x
	sta (ptr1),y

	ldy #40
:	lda char_bottom,x
	sta (ptr1),y
	iny
	cpy #42
	bne :-
	lda char_bottom_right,x
	sta (ptr1),y
	rts
}


.global display_key_40_space_18 {
	lda char_left,x
	sta (ptr1),y
	iny
	lda #$20
	ora current_key_state
:	sta (ptr1),y
	iny
	cpy #17
	bne :-
	lda char_right,x
	sta (ptr1),y

	ldy #40
	lda char_bottom_left,x
	sta (ptr1),y
	iny
	lda char_bottom,x
:	sta (ptr1),y
	iny
	cpy #57
	bne :-
	lda char_bottom_right,x
	sta (ptr1),y
	rts
}


.global display_key_40g_shl {
	lda char_left,x
	sta (ptr1),y
	iny
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
	lda char_bottom_left,x
	sta (ptr1),y
	iny
:	lda char_bottom,x
	sta (ptr1),y
	iny
	cpy #43
	bne :-
	lda char_bottom_right,x
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

	ldy #120
	lda char_bottom_left,x
	sta (ptr1),y
	iny
:	lda char_bottom,x
	sta (ptr1),y
	iny
	cpy #124
	bne :-
	lda char_bottom_right,x
	sta (ptr1),y
	rts
}


.global display_key_40g_gt {
    iny
	lda char_top_right,x
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
	lda char_bottom,x
	sta (ptr1),y
	iny
	lda char_bottom_right,x
	sta (ptr1),y
	rts
}
