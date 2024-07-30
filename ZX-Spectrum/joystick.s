.include "features.inc"

POSITION_JOYSTICK_1 = screen_offset(6, 15)
POSITION_JOYSTICK_2 = screen_offset(16, 15)

; Add offset to hl, correctin for screen boundaries
.macro screen_add offset {
    ld a,l
    add a,offset
    ld l,a
    jr nc,:+
    ld a,h
    add a,8
    ld h,a
:    
}

; Subtract offset from hl, correcting for section bounaries
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

.public display_plus2_joysticks {
    set_charset charset_joystick
    call read_sinclair_1
    ld de,POSITION_JOYSTICK_1
    call display_joystick_1_button
    call read_sinclair_2
    ld de,POSITION_JOYSTICK_2
    jp display_joystick_1_button
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

