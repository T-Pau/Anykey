public _main

include "platform.inc"
include "keyboard.inc"

global copy_screen, copy_colors

section code_user

_main:
    ld a,7
    out (254),a
    ld iy,screen_main
    call copy_screen
    ld de,colors_main
    call copy_colors
loop:
    call read_keyboard
    call display_keyboard
    jp loop
