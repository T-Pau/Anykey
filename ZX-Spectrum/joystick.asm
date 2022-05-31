public display_joystick

global set_charset, copy_chars, dpad, button

include "platform.inc"

JOYSTICK_OFFSET_PORT = 0
JOYSTICK_OFFSET_DPAD = 1
JOYSTICK_OFFSET_BUTTON = 3
JOYSTICK_SIZE = 5

section code_user

; a: port (0 or 1)
display_joystick:
    ld ix,joystick
    ld c,a
    cp a,0
    jr z,not_1
    ld d,0
    ld e,JOYSTICK_SIZE
    add ix,de
not_1:
    ld h,charset_joystick >> 8
    ld l,charset_joystick & $ff
    call set_charset

    ld a,(ix + JOYSTICK_OFFSET_PORT)
    in a,($fe)
    xor a,$ff
    dec c
    jr nz,not_1_read
    ld c,0
    ld b,5
mirror_loop:
    rr a
    rl c
    djnz mirror_loop
    ld a,c
not_1_read:
    ld (value),a
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
    byte $ef
    word screen + JOYSTICK_1_DPAD_OFFSET
    word screen + JOYSTICK_1_BUTTON_OFFSET

    byte $f7
    word screen + JOYSTICK_2_DPAD_OFFSET
    word screen + JOYSTICK_2_BUTTON_OFFSET


section bss_user

value:
    defs 1
