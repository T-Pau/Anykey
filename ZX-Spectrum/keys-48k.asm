; keys-48k.asm -- keyboard layout 48k

; This file is automatically created by ./key-table from keys-48k.key.
; Do not edit.

global keys_48k, num_keys_48k, display_key_2

include "platform.inc"

section data_user

num_keys_48k:
	byte 4

keys_48k:
    word screen + 71, color + 71, display_key_2
    word screen + 73, color + 73, display_key_2
    word screen + 75, color + 75, display_key_2
    word screen + 136, color + 136, display_key_2
