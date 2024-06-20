; keys-plus.s -- keyboard layout 48k

; This file is automatically created by ./key-table from keys-plus.key.
; Do not edit.

global keys_48k, num_keys_48k, display_key_4,display_key_2,display_key_enter,display_key_9,display_key_3,display_key_5

include "platform.inc"

section data_user

num_keys_48k:
	byte 58

keys_48k:
    word screen + 2115, color + 323, display_key_4
    word screen + 2121, color + 329, display_key_2
    word screen + 2123, color + 331, display_key_2
    word screen + 2125, color + 333, display_key_2
    word screen + 2127, color + 335, display_key_2
    word screen + 2056, color + 264, display_key_2
    word screen + 2058, color + 266, display_key_2
    word screen + 2060, color + 268, display_key_2
    word screen + 2062, color + 270, display_key_2
    word screen + 2064, color + 272, display_key_2
    word screen + 200, color + 200, display_key_2
    word screen + 202, color + 202, display_key_2
    word screen + 204, color + 204, display_key_2
    word screen + 206, color + 206, display_key_2
    word screen + 208, color + 208, display_key_2
    word screen + 135, color + 135, display_key_2
    word screen + 137, color + 137, display_key_2
    word screen + 139, color + 139, display_key_2
    word screen + 141, color + 141, display_key_2
    word screen + 143, color + 143, display_key_2
    word screen + 153, color + 153, display_key_2
    word screen + 151, color + 151, display_key_2
    word screen + 149, color + 149, display_key_2
    word screen + 147, color + 147, display_key_2
    word screen + 145, color + 145, display_key_2
    word screen + 218, color + 218, display_key_2
    word screen + 216, color + 216, display_key_2
    word screen + 214, color + 214, display_key_2
    word screen + 212, color + 212, display_key_2
    word screen + 210, color + 210, display_key_2
    word screen + 218, color + 218, display_key_enter
    word screen + 2072, color + 280, display_key_2
    word screen + 2070, color + 278, display_key_2
    word screen + 2068, color + 276, display_key_2
    word screen + 2066, color + 274, display_key_2
    word screen + 2189, color + 397, display_key_9
    word screen + 2179, color + 387, display_key_2
    word screen + 2133, color + 341, display_key_2
    word screen + 2131, color + 339, display_key_2
    word screen + 2129, color + 337, display_key_2
    word screen + 2187, color + 395, display_key_2
    word screen + 2185, color + 393, display_key_2
    word screen + 2200, color + 408, display_key_2
    word screen + 2198, color + 406, display_key_2
    word screen + 2135, color + 343, display_key_2
    word screen + 2202, color + 410, display_key_2
    word screen + 2183, color + 391, display_key_2
    word screen + 2181, color + 389, display_key_2
    word screen + 2051, color + 259, display_key_3
    word screen + 2119, color + 327, display_key_2
    word screen + 198, color + 198, display_key_2
    word screen + 131, color + 131, display_key_2
    word screen + 133, color + 133, display_key_2
    word screen + 155, color + 155, display_key_3
    word screen + 2054, color + 262, display_key_2
    word screen + 195, color + 195, display_key_3
    word screen + 2137, color + 345, display_key_5
    word screen + 2204, color + 412, display_key_2
