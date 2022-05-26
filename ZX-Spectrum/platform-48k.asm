include "platform.inc"

section data_user

charset:
    incbin "charset-48k.bin"

screen_main:
    incbin "keyboard-48k.bin"

colors_main:
    byte 32 * 3 + 4, 7<<3
    byte 24, 7, 8, 7<<3
    byte 24, UNCHECKED_COLOR, 8, 7<<3
    byte 24, UNCHECKED_COLOR, 8, 7<<3
    byte 24, UNCHECKED_COLOR, 8, 7<<3
    byte 24, UNCHECKED_COLOR, 8, 7<<3
    byte 24, UNCHECKED_COLOR, 8, 7<<3
    byte 24, UNCHECKED_COLOR, 8, 7<<3
    byte 24, UNCHECKED_COLOR, 8, 7<<3
    byte 24, UNCHECKED_COLOR, 8, 7<<3
    byte 24, 7
    byte 255, 7<<3
    byte (11*32+4) - 255, 7<<3
    byte 0

; TODO: create from .keys file
keys:
    byte 0
