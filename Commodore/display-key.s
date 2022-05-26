;  display_key.s -- Display current_key_state of key
;  Copyright (C) 2020-2022 Dieter Baron
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

.export display_key, set_keys_table, num_keys, current_key_state

.include "defines.inc"

.bss

num_keys:
	.res 1

current_key_state:
	.res 1

.code

; set keys table to X/Y, number of keys A
set_keys_table:
	sta num_keys
	stx address_low + 1
	sty address_low + 2
	
	clc
	txa
	adc num_keys
	sta address_high + 1
	lda address_low + 2
	adc #0
	sta address_high + 2
	
	lda address_high + 1
	adc num_keys
	sta display_low + 1
	lda address_high + 2
	adc #0
	sta display_low + 2
	
	lda display_low + 1
	adc num_keys
	sta display_high + 1
	lda display_low + 2
	adc #0
	sta display_high + 2

	rts


; display key x pressed a
; x is not disturbed

display_key:
	cmp #0
	beq :+
	lda #$80
:	sta current_key_state

address_low:
	lda $1000,x
	sta ptr1
address_high:
	lda $1000,x
	sta ptr1 + 1
display_low:
	lda $1000,x
	sta jump + 1
display_high:
	lda $1000,x
	sta jump + 2
	ldy #0
.ifdef USE_PET
	stx restore + 1
	ldx current_key_state
	beq jump
	ldx #1
jump:
	jsr $1000
restore:
	ldx #$00
	rts
.else
jump:
	jmp $1000
.endif