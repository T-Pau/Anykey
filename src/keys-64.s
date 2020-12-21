; keys-64.s -- keyboard layout keys_64

; This file is automatically created by ./key-table from keys-64.key.
; Do not edit.

.autoimport +

.include "anykey.inc"

.export keys_64_address_low, keys_64_address_high
.export keys_64_display_low, keys_64_display_high
.export keys_64_num_keys

.rodata

keys_64_num_keys:
    .byte 65

keys_64_address_low:
    .byte <(keys_64_offset + 30 + 40 * 0)
    .byte <(keys_64_offset + 28 + 40 * 4)
    .byte <(keys_64_offset + 30 + 40 * 6)
    .byte <(keys_64_offset + 35 + 40 * 6)
    .byte <(keys_64_offset + 35 + 40 * 0)
    .byte <(keys_64_offset + 35 + 40 * 2)
    .byte <(keys_64_offset + 35 + 40 * 4)
    .byte <(keys_64_offset + 28 + 40 * 6)
    .byte <(keys_64_offset + 6 + 40 * 0)
    .byte <(keys_64_offset + 5 + 40 * 2)
    .byte <(keys_64_offset + 4 + 40 * 4)
    .byte <(keys_64_offset + 8 + 40 * 0)
    .byte <(keys_64_offset + 5 + 40 * 6)
    .byte <(keys_64_offset + 6 + 40 * 4)
    .byte <(keys_64_offset + 7 + 40 * 2)
    .byte <(keys_64_offset + 2 + 40 * 4)
    .byte <(keys_64_offset + 10 + 40 * 0)
    .byte <(keys_64_offset + 9 + 40 * 2)
    .byte <(keys_64_offset + 8 + 40 * 4)
    .byte <(keys_64_offset + 12 + 40 * 0)
    .byte <(keys_64_offset + 9 + 40 * 6)
    .byte <(keys_64_offset + 10 + 40 * 4)
    .byte <(keys_64_offset + 11 + 40 * 2)
    .byte <(keys_64_offset + 7 + 40 * 6)
    .byte <(keys_64_offset + 14 + 40 * 0)
    .byte <(keys_64_offset + 13 + 40 * 2)
    .byte <(keys_64_offset + 12 + 40 * 4)
    .byte <(keys_64_offset + 16 + 40 * 0)
    .byte <(keys_64_offset + 13 + 40 * 6)
    .byte <(keys_64_offset + 14 + 40 * 4)
    .byte <(keys_64_offset + 15 + 40 * 2)
    .byte <(keys_64_offset + 11 + 40 * 6)
    .byte <(keys_64_offset + 18 + 40 * 0)
    .byte <(keys_64_offset + 17 + 40 * 2)
    .byte <(keys_64_offset + 16 + 40 * 4)
    .byte <(keys_64_offset + 20 + 40 * 0)
    .byte <(keys_64_offset + 17 + 40 * 6)
    .byte <(keys_64_offset + 18 + 40 * 4)
    .byte <(keys_64_offset + 19 + 40 * 2)
    .byte <(keys_64_offset + 15 + 40 * 6)
    .byte <(keys_64_offset + 22 + 40 * 0)
    .byte <(keys_64_offset + 21 + 40 * 2)
    .byte <(keys_64_offset + 20 + 40 * 4)
    .byte <(keys_64_offset + 24 + 40 * 0)
    .byte <(keys_64_offset + 21 + 40 * 6)
    .byte <(keys_64_offset + 22 + 40 * 4)
    .byte <(keys_64_offset + 23 + 40 * 2)
    .byte <(keys_64_offset + 19 + 40 * 6)
    .byte <(keys_64_offset + 26 + 40 * 0)
    .byte <(keys_64_offset + 25 + 40 * 2)
    .byte <(keys_64_offset + 24 + 40 * 4)
    .byte <(keys_64_offset + 28 + 40 * 0)
    .byte <(keys_64_offset + 25 + 40 * 6)
    .byte <(keys_64_offset + 26 + 40 * 4)
    .byte <(keys_64_offset + 27 + 40 * 2)
    .byte <(keys_64_offset + 23 + 40 * 6)
    .byte <(keys_64_offset + 2 + 40 * 0)
    .byte <(keys_64_offset + 0 + 40 * 0)
    .byte <(keys_64_offset + 0 + 40 * 2)
    .byte <(keys_64_offset + 4 + 40 * 0)
    .byte <(keys_64_offset + 6 + 40 * 8)
    .byte <(keys_64_offset + 0 + 40 * 6)
    .byte <(keys_64_offset + 3 + 40 * 2)
    .byte <(keys_64_offset + 0 + 40 * 4)
    .byte <(keys_64_offset + 29 + 40 * 2)

keys_64_address_high:
    .byte >(keys_64_offset + 30 + 40 * 0)
    .byte >(keys_64_offset + 28 + 40 * 4)
    .byte >(keys_64_offset + 30 + 40 * 6)
    .byte >(keys_64_offset + 35 + 40 * 6)
    .byte >(keys_64_offset + 35 + 40 * 0)
    .byte >(keys_64_offset + 35 + 40 * 2)
    .byte >(keys_64_offset + 35 + 40 * 4)
    .byte >(keys_64_offset + 28 + 40 * 6)
    .byte >(keys_64_offset + 6 + 40 * 0)
    .byte >(keys_64_offset + 5 + 40 * 2)
    .byte >(keys_64_offset + 4 + 40 * 4)
    .byte >(keys_64_offset + 8 + 40 * 0)
    .byte >(keys_64_offset + 5 + 40 * 6)
    .byte >(keys_64_offset + 6 + 40 * 4)
    .byte >(keys_64_offset + 7 + 40 * 2)
    .byte >(keys_64_offset + 2 + 40 * 4)
    .byte >(keys_64_offset + 10 + 40 * 0)
    .byte >(keys_64_offset + 9 + 40 * 2)
    .byte >(keys_64_offset + 8 + 40 * 4)
    .byte >(keys_64_offset + 12 + 40 * 0)
    .byte >(keys_64_offset + 9 + 40 * 6)
    .byte >(keys_64_offset + 10 + 40 * 4)
    .byte >(keys_64_offset + 11 + 40 * 2)
    .byte >(keys_64_offset + 7 + 40 * 6)
    .byte >(keys_64_offset + 14 + 40 * 0)
    .byte >(keys_64_offset + 13 + 40 * 2)
    .byte >(keys_64_offset + 12 + 40 * 4)
    .byte >(keys_64_offset + 16 + 40 * 0)
    .byte >(keys_64_offset + 13 + 40 * 6)
    .byte >(keys_64_offset + 14 + 40 * 4)
    .byte >(keys_64_offset + 15 + 40 * 2)
    .byte >(keys_64_offset + 11 + 40 * 6)
    .byte >(keys_64_offset + 18 + 40 * 0)
    .byte >(keys_64_offset + 17 + 40 * 2)
    .byte >(keys_64_offset + 16 + 40 * 4)
    .byte >(keys_64_offset + 20 + 40 * 0)
    .byte >(keys_64_offset + 17 + 40 * 6)
    .byte >(keys_64_offset + 18 + 40 * 4)
    .byte >(keys_64_offset + 19 + 40 * 2)
    .byte >(keys_64_offset + 15 + 40 * 6)
    .byte >(keys_64_offset + 22 + 40 * 0)
    .byte >(keys_64_offset + 21 + 40 * 2)
    .byte >(keys_64_offset + 20 + 40 * 4)
    .byte >(keys_64_offset + 24 + 40 * 0)
    .byte >(keys_64_offset + 21 + 40 * 6)
    .byte >(keys_64_offset + 22 + 40 * 4)
    .byte >(keys_64_offset + 23 + 40 * 2)
    .byte >(keys_64_offset + 19 + 40 * 6)
    .byte >(keys_64_offset + 26 + 40 * 0)
    .byte >(keys_64_offset + 25 + 40 * 2)
    .byte >(keys_64_offset + 24 + 40 * 4)
    .byte >(keys_64_offset + 28 + 40 * 0)
    .byte >(keys_64_offset + 25 + 40 * 6)
    .byte >(keys_64_offset + 26 + 40 * 4)
    .byte >(keys_64_offset + 27 + 40 * 2)
    .byte >(keys_64_offset + 23 + 40 * 6)
    .byte >(keys_64_offset + 2 + 40 * 0)
    .byte >(keys_64_offset + 0 + 40 * 0)
    .byte >(keys_64_offset + 0 + 40 * 2)
    .byte >(keys_64_offset + 4 + 40 * 0)
    .byte >(keys_64_offset + 6 + 40 * 8)
    .byte >(keys_64_offset + 0 + 40 * 6)
    .byte >(keys_64_offset + 3 + 40 * 2)
    .byte >(keys_64_offset + 0 + 40 * 4)
    .byte >(keys_64_offset + 29 + 40 * 2)

keys_64_display_low:
    .byte <(display_key_2)
    .byte <(display_key_4)
    .byte <(display_key_2)
    .byte <(display_key_3)
    .byte <(display_key_3)
    .byte <(display_key_3)
    .byte <(display_key_3)
    .byte <(display_key_2)
    .byte <(display_key_2)
    .byte <(display_key_2)
    .byte <(display_key_2)
    .byte <(display_key_2)
    .byte <(display_key_2)
    .byte <(display_key_2)
    .byte <(display_key_2)
    .byte <(display_key_2_3)
    .byte <(display_key_2)
    .byte <(display_key_2)
    .byte <(display_key_2)
    .byte <(display_key_2)
    .byte <(display_key_2)
    .byte <(display_key_2)
    .byte <(display_key_2)
    .byte <(display_key_2)
    .byte <(display_key_2)
    .byte <(display_key_2)
    .byte <(display_key_2)
    .byte <(display_key_2)
    .byte <(display_key_2)
    .byte <(display_key_2)
    .byte <(display_key_2)
    .byte <(display_key_2)
    .byte <(display_key_2)
    .byte <(display_key_2)
    .byte <(display_key_2)
    .byte <(display_key_2)
    .byte <(display_key_2)
    .byte <(display_key_2)
    .byte <(display_key_2)
    .byte <(display_key_2)
    .byte <(display_key_2)
    .byte <(display_key_2)
    .byte <(display_key_2)
    .byte <(display_key_2)
    .byte <(display_key_2)
    .byte <(display_key_2)
    .byte <(display_key_2)
    .byte <(display_key_2)
    .byte <(display_key_2)
    .byte <(display_key_2)
    .byte <(display_key_2)
    .byte <(display_key_2)
    .byte <(display_key_3)
    .byte <(display_key_2)
    .byte <(display_key_2)
    .byte <(display_key_2)
    .byte <(display_key_2)
    .byte <(display_key_2)
    .byte <(display_key_3)
    .byte <(display_key_2)
    .byte <(display_key_17)
    .byte <(display_key_2)
    .byte <(display_key_2)
    .byte <(display_key_2)
    .byte <(display_key_3)

keys_64_display_high:
    .byte >(display_key_2)
    .byte >(display_key_4)
    .byte >(display_key_2)
    .byte >(display_key_3)
    .byte >(display_key_3)
    .byte >(display_key_3)
    .byte >(display_key_3)
    .byte >(display_key_2)
    .byte >(display_key_2)
    .byte >(display_key_2)
    .byte >(display_key_2)
    .byte >(display_key_2)
    .byte >(display_key_2)
    .byte >(display_key_2)
    .byte >(display_key_2)
    .byte >(display_key_2_3)
    .byte >(display_key_2)
    .byte >(display_key_2)
    .byte >(display_key_2)
    .byte >(display_key_2)
    .byte >(display_key_2)
    .byte >(display_key_2)
    .byte >(display_key_2)
    .byte >(display_key_2)
    .byte >(display_key_2)
    .byte >(display_key_2)
    .byte >(display_key_2)
    .byte >(display_key_2)
    .byte >(display_key_2)
    .byte >(display_key_2)
    .byte >(display_key_2)
    .byte >(display_key_2)
    .byte >(display_key_2)
    .byte >(display_key_2)
    .byte >(display_key_2)
    .byte >(display_key_2)
    .byte >(display_key_2)
    .byte >(display_key_2)
    .byte >(display_key_2)
    .byte >(display_key_2)
    .byte >(display_key_2)
    .byte >(display_key_2)
    .byte >(display_key_2)
    .byte >(display_key_2)
    .byte >(display_key_2)
    .byte >(display_key_2)
    .byte >(display_key_2)
    .byte >(display_key_2)
    .byte >(display_key_2)
    .byte >(display_key_2)
    .byte >(display_key_2)
    .byte >(display_key_2)
    .byte >(display_key_3)
    .byte >(display_key_2)
    .byte >(display_key_2)
    .byte >(display_key_2)
    .byte >(display_key_2)
    .byte >(display_key_2)
    .byte >(display_key_3)
    .byte >(display_key_2)
    .byte >(display_key_17)
    .byte >(display_key_2)
    .byte >(display_key_2)
    .byte >(display_key_2)
    .byte >(display_key_3)
