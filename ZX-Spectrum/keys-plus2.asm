; keys-plus2.asm -- keyboard layout 48k

; This file is automatically created by ./key-table from keys-plus2.key.
; Do not edit.

global keys_48k, num_keys_48k, display_key_4,display_key_2,display_key_enter,display_key_9,display_key_3,display_key_5

include "platform.inc"

section data_user

num_keys_48k:
	byte 58

keys_48k:
    word screen + 2051, color + 259, display_key_4
    word screen + 2057, color + 265, display_key_2
    word screen + 2059, color + 267, display_key_2
    word screen + 2061, color + 269, display_key_2
    word screen + 2063, color + 271, display_key_2
    word screen + 200, color + 200, display_key_2
    word screen + 202, color + 202, display_key_2
    word screen + 204, color + 204, display_key_2
    word screen + 206, color + 206, display_key_2
    word screen + 208, color + 208, display_key_2
    word screen + 136, color + 136, display_key_2
    word screen + 138, color + 138, display_key_2
    word screen + 140, color + 140, display_key_2
    word screen + 142, color + 142, display_key_2
    word screen + 144, color + 144, display_key_2
    word screen + 71, color + 71, display_key_2
    word screen + 73, color + 73, display_key_2
    word screen + 75, color + 75, display_key_2
    word screen + 77, color + 77, display_key_2
    word screen + 79, color + 79, display_key_2
    word screen + 89, color + 89, display_key_2
    word screen + 87, color + 87, display_key_2
    word screen + 85, color + 85, display_key_2
    word screen + 83, color + 83, display_key_2
    word screen + 81, color + 81, display_key_2
    word screen + 154, color + 154, display_key_2
    word screen + 152, color + 152, display_key_2
    word screen + 150, color + 150, display_key_2
    word screen + 148, color + 148, display_key_2
    word screen + 146, color + 146, display_key_2
    word screen + 154, color + 154, display_key_enter
    word screen + 216, color + 216, display_key_2
    word screen + 214, color + 214, display_key_2
    word screen + 212, color + 212, display_key_2
    word screen + 210, color + 210, display_key_2
    word screen + 2125, color + 333, display_key_9
    word screen + 2115, color + 323, display_key_2
    word screen + 2069, color + 277, display_key_2
    word screen + 2067, color + 275, display_key_2
    word screen + 2065, color + 273, display_key_2
    word screen + 67, color + 67, display_key_2
    word screen + 69, color + 69, display_key_2
    word screen + 91, color + 91, display_key_3
    word screen + 131, color + 131, display_key_3
    word screen + 134, color + 134, display_key_2
    word screen + 195, color + 195, display_key_3
    word screen + 198, color + 198, display_key_2
    word screen + 2055, color + 263, display_key_2
    word screen + 2071, color + 279, display_key_2
    word screen + 2117, color + 325, display_key_2
    word screen + 2119, color + 327, display_key_2
    word screen + 2121, color + 329, display_key_2
    word screen + 2123, color + 331, display_key_2
    word screen + 2134, color + 342, display_key_2
    word screen + 2136, color + 344, display_key_2
    word screen + 2138, color + 346, display_key_2
    word screen + 2073, color + 281, display_key_5
    word screen + 2140, color + 348, display_key_2
