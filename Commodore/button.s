;  button.s -- Set state of button.
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

.seciton reserve

state .reserve 1

.section code

; set state of button at ptr2 to A

.global button {
	cmp #0
	beq :+
	lda #$80
:	sta state

	ldy #0
	lda (ptr2),y
	and #$7f
	ora state
	sta (ptr2),y
	iny
	lda (ptr2),y
	and #$7f
	ora state
	sta (ptr2),y
	iny
	lda (ptr2),y
	and #$7f
	ora state
	sta (ptr2),y
	
	ldy #40
	lda (ptr2),y
	and #$7f
	ora state
	sta (ptr2),y
	iny
	lda (ptr2),y
	and #$7f
	ora state
	sta (ptr2),y
	iny
	lda (ptr2),y
	and #$7f
	ora state
	sta (ptr2),y
	
	ldy #80
	lda (ptr2),y
	and #$7f
	ora state
	sta (ptr2),y
	iny
	lda (ptr2),y
	and #$7f
	ora state
	sta (ptr2),y
	iny
	lda (ptr2),y
	and #$7f
	ora state
	sta (ptr2),y

	clc
	lda ptr2
	adc #3
	sta ptr2
	bcc :+
	inc ptr2 + 1
:
	rts
}
