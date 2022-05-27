;  reset-keyboard.asm -- reset pressed state of all keys.
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

public reset_keyboard, change_keyboard_colors

include "platform.inc"

section code_user

reset_keyboard:
    ld b,CHECKED_COLOR
    ld c,UNCHECKED_COLOR
    ; fallthrough

; b: color to reset
; c: color to replace with
change_keyboard_colors:
    ld hl,color + KEYBOARD_OFFSET
    ld de, KEYBOARD_SIZE
reset_loop:
    ld a,(hl)
    cp a,b
    jr nz,not_checked
    ld (hl),c
not_checked:
    inc hl
    dec de
    ld a,d
    or a,e
    jr nz,reset_loop
    ret
