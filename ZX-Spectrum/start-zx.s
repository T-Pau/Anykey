SECTION code_user

PUBLIC _main

_main:
    ld a,0
loop:
    inc a
    out (254),a
    jp loop
