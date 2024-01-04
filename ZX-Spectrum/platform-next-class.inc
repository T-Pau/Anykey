USE_EXTENDED_KEYS = 1

.public .macro readnextreg address {
    ld a, address
    ld bc, $243b
    out (c), a
    inc b
    in a, (c)
}
