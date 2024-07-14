;  platform-plus2.s -- +2/+3 specific code
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

KEYBOARD_OFFSET = 32 * 2 + 3
KEYBOARD_SIZE = 32 * 9 + 27

; y = 15, x = 7
JOYSTICK_1_DPAD_OFFSET = 8 * 256 + 7 * 32 + 7
JOYSTICK_1_BUTTON_OFFSET = 16 * 256 + 12
JOYSTICK_2_DPAD_OFFSET = JOYSTICK_1_DPAD_OFFSET + 10
JOYSTICK_2_BUTTON_OFFSET = JOYSTICK_1_BUTTON_OFFSET + 10

num_keys = 58

.section data

colors_main {
    .data 32 + 2, 7<<3
    .data 29, 7, 3, 7<<3
    .data 29, UNCHECKED_COLOR, 3, 7<<3
    .data 29, UNCHECKED_COLOR, 3, 7<<3
    .data 29, UNCHECKED_COLOR, 3, 7<<3
    .data 29, UNCHECKED_COLOR, 3, 7<<3
    .data 29, UNCHECKED_COLOR, 3, 7<<3
    .data 29, UNCHECKED_COLOR, 3, 7<<3
    .data 29, UNCHECKED_COLOR, 3, 7<<3
    .data 29, UNCHECKED_COLOR, 3, 7<<3
    .data 29, UNCHECKED_COLOR, 3, 7<<3
    .data 29, UNCHECKED_COLOR, 3, 7<<3
    .data 29, 7
    .data 32 * 2 + 7, 7<<3
    .data 20, 7, 12, 7<<3
    .data 20, 7, 12, 7<<3
    .data 20, 7, 12, 7<<3
    .data 20, 7, 12, 7<<3
    .data 20, 7, 12, 7<<3
    .data 32 * 5 + 6, 7<<3
    .data 0
}


screen_help {
    .binary_file "help-plus2-rl.bin"
}


colors_help {
    .data 32, 7<<3
    .data 255, 7, 255, 7, 2, 7 ; 16 lines
    .data 32*7, 7<<3
}
