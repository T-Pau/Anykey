JOYSTICK_LABEL_1 = screen_offset(1, 14)
JOYSTICK_LABEL_2 = screen_offset(12, 14)

JOYSTICK_WINDOW_1 = screen_offset(0, 15)
JOYSTICK_WINDOW_2 = screen_offset(11, 15)
JOYSTICK_WINDOW_MOUSE = screen_offset(22, 15)

.section code

JOYSTICK_VIEW_1_BUTTON = 0
JOYSTICK_VIEW_2_BUTTONS = 1
JOYSTICK_VIEW_MEGADRIVE = 2

indirect {
    jp (hl)
}

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

:   set_charset charset_joystick
    ld a,(joystick_type_2)
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

:   ld a,(joystick_type_1)
    ld hl,JOYSTICK_WINDOW_1
    call display_next_joystick

    ld a,(joystick_type_2)
    ld hl,JOYSTICK_WINDOW_2
    jp display_next_joystick
}


; Read and display Next Joystick.
; Arguments:
;   a: joystick type
;   hl: position on screen to display at
display_next_joystick {
    ld (window_position),hl
    ld iy,joystick_info
    sla a
    sla a
    ld b,0
    ld c,a
    add iy,bc
    ld h, (iy+1)
    ld l, (iy)
    call indirect
    ld h, (iy+3)
    ld l, (iy+2)
    ld de,(window_position)
    jp (hl)
}

; Display 2 button joystick.
; Arguments:
;   de: screen position to display at
;   value: state of joystick
display_joystick_2_buttons {
    ld h,d
    ld l,e
    inc hl
    ld a,(value)
    and a,$0f
    ld ix,dpad
    call display_indexed
    screen_subtract $5f
    ld a,(value)    
    and a,$30
    rr a
    rr a
    rr a
    rr a
    ld ix,buttons_2
    jp display_indexed
}

; Display Megadrive joystick.
; Arguments:
;   de: screen position to display at
;   value: state of joystick
display_joystick_megadrive {
    ld h,d
    ld l,e
    inc hl
    ld a,(value)
    and a,$0f
    ld ix,dpad
    call display_indexed
    screen_subtract $5f
    ld a,(value)    
    and a,$70
    rr a
    rr a
    rr a
    rr a
    ld ix,buttons_md
    call display_indexed
    screen_subtract $64
    ld a,(value)    
    and a,$80
    ld ix,buttons_start
    jp display_button
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

joystick_info {
    .data read_sinclair_1, display_joystick_1_button
    .data read_kempston_1, display_joystick_2_buttons
    .data read_kempston_2, display_joystick_2_buttons
    .data read_megadrive_1, display_joystick_megadrive
    .data read_cursor, display_joystick_1_button
    .data read_megadrive_2, display_joystick_megadrive
    .data read_sinclair_2, display_joystick_1_button
    .data read_keyjoy, display_joystick_2_buttons
}


.section reserved

joystick_type_1 .reserve 1
joystick_type_2 .reserve 1
new_joystick_type_2 .reserve 1
window_position .reserve 2