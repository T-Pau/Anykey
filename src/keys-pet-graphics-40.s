; keys-pet-graphics-40.s -- keyboard layout keys_pet_graphics_40

; This file is automatically created by ./key-table from keys-pet-graphics-40.key.
; Do not edit.

.autoimport +

.include "defines.inc"

.export keys_pet_graphics_40_address_low, keys_pet_graphics_40_address_high
.export keys_pet_graphics_40_display_low, keys_pet_graphics_40_display_high
.export keys_pet_graphics_40_num_keys

.rodata

keys_pet_graphics_40_num_keys:
    .byte 80

keys_pet_graphics_40_address_low:
    .byte <(screen + 80)
    .byte <(screen + 85)
    .byte <(screen + 89)
    .byte <(screen + 86)
    .byte <(screen + 88)
    .byte <(screen + 90)
    .byte <(screen + 92)
    .byte <(screen + 94)
    .byte <(screen + 81)
    .byte <(screen + 83)
    .byte <(screen + 85)
    .byte <(screen + 87)
    .byte <(screen + 89)
    .byte <(screen + 80)
    .byte <(screen + 93)
    .byte <(screen + 95)
    .byte <(screen + 120)
    .byte <(screen + 122)
    .byte <(screen + 124)
    .byte <(screen + 126)
    .byte <(screen + 128)
    .byte <(screen + 130)
    .byte <(screen + 132)
    .byte <(screen + 134)
    .byte <(screen + 121)
    .byte <(screen + 123)
    .byte <(screen + 125)
    .byte <(screen + 127)
    .byte <(screen + 129)
    .byte <(screen + 80)
    .byte <(screen + 133)
    .byte <(screen + 135)
    .byte <(screen + 160)
    .byte <(screen + 162)
    .byte <(screen + 164)
    .byte <(screen + 166)
    .byte <(screen + 168)
    .byte <(screen + 80)
    .byte <(screen + 172)
    .byte <(screen + 174)
    .byte <(screen + 161)
    .byte <(screen + 163)
    .byte <(screen + 165)
    .byte <(screen + 167)
    .byte <(screen + 169)
    .byte <(screen + 80)
    .byte <(screen + 173)
    .byte <(screen + 175)
    .byte <(screen + 200)
    .byte <(screen + 202)
    .byte <(screen + 204)
    .byte <(screen + 206)
    .byte <(screen + 208)
    .byte <(screen + 170)
    .byte <(screen + 212)
    .byte <(screen + 214)
    .byte <(screen + 201)
    .byte <(screen + 203)
    .byte <(screen + 205)
    .byte <(screen + 207)
    .byte <(screen + 209)
    .byte <(screen + 80)
    .byte <(screen + 213)
    .byte <(screen + 215)
    .byte <(screen + 240)
    .byte <(screen + 242)
    .byte <(screen + 244)
    .byte <(screen + 80)
    .byte <(screen + 248)
    .byte <(screen + 250)
    .byte <(screen + 252)
    .byte <(screen + 254)
    .byte <(screen + 241)
    .byte <(screen + 243)
    .byte <(screen + 245)
    .byte <(screen + 247)
    .byte <(screen + 249)
    .byte <(screen + 91)
    .byte <(screen + 253)
    .byte <(screen + 255)

keys_pet_graphics_40_address_high:
    .byte >(screen + 80)
    .byte >(screen + 85)
    .byte >(screen + 89)
    .byte >(screen + 86)
    .byte >(screen + 88)
    .byte >(screen + 90)
    .byte >(screen + 92)
    .byte >(screen + 94)
    .byte >(screen + 81)
    .byte >(screen + 83)
    .byte >(screen + 85)
    .byte >(screen + 87)
    .byte >(screen + 89)
    .byte >(screen + 80)
    .byte >(screen + 93)
    .byte >(screen + 95)
    .byte >(screen + 120)
    .byte >(screen + 122)
    .byte >(screen + 124)
    .byte >(screen + 126)
    .byte >(screen + 128)
    .byte >(screen + 130)
    .byte >(screen + 132)
    .byte >(screen + 134)
    .byte >(screen + 121)
    .byte >(screen + 123)
    .byte >(screen + 125)
    .byte >(screen + 127)
    .byte >(screen + 129)
    .byte >(screen + 80)
    .byte >(screen + 133)
    .byte >(screen + 135)
    .byte >(screen + 160)
    .byte >(screen + 162)
    .byte >(screen + 164)
    .byte >(screen + 166)
    .byte >(screen + 168)
    .byte >(screen + 80)
    .byte >(screen + 172)
    .byte >(screen + 174)
    .byte >(screen + 161)
    .byte >(screen + 163)
    .byte >(screen + 165)
    .byte >(screen + 167)
    .byte >(screen + 169)
    .byte >(screen + 80)
    .byte >(screen + 173)
    .byte >(screen + 175)
    .byte >(screen + 200)
    .byte >(screen + 202)
    .byte >(screen + 204)
    .byte >(screen + 206)
    .byte >(screen + 208)
    .byte >(screen + 170)
    .byte >(screen + 212)
    .byte >(screen + 214)
    .byte >(screen + 201)
    .byte >(screen + 203)
    .byte >(screen + 205)
    .byte >(screen + 207)
    .byte >(screen + 209)
    .byte >(screen + 80)
    .byte >(screen + 213)
    .byte >(screen + 215)
    .byte >(screen + 240)
    .byte >(screen + 242)
    .byte >(screen + 244)
    .byte >(screen + 80)
    .byte >(screen + 248)
    .byte >(screen + 250)
    .byte >(screen + 252)
    .byte >(screen + 254)
    .byte >(screen + 241)
    .byte >(screen + 243)
    .byte >(screen + 245)
    .byte >(screen + 247)
    .byte >(screen + 249)
    .byte >(screen + 91)
    .byte >(screen + 253)
    .byte >(screen + 255)

keys_pet_graphics_40_display_low:
    .byte <(display_key_40_full)
    .byte <(display_key_40_top)
    .byte <(display_key_40_top)
    .byte <(display_key_n)
    .byte <(display_key_n)
    .byte <(display_key_n)
    .byte <(display_key_n)
    .byte <(display_key_n)
    .byte <(display_key_n)
    .byte <(display_key_n)
    .byte <(display_key_n)
    .byte <(display_key_n)
    .byte <(display_key_n)
    .byte <(display_key_s)
    .byte <(display_key_n)
    .byte <(display_key_n)
    .byte <(display_key_n)
    .byte <(display_key_n)
    .byte <(display_key_n)
    .byte <(display_key_n)
    .byte <(display_key_n)
    .byte <(display_key_n)
    .byte <(display_key_n)
    .byte <(display_key_n)
    .byte <(display_key_n)
    .byte <(display_key_n)
    .byte <(display_key_n)
    .byte <(display_key_n)
    .byte <(display_key_n)
    .byte <(display_key_s)
    .byte <(display_key_n)
    .byte <(display_key_n)
    .byte <(display_key_n)
    .byte <(display_key_n)
    .byte <(display_key_n)
    .byte <(display_key_n)
    .byte <(display_key_n)
    .byte <(display_key_s)
    .byte <(display_key_n)
    .byte <(display_key_n)
    .byte <(display_key_n)
    .byte <(display_key_n)
    .byte <(display_key_n)
    .byte <(display_key_n)
    .byte <(display_key_n)
    .byte <(display_key_s)
    .byte <(display_key_n)
    .byte <(display_key_n)
    .byte <(display_key_n)
    .byte <(display_key_n)
    .byte <(display_key_n)
    .byte <(display_key_n)
    .byte <(display_key_n)
    .byte <(display_key_h)
    .byte <(display_key_n)
    .byte <(display_key_n)
    .byte <(display_key_n)
    .byte <(display_key_n)
    .byte <(display_key_n)
    .byte <(display_key_n)
    .byte <(display_key_n)
    .byte <(display_key_s)
    .byte <(display_key_n)
    .byte <(display_key_n)
    .byte <(display_key_n)
    .byte <(display_key_n)
    .byte <(display_key_n)
    .byte <(display_key_s)
    .byte <(display_key_n)
    .byte <(display_key_n)
    .byte <(display_key_n)
    .byte <(display_key_n)
    .byte <(display_key_n)
    .byte <(display_key_n)
    .byte <(display_key_w)
    .byte <(display_key_n)
    .byte <(display_key_n)
    .byte <(display_key_s)
    .byte <(display_key_n)
    .byte <(display_key_n)

keys_pet_graphics_40_display_high:
    .byte >(display_key_40_full)
    .byte >(display_key_40_top)
    .byte >(display_key_40_top)
    .byte >(display_key_n)
    .byte >(display_key_n)
    .byte >(display_key_n)
    .byte >(display_key_n)
    .byte >(display_key_n)
    .byte >(display_key_n)
    .byte >(display_key_n)
    .byte >(display_key_n)
    .byte >(display_key_n)
    .byte >(display_key_n)
    .byte >(display_key_s)
    .byte >(display_key_n)
    .byte >(display_key_n)
    .byte >(display_key_n)
    .byte >(display_key_n)
    .byte >(display_key_n)
    .byte >(display_key_n)
    .byte >(display_key_n)
    .byte >(display_key_n)
    .byte >(display_key_n)
    .byte >(display_key_n)
    .byte >(display_key_n)
    .byte >(display_key_n)
    .byte >(display_key_n)
    .byte >(display_key_n)
    .byte >(display_key_n)
    .byte >(display_key_s)
    .byte >(display_key_n)
    .byte >(display_key_n)
    .byte >(display_key_n)
    .byte >(display_key_n)
    .byte >(display_key_n)
    .byte >(display_key_n)
    .byte >(display_key_n)
    .byte >(display_key_s)
    .byte >(display_key_n)
    .byte >(display_key_n)
    .byte >(display_key_n)
    .byte >(display_key_n)
    .byte >(display_key_n)
    .byte >(display_key_n)
    .byte >(display_key_n)
    .byte >(display_key_s)
    .byte >(display_key_n)
    .byte >(display_key_n)
    .byte >(display_key_n)
    .byte >(display_key_n)
    .byte >(display_key_n)
    .byte >(display_key_n)
    .byte >(display_key_n)
    .byte >(display_key_h)
    .byte >(display_key_n)
    .byte >(display_key_n)
    .byte >(display_key_n)
    .byte >(display_key_n)
    .byte >(display_key_n)
    .byte >(display_key_n)
    .byte >(display_key_n)
    .byte >(display_key_s)
    .byte >(display_key_n)
    .byte >(display_key_n)
    .byte >(display_key_n)
    .byte >(display_key_n)
    .byte >(display_key_n)
    .byte >(display_key_s)
    .byte >(display_key_n)
    .byte >(display_key_n)
    .byte >(display_key_n)
    .byte >(display_key_n)
    .byte >(display_key_n)
    .byte >(display_key_n)
    .byte >(display_key_w)
    .byte >(display_key_n)
    .byte >(display_key_n)
    .byte >(display_key_s)
    .byte >(display_key_n)
    .byte >(display_key_n)

