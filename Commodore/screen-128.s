;  screen-64.s -- Main screen for C128 keyboard.
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

.section data

.global main_screen_128 {
	.data "keyboard                                ":screen_inverted
	.incbin "keyboard-128-screen.bin"
	.data "                                        ":screen_inverted
	.data "     joysticks                          ":screen_inverted
	.data "    ":screen_inverted
	.data     "I                              J":screen
    .data                                     "    ":screen_inverted
    .data "    ":screen_inverted
	.data     "      AHBAHBAHB       AHBAHBAHB ":screen
    .data                                     "    ":screen_inverted
    .data "    ":screen_inverted
	.data     "      E1FE2FE3F       E1FE2FE3F ":screen
    .data                                     "    ":screen_inverted
    .data "    ":screen_inverted
	.data     "      CGDCGDCGD       CGDCGDCGD ":screen
    .data                                     "    ":screen_inverted
	.data "    ":screen_inverted
	.data     "K                              L":screen
    .data                                     "    ":screen_inverted
	.data "                                        ":screen_inverted
	.data "      f5: reset keyboard  f7: help      ":screen_inverted
	.data "          (hold for 2 seconds)          ":screen_inverted
}


.global main_color_128 {
	.res 40 * 2, FRAME_COLOR
.ifdef __C64__
	; mark 40/80 display uncheckable
	.res 16, UNCHECKED_COLOR
	.res 2, PRESSED_COLOR
	.res 22, UNCHECKED_COLOR
	.res 16, UNCHECKED_COLOR
	.res 2, PRESSED_COLOR
	.res 22, UNCHECKED_COLOR
.else
	.res 40 * 2, UNCHECKED_COLOR
.endif
	.res 40 * 10, UNCHECKED_COLOR
	.res 40 * 3, FRAME_COLOR
	.repeat 5, i
	.res 5, FRAME_COLOR
	.res 30, CONTENT_COLOR
	.res 5, FRAME_COLOR
	.endrep
	.res 40 * 3, FRAME_COLOR
}
