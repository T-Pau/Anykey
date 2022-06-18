section code_user

PORT_SPRITE_ATTRIBUTE = $57
PORT_SPRITE_PATTERN = $5b
PORT_SPRITE_SLOT = $303b

NEXTREG_SPRITE_LAYER = $15
NEXTREG_PALETTE_INDEX = $40
NEXTREG_PALETTE_VALUE = $41
NEXTREG_PALETTE_CONTROL = $43
NEXTREG_SPRITE_TRANSPARENCY = $4b


global init_logo_sprites
init_logo_sprites:
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
    byte 233, 229, 0, $c0, $80
    byte 16, 0, 0, $c0, $60
    byte 32, 0, 0, $c1, $40
    byte 48, 0, 0, $c1, $60

sprite_palette:
	byte %00000000 ; black
	byte %10100000 ; red
	byte %10101000 ; orange
	byte %10110100 ; yellow
	byte %00010100 ; green
	byte %00000010 ; bule
