;  platform-48k.asm -- 48k specific code
;  Copyright (C) 2022 Dieter Baron
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

include "platform.inc"

section data_user

charset:
    incbin "charset-plus2.bin"

screen_main:
    incbin "keyboard-plus2-rl.bin"

colors_main:
    byte 32 + 2, 7<<3
    byte 29, 7, 3, 7<<3
    byte 29, UNCHECKED_COLOR, 3, 7<<3
    byte 29, UNCHECKED_COLOR, 3, 7<<3
    byte 29, UNCHECKED_COLOR, 3, 7<<3
    byte 29, UNCHECKED_COLOR, 3, 7<<3
    byte 29, UNCHECKED_COLOR, 3, 7<<3
    byte 29, UNCHECKED_COLOR, 3, 7<<3
    byte 29, UNCHECKED_COLOR, 3, 7<<3
    byte 29, UNCHECKED_COLOR, 3, 7<<3
    byte 29, UNCHECKED_COLOR, 3, 7<<3
    byte 29, UNCHECKED_COLOR, 3, 7<<3
    byte 29, 7
    byte 32 * 2 + 7, 7<<3
    byte 20, 7, 12, 7<<3
    byte 20, 7, 12, 7<<3
    byte 20, 7, 12, 7<<3
    byte 20, 7, 12, 7<<3
    byte 20, 7, 12, 7<<3
    byte 32 * 5 + 6, 7<<3
    byte 0

screen_help:
    incbin "help-plus2-rl.bin"

colors_help:
    byte 32, 7<<3
    byte 255, 7, 255, 7, 2, 7 ; 16 lines
    byte 32*7, 7<<3
