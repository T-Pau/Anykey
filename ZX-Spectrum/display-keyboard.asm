public display_keyboard, key_state, new_key_state

include "platform.inc"
include "keyboard.inc"

section code_user

display_keyboard:
    ld ix,keys_48k
    ld iy,key_state
    ld a,num_keys
    ld (current_key),a

display_loop:
    ld a,(iy+num_keys) ; new state
    cp a,(iy) ; old state
    jr z,next_key

    ld (iy),a
    ld c,CHECKED_COLOR
    or a
    jr z, not_pressed
    ld c,PRESSED_COLOR
not_pressed:
    ld l,(ix + key_display_routine)
    ld h,(ix + key_display_routine + 1)
    call display_key

next_key:
    inc iy
    ld e,key_size
    ld d,0
    add ix,de
    ld a,(current_key)
    dec a
    ret z
    ld (current_key),a
    jr display_loop

display_key:
    jp (hl)
    ret

section bss_user

key_state:
    defs num_keys

new_key_state:
    defs num_keys


current_key:
    defs 1
