; keys-pet-business.s -- keyboard layout keys_pet_business

; This file is automatically created by ./key-table from keys-pet-business.key.
; Do not edit.

.autoimport +

.include "defines.inc"

.export keys_pet_business_address_low, keys_pet_business_address_high
.export keys_pet_business_display_low, keys_pet_business_display_high
.export keys_pet_business_num_keys

.rodata

keys_pet_business_num_keys:
    .byte 80

keys_pet_business_address_low:
    .byte <(screen + 173)
    .byte <(screen + 179)
    .byte <(screen + 185)
    .byte <(screen + 191)
    .byte <(screen + 197)
    .byte <(screen + 1385)
    .byte <(screen + 217)
    .byte <(screen + 223)
    .byte <(screen + 176)
    .byte <(screen + 182)
    .byte <(screen + 188)
    .byte <(screen + 194)
    .byte <(screen + 200)
    .byte <(screen + 1625)
    .byte <(screen + 220)
    .byte <(screen + 226)
    .byte <(screen + 414)
    .byte <(screen + 420)
    .byte <(screen + 426)
    .byte <(screen + 432)
    .byte <(screen + 438)
    .byte <(screen + 444)
    .byte <(screen + 457)
    .byte <(screen + 463)
    .byte <(screen + 417)
    .byte <(screen + 423)
    .byte <(screen + 429)
    .byte <(screen + 435)
    .byte <(screen + 441)
    .byte <(screen + 1625)
    .byte <(screen + 460)
    .byte <(screen + 466)
    .byte <(screen + 655)
    .byte <(screen + 661)
    .byte <(screen + 667)
    .byte <(screen + 673)
    .byte <(screen + 679)
    .byte <(screen + 1625)
    .byte <(screen + 697)
    .byte <(screen + 703)
    .byte <(screen + 658)
    .byte <(screen + 664)
    .byte <(screen + 670)
    .byte <(screen + 676)
    .byte <(screen + 682)
    .byte <(screen + 1625)
    .byte <(screen + 700)
    .byte <(screen + 706)
    .byte <(screen + 897)
    .byte <(screen + 903)
    .byte <(screen + 909)
    .byte <(screen + 915)
    .byte <(screen + 921)
    .byte <(screen + 688)
    .byte <(screen + 937)
    .byte <(screen + 943)
    .byte <(screen + 900)
    .byte <(screen + 906)
    .byte <(screen + 912)
    .byte <(screen + 918)
    .byte <(screen + 924)
    .byte <(screen + 1625)
    .byte <(screen + 940)
    .byte <(screen + 946)
    .byte <(screen + 891)
    .byte <(screen + 170)
    .byte <(screen + 209)
    .byte <(screen + 1619)
    .byte <(screen + 450)
    .byte <(screen + 927)
    .byte <(screen + 1177)
    .byte <(screen + 1183)
    .byte <(screen + 1370)
    .byte <(screen + 206)
    .byte <(screen + 1139)
    .byte <(screen + 447)
    .byte <(screen + 1382)
    .byte <(screen + 1385)
    .byte <(screen + 1180)
    .byte <(screen + 1186)

keys_pet_business_address_high:
    .byte >(screen + 173)
    .byte >(screen + 179)
    .byte >(screen + 185)
    .byte >(screen + 191)
    .byte >(screen + 197)
    .byte >(screen + 1385)
    .byte >(screen + 217)
    .byte >(screen + 223)
    .byte >(screen + 176)
    .byte >(screen + 182)
    .byte >(screen + 188)
    .byte >(screen + 194)
    .byte >(screen + 200)
    .byte >(screen + 1625)
    .byte >(screen + 220)
    .byte >(screen + 226)
    .byte >(screen + 414)
    .byte >(screen + 420)
    .byte >(screen + 426)
    .byte >(screen + 432)
    .byte >(screen + 438)
    .byte >(screen + 444)
    .byte >(screen + 457)
    .byte >(screen + 463)
    .byte >(screen + 417)
    .byte >(screen + 423)
    .byte >(screen + 429)
    .byte >(screen + 435)
    .byte >(screen + 441)
    .byte >(screen + 1625)
    .byte >(screen + 460)
    .byte >(screen + 466)
    .byte >(screen + 655)
    .byte >(screen + 661)
    .byte >(screen + 667)
    .byte >(screen + 673)
    .byte >(screen + 679)
    .byte >(screen + 1625)
    .byte >(screen + 697)
    .byte >(screen + 703)
    .byte >(screen + 658)
    .byte >(screen + 664)
    .byte >(screen + 670)
    .byte >(screen + 676)
    .byte >(screen + 682)
    .byte >(screen + 1625)
    .byte >(screen + 700)
    .byte >(screen + 706)
    .byte >(screen + 897)
    .byte >(screen + 903)
    .byte >(screen + 909)
    .byte >(screen + 915)
    .byte >(screen + 921)
    .byte >(screen + 688)
    .byte >(screen + 937)
    .byte >(screen + 943)
    .byte >(screen + 900)
    .byte >(screen + 906)
    .byte >(screen + 912)
    .byte >(screen + 918)
    .byte >(screen + 924)
    .byte >(screen + 1625)
    .byte >(screen + 940)
    .byte >(screen + 946)
    .byte >(screen + 891)
    .byte >(screen + 170)
    .byte >(screen + 209)
    .byte >(screen + 1619)
    .byte >(screen + 450)
    .byte >(screen + 927)
    .byte >(screen + 1177)
    .byte >(screen + 1183)
    .byte >(screen + 1370)
    .byte >(screen + 206)
    .byte >(screen + 1139)
    .byte >(screen + 447)
    .byte >(screen + 1382)
    .byte >(screen + 1385)
    .byte >(screen + 1180)
    .byte >(screen + 1186)

keys_pet_business_display_low:
    .byte <(display_key_3)
    .byte <(display_key_3)
    .byte <(display_key_3)
    .byte <(display_key_3)
    .byte <(display_key_3)
    .byte <(display_key_3)
    .byte <(display_key_3)
    .byte <(display_key_3)
    .byte <(display_key_3)
    .byte <(display_key_3)
    .byte <(display_key_3)
    .byte <(display_key_3)
    .byte <(display_key_3)
    .byte <(display_key_3)
    .byte <(display_key_3)
    .byte <(display_key_3)
    .byte <(display_key_3)
    .byte <(display_key_3)
    .byte <(display_key_3)
    .byte <(display_key_3)
    .byte <(display_key_3)
    .byte <(display_key_3)
    .byte <(display_key_3)
    .byte <(display_key_3)
    .byte <(display_key_3)
    .byte <(display_key_3)
    .byte <(display_key_3)
    .byte <(display_key_3)
    .byte <(display_key_3)
    .byte <(display_key_3)
    .byte <(display_key_3)
    .byte <(display_key_3)
    .byte <(display_key_3)
    .byte <(display_key_3)
    .byte <(display_key_3)
    .byte <(display_key_3)
    .byte <(display_key_3)
    .byte <(display_key_3)
    .byte <(display_key_3)
    .byte <(display_key_3)
    .byte <(display_key_3)
    .byte <(display_key_3)
    .byte <(display_key_3)
    .byte <(display_key_3)
    .byte <(display_key_3)
    .byte <(display_key_3)
    .byte <(display_key_3)
    .byte <(display_key_3)
    .byte <(display_key_3)
    .byte <(display_key_3)
    .byte <(display_key_3)
    .byte <(display_key_3)
    .byte <(display_key_3)
    .byte <(display_key_n)
    .byte <(display_key_3)
    .byte <(display_key_3)
    .byte <(display_key_3)
    .byte <(display_key_3)
    .byte <(display_key_3)
    .byte <(display_key_3)
    .byte <(display_key_3)
    .byte <(display_key_3)
    .byte <(display_key_3)
    .byte <(display_key_3)
    .byte <(display_key_6)
    .byte <(display_key_3)
    .byte <(display_key_3)
    .byte <(display_key_3)
    .byte <(display_key_3)
    .byte <(display_key_6)
    .byte <(display_key_3)
    .byte <(display_key_3)
    .byte <(display_key_3)
    .byte <(display_key_3)
    .byte <(display_key_space_26)
    .byte <(display_key_3)
    .byte <(display_key_3)
    .byte <(display_key_3)
    .byte <(display_key_3)
    .byte <(display_key_3)

keys_pet_business_display_high:
    .byte >(display_key_3)
    .byte >(display_key_3)
    .byte >(display_key_3)
    .byte >(display_key_3)
    .byte >(display_key_3)
    .byte >(display_key_3)
    .byte >(display_key_3)
    .byte >(display_key_3)
    .byte >(display_key_3)
    .byte >(display_key_3)
    .byte >(display_key_3)
    .byte >(display_key_3)
    .byte >(display_key_3)
    .byte >(display_key_3)
    .byte >(display_key_3)
    .byte >(display_key_3)
    .byte >(display_key_3)
    .byte >(display_key_3)
    .byte >(display_key_3)
    .byte >(display_key_3)
    .byte >(display_key_3)
    .byte >(display_key_3)
    .byte >(display_key_3)
    .byte >(display_key_3)
    .byte >(display_key_3)
    .byte >(display_key_3)
    .byte >(display_key_3)
    .byte >(display_key_3)
    .byte >(display_key_3)
    .byte >(display_key_3)
    .byte >(display_key_3)
    .byte >(display_key_3)
    .byte >(display_key_3)
    .byte >(display_key_3)
    .byte >(display_key_3)
    .byte >(display_key_3)
    .byte >(display_key_3)
    .byte >(display_key_3)
    .byte >(display_key_3)
    .byte >(display_key_3)
    .byte >(display_key_3)
    .byte >(display_key_3)
    .byte >(display_key_3)
    .byte >(display_key_3)
    .byte >(display_key_3)
    .byte >(display_key_3)
    .byte >(display_key_3)
    .byte >(display_key_3)
    .byte >(display_key_3)
    .byte >(display_key_3)
    .byte >(display_key_3)
    .byte >(display_key_3)
    .byte >(display_key_3)
    .byte >(display_key_n)
    .byte >(display_key_3)
    .byte >(display_key_3)
    .byte >(display_key_3)
    .byte >(display_key_3)
    .byte >(display_key_3)
    .byte >(display_key_3)
    .byte >(display_key_3)
    .byte >(display_key_3)
    .byte >(display_key_3)
    .byte >(display_key_3)
    .byte >(display_key_6)
    .byte >(display_key_3)
    .byte >(display_key_3)
    .byte >(display_key_3)
    .byte >(display_key_3)
    .byte >(display_key_6)
    .byte >(display_key_3)
    .byte >(display_key_3)
    .byte >(display_key_3)
    .byte >(display_key_3)
    .byte >(display_key_space_26)
    .byte >(display_key_3)
    .byte >(display_key_3)
    .byte >(display_key_3)
    .byte >(display_key_3)
    .byte >(display_key_3)

