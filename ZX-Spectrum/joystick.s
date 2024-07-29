.include "features.inc"

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
    jr z,display
    ld d,0
    ld e,JOYSTICK_SIZE
    ld b,c
:   add ix,de
    djnz :-
display:
    set_charset charset_joystick

    ld a,(value)
    and a,$1e
    add a,<dpad
    ld e,a
    ld a,0
    adc a,>dpad
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
    add a,<buttons_1
    ld e,a
    ld a,0
    adc a,>buttons_1
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

; Display button
; Arguments:
;   a: non-zero if pressed
;   hl: destination on screen
;   ix: array of addresses runlength encoded characters for button display
display_button {
    and a,a
    jr z,:+
    ld a,1
:   jp display_indexed
}

; Display element by index
; Arguments:
;   a: index
;   hl: destinaton on screen
;   ix: array of addresses runlength encoded characters for button display
display_indexed {
    sla a
    ld b,0
    ld c,a
    add ix,bc
    ld b,(ix+1)
    ld c,(ix)
    push bc
    pop iy
    jp rl_expand_chars
}


.section data

joystick {
    .data SCREEN + JOYSTICK_1_DPAD_OFFSET
    .data SCREEN + JOYSTICK_1_BUTTON_OFFSET

    .data SCREEN + JOYSTICK_2_DPAD_OFFSET
    .data SCREEN + JOYSTICK_2_BUTTON_OFFSET
}


.section reserved

value .reserve 1
