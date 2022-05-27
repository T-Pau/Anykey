;  copy-screen.asm -- Copy characters to screen RAM.
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

public copy_screen, copy_chars

include "platform.inc"

section code_user

; iy - chars to copy from
copy_screen:
    ld hl, screen
    ld ix, screen_size
    ; fallthrough

; iy - chars to copy from
; hl - screen position to copy to
; ix - length
copy_chars:
    ; calculate address of character in set
    ld a,(iy)
    ld e,a
    ld d,0
    scf
    ccf
    rl de
    rl de
    rl de
    add de,charset

    ; copy character
    ld b, 8
copy_char_loop:
    ld a,(de)
    ld (hl),a
    inc h
    inc de
    djnz copy_char_loop

    dec ix
    ld de,ix
    ld a,0
    or d
    or e
    ret z
    inc iy
    inc l
    jr z,copy_chars
    ld a,h
    sub 8
    ld h,a
    jr copy_chars
