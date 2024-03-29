public display_joystick_1, display_joystick_2, display_joystick_3

global set_charset, copy_chars, dpad, button

include "platform.inc"

JOYSTICK_OFFSET_DPAD = 0
JOYSTICK_OFFSET_BUTTON = 2
JOYSTICK_SIZE = 4

section code_user

display_joystick_1:
    ld a,$ef
    in a,($fe)
    xor a,$ff
    ld c,0
    jp display_joystick

display_joystick_2:
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

display_joystick_3:
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

; a: current value
; c: joystick number
display_joystick:
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
    ld h,charset_joystick >> 8
    ld l,charset_joystick & $ff
    call set_charset

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
    ld iy,hl
    ld h,(ix + JOYSTICK_OFFSET_DPAD + 1)
    ld l,(ix + JOYSTICK_OFFSET_DPAD)
    call copy_chars

    ld a,(value)
    and a,$01
    rlc a
    add a,button & 0xff
    ld e,a
    ld a,0
    adc a,button >> 8
    ld d,a
    ld a,(de)
    ld l,a
    inc de
    ld a,(de)
    ld h,a
    ld iy,hl
    ld h,(ix + JOYSTICK_OFFSET_BUTTON + 1)
    ld l,(ix + JOYSTICK_OFFSET_BUTTON)
    call copy_chars
    ret

section data_user

charset_joystick:
    incbin "charset-joystick.bin"

joystick:
    word screen + JOYSTICK_1_DPAD_OFFSET
    word screen + JOYSTICK_1_BUTTON_OFFSET

    word screen + JOYSTICK_2_DPAD_OFFSET
    word screen + JOYSTICK_2_BUTTON_OFFSET

IF JOYSTICK_3_DPAD_OFFSET
    word screen + JOYSTICK_3_DPAD_OFFSET
    word screen + JOYSTICK_3_BUTTON_OFFSET
ENDIF

section bss_user

value:
    defs 1
