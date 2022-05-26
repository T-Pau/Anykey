public reset_keyboard

include "platform.inc"

section code_user

reset_keyboard:
    ld hl,color + KEYBOARD_OFFSET
    ld de, KEYBOARD_SIZE
reset_loop:
    ld a,(hl)
    cp a,CHECKED_COLOR
    jr nz,not_checked
    ld (hl),UNCHECKED_COLOR
not_checked:
    inc hl
    dec de
    ld a,d
    or a,e
    jr nz,reset_loop
    ret
