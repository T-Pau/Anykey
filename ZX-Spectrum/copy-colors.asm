include "platform.inc"

public copy_colors

section code_user

; de: colors to copy
copy_colors:
    ld hl, color
run_loop:
    ld a,(de)
    ld b,a
    or a
    ret z
    inc de
    ld a,(de)
byte_loop:
    ld (hl),a
    inc hl
    djnz byte_loop
    inc de
    jr run_loop
