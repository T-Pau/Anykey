public main_loop

include "platform.inc"
include "keyboard.inc"

section code_user

main_loop:
    call read_keyboard
    call display_keyboard
    call handle_keys_main
    jr main_loop

handle_keys_main:
    ld ix,key_state
    ld a,(ix + KEY_INDEX_RESET)
    cp a,0
    jr z,not_reset
    ld a,(reset_pressed)
    inc a
    ld (reset_pressed),a
    cp a,PRESS_DURATION
    jr c,check_help
    call reset_keyboard
    jr check_help
not_reset:
    ld (reset_pressed),a
check_help:
    ld a,(ix + KEY_INDEX_HELP)
    cp a,0
    jr z,not_help
    ld a,(help_pressed)
    inc a
    ld (help_pressed),a
    cp a,PRESS_DURATION
    ret c
    ; TODO: help
    ret
not_help:
    ld (help_pressed),a
    ret

section bss_user

reset_pressed:
    defs 1

help_pressed:
    defs 1
