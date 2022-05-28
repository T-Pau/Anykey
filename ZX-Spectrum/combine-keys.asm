public combine_keys

include "keyboard.inc"

section code_user

combine_keys:
    ld ix,new_key_state + 40
    ld hl,combine_list
loop:
    call get_address
    cp a,$ff
    ret z
    ld a,(bc)
    ld e,a
    call get_address
    ld a,(bc)
    and a,e
    ld (ix),a
    inc ix
    jr loop

get_address:
    ld a,(hl)
    inc hl
    cp a,$ff
    ret z
    add a,new_key_state & $ff
    ld c,a
    ld a,new_key_state >> 8
    adc a,0
    ld b,a
    ret

section data_user

combine_list:
    byte  0, 17 ; caps + 3: true video
    byte  0, 18 ; caps + 4: inv video
    byte  0, 35 ; caps + space: break
    byte  0, 20 ; caps + 0: delete
    byte  0, 21 ; caps + 9: graph
    byte  0, 36 ; caps + symbol: extend mode
    byte  0, 15 ; caps + 1: edit
    byte  0, 16 ; caps + 2: caps lock
    byte 36, 37 ; symbol + m: .
    byte 36, 26 ; symbol + o: ;
    byte 36, 25 ; symbol + p: "
    byte  0, 19 ; caps + 5: cursor left
    byte  0, 22 ; caps + 8: cursor right
    byte  0, 23 ; caps + 7: cursor up
    byte  0, 24 ; caps + 6: cursor down
    byte 36, 38 ; symbol + n: ,
    byte $ff
