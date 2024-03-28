;  screen-64.s -- Main screen for C128 keyboard.
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

.section data

.public main_screen_mega65_c64 {
    .data "    keyboard                            ":screen_inverted
    .binary_file "keyboard-mega65-c64-screen.bin"
    .data "                                        ":screen_inverted
    .data "     joysticks                          ":screen_inverted
    .data "    ":screen_inverted
    .data     "I                              J":screen_lowercase
    .data                                     "    ":screen_inverted
    .data "    ":screen_inverted
    .data     "      AHBAHBAHB       AHBAHBAHB ":screen_lowercase
    .data                                     "    ":screen_inverted
    .data "    ":screen_inverted
    .data     "      E1FE2FE3F       E1FE2FE3F ":screen_lowercase
    .data                                     "    ":screen_inverted
    .data "    ":screen_inverted
    .data     "      CGDCGDCGD       CGDCGDCGD ":screen_lowercase
    .data                                     "    ":screen_inverted
    .data "    ":screen_inverted
    .data     "K                              L":screen_lowercase
    .data                                     "    ":screen_inverted
    .data "                                        ":screen_inverted
    .data "    f13: reset keyboard   help: help    ":screen_inverted
    .data "          (hold for 2 seconds)          ":screen_inverted
}


.public main_color_mega65_c64 {
    .data .fill(40 * 2, FRAME_COLOR)
    .repeat 12 {
        .data .fill(3, FRAME_COLOR), .fill(34, UNCHECKED_COLOR), .fill(3, FRAME_COLOR)
    }
    .data .fill(40 * 3, FRAME_COLOR)
    .repeat 5 {
        .data .fill(5, FRAME_COLOR), .fill(30, CONTENT_COLOR), .fill(5, FRAME_COLOR)
    }
    .data .fill(40 * 3, FRAME_COLOR)
}
