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

.export init_keyboard_vicii, read_keyboard_128, process_skip
.export port1, port2

.include "defines.inc"

.macpack utility
.macpack c128


.bss

port1:
	.res 1
port2:
	.res 1
temp:
	.res 1

.code

init_keyboard_vicii:
	jsr init_restore_nmi
    rts
	
.export process_skip
process_skip:
.scope
;    inc VIDEO_BORDER_COLOR
.if .defined(__C64__)
    lda machine_type
    bpl :+
    rts
:
.endif
.if .defined(__MEGA65__)
    rts
.endif
	ldx num_keys
	dex
	lda #0
:	sta skip_key,x
	dex
	bpl :-

	lda port1
	beq port1_clear
	lda #1
	ldx #0
port1_loop:
    ror port1
	bcc port1_loop_end
	lda #1
	sta skip_key,x
    sta skip_key + 8,x
    sta skip_key + 16,x
    sta skip_key + 24,x
    sta skip_key + 32,x
    sta skip_key + 40,x
    sta skip_key + 48,x
    sta skip_key + 56,x
    sta skip_key + 64,x
    sta skip_key + 72,x
    sta skip_key + 80,x
port1_loop_end:
	inx
	cpx #5
	bne port1_loop

port1_clear:
.if .defined(__C64__)
	lda machine_type
	bne :+
	sta skip_key + 64 ; don't skip restore on C64
:
.endif
;    dec VIDEO_BORDER_COLOR
	rts
.endscope

read_keyboard_128:
.scope
	lda #$ff
	sta CIA1_PRA
	sta CIA1_PRB
	lda #$00
	sta CIA1_DDRA
	sta CIA1_DDRB
	lda CIA1_PRB
	eor #$ff
	ora port1
	sta port1
	lda CIA1_PRA
	eor #$ff
	sta port2
	lda #$ff
	sta CIA1_DDRA
	lda #$00
	sta CIA1_DDRB
	lda #$fe
	ldx #64
byteloop:
	sta VIC_KBD_128
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
	cpx #88
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
	lda #$ff
	sta VIC_KBD_128

	lda #$ff
	sta CIA1_PRA
	sta CIA1_PRB
	lda #$00
	sta CIA1_DDRB
	sta CIA1_DDRA
	lda CIA1_PRB
	eor #$ff
	ora port1
	sta port1

	lda $01
	eor #$ff
	and #$40
	sta new_key_state + 88
.ifdef __C128__
	lda MMU_MCR
	eor #$ff
	and #$80
	sta new_key_state + 89
.endif
	rts
.endscope
