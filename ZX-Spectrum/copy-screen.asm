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
