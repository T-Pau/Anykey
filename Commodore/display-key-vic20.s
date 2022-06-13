;  display_key-vicii-ted.s -- Display current_key_state of key, VIC-II / TED version
;  Copyright (C) 2020 Dieter Baron
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

.include "defines.inc"

COLOR_RAM_OFFSET = color_ram - screen

.macro set_color
.scope
	clc
;	lda ptr1
;	adc #<COLOR_RAM_OFFSET
;	sta ptr1
	lda ptr1 + 1
	adc #>COLOR_RAM_OFFSET
	sta ptr1 + 1

	lda current_key_color
	ldy #0
released:
.endscope
.endmacro

.segment "CODE_LOW"

.export display_key_1
display_key_1:
	lda (ptr1),y
	and #$7f
	ora current_key_state
	sta (ptr1),y

	ldy #22
	lda (ptr1),y
	and #$7f
	ora current_key_state
	sta (ptr1),y

	set_color
	sta (ptr1),y
	ldy #22
	sta (ptr1),y

	rts

.export display_key_2
display_key_2:
	lda (ptr1),y
	and #$7f
	ora current_key_state
	sta (ptr1),y
	iny
	lda (ptr1),y
	and #$7f
	ora current_key_state
	sta (ptr1),y

	ldy #22
	lda (ptr1),y
	and #$7f
	ora current_key_state
	sta (ptr1),y
	iny
	lda (ptr1),y
	and #$7f
	ora current_key_state
	sta (ptr1),y

	set_color
	sta (ptr1),y
	iny
	sta (ptr1),y
	ldy #22
	sta (ptr1),y
	iny
	sta (ptr1),y
	
	rts


.export display_key_10
display_key_10:
	ldy #9
:	lda (ptr1),y
	and #$7f
	ora current_key_state
	sta (ptr1),y
	dey
	bpl :-

	ldy #22
:	lda (ptr1),y
	and #$7f
	ora current_key_state
	sta (ptr1),y
	iny
	cpy #22 + 10
	bne :-

	set_color
	ldy #9
:	sta (ptr1),y
	dey
	bpl :-

	ldy #22
:	sta (ptr1),y
	iny
	cpy #22 + 10
	bne :-
	
	rts

.export display_key_left_shift
display_key_left_shift:
	lda (ptr1),y
	and #$7f
	ora current_key_state
	sta (ptr1),y

	ldy #22
	lda (ptr1),y
	and #$7f
	ora current_key_state
	sta (ptr1),y

	ldy #45
	lda (ptr1),y
	and #$7f
	ora current_key_state
	sta (ptr1),y

	ldy #67
	lda (ptr1),y
	and #$7f
	ora current_key_state
	sta (ptr1),y

	set_color
	sta (ptr1),y
	ldy #22
	sta (ptr1),y
	ldy #45
	sta (ptr1),y
	ldy #67
	sta (ptr1),y

	rts
