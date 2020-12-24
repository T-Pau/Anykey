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

.export joy1, joy2, main_color_save, is_128, init_state
.export joystick_positions
.export bottom_charset_line, joystick_label_line

.autoimport +

.include "defines.inc"

.macpack utility
.macpack c128

.bss

is_128:
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

.code

init_state:
	lda #0
	sta joy1
	sta joy2
	sta command
	sta last_command
	store_word screen + 16 * 40 + 5, joystick_positions
	store_word screen + 16 * 40 + 21, joystick_positions + 2
	lda VIC_CLK_128
	eor #$ff
	sta is_128
	beq c64
	lda #SCREEN_TOP + 8 * 7
	sta bottom_charset_line
	lda #SCREEN_TOP + 15 * 8
	sta joystick_label_line
	add_word joystick_positions, 40
	add_word joystick_positions + 2, 40
	ldx #<keys_128_address_low
	ldy #>keys_128_address_low
	lda keys_128_num_keys
	jsr set_keys_table
	jmp both
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
.endif
both:
	memcpy_128 main_color_save, main_color_64, main_color_128, 1000
	jmp init_keyboard
