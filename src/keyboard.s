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

.include "anykey.inc"

RESTORE_FRAMES = 10

.bss

key_state:
	.res 65

new_key_state:
	.res 65

skip_key:
	.res 65

restore_countdown:
	.res 1

nmi_vector:
	.res 2

nmi_a:
	.res 1

port1:
	.res 1
port2:
	.res 1
temp:
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
	sta skip_key + 64
	
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
	sta CIA1_DDRB
	lda CIA1_PRB
	eor #$ff
	sta port1
	lda CIA1_PRA
	eor #$ff
	sta port2
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
	ldx #63
	lda #0
:	sta skip_key,x
	dex
	bpl :-
	lda #$ff
	sta CIA1_DDRB

	lda CIA1_PRB
	eor #$ff
	ora port1
	beq port1_clear
	sta port1

	ldx #0
port1_loop:
	lda port1
	lsr
	sta port1
	bcc port1_loop_end
	stx temp
	ldy temp
	ldx #7
	lda #1
:	sta skip_key,y
	tya
	clc
	adc #8
	tay
	dex
	bpl :-
	ldx temp
port1_loop_end:
	inx
	cpx #5
	bne port1_loop
	
port1_clear:
	; TODO: if port 2 bit is set and key in that row is pressed, ignore that key's column (except for key itself)
	rts


display_keyboard:
	ldx #64
display_loop:
	lda skip_key,x
	bne :+
	lda new_key_state,x
	cmp key_state,x
	beq :+
	sta key_state,x
	jsr display_key
:	dex
	bpl display_loop

	lda command
	bne no_f8
	lda key_state + 15 ; left shift
	ora key_state + 52 ; right shift
	beq no_f8
	lda key_state + 3 ; F7
	beq no_f8
	lda #COMMAND_HELP
	sta command
no_f8:
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
