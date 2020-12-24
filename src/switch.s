;  keyboard.s -- Read Keyboard
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
.export switch_keyboard_bottom, switch_keyboard_top, switch_joystick_label, switch_joystick, switch_bottom, switch_joystick_bottom

.include "defines.inc"

.macpack cbm_ext

.code

switch_keyboard_top:
	jsr content_background
	lda #COLOR_MID_GRAY
	ldy is_128
	beq :+
	lda #COLOR_LIGHT_GRAY
:
	ldx #SCREEN_TOP + 8
:	cpx VIC_HLINE
	bne :-
	ldx #9
:	dex
	bpl :-
	nop
	nop
	sta VIC_BORDERCOLOR
	set_vic_text screen, charset_keyboard_top
	ldx #0
	jsr read_pots
	lda is_128
	beq :+
	jsr read_keyboard_128
:
	rts

switch_keyboard_bottom:
	lda #(((screen & $3c00) >> 6) | ((charset_keyboard_bottom & $3800) >> 10))
	ldx bottom_charset_line
:	cpx VIC_HLINE
	bne :-
	ldx #9
:	dex
	bpl :-
	nop
	nop
	sta VIC_VIDEO_ADR
	lda command
	bne :+
	jsr handle_joysticks
:
	jmp select_pots2


switch_joystick_label:
	set_vic_text screen, charset
	lda #COLOR_MID_GRAY
	ldx joystick_label_line
:	cpx VIC_HLINE
	bne :-
	sta VIC_BORDERCOLOR
	jsr label_background
	rts

switch_joystick:
	jsr content_background
	ldx #1
	jsr read_pots
	jsr read_keyboard
	jsr select_pots1
	rts

switch_joystick_bottom: ; 128 only
	lda #COLOR_MID_GRAY
	ldx #SCREEN_TOP + 22 * 8 - 0
:	cpx VIC_HLINE
	bne :-
	sta VIC_BG_COLOR0
	lda #COLOR_BLACK
	inx
:	cpx VIC_HLINE
	bne :-
	sta VIC_BG_COLOR0
	rts	

switch_bottom:
	jsr display_logo
	lda command
	bne :+
	jsr display_keyboard
:
	rts
