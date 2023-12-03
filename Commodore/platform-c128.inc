.include "c128.inc"
.include "mmu.inc"

.include "platform-vicii.inc"

USE_KEYBOARD_SELECT_BITMASK = 1

screen = $8c00

charset = $a000
charset_keyboard_top = charset + $800
charset_keyboard_bottom = charset_keyboard_top + $800
sprites = charset_keyboard_bottom + $800
color_ram = $d800

sprite_logo = (sprites & $3fff) / 64

.section zero_page

.global tmp1 .reserve 1
.global ptr1 .reserve 2
.global ptr2 .reserve 2
.global ptr3 .reserve 2
