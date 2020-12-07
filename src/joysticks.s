;  help.s -- Display and handle keyboard input for help.
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

.export handle_joysticks, port_digital, select_pots1, select_pots2, read_pots

.include "anykey.inc"

.bss

port_digital:
	.res 1

.code

select_pots1:
	lda #$c0
	sta CIA1_DDRA
    lda #$40
    sta CIA1_PRA
    rts

select_pots2:
	lda #$c0
	sta CIA1_DDRA
	lda #$80
	sta CIA1_PRA
	rts

read_pots:
	lda joy1,x
	and #$1f
	ldy SID_ADConv1
	bmi :+
	ora #$20
:	ldy SID_ADConv2
	bmi :+
	ora #$40
:	sta joy1,x
	rts

handle_joysticks:
    lda #$00
    sta CIA1_DDRA
    sta CIA1_DDRB

    lda #$ff
    sta CIA1_PRA
    eor CIA1_PRB
    and #$1f
    ora joy1
    sta port_digital
    ldx #0
	jsr display_joystick

    lda #$ff
    sta CIA1_PRB
    eor CIA1_PRA
    and #$1f
    ora joy2
    sta port_digital
    ldx #1
	jmp display_joystick
