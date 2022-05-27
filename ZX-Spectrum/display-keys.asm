;  display-keys.asm -- Key update routines.
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

public display_key_2, display_key_3

include "keyboard.inc"

section code_user

; ix: key description
; c: color

display_key_2:
    ld l,(ix + key_screen_offset)
    ld a,(ix + key_screen_offset + 1)
    add 3
    ld h,a
    ld b,9
loop2_char:
    ld a,(hl)
    xor a,%00111111
    ld (hl),a
    inc l
    ld a,(hl)
    xor a,%11111100
    ld (hl),a
    ld a,5
    cp a,b
    jr z,next_line2
    inc h
    dec l
    jr next_row2
next_line2:
    ld a,(ix + key_screen_offset)
    add 32
    ld l,a
    ld h,(ix + key_screen_offset + 1)
next_row2:
    djnz loop2_char

    ld l,(ix+key_color_offset)
    ld h,(ix+key_color_offset+1)
    ld b,2
loop2_color:
    ld a,c
    ld (hl),a
    inc l
    ld (hl),a
    ld a,l
    add 31
    ld l,a
    djnz loop2_color

    ret

display_key_3:
    ld l,(ix + key_screen_offset)
    ld a,(ix + key_screen_offset + 1)
    add 3
    ld h,a
    ld b,9
loop3_char:
    ld a,(hl)
    xor a,%00111111
    ld (hl),a
    inc l
    ld a,(hl)
    xor a,%11111111
    ld (hl),a
    inc l
    ld a,(hl)
    xor a,%11111100
    ld (hl),a
    ld a,5
    cp a,b
    jr z,next_line3
    inc h
    dec l
    dec l
    jr next_row3
next_line3:
    ld a,(ix + key_screen_offset)
    add 32
    ld l,a
    ld h,(ix + key_screen_offset + 1)
next_row3:
    djnz loop3_char

    ld l,(ix+key_color_offset)
    ld h,(ix+key_color_offset+1)
    ld b,2
loop3_color:
    ld a,c
    ld (hl),a
    inc l
    ld (hl),a
    inc l
    ld (hl),a
    ld a,l
    add 30
    ld l,a
    djnz loop3_color

    ret
