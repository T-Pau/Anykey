;  joysticks-vicii.s -- Read and display joysticks, VIC-II version.
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
;  THIS SOFTWARE IS PROVIDED BY THE AUTHORS "AS IS" AND ANY EXPRESS
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

.section code

.public select_pots1 {
    lda #$c0
    sta CIA1_DDRA
    lda #$40
    sta CIA1_PRA
    rts
}


.public select_pots2 {
    lda #$c0
    sta CIA1_DDRA
    lda #$80
    sta CIA1_PRA
    rts
}


.public read_pots {
    .if .defined(C64) {
        lda machine_type
        bpl not_mega65
    }
    .if .defined(C64) || .defined(MEGA65) {
        lda joy1,x
        and #$1f
        sta joy1,x
        txa
        asl
        tay
        lda $d620,y
        bmi :+
        lda joy1,x
        ora #$20
        sta joy1,x
    :   lda $d621,y
        bmi :+
        lda joy1,x
        ora #$40
        sta joy1,x
    :   rts
    }
    .if .defined(C64) {
    not_mega65:
    }
    .if !.defined(MEGA65) {
        lda joy1,x
        and #$1f
        ldy SID_POT_X
        bmi :+
        ora #$20
    :	ldy SID_POT_Y
        bmi :+
        ora #$40
    :	sta joy1,x
        rts
    }
}


.public handle_joysticks {
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
}
