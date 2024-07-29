JOYSTICK_LABEL_1 = screen_offset(1, 14)
JOYSTICK_LABEL_2 = screen_offset(12, 14)

.section code

JOYSTICK_VIEW_1_BUTTON = 0
JOYSTICK_VIEW_2_BUTTONS = 1
JOYSTICK_VIEW_MEGADRIVE = 2

reset_next_joysticks {
    ld a,$ff
    ld (joystick_type_1),a
    ld (joystick_type_2),a
    ret
}

display_next_joysticks {
    call get_joystick_config
    ld a,c
    ld (new_joystick_type_2),a
    ld a,(joystick_type_1)
    cp a,b
    jr z,:+
    set_charset charset
    ld a,b
    ld (joystick_type_1),a
    ld hl,JOYSTICK_LABEL_1
    ld ix,joystick_names
    call display_indexed
    ; TODO: clear window

:   ld a,(joystick_type_2)
    ld c,a
    ld a,(new_joystick_type_2)
    cp a,c
    jr z,:+
    set_charset charset
    ld (joystick_type_2),a
    ld hl,JOYSTICK_LABEL_2
    ld ix,joystick_names
    call display_indexed
    ; TODO: clear window

:   ret
}

; Get which joysticks are configured.
; Returns:
;   b: joystick 1 type
;   c: joystick 2 type
get_joystick_config {
    readnextreg NEXTREG_PERIPHERAL_SETTINGS_1
    ld b,0
    ld c,0

    ; 112212..
    rl a
    rl b
    rl a
    rl b
    rl a
    rl c
    rl a
    rl c
    rl a
    rl b
    rl a
    rl c
    ret
}



.section data

.pre_if .false
joystick_info {
    .data JOYSTICK_VIEW_1_BUTTON, 0, handle_sinclair
    .data JOYSTICK_VIEW_2_BUTTONS, 0, handle_kempston
    .data JOYSTICK_VIEW_2_BUTTONS, 1, handle_kempston
    .data JOYSTICK_VIEW_MEGADRIVE, 0, handle_megadrive
    .data JOYSTICK_VIEW_1_BUTTON, 0, handle_cursor
    .data JOYSTICK_VIEW_MEGADRIVE, 1, handle_megadrive
    .data JOYSTICK_VIEW_1_BUTTON, 1, handle_sinclair
    .data JOYSTICK_VIEW_2_BUTTONS, 0, handle_keyjoy
}
.pre_end


.section reserved

joystick_type_1 .reserve 1
joystick_type_2 .reserve 1
new_joystick_type_2 .reserve 1