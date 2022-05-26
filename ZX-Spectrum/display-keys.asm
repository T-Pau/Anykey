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
