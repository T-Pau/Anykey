; extended-keys.s -- read extended keys directly on Next and N-Go

.section code

.public init_extended_keys {
    ; disable emulating legacy key combinations for extended keys
    readnextreg $68
    or a, $10
    nextreg $68, a
    ret
}


.public read_extended_keys {
    ld hl,new_key_state + 40
    readnextreg $b0
    call read_row
    readnextreg $b1
    call read_row
    ret
}


read_row {
;    xor $ff
    ld c,a
    ld b,8

column_loop:
    ld a,c
    and $01
    ld (hl),a
    inc hl
    rrc c
    djnz column_loop
    ret
}