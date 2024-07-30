.include "features.inc"

JOYSTICK_OFFSET_DPAD = 0
JOYSTICK_OFFSET_BUTTON = 2
JOYSTICK_SIZE = 4

; Subtracts bc from hl, correcting for section bounaries
.macro screen_subtract offset {
    ld a,l
    sub a,offset
    ld l,a
    jr nc,:+
    ld a,h
    sub a,8
    ld h,a
:    
}

.section code

; Display 1 button joystick.
; Arguments:
;   de: screen position to display at
;   value: state of joystick
display_joystick_1_button {
    ld h,d
    ld l,e
    inc hl
    inc hl
    ld a,(value)
    and a,$0f
    ld ix,dpad
    call display_indexed
    screen_subtract $5f
    ld a,(value)    
    and a,$10
    ld ix,buttons_1
    jp display_button
}

; Read Cursor joystick.
; Result:
;   value: state of joystick
; Preserves: iy
read_cursor {
    ld de, joystick_keys_cursor
    jp read_keyboard_joystick
}

; Read Kempston 1 joystick.
; Result:
;   value: state of joystick
; Preserves: iy
read_kempston_1 {
    in a,(PORT_KEMPSTON_JOYSTICK_1)
    and a,$3f
    ld (value),a
    ret
}

; Read Kempston 2 joystick.
; Result:
;   value: state of joystick
; Preserves: iy
read_kempston_2 {
    in a,(PORT_KEMPSTON_JOYSTICK_2)
    and a,$3f
    ld (value),a
    ret
}

; Read Keyjoy joystick.
; Result:
;   value: state of joystick
; Preserves: iy
read_keyjoy {
    ld de, joystick_keys_keyjoy
    jp read_keyboard_joystick
}

; Read Megadrive 1 joystick.
; Result:
;   value: state of joystick
; Preserves: iy
read_megadrive_1 {
    in a,(PORT_KEMPSTON_JOYSTICK_1)
    ld (value),a
    ret
}

; Read Megadrive 2 joystick.
; Result:
;   value: state of joystick
; Preserves: iy
read_megadrive_2 {
    in a,(PORT_KEMPSTON_JOYSTICK_2)
    ld (value),a
    ret
}

; Read Sincliar 1 joystick.
; Result:
;   value: state of joystick
; Preserves: iy
read_sinclair_1 {
    ld de, joystick_keys_sinclair_1
    jp read_keyboard_joystick
}

; Read Sincliar 2 joystick.
; Result:
;   value: state of joystick
; Preserves: iy
read_sinclair_2 {
    ld de, joystick_keys_sinclair_2
    jp read_keyboard_joystick
}


; Read keyboard joystick.
; Arguments:
;   de: pionter to list of keys (highest bit first)
; Result:
;   value: state of joystick
; Preserves: iy
read_keyboard_joystick {
    ld ix,value
    ld (ix),0
    ld b,0
loop:
    ld a,(de)
    cp a,$ff
    ret z
    ld c,a
    ld hl,key_state
    add hl,bc
    ld a,(hl)
    and a,a
    jr z,:+
    scf
:   rl (ix)
    inc de
    jp loop
}

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

joystick_keys_sinclair_1 {
    .data KEY_0, KEY_9, KEY_8, KEY_6, KEY_7, $ff
}

joystick_keys_sinclair_2 {
    .data KEY_5, KEY_4, KEY_3, KEY_1, KEY_2, $ff
}

joystick_keys_cursor {
    .data KEY_0, KEY_7, KEY_6, KEY_5, KEY_8, $ff
}

joystick_keys_keyjoy {
    .data KEY_M, KEY_SPACE, KEY_Q, KEY_A, KEY_O, KEY_P, $ff
}

.section reserved

value .reserve 1

