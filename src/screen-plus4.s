;  screen-plus4.s -- Main screen for Plus/4 keyboard.
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

.export main_screen_plus4, main_color_plus4

.autoimport +

.macpack cbm
.macpack cbm_ext

.include "defines.inc"

.rodata

main_screen_plus4:
	invcode "   keyboard                             "
	.incbin "keyboard-plus4-screen.bin"
	invcode "                                        "
	invcode "           joysticks                    "
	invcode "          "
	scrcode           "I                  J"
    invcode                               "          "
	invcode "          "
	scrcode           "      AHB       AHB "
    invcode                               "          "
	invcode "          "
	scrcode           "      EfF       EfF "
    invcode                               "          "
	invcode "          "
	scrcode           "      CGD       CGD "
    invcode                               "          "
	invcode "          "
	scrcode           "K                  L"
    invcode                               "          "
	invcode "                                        "
	invcode "     f3: reset   help: help      "
	.byte $79, $7a, $7b, $7c, $7d, $7e, $7f
	invcode "      (hold for 2 seconds)       "
	.byte $f9, $fa, $fb, $fc, $fd, $fe, $ff

main_color_plus4:
	.res 40 * 2, FRAME_COLOR
	.repeat 12, i
	.res 2, FRAME_COLOR
	.res 36, UNCHECKED_COLOR
	.res 2, FRAME_COLOR
	.endrepeat
	.res 40 * 3, FRAME_COLOR
	.repeat 5, i
	.res 11, FRAME_COLOR
	.res 18, CONTENT_COLOR
	.res 11, FRAME_COLOR
	.endrep
	.res 40 * 3, FRAME_COLOR
