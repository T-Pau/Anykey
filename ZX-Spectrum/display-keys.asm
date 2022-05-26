public display_key_2, display_key_3

include "keyboard.inc"

section code_user

; ix: key description
; c: color

display_key_2:
    ld l,(ix + key_screen_offset)
    ld h,(ix + key_screen_offset + 1)
    ld b,9
loop2_char:
    ld a,(hl)
    xor a,%00111111
    ld (hl),a
    inc l
    ld a,(hl)
    xor a,%11111100
    ld (hl),a
    inc h
    dec l
    djnz loop2_char

    ld a,c
    ld l,(ix+key_color_offset)
    ld h,(ix+key_color_offset+1)
    ld b,9
loop2_color:
    ld (hl),a
    inc l
    ld (hl),a
    inc h
    dec l
    djnz loop2_color

    ret


display_key_3:
    ld l,(ix + key_screen_offset)
    ld h,(ix + key_screen_offset + 1)
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
    inc h
    dec l
    dec l
    djnz loop3_char

    ld a,c
    ld l,(ix+key_color_offset)
    ld h,(ix+key_color_offset+1)
    ld b,9
loop3_color:
    ld (hl),a
    inc l
    ld (hl),a
    inc l
    ld (hl),a
    inc h
    dec l
    dec l
    djnz loop3_color

    ret
