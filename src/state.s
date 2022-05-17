;  state.s -- Current program state.
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

.export joy1, joy2, main_color_save, machine_type, init_state
.export joystick_positions
.export bottom_charset_line, joystick_label_line, keyboard_height

.autoimport +

.include "defines.inc"

.macpack utility
.macpack c128

.bss

machine_type:
	.res 1

joy1:
	.res 1
joy2:
	.res 1

bottom_charset_line:
	.res 1
	
joystick_label_line:
	.res 1

joystick_positions:
	.res 4

main_color_save:
	.res 1000

keyboard_height:
	.res 1

.code

init_state:
.scope
	lda #0
	sta machine_type
	sta joy1
	sta joy2
	sta command
	sta last_command
	lda #KEY_INDEX_HELP
	sta key_index_help
	lda #KEY_INDEX_RESET
	sta key_index_reset
.if .defined(USE_VICII)
.ifdef __C64__
    lda #1
    sta VIC_SPR0_X
    lda #VIC_KNOCK_IV_1
    sta VIC_KEY
    lda #VIC_KNOCK_IV_2
    sta VIC_KEY
    lda #0
    sta VIC_PALETTE_RED
    lda VIC_SPR0_X
    beq not_m65
    lda #$ff
    sta machine_type
	ldx #<keys_mega65_address_low
	ldy #>keys_mega65_address_low
	lda keys_mega65_num_keys
	jsr set_keys_table
	lda #(9 * 8)
	sta tmp1
    ldx #<$D614
    ldy #<$D613
    lda #>$D614
    jsr set_keyboard_registers
	lda #SCREEN_TOP + 8 * 7 + 1
	sta bottom_charset_line
	lda #65 ; set CPU to fast
	sta 0
    bne not_c64
not_m65:
	lda #64
	sta tmp1
    ldx #<KEYBOARD_SELECT
    ldy #<KEYBOARD_VALUE
    lda #>KEYBOARD_SELECT
    jsr set_keyboard_registers
.endif
	lda VIC_CLK_128
	cmp #$ff
	beq c64
	lda #1
	sta machine_type
	ldx #<keys_128_address_low
	ldy #>keys_128_address_low
	lda keys_128_num_keys
	jsr set_keys_table
	lda #SCREEN_TOP + 8 * 7
	sta bottom_charset_line
not_c64:
	lda #SCREEN_TOP + 15 * 8
	sta joystick_label_line
	lda #14
	sta keyboard_height
.ifdef __C64__
	; TODO: mega65
.endif
	bne both
c64:
.ifdef __C64__
	lda #SCREEN_TOP + 8 * 4
	sta bottom_charset_line
	lda #SCREEN_TOP + 13 * 8
	sta joystick_label_line
	ldx #<keys_64_address_low
	ldy #>keys_64_address_low
	lda keys_64_num_keys
	jsr set_keys_table
	lda #12
	sta keyboard_height
.endif
both:
	memcpy_128 main_color_save, main_color_64, main_color_128, main_color_mega65_c64, 1000
.elseif .defined(USE_TED)
	ldx #<keys_plus4_address_low
	ldy #>keys_plus4_address_low
	lda keys_plus4_num_keys
	jsr set_keys_table
	lda #14
	sta keyboard_height
	memcpy main_color_save, main_color_plus4, 1000
.endif
	lda keyboard_height
	cmp #12
	bne high_keyboard
	store_word screen + 16 * 40 + 5, joystick_positions
	store_word screen + 16 * 40 + 21, joystick_positions + 2
	jmp init_keyboard
high_keyboard:
.ifdef USE_TED
	store_word screen + 17 * 40 + 11, joystick_positions
.else
	store_word screen + 17 * 40 + 5, joystick_positions
.endif
	store_word screen + 17 * 40 + 21, joystick_positions + 2
	jmp init_keyboard
.endscope
