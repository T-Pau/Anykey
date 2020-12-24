; keys-128.s -- keyboard layout keys_128

; This file is automatically created by ./key-table from keys-128.key.
; Do not edit.

.autoimport +

.include "defines.inc"

.export keys_128_address_low, keys_128_address_high
.export keys_128_display_low, keys_128_display_high
.export keys_128_num_keys

.rodata

keys_128_num_keys:
    .byte 91

keys_128_address_low:
    .byte <(screen + 190)
    .byte <(screen + 348)
    .byte <(screen + 430)
    .byte <(screen + 118)
    .byte <(screen + 112)
    .byte <(screen + 114)
    .byte <(screen + 116)
    .byte <(screen + 428)
    .byte <(screen + 166)
    .byte <(screen + 245)
    .byte <(screen + 324)
    .byte <(screen + 168)
    .byte <(screen + 405)
    .byte <(screen + 326)
    .byte <(screen + 247)
    .byte <(screen + 322)
    .byte <(screen + 170)
    .byte <(screen + 249)
    .byte <(screen + 328)
    .byte <(screen + 172)
    .byte <(screen + 409)
    .byte <(screen + 330)
    .byte <(screen + 251)
    .byte <(screen + 407)
    .byte <(screen + 174)
    .byte <(screen + 253)
    .byte <(screen + 332)
    .byte <(screen + 176)
    .byte <(screen + 413)
    .byte <(screen + 334)
    .byte <(screen + 255)
    .byte <(screen + 411)
    .byte <(screen + 178)
    .byte <(screen + 257)
    .byte <(screen + 336)
    .byte <(screen + 180)
    .byte <(screen + 417)
    .byte <(screen + 338)
    .byte <(screen + 259)
    .byte <(screen + 415)
    .byte <(screen + 182)
    .byte <(screen + 261)
    .byte <(screen + 340)
    .byte <(screen + 184)
    .byte <(screen + 421)
    .byte <(screen + 342)
    .byte <(screen + 263)
    .byte <(screen + 419)
    .byte <(screen + 186)
    .byte <(screen + 265)
    .byte <(screen + 344)
    .byte <(screen + 188)
    .byte <(screen + 425)
    .byte <(screen + 346)
    .byte <(screen + 267)
    .byte <(screen + 423)
    .byte <(screen + 162)
    .byte <(screen + 160)
    .byte <(screen + 240)
    .byte <(screen + 164)
    .byte <(screen + 487)
    .byte <(screen + 400)
    .byte <(screen + 243)
    .byte <(screen + 320)
    .byte <(screen + 92)
    .byte <(screen + 194)
    .byte <(screen + 274)
    .byte <(screen + 82)
    .byte <(screen + 354)
    .byte <(screen + 272)
    .byte <(screen + 192)
    .byte <(screen + 352)
    .byte <(screen + 80)
    .byte <(screen + 198)
    .byte <(screen + 278)
    .byte <(screen + 94)
    .byte <(screen + 358)
    .byte <(screen + 276)
    .byte <(screen + 196)
    .byte <(screen + 356)
    .byte <(screen + 84)
    .byte <(screen + 432)
    .byte <(screen + 436)
    .byte <(screen + 104)
    .byte <(screen + 106)
    .byte <(screen + 108)
    .byte <(screen + 110)
    .byte <(screen + 98)
    .byte <(screen + 86)
    .byte <(screen + 96)
    .byte <(screen + 269)

keys_128_address_high:
    .byte >(screen + 190)
    .byte >(screen + 348)
    .byte >(screen + 430)
    .byte >(screen + 118)
    .byte >(screen + 112)
    .byte >(screen + 114)
    .byte >(screen + 116)
    .byte >(screen + 428)
    .byte >(screen + 166)
    .byte >(screen + 245)
    .byte >(screen + 324)
    .byte >(screen + 168)
    .byte >(screen + 405)
    .byte >(screen + 326)
    .byte >(screen + 247)
    .byte >(screen + 322)
    .byte >(screen + 170)
    .byte >(screen + 249)
    .byte >(screen + 328)
    .byte >(screen + 172)
    .byte >(screen + 409)
    .byte >(screen + 330)
    .byte >(screen + 251)
    .byte >(screen + 407)
    .byte >(screen + 174)
    .byte >(screen + 253)
    .byte >(screen + 332)
    .byte >(screen + 176)
    .byte >(screen + 413)
    .byte >(screen + 334)
    .byte >(screen + 255)
    .byte >(screen + 411)
    .byte >(screen + 178)
    .byte >(screen + 257)
    .byte >(screen + 336)
    .byte >(screen + 180)
    .byte >(screen + 417)
    .byte >(screen + 338)
    .byte >(screen + 259)
    .byte >(screen + 415)
    .byte >(screen + 182)
    .byte >(screen + 261)
    .byte >(screen + 340)
    .byte >(screen + 184)
    .byte >(screen + 421)
    .byte >(screen + 342)
    .byte >(screen + 263)
    .byte >(screen + 419)
    .byte >(screen + 186)
    .byte >(screen + 265)
    .byte >(screen + 344)
    .byte >(screen + 188)
    .byte >(screen + 425)
    .byte >(screen + 346)
    .byte >(screen + 267)
    .byte >(screen + 423)
    .byte >(screen + 162)
    .byte >(screen + 160)
    .byte >(screen + 240)
    .byte >(screen + 164)
    .byte >(screen + 487)
    .byte >(screen + 400)
    .byte >(screen + 243)
    .byte >(screen + 320)
    .byte >(screen + 92)
    .byte >(screen + 194)
    .byte >(screen + 274)
    .byte >(screen + 82)
    .byte >(screen + 354)
    .byte >(screen + 272)
    .byte >(screen + 192)
    .byte >(screen + 352)
    .byte >(screen + 80)
    .byte >(screen + 198)
    .byte >(screen + 278)
    .byte >(screen + 94)
    .byte >(screen + 358)
    .byte >(screen + 276)
    .byte >(screen + 196)
    .byte >(screen + 356)
    .byte >(screen + 84)
    .byte >(screen + 432)
    .byte >(screen + 436)
    .byte >(screen + 104)
    .byte >(screen + 106)
    .byte >(screen + 108)
    .byte >(screen + 110)
    .byte >(screen + 98)
    .byte >(screen + 86)
    .byte >(screen + 96)
    .byte >(screen + 269)

keys_128_display_low:
    .byte <(display_key_2)
    .byte <(display_key_4)
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
    .byte <(display_key_18)
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
    .byte <(display_key_2_2)
    .byte <(display_key_2)
    .byte <(display_key_2)
    .byte <(display_key_2)
    .byte <(display_key_2)
    .byte <(display_key_4)
    .byte <(display_key_2)
    .byte <(display_key_2)
    .byte <(display_key_2)
    .byte <(display_key_2)
    .byte <(display_key_2)
    .byte <(display_key_2)
    .byte <(display_key_2)
    .byte <(display_key_2)
    .byte <(display_key_3)

keys_128_display_high:
    .byte >(display_key_2)
    .byte >(display_key_4)
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
    .byte >(display_key_18)
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
    .byte >(display_key_2_2)
    .byte >(display_key_2)
    .byte >(display_key_2)
    .byte >(display_key_2)
    .byte >(display_key_2)
    .byte >(display_key_4)
    .byte >(display_key_2)
    .byte >(display_key_2)
    .byte >(display_key_2)
    .byte >(display_key_2)
    .byte >(display_key_2)
    .byte >(display_key_2)
    .byte >(display_key_2)
    .byte >(display_key_2)
    .byte >(display_key_3)

