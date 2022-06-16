section code_user

global init_logo_sprites
init_logo_sprites:
    ld bc, $303b
    out (c), 0
    ld hl, sprite_data
    ld de, 8 * 16 * 4
data_loop:
    ld a,(hl)
    nextreg $56, a
    dec de
    ld a, d
    or a, e
    jr nz, data_loop

    out (c), 0
    ld hl, sprite_attributes
    ld de, 4 * 5
attribute_loop:
    ld a,(hl)
    nextreg $57, a
    dec de
    ld a, d
    or a, e
    jr nz, attribute_loop

    nextreg $15, $03 ; enable sprites, make visible in border
    nextreg $4b, $0f ; select transparent palette index

    ret

section data_user

sprite_data:
    byte $ff, $ff, $00, $00, $0f, $ff, $ff, $ff
    byte $ff, $00, $00, $00, $00, $0f, $ff, $ff
    byte $f0, $00, $01, $11, $11, $11, $ff, $ff
    byte $f0, $00, $00, $00, $00, $00, $ff, $ff
    byte $00, $02, $22, $22, $22, $22, $2f, $ff
    byte $00, $00, $00, $00, $00, $00, $0f, $ff
    byte $00, $33, $33, $33, $33, $33, $3f, $ff
    byte $00, $00, $00, $00, $00, $00, $0f, $ff
    byte $00, $04, $44, $44, $44, $44, $4f, $ff
    byte $f0, $00, $00, $00, $00, $00, $ff, $ff
    byte $f0, $00, $05, $55, $55, $55, $ff, $ff
    byte $ff, $00, $00, $00, $00, $0f, $ff, $ff
    byte $ff, $ff, $00, $00, $0f, $ff, $ff, $ff
    byte $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff
    byte $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff
    byte $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff

    byte $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff
    byte $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff
    byte $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff
    byte $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff
    byte $00, $00, $00, $ff, $ff, $00, $ff, $ff
    byte $ff, $00, $ff, $ff, $ff, $00, $ff, $ff
    byte $ff, $00, $ff, $ff, $ff, $ff, $ff, $ff
    byte $ff, $00, $ff, $ff, $ff, $ff, $ff, $ff
    byte $ff, $00, $ff, $ff, $ff, $ff, $ff, $ff
    byte $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff
    byte $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff
    byte $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff
    byte $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff
    byte $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff
    byte $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff
    byte $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff

    byte $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff
    byte $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff
    byte $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff
    byte $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff
    byte $00, $00, $0f, $ff, $f0, $00, $0f, $ff
    byte $00, $ff, $00, $ff, $00, $ff, $00, $ff
    byte $00, $00, $0f, $ff, $00, $00, $00, $ff
    byte $00, $ff, $ff, $ff, $00, $ff, $00, $ff
    byte $00, $ff, $ff, $ff, $00, $ff, $00, $ff
    byte $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff
    byte $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff
    byte $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff
    byte $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff
    byte $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff
    byte $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff
    byte $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff

    byte $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff
    byte $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff
    byte $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff
    byte $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff
    byte $00, $ff, $00, $ff, $ff, $ff, $ff, $ff
    byte $00, $ff, $00, $ff, $ff, $ff, $ff, $ff
    byte $00, $ff, $00, $ff, $ff, $ff, $ff, $ff
    byte $00, $ff, $00, $ff, $ff, $ff, $ff, $ff
    byte $f0, $00, $0f, $ff, $ff, $ff, $ff, $ff
    byte $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff
    byte $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff
    byte $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff
    byte $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff
    byte $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff
    byte $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff
    byte $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff

sprite_attributes:
    byte 40, 40, 0, $c0, $80
    byte 16, 0, 0, $c1, $40
    byte 32, 0, 0, $c2, $40
    byte 64, 0, 0, $c3, $40
