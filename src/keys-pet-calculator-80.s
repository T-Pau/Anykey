; keys-pet-calculator-80.s -- keyboard layout keys_pet_calculator_80

; This file is automatically created by ./key-table from keys-pet-calculator-80.key.
; Do not edit.

.autoimport +

.include "defines.inc"

.export keys_pet_calculator_80_address_low, keys_pet_calculator_80_address_high
.export keys_pet_calculator_80_display_low, keys_pet_calculator_80_display_high
.export keys_pet_calculator_80_num_keys

.rodata

keys_pet_calculator_80_num_keys:
    .byte 80

keys_pet_calculator_80_address_low:
    .byte <(screen + 160)
    .byte <(screen + 170)
    .byte <(screen + 180)
    .byte <(screen + 190)
    .byte <(screen + 200)
    .byte <(screen + 210)
    .byte <(screen + 220)
    .byte <(screen + 230)
    .byte <(screen + 165)
    .byte <(screen + 175)
    .byte <(screen + 185)
    .byte <(screen + 195)
    .byte <(screen + 205)
    .byte <(screen + 160)
    .byte <(screen + 225)
    .byte <(screen + 235)
    .byte <(screen + 400)
    .byte <(screen + 410)
    .byte <(screen + 420)
    .byte <(screen + 430)
    .byte <(screen + 440)
    .byte <(screen + 450)
    .byte <(screen + 460)
    .byte <(screen + 470)
    .byte <(screen + 405)
    .byte <(screen + 415)
    .byte <(screen + 425)
    .byte <(screen + 435)
    .byte <(screen + 445)
    .byte <(screen + 160)
    .byte <(screen + 465)
    .byte <(screen + 475)
    .byte <(screen + 640)
    .byte <(screen + 650)
    .byte <(screen + 660)
    .byte <(screen + 670)
    .byte <(screen + 680)
    .byte <(screen + 160)
    .byte <(screen + 700)
    .byte <(screen + 710)
    .byte <(screen + 645)
    .byte <(screen + 655)
    .byte <(screen + 665)
    .byte <(screen + 675)
    .byte <(screen + 685)
    .byte <(screen + 160)
    .byte <(screen + 705)
    .byte <(screen + 715)
    .byte <(screen + 880)
    .byte <(screen + 890)
    .byte <(screen + 900)
    .byte <(screen + 910)
    .byte <(screen + 920)
    .byte <(screen + 690)
    .byte <(screen + 940)
    .byte <(screen + 950)
    .byte <(screen + 885)
    .byte <(screen + 895)
    .byte <(screen + 905)
    .byte <(screen + 915)
    .byte <(screen + 925)
    .byte <(screen + 160)
    .byte <(screen + 945)
    .byte <(screen + 955)
    .byte <(screen + 1120)
    .byte <(screen + 1130)
    .byte <(screen + 1140)
    .byte <(screen + 160)
    .byte <(screen + 1160)
    .byte <(screen + 1170)
    .byte <(screen + 1180)
    .byte <(screen + 1190)
    .byte <(screen + 1125)
    .byte <(screen + 1135)
    .byte <(screen + 1145)
    .byte <(screen + 1155)
    .byte <(screen + 1165)
    .byte <(screen + 215)
    .byte <(screen + 1185)
    .byte <(screen + 1195)

keys_pet_calculator_80_address_high:
    .byte >(screen + 160)
    .byte >(screen + 170)
    .byte >(screen + 180)
    .byte >(screen + 190)
    .byte >(screen + 200)
    .byte >(screen + 210)
    .byte >(screen + 220)
    .byte >(screen + 230)
    .byte >(screen + 165)
    .byte >(screen + 175)
    .byte >(screen + 185)
    .byte >(screen + 195)
    .byte >(screen + 205)
    .byte >(screen + 160)
    .byte >(screen + 225)
    .byte >(screen + 235)
    .byte >(screen + 400)
    .byte >(screen + 410)
    .byte >(screen + 420)
    .byte >(screen + 430)
    .byte >(screen + 440)
    .byte >(screen + 450)
    .byte >(screen + 460)
    .byte >(screen + 470)
    .byte >(screen + 405)
    .byte >(screen + 415)
    .byte >(screen + 425)
    .byte >(screen + 435)
    .byte >(screen + 445)
    .byte >(screen + 160)
    .byte >(screen + 465)
    .byte >(screen + 475)
    .byte >(screen + 640)
    .byte >(screen + 650)
    .byte >(screen + 660)
    .byte >(screen + 670)
    .byte >(screen + 680)
    .byte >(screen + 160)
    .byte >(screen + 700)
    .byte >(screen + 710)
    .byte >(screen + 645)
    .byte >(screen + 655)
    .byte >(screen + 665)
    .byte >(screen + 675)
    .byte >(screen + 685)
    .byte >(screen + 160)
    .byte >(screen + 705)
    .byte >(screen + 715)
    .byte >(screen + 880)
    .byte >(screen + 890)
    .byte >(screen + 900)
    .byte >(screen + 910)
    .byte >(screen + 920)
    .byte >(screen + 690)
    .byte >(screen + 940)
    .byte >(screen + 950)
    .byte >(screen + 885)
    .byte >(screen + 895)
    .byte >(screen + 905)
    .byte >(screen + 915)
    .byte >(screen + 925)
    .byte >(screen + 160)
    .byte >(screen + 945)
    .byte >(screen + 955)
    .byte >(screen + 1120)
    .byte >(screen + 1130)
    .byte >(screen + 1140)
    .byte >(screen + 160)
    .byte >(screen + 1160)
    .byte >(screen + 1170)
    .byte >(screen + 1180)
    .byte >(screen + 1190)
    .byte >(screen + 1125)
    .byte >(screen + 1135)
    .byte >(screen + 1145)
    .byte >(screen + 1155)
    .byte >(screen + 1165)
    .byte >(screen + 215)
    .byte >(screen + 1185)
    .byte >(screen + 1195)

keys_pet_calculator_80_display_low:
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

keys_pet_calculator_80_display_high:
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
