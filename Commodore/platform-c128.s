.include "platform-vicii.inc"

USE_KEYBOARD_SELECT_BITMASK = 1

screen = $8c00

charset = $a000
charset_keyboard_top = charset + $800
charset_keyboard_bottom = charset_keyboard_top + $800
sprites = charset_keyboard_bottom + $800
color_ram = $d800

sprite_logo = (sprites & $3fff) / 64

