
JOYSTICK_OFFSET_DPAD = 0
JOYSTICK_OFFSET_BUTTON = 2
JOYSTICK_SIZE = 4

.section code

.public display_joystick_1 {
    ld a,$ef
    in a,($fe)
    xor a,$ff
    ld c,0
    jp display_joystick
}


.public display_joystick_2 {
    ld a,$f7
    in a,($fe)
    xor a,$ff
    ld d,0
    ld b,5
mirror_loop:
    rr a
    rl d
    djnz mirror_loop
    ld a,d
    ld c,1
    jp display_joystick
}


.public display_joystick_3 {
    in a,(31)
    ld c,a
    ld a,0
    rr c
    rl d
    rr c
    rl a
    rr d
    rl a
    ld b,3
mirror_loop_kempston:
    rr c
    rl a
    djnz mirror_loop_kempston

    ld c,2
    jp display_joystick
}


; a: current value
; c: joystick number
display_joystick {
    ld (value),a
    ld ix,joystick
    ld a,c
    cp a,0
    jr z,port_0
    ld d,0
    ld e,JOYSTICK_SIZE
    ld b,c
index_loop:
    add ix,de
    djnz index_loop
port_0:
    set_charset charset_joystick

    ld a,(value)
    and a,$1e
    add a,dpad & $ff
    ld e,a
    ld a,0
    adc a,dpad >> 8
    ld d,a
    ld a,(de)
    ld l,a
    inc de
    ld a,(de)
    ld h,a
    push hl
    pop iy
    ld h,(ix + JOYSTICK_OFFSET_DPAD + 1)
    ld l,(ix + JOYSTICK_OFFSET_DPAD)
    call rl_expand_chars

    ld a,(value)
    and a,$01
    rlc a
    add a,button & $ff
    ld e,a
    ld a,0
    adc a,button >> 8
    ld d,a
    ld a,(de)
    ld l,a
    inc de
    ld a,(de)
    ld h,a
    push hl
    pop iy
    ld h,(ix + JOYSTICK_OFFSET_BUTTON + 1)
    ld l,(ix + JOYSTICK_OFFSET_BUTTON)
    call rl_expand_chars
    ret
}


.section data

joystick {
    .data screen + JOYSTICK_1_DPAD_OFFSET
    .data screen + JOYSTICK_1_BUTTON_OFFSET

    .data screen + JOYSTICK_2_DPAD_OFFSET
    .data screen + JOYSTICK_2_BUTTON_OFFSET

    .if .defined(PLATFORM_NEXT) || .defined(PLATFORM_N_GO) {
        .data screen + JOYSTICK_3_DPAD_OFFSET
        .data screen + JOYSTICK_3_BUTTON_OFFSET
    }
}


.section reserved

value .reserve 1
