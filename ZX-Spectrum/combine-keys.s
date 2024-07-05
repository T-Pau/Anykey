.include "platform.inc"

.section code

.public combine_keys {
    .if .defined(USE_EXTENDED_KEYS) {
        ld ix,new_key_state + 56
    }
    .else {
        ld ix,new_key_state + 40
    }
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
}


get_address {
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
}


.section data

combine_list {
    .if !.defined(USE_EXTENDED_KEYS) {
        .data  0, 22 ; caps + 8: cursor right
        .data  0, 19 ; caps + 5: cursor left
        .data  0, 24 ; caps + 6: cursor down
        .data  0, 23 ; caps + 7: cursor up
        .data 36, 37 ; symbol + m: .
        .data 36, 38 ; symbol + n: ,
        .data 36, 25 ; symbol + p: "
        .data 36, 26 ; symbol + o: ;

        .data  0, 36 ; caps + symbol: extend mode
        .data  0, 16 ; caps + 2: caps lock
        .data  0, 21 ; caps + 9: graph
        .data  0, 17 ; caps + 3: true video
        .data  0, 18 ; caps + 4: inv video
        .data  0, 35 ; caps + space: break
        .data  0, 15 ; caps + 1: edit
        .data  0, 20 ; caps + 0: delete
    }

    .data  0,  0 ; right caps
    .data 36, 36 ; right symbol
    .data $ff
}