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

.section code

; ix: key description
; c: color

.public display_key_2 {
    ld e,(ix + key_screen_offset)
    ld a,(ix + key_screen_offset + 1)
    add 3
    ld d,a
    ld hl,circle_mask
    ld b,9
loop2_char:
    ld a,(de)
    xor a,(hl)
    inc hl
    ld (de),a
    inc e

    ld a,(de)
    xor a,(hl)
    inc hl
    ld (de),a
    ld a,5
    cp a,b
    jr z,next_line2
    inc d
    dec e
    jr next_row2
next_line2:
    ld a,(ix + key_screen_offset)
    add 32
    ld e,a
    ld d,(ix + key_screen_offset + 1)
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
}


.public display_key_3 {
    ld d,3
    jp display_key_n
}


.public display_key_4 {
    ld d,4
    jp display_key_n
}


.public display_key_5 {
    ld d,5
    jp display_key_n
}


.public display_key_9 {
    ld d,9
    jr display_key_n
}


display_key_n {
    ld a,d
    ld (key_width),a
    ld a,c
    ld (key_color),a
    ld e,(ix + key_screen_offset)
    ld a,(ix + key_screen_offset + 1)
    add 3
    ld d,a
    ld hl,circle_mask
    ld c,9
loop_n_char:
    ld a,(de)
    xor a,(hl)
    inc hl
    ld (de),a
    inc e

    ld a,(key_width)
    ld b,a
    dec b
    dec b
loop_n_x:
    ld a,(de)
    xor a,%11111111
    ld (de),a
    inc e
    djnz loop_n_x

    ld a,(de)
    xor a,(hl)
    inc hl
    ld (de),a
    inc e
    ld a,5
    cp a,c
    jr z,next_line_n
    inc d
    ld a,(key_width)
    ld b,a
    ld a,e
    sub a,b
    ld e,a
    jr next_row_n
next_line_n:
    ld a,(ix + key_screen_offset)
    add 32
    ld e,a
    ld d,(ix + key_screen_offset + 1)
next_row_n:
    dec c
    ld a,c
    cp a,0
    jr nz,loop_n_char

    ld a,(key_color)
    ld c,a
    ld a,(key_width)
    ld d,a
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
}

.public display_key_enter {
    ld hl,circle_mask_enter
    ld e,(ix + key_screen_offset)
    inc e
    inc e
    ld a,(ix + key_screen_offset + 1)
    add 3
    ld d,a
    ld b,16
loop_enter_top_char:
    ld a,(de)
    xor a,(hl)
    inc hl
    ld (de),a
    inc e
    ld a,(de)
    xor a,(hl)
    inc hl
    ld (de),a
    ld a,b
    cp a,12
    jr z,next_line_enter_top
    cp a,4
    jr z,next_line_enter_top_2
    inc d
    dec e
    jr next_row_enter_top
next_line_enter_top:
    ld a,(ix + key_screen_offset)
    add 34
    ld e,a
    ld d,(ix + key_screen_offset + 1)
    jr next_row_enter_top
next_line_enter_top_2:
    ld a,(ix + key_screen_offset)
    add 66
    ld e,a
    ld a,(ix + key_screen_offset + 1)
IF PLATFORM_PLUS
    add a,8
ENDIF
    ld d,a
next_row_enter_top:
    djnz loop_enter_top_char

    ld a,(ix + key_screen_offset)
    add a,64
    ld e,a
    ld a,(ix + key_screen_offset + 1)
IF PLATFORM_PLUS
    add 3+8
ELSE
    add 3
ENDIF
    ld d,a
    ld b,9
loop_enter_bottom_char:
    ld a,(de)
    xor a,(hl)
    inc hl
    ld (de),a
    inc e
    ld a,(de)
    xor a,%11111111
    ld (de),a
    inc e
    ld a,(de)
    xor a,%11111111
    ld (de),a
    inc e
    ld a,(de)
    xor a,(hl)
    inc hl
    ld (de),a
    ld a,b
    cp a,5
    jr z,next_line_enter_bottom
    inc d
    dec e
    dec e
    dec e
    jr next_row_enter_bottom
next_line_enter_bottom:
    ld a,(ix + key_screen_offset)
    add 32+64
    ld e,a
    ld a,(ix + key_screen_offset + 1)
IF PLATFORM_PLUS
    add a,8
ENDIF
    ld d,a
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

IF PLATFORM_PLUS
    inc h
ENDIF
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
}


.section data

circle_mask {
    .data %00011111, %11111000
    .data %00011111, %11111000
    .data %00111111, %11111100
    .data %00111111, %11111100
    .data %00111111, %11111100
    .data %00011111, %11111000
    .data %00011111, %11111000
    .data %00001111, %11110000
    .data %00000011, %11000000
}

circle_mask_enter {
    .data %00011111, %11111000
    .data %00011111, %11111000
    .data %00111111, %11111100
    .data %00111111, %11111100
    .data %00111111, %11111100

    .data %00111111, %11111100
    .data %00111111, %11111100
    .data %00111111, %11111100
    .data %00111111, %11111100
    .data %00111111, %11111100
    .data %00111111, %11111100
    .data %00111111, %11111100
    .data %00111111, %11111100

    .data %00111111, %11111100
    .data %00111111, %11111100
    .data %00111111, %11111100
    .data %00011111, %11111100
    .data %00011111, %11111100
    .data %00111111, %11111100
    .data %00111111, %11111100
    .data %00111111, %11111100

    .data %00011111, %11111000
    .data %00011111, %11111000
    .data %00001111, %11110000
    .data %00000011, %11000000
}


.section reserved

key_color .reserve 1
key_width .reserve 1
