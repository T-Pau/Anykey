;  platform-48k.s -- 48k specific code
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

; TODO: adapt
KEYBOARD_OFFSET = 32 * 4 + 3
KEYBOARD_SIZE = 32 * 9 + 27
num_keys = 58

.section data

charset {
    incbin "charset-plus.bin"
}


screen_main {
    incbin "keyboard-plus-rl.bin"
}


colors_main {
    .data 32 * 3 + 2, 7<<3
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
    .data 255, 7<<3
    .data (9*32+2) - 255, 7<<3
    .data 0
}


screen_help {
    incbin "help-plus-rl.bin"
}


colors_help {
    .data 32, 7<<3
    .data 255, 7, 255, 7, 2, 7 ; 16 lines
    .data 32*7, 7<<3
}
