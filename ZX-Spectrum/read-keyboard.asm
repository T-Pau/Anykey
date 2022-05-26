include "platform.inc"
include "keyboard.inc"

section code_user

read_keyboard:
    ld e,%11111110 ; first row
    ld hl,new_key_state

row_loop:
    ld a,e
    in a,($fe)
    xor $ff
    ld c,a
    ld b,5

column_loop:
    ld a,c
    and $01
    ld (hl),a
    inc hl
    rrc c
    djnz column_loop

    rlc e
    ld a,%11111110
    cp e
    ret z
    jr row_loop

section data_user
