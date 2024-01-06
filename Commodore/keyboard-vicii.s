;  keyboard.s -- Read and display keyboard state
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

.section reserved

.public port1 .reserve 1
.public port2 .reserve 1

temp .reserve 1

.section code

.public init_keyboard_vicii {
    jsr init_restore_nmi
    rts
}
    
.public process_skip {
;    inc VIDEO_BORDER_COLOR
    .if .defined(C64) {
        lda machine_type
        bpl :+
        rts
    :
    }
    .if .defined(MEGA65) {
        rts
    }
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
    .if .defined(C64) {
        lda machine_type
        bne :+
        sta skip_key + 64 ; don't skip restore on C64
    :
    }
;    dec VIDEO_BORDER_COLOR
    rts
}


.public read_keyboard_128 {
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
    sta VIC_C128_KEYBOARD
    lda CIA1_PRB
    eor #$ff
    tay
    and bitmask,x
    beq one_not_pressed
    inc new_key_state,x
    bne two
one_not_pressed:
    sta new_key_state,x
two:
    inx
    tya
    and bitmask,x
    beq two_not_pressed
    inc new_key_state,x
    bne three
two_not_pressed:
    sta new_key_state,x
three:
    inx
    tya
    and bitmask,x
    beq three_not_pressed
    inc new_key_state,x
    bne four
three_not_pressed:
    sta new_key_state,x
four:
    inx
    tya
    and bitmask,x
    beq four_not_pressed
    inc new_key_state,x
    bne five
four_not_pressed:
    sta new_key_state,x
five:
    inx
    tya
    and bitmask,x
    beq five_not_pressed
    inc new_key_state,x
    bne six
five_not_pressed:
    sta new_key_state,x
six:
    inx
    tya
    and bitmask,x
    beq six_not_pressed
    inc new_key_state,x
    bne seven
six_not_pressed:
    sta new_key_state,x
seven:
    inx
    tya
    and bitmask,x
    beq seven_not_pressed
    inc new_key_state,x
    bne eight
seven_not_pressed:
    sta new_key_state,x
eight:
    inx
    tya
    and bitmask,x
    beq eight_not_pressed
    inc new_key_state,x
    bne nine
eight_not_pressed:
    sta new_key_state,x
nine:
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
    beq end_read
    jmp byteloop

end_read:
    lda #$ff
    sta VIC_C128_KEYBOARD

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
    and #$40
    bne not_caps
    inc new_key_state + 88
    bne disp_40_80
not_caps:
    sta new_key_state + 88
disp_40_80:
    .if .defined(C128) {
        lda MMU_MODE_CONFIGURATION
        and #MMU_MODE_CONFIGURATION_40_80
        bne not_disp_40_80
        inc new_key_state + 89
        bne end
    not_disp_40_80:
        sta new_key_state + 89
    end:
    }
    rts
}
