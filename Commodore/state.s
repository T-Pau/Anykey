;  state.s -- Current program state.
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

.include "features.inc"

.section reserved

.public machine_type .reserve 1
.public joy1 .reserve 1
.public joy2 .reserve 1
.public bottom_charset_line .reserve 1
.public joystick_label_line .reserve 1
.public joystick_positions .reserve 4
.pre_if .defined(C16) ; TODO: make this more efficient, not enough memory on C16
.public main_color_save .reserve SCREEN_SIZE / 2
.pre_else
.public main_color_save .reserve SCREEN_SIZE
.pre_end
.public keyboard_height .reserve 1

.section code

.public init_state {
    lda #0
    sta joy1
    sta joy2
    sta command
    sta last_command
    .if .defined(USE_VICII) {
        .if .defined(C64) {
            jsr init_c64
        }
        .else_if .defined(C128) {
            jsr init_c128
        }
        .else_if .defined(MEGA65) {
            jsr init_mega65
        }
        rl_expand_typed main_color_save, main_color_c64, main_color_c128, main_color_mega65_c64
    }
    .else_if .defined(USE_TED) {
        ldx #<keys_address_low
        ldy #>keys_address_low
        lda keys_num_keys
        jsr set_keys_table
        lda #14
        sta keyboard_height
        rl_expand main_color_save, main_color
        lda #KEY_INDEX_HELP
        sta key_index_help
        lda #KEY_INDEX_RESET
        sta key_index_reset
    }
    lda keyboard_height
    cmp #12
    bne high_keyboard
    store_word joystick_positions, screen + 16 * 40 + 6
    store_word joystick_positions + 2, screen + 16 * 40 + 22
    jmp init_keyboard
high_keyboard:
    .if .defined(USE_TED) {
        store_word joystick_positions, screen + 17 * 40 + 12
    }
    .else {
        store_word joystick_positions, screen + 17 * 40 + 6
    }
    store_word joystick_positions + 2, screen + 17 * 40 + 22
    jmp init_keyboard
}

.pre_if .defined(C64)
init_c64 {
    lda machine_type
    bpl :+
    jmp init_mega65
    lda #64
    sta tmp1
    ldx #<KEYBOARD_SELECT
    ldy #<KEYBOARD_VALUE
    lda #>KEYBOARD_SELECT
    jmp set_keyboard_registers
    lda machine_type
:   beq :+
    jmp init_c128
:	lda #SCREEN_TOP + 8 * 4
    sta bottom_charset_line
    lda #SCREEN_TOP + 13 * 8
    sta joystick_label_line
    ldx #<keys_64_address_low
    ldy #>keys_64_address_low
    lda keys_64_num_keys
    jsr set_keys_table
    lda #12
    sta keyboard_height
    jmp init_c64_c128
}
.pre_end

.pre_if .defined(C64) || .defined(C128)
init_c128 {
    ldx #<keys_128_address_low
    ldy #>keys_128_address_low
    lda keys_128_num_keys
    jsr set_keys_table
    lda #SCREEN_TOP + 8 * 7
    sta bottom_charset_line
    jsr init_c64_c128
    jmp init_c128_mega65
}


init_c64_c128 {
    lda #KEY_INDEX_HELP
    sta key_index_help
    lda #KEY_INDEX_RESET
    sta key_index_reset
    rts
}
.pre_end

.pre_if .defined(C64) || .defined(MEGA65)
init_mega65 {
    lda #65 ; set CPU to fast
    sta 0
    lda #67 ; Help
    sta key_index_help
    lda #70 ; F13
    sta key_index_reset
    ldx #<keys_mega65_address_low
    ldy #>keys_mega65_address_low
    lda keys_mega65_num_keys
    jsr set_keys_table
    lda #9 * 8
    sta tmp1
    ldx #<$D614
    ldy #<$D613
    lda #>$D614
    jsr set_keyboard_registers
    lda #SCREEN_TOP + 8 * 7 + 1
    sta bottom_charset_line
    jmp init_c128_mega65
}
.pre_end

.pre_if .defined(C64) || .defined(C128) || .defined(MEGA65)
init_c128_mega65 {
    lda #SCREEN_TOP + 15 * 8
    sta joystick_label_line
    lda #14
    sta keyboard_height
    rts
}
.pre_end
