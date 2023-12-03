;  expand.s -- expand run length encoded data.
;  Copyright (C)  Dieter Baron
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

; ptr1: runlength encoded string
; ptr2: destination to expand to
.gloabl rl_expand {
	ldy #0
loop:
	lda (ptr1),y
	inc_16 ptr1
	cmp #$fe
	bne no_skip
    lda (ptr1),y
    inc_16 ptr1
    clc
    adc ptr2
    sta ptr2
    bcc loop
    inc ptr2 + 1
    bne loop
no_skip:
	ldx #$01
	cmp #$ff
	bne runlength_loop
	lda (ptr1),y
	inc_16 ptr1
	cmp #$00
	bne :+
	rts
:   tax
    lda (ptr1),y
    inc_16 ptr1
runlength_loop:
	sta (ptr2),y
	iny
	dex
	bne runlength_loop
	tya
    clc
    adc ptr2
    sta ptr2
    bcc :+
    inc ptr2 + 1
:   jmp rl_expand
}
