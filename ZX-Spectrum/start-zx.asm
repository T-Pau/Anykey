public _main

include "platform.inc"

global copy_screen, copy_colors, main_loop

section code_user

_main:
    ld a,7
    out (254),a
    ld iy,screen_main
    call copy_screen
    ld de,colors_main
    call copy_colors
    jp main_loop

section bss_user

frame:
    defs 1
