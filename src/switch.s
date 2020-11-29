;  keyboard.s -- Read Keyboard
;  Copyright (C) 2020 Dieter Baron
;
;  This file is part of Joyride, a controller test program for C64.
;  The authors can be contacted at <joyride@tpau.group>.
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
.export switch_keyboard_bottom, switch_keyboard_top, switch_joystick_label, switch_joystick, switch_bottom

.include "anykey.inc"

.macpack cbm_ext

.code

switch_keyboard_top:
	jsr content_background
	ldx #top + 8 + 1
:	cpx VIC_HLINE
	bne :-
	set_vic_text screen, charset_keyboard_top
	rts

switch_keyboard_bottom:
	ldx #top + 8 * 4 + 1
:	cpx VIC_HLINE
	bne :-
	set_vic_text screen, charset_keyboard_bottom
	jmp handle_joysticks


switch_joystick_label:
	set_vic_text screen, charset
	ldx #top + 13 * 8
:	cpx VIC_HLINE
	bne :-
	jsr label_background
	rts

switch_joystick:
	jsr content_background
	jsr read_keyboard
	rts

switch_bottom:
	jsr display_logo
	jsr display_keyboard
	rts
