;  display-keys-48k.asm -- Key update routines.
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

public display_key_2, display_key_3, display_key_4, display_key_5, display_key_9, display_key_enter

include "keyboard.inc"

section code_user

; ix: key description
; c: color

display_key_2:
    ld l,(ix + key_screen_offset)
    ld a,(ix + key_screen_offset + 1)
    add 2
    ld h,a
    ld b,11
loop2_char:
    ld a,(hl)
    xor a,%00111111
    ld (hl),a
    inc l
    ld a,(hl)
    xor a,%11111100
    ld (hl),a
    ld a,6
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
    add 2
    ld h,a
    ld b,11
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
    ld a,6
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


display_key_4:
    ld d,4
    jp display_key_n

display_key_5:
    ld d,5
    jp display_key_n

display_key_9:
    ld d,9
    jr display_key_n

display_key_n:
    ld l,(ix + key_screen_offset)
    ld a,(ix + key_screen_offset + 1)
    add 2
    ld h,a
    ld e,11
loop_n_char:
    ld b,d
    dec b
    dec b
    ld a,(hl)
    xor a,%00111111
    ld (hl),a
    inc l
loop_n_x:
    ld a,(hl)
    xor a,%11111111
    ld (hl),a
    inc l
    djnz loop_n_x
    ld a,(hl)
    xor a,%11111100
    ld (hl),a
    inc l
    ld a,6
    cp a,e
    jr z,next_line_n
    inc h
    ld a,l
    sub a,d
    ld l,a
    jr next_row_n
next_line_n:
    ld a,(ix + key_screen_offset)
    add 32
    ld l,a
    ld h,(ix + key_screen_offset + 1)
next_row_n:
    dec e
    ld a,e
    cp a,0
    jr nz,loop_n_char

    ld l,(ix+key_color_offset)
    ld h,(ix+key_color_offset+1)
    ld e,2
loop_n_color_y:
    ld b,d
loop_n_color_x:
    ld a,c
    ld (hl),a
    inc l
    djnz loop_n_color_x
    ld a,32
    sub a,d
    add a,l
    ld l,a
    dec e
    ld a,e
    cp a,0
    jr nz,loop_n_color_y

    ret


display_key_enter:
    ld l,(ix + key_screen_offset)
    inc l
    inc l
    ld a,(ix + key_screen_offset + 1)
    add 2
    ld h,a
    ld b,16
loop_enter_top_char:
    ld a,(hl)
    xor a,%00111111
    ld (hl),a
    inc l
    ld a,(hl)
    xor a,%11111100
    ld (hl),a
    ld a,b
    cp a,11
    jr z,next_line_enter_top
    cp a,3
    jr z,next_line_enter_top_2
    inc h
    dec l
    jr next_row_enter_top
next_line_enter_top:
    ld a,(ix + key_screen_offset)
    add 34
    ld l,a
    ld h,(ix + key_screen_offset + 1)
    jr next_row_enter_top
next_line_enter_top_2:
    ld a,(ix + key_screen_offset)
    add 66
    ld l,a
    ld a,(ix + key_screen_offset + 1)
    add a,8
    ld h,a
next_row_enter_top:
    djnz loop_enter_top_char

    ld a,(ix + key_screen_offset)
    add a,64
    ld l,a
    ld a,(ix + key_screen_offset + 1)
    add 2+8
    ld h,a
    ld b,11
loop_enter_bottom_char:
    ld a,(hl)
    xor a,%00111111
    ld (hl),a
    inc l
    ld a,(hl)
    xor a,%11111111
    ld (hl),a
    inc l
    ld a,(hl)
    xor a,%11111111
    ld (hl),a
    inc l
    ld a,(hl)
    xor a,%11111100
    ld (hl),a
    ld a,6
    cp a,b
    jr z,next_line_enter_bottom
    inc h
    dec l
    dec l
    dec l
    jr next_row_enter_bottom
next_line_enter_bottom:
    ld a,(ix + key_screen_offset)
    add 32+64
    ld l,a
    ld a,(ix + key_screen_offset + 1)
    add a,8
    ld h,a
next_row_enter_bottom:
    djnz loop_enter_bottom_char


    ld l,(ix+key_color_offset)
    ld h,(ix+key_color_offset+1)
    inc hl
    inc hl
    ld b,2
enter_color_top:
    ld a,c
    ld (hl),a
    inc hl
    ld (hl),a
    ld a,l
    add a,31
    ld l,a
    djnz enter_color_top

    inc h
    dec hl
    dec hl
    ld b,2
enter_color_bottom:
    ld a,c
    ld (hl),a
    inc hl
    ld (hl),a
    inc hl
    ld (hl),a
    inc hl
    ld (hl),a
    ld a,l
    add a,29
    ld l,a
    djnz enter_color_bottom

    ret
