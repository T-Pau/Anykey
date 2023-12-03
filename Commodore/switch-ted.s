;  switch-ted.s -- IRQ handler routines for TED.
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

.global switch_keyboard_top {
	jsr content_background
	ldx #SCREEN_TOP + 8
:	cpx VIDEO_CURRENT_LINE
	bne :-
	set_ted_charset charset_keyboard_top
	rts
}


.global switch_keyboard_bottom {
	lda #((charset_keyboard_bottom & $fc00) >> 8)
	ldx #SCREEN_TOP + 5 * 8
:	cpx VIDEO_CURRENT_LINE
	bne :-
	sta TED_CLK
	lda command
	bne :+
	jsr handle_joysticks
:	rts
}


.global switch_joystick_label {
	set_ted_charset charset
	ldx #SCREEN_TOP + 15 * 8
:	cpx VIDEO_CURRENT_LINE
	bne :-
	jsr label_background
	rts
}


.global switch_joystick {
	jsr content_background
	jsr read_keyboard
	rts
}


.global switch_joystick_bottom {
	lda #FRAME_COLOR
	ldx #SCREEN_TOP + 22 * 8 - 1
:	cpx VIDEO_CURRENT_LINE
	bne :-
	sta VIDEO_BACKGROUND_COLOR
	inx
:	cpx VIDEO_CURRENT_LINE
	bne :-
	jsr label_background
	jsr display_keyboard
	jsr process_command_keys
	rts
}