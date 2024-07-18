.include "features.inc"

.public .macro readnextreg address {
    ld a, address
    ld bc, $243b
    out (c), a
    inc b
    in a, (c)
}

PORT_SPRITE_ATTRIBUTE = $57
PORT_SPRITE_PATTERN = $5b
PORT_SPRITE_SLOT = $303b

NEXTREG_SPRITE_LAYER = $15
NEXTREG_PALETTE_INDEX = $40
NEXTREG_PALETTE_VALUE = $41
NEXTREG_PALETTE_CONTROL = $43
NEXTREG_SPRITE_TRANSPARENCY = $4b

.section code

.public init_logo_sprites {
    nextreg NEXTREG_SPRITE_LAYER, $03

    ld a, 0
    ld bc, PORT_SPRITE_SLOT
    out (c), a
    ld bc, PORT_SPRITE_ATTRIBUTE
    ld hl, sprite_attributes
    ld d, 5 * 4
loop_attributes:
    ld a, (hl)
    inc hl
    out (c), a
    dec d
    ld a, d
    cp a, 0
    jr nz, loop_attributes

    ld bc, PORT_SPRITE_SLOT
    ld a,0
    out (c), a
    ld bc, PORT_SPRITE_PATTERN
    ld hl, sprite_data
    ld de, 128 * 4
loop_data:
    ld a, (hl)
    inc hl
    out(c), a
    dec de
    ld a, e
    or a, d
    jr nz, loop_data

    nextreg NEXTREG_SPRITE_TRANSPARENCY, $0f
    nextreg NEXTREG_PALETTE_CONTROL, $20
    nextreg NEXTREG_PALETTE_INDEX,0

    ld b, 5
    ld hl, sprite_palette
SpritePaletteLoop:
    ld a, (hl)
    inc hl
    nextreg NEXTREG_PALETTE_VALUE, a
    djnz SpritePaletteLoop

    ret
}


.section data

sprite_data {
    .data $ff, $ff, $00, $00, $0f, $ff, $ff, $ff
    .data $ff, $00, $00, $00, $00, $0f, $ff, $ff
    .data $f0, $00, $01, $11, $11, $11, $ff, $ff
    .data $f0, $00, $00, $00, $00, $00, $ff, $ff
    .data $00, $02, $22, $22, $22, $22, $2f, $ff
    .data $00, $00, $00, $00, $00, $00, $0f, $ff
    .data $00, $33, $33, $33, $33, $33, $3f, $ff
    .data $00, $00, $00, $00, $00, $00, $0f, $ff
    .data $00, $04, $44, $44, $44, $44, $4f, $ff
    .data $f0, $00, $00, $00, $00, $00, $ff, $ff
    .data $f0, $00, $05, $55, $55, $55, $ff, $ff
    .data $ff, $00, $00, $00, $00, $0f, $ff, $ff
    .data $ff, $ff, $00, $00, $0f, $ff, $ff, $ff
    .data $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff
    .data $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff
    .data $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff

    .data $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff
    .data $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff
    .data $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff
    .data $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff
    .data $00, $00, $00, $ff, $ff, $00, $ff, $ff
    .data $ff, $00, $ff, $ff, $ff, $00, $ff, $ff
    .data $ff, $00, $ff, $ff, $ff, $ff, $ff, $ff
    .data $ff, $00, $ff, $ff, $ff, $ff, $ff, $ff
    .data $ff, $00, $ff, $ff, $ff, $ff, $ff, $ff
    .data $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff
    .data $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff
    .data $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff
    .data $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff
    .data $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff
    .data $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff
    .data $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff

    .data $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff
    .data $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff
    .data $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff
    .data $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff
    .data $00, $00, $0f, $ff, $f0, $00, $0f, $ff
    .data $00, $ff, $00, $ff, $00, $ff, $00, $ff
    .data $00, $00, $0f, $ff, $00, $00, $00, $ff
    .data $00, $ff, $ff, $ff, $00, $ff, $00, $ff
    .data $00, $ff, $ff, $ff, $00, $ff, $00, $ff
    .data $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff
    .data $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff
    .data $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff
    .data $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff
    .data $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff
    .data $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff
    .data $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff

    .data $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff
    .data $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff
    .data $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff
    .data $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff
    .data $00, $ff, $00, $ff, $ff, $ff, $ff, $ff
    .data $00, $ff, $00, $ff, $ff, $ff, $ff, $ff
    .data $00, $ff, $00, $ff, $ff, $ff, $ff, $ff
    .data $00, $ff, $00, $ff, $ff, $ff, $ff, $ff
    .data $f0, $00, $0f, $ff, $ff, $ff, $ff, $ff
    .data $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff
    .data $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff
    .data $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff
    .data $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff
    .data $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff
    .data $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff
    .data $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff
}


sprite_attributes {
    .data 233, 229, 0, $c0, $80
    .data 16, 0, 0, $c0, $60
    .data 32, 0, 0, $c1, $40
    .data 48, 0, 0, $c1, $60
}


sprite_palette {
	.data %00000000 ; black
	.data %10100000 ; red
	.data %10101000 ; orange
	.data %10110100 ; yellow
	.data %00010100 ; green
	.data %00000010 ; bule
}
