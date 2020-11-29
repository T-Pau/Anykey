;  keyboard.s -- Read and display keyboard state
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

.export init_keyboard, display_keyboard, read_keyboard

.include "c64.inc"

RESTORE_FRAMES = 10

.bss

key_state:
	.res 65

new_key_state:
	.res 65

restore_countdown:
	.res 1

nmi_vector:
	.res 2

nmi_a:
	.res 1
	
.code

init_keyboard:
	ldx #64
	lda #0
:	sta key_state,x
	dey
	bpl :-
	sta restore_countdown
	sta new_key_state + 64
	
	lda $0318
	sta nmi_vector
	lda $0319
	sta nmi_vector + 1
	ldx #<handle_nmi
	ldy #>handle_nmi
	stx $0318
	sty $0319
	
	rts


read_keyboard:
	lda #$ff
	sta CIA1_DDRA
	lda #$00
	sta CIA1_DDRB
	lda #$fe
	ldx #0
byteloop:
	sta CIA1_PRA
	lda CIA1_PRB
	eor #$ff
	tay
	and bitmask,x
	sta new_key_state,x
	inx
	tya
	and bitmask,x
	sta new_key_state,x
	inx
	tya
	and bitmask,x
	sta new_key_state,x
	inx
	tya
	and bitmask,x
	sta new_key_state,x
	inx
	tya
	and bitmask,x
	sta new_key_state,x
	inx
	tya
	and bitmask,x
	sta new_key_state,x
	inx
	tya
	and bitmask,x
	sta new_key_state,x
	inx
	tya
	and bitmask,x
	sta new_key_state,x
	inx
	cpx #64
	beq end_read
	txa
	lsr
	lsr
	lsr
	tay
	lda bitmask,y
	eor #$ff
	bne byteloop

end_read:
	ldx restore_countdown
	beq :+
	dex
	stx restore_countdown
	stx new_key_state + 64
:
	rts


display_keyboard:
	ldx #64
display_loop:
	lda new_key_state,x
	cmp key_state,x
	beq :+
	sta key_state,x
	jsr display_key
:	dex
	bpl display_loop

	; TODO: if shift + f7 pressed, display help

	rts

handle_nmi:
	sta nmi_a
	lda #RESTORE_FRAMES
	sta restore_countdown
	lda nmi_a
	jmp (nmi_vector)
	
.rodata

bitmask:
	.repeat 8, i
	.byte $01, $02, $04, $08, $10, $20, $40, $80
;	.byte $80, $40, $20, $10, $08, $04, $02, $01
	.endrep
