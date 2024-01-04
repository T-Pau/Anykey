;  keyboard.s -- Process and display keyboard state
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

.pre_if .defined(USE_PET)
MAX_KEY_READ = 80
.pre_else
MAX_KEY_READ = 64
.pre_end

.section data

.public key_state .reserve MAX_NUM_KEYS
.public new_key_state .reserve MAX_NUM_KEYS + 1
.pre_if .defined(USE_SKIP)
.public skip_key .reserve MAX_NUM_KEYS
.pre_end

.public key_index_help .reserve 1
.public key_index_reset .reserve 1

next_key .reserve 1
reset_count .reserve 1
help_count .reserve 1

.section code

.public init_keyboard {
    ldx #MAX_NUM_KEYS - 1
    lda #0
    sta next_key
:	sta key_state,x
    sta new_key_state,x
    .if .defined(USE_SKIP) {
        sta skip_key,x
    }
    dex
    bpl :-
    sta reset_count
    sta help_count
    .if .defined(USE_VICII) {
        jsr init_keyboard_vicii
    }
    rts
}

.public display_keyboard {
;    inc VIDEO_BORDER_COLOR
    ldx next_key
loop:
    .if .defined(USE_SKIP) {
        lda skip_key,x
        bne next
    }
    lda new_key_state,x
    and #$06
    beq :+
    lda #$02
    sta new_key_state,x
:	cmp key_state,x
    beq next
    sta key_state,x
    .if  !.defined(USE_PET) {
        cmp #0
        beq unpressed
        ldy #PRESSED_COLOR
        bne display
    unpressed:
        ldy #CHECKED_COLOR
    display:
        sty current_key_color
    }
    jsr display_key
next:
    inx
    .if .defined(USE_VICII) {
        lda VIC_CONTROL_1
        bmi :+
        lda VIC_RASTER
        cmp #SCREEN_TOP - 12
        bcs stop
    :
    }
    cpx num_keys
    bne loop
    ldx #0
stop:
    stx next_key
;    dec VIDEO_BORDER_COLOR
    rts
}

.public process_command_keys {
    lda command
    bne no_key
    ldx key_index_help
    lda key_state,x
    beq no_help
    ldx help_count
    inx
    stx help_count
    cpx #HOLD_FRAMES
    bcc end
    lda #COMMAND_HELP
    sta command
    bne no_key
no_help:
    lda #0
    sta help_count
    ldx key_index_reset
    lda key_state,x
    beq no_key
    ldx reset_count
    inx
    stx reset_count
    cpx #HOLD_FRAMES
    bcc end
    lda #COMMAND_RESET_KEYBOARD
    sta command
no_key:
    lda #0
    sta reset_count
    sta help_count
end:
    rts
}

.pre_if .defined(USE_VICII)
check_joysticks {
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
    ora port2
    sta port2
    rts
}
.pre_end

.public read_keyboard {
    .if .defined(USE_VICII) {
        lda #0
        sta port1
        sta port2
        jsr check_joysticks
        lda #$ff
        sta CIA1_DDRA
        lda #$00
        sta CIA1_DDRB
    }
    .if .defined(C64) {
        lda machine_type
        bpl init_bits
        lda #0
        beq init_end
    init_bits:
        lda #$fe
    init_end:
    }
    .else_if .defined(USE_PET) || .defined(MEGA65) {
        lda #0
    }
    .else {
        lda #$fe
    }
    ldx #0
byteloop:
.private read_keyboard_select = byteloop + 1
    sta KEYBOARD_SELECT
    .if .defined(USE_TED) {
        lda #$ff
        sta KEYBOARD_VALUE
    }
value:
.private read_keyboard_value = value + 1
    lda KEYBOARD_VALUE
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
max_key_read:
.private read_keyboard_max_read_keys = max_read_keys + 1
    cpx #MAX_KEY_READ
    beq end_read
    txa
    lsr
    lsr
    lsr
    tay
    .if .defined(C64) {
        lda machine_type
        bpl next_bits
        tya
        bne next_end
    next_bits:
        lda bitmask,y
        eor #$ff
    next_end:
    }
    .else_if !(.defined(USE_PET) || .defined(MEGA65)) {
        lda bitmask,y
        eor #$ff
    }
    beq end_read
    jmp byteloop

end_read:
    .if .defined(USE_VICII) {
        jsr process_restore
        jsr check_joysticks
    ;    jsr process_skip
        ; TODO: if port 2 bit is set and key in that row is pressed, ignore that key's column (except for key itself)
    }
    rts
}

.pre_if .defined(C64) || .defined(MEGA65)
.public set_keyboard_registers {
    stx read_keyboard_select
    sta read_keyboard_select + 1
    sty read_keyboard_value
    sta read_keyboard_value + 1
    lda tmp1
    sta read_keyboard_max_key_read
    rts
}

.public read_keyboard_mega65 {
    ; Caps
    lda $d611
    and #%01000000
    beq :+
    lda #02
:   sta new_key_state + 72

    ; bit 1: up
    ; bit 0: left
    lda $d60f
    sta tmp1
    and #$01
    sta skip_key + 2 ; cursor right
    asl
    sta new_key_state + 73 ; cursor left
    lda tmp1
    and #$02
    sta new_key_state + 74 ; cursor up
    lsr
    sta skip_key + 7 ; cursor down
    ora tmp1
    and #$01
    sta skip_key + 6 * 8 + 4 ; right shift
    rts
}
.pre_end

.section data

.public bitmask {
    .repeat 11 {
        .data $01, $02, $04, $08, $10, $20, $40, $80
;   	.data $80, $40, $20, $10, $08, $04, $02, $01
    }
}
