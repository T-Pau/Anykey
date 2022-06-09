.segment "CHARSET"
.rodata

.export num_buttons_vic20
num_buttons_vic20:
    .byte 8

.export buttons_vic20
buttons_vic20:
    .word buttons_vic20_0
    .word buttons_vic20_1
    .word buttons_vic20_2
    .word buttons_vic20_3
    .word buttons_vic20_4
    .word buttons_vic20_5
    .word buttons_vic20_6
    .word buttons_vic20_7

buttons_vic20_0:
    .byte $5f, $60, $61, $62, $fe, $12, $63, $64
    .byte $65, $66, $ff, $00

buttons_vic20_1:
    .byte $67, $68, $61, $62, $fe, $12, $69, $6a
    .byte $65, $66, $ff, $00

buttons_vic20_2:
    .byte $5f, $6b, $6c, $62, $fe, $12, $63, $6d
    .byte $6e, $66, $ff, $00

buttons_vic20_3:
    .byte $67, $6f, $6c, $62, $fe, $12, $69, $70
    .byte $6e, $66, $ff, $00

buttons_vic20_4:
    .byte $5f, $60, $61, $71, $fe, $12, $63, $64
    .byte $65, $72, $ff, $00

buttons_vic20_5:
    .byte $67, $68, $61, $71, $fe, $12, $69, $6a
    .byte $65, $72, $ff, $00

buttons_vic20_6:
    .byte $5f, $6b, $6c, $71, $fe, $12, $63, $6d
    .byte $6e, $72, $ff, $00

buttons_vic20_7:
    .byte $67, $6f, $6c, $71, $fe, $12, $69, $70
    .byte $6e, $72, $ff, $00

.export num_dpad_vic20
num_dpad_vic20:
    .byte 16

.export dpad_vic20
dpad_vic20:
    .word dpad_vic20_0
    .word dpad_vic20_1
    .word dpad_vic20_2
    .word dpad_vic20_3
    .word dpad_vic20_4
    .word dpad_vic20_5
    .word dpad_vic20_6
    .word dpad_vic20_7
    .word dpad_vic20_8
    .word dpad_vic20_9
    .word dpad_vic20_10
    .word dpad_vic20_11
    .word dpad_vic20_12
    .word dpad_vic20_13
    .word dpad_vic20_14
    .word dpad_vic20_15

dpad_vic20_0:
    .byte $73, $74, $20, $fe, $13, $75, $76, $77
    .byte $fe, $13, $78, $79, $7a, $fe, $13, $7b
    .byte $7c, $cd, $ff, $00

dpad_vic20_1:
    .byte $73, $74, $20, $fe, $13, $75, $7d, $7e
    .byte $fe, $13, $78, $7f, $df, $fe, $13, $7b
    .byte $7c, $cd, $ff, $00

dpad_vic20_2:
    .byte $e0, $e1, $20, $fe, $13, $e2, $e3, $77
    .byte $fe, $13, $78, $79, $7a, $fe, $13, $7b
    .byte $7c, $cd, $ff, $00

dpad_vic20_3:
    .byte $e0, $e1, $20, $fe, $13, $e2, $e4, $7e
    .byte $fe, $13, $78, $7f, $df, $fe, $13, $7b
    .byte $7c, $cd, $ff, $00

dpad_vic20_4:
    .byte $73, $74, $20, $fe, $13, $75, $76, $77
    .byte $fe, $13, $e5, $e6, $7a, $fe, $13, $e7
    .byte $e8, $cd, $ff, $00

dpad_vic20_5:
    .byte $73, $74, $20, $fe, $13, $75, $7d, $7e
    .byte $fe, $13, $e5, $e9, $df, $fe, $13, $e7
    .byte $e8, $cd, $ff, $00

dpad_vic20_6:
    .byte $e0, $e1, $20, $fe, $13, $e2, $e3, $77
    .byte $fe, $13, $e5, $e6, $7a, $fe, $13, $e7
    .byte $e8, $cd, $ff, $00

dpad_vic20_7:
    .byte $e0, $e1, $20, $fe, $13, $e2, $e4, $7e
    .byte $fe, $13, $e5, $e9, $df, $fe, $13, $e7
    .byte $e8, $cd, $ff, $00

dpad_vic20_8:
    .byte $73, $74, $20, $fe, $13, $ea, $76, $77
    .byte $fe, $13, $eb, $79, $7a, $fe, $13, $7b
    .byte $7c, $cd, $ff, $00

dpad_vic20_9:
    .byte $73, $74, $20, $fe, $13, $ea, $7d, $7e
    .byte $fe, $13, $eb, $7f, $df, $fe, $13, $7b
    .byte $7c, $cd, $ff, $00

dpad_vic20_10:
    .byte $e0, $e1, $20, $fe, $13, $ec, $e3, $77
    .byte $fe, $13, $eb, $79, $7a, $fe, $13, $7b
    .byte $7c, $cd, $ff, $00

dpad_vic20_11:
    .byte $e0, $e1, $20, $fe, $13, $ec, $e4, $7e
    .byte $fe, $13, $eb, $7f, $df, $fe, $13, $7b
    .byte $7c, $cd, $ff, $00

dpad_vic20_12:
    .byte $73, $74, $20, $fe, $13, $ea, $76, $77
    .byte $fe, $13, $ed, $e6, $7a, $fe, $13, $e7
    .byte $e8, $cd, $ff, $00

dpad_vic20_13:
    .byte $73, $74, $20, $fe, $13, $ea, $7d, $7e
    .byte $fe, $13, $ed, $e9, $df, $fe, $13, $e7
    .byte $e8, $cd, $ff, $00

dpad_vic20_14:
    .byte $e0, $e1, $20, $fe, $13, $ec, $e3, $77
    .byte $fe, $13, $ed, $e6, $7a, $fe, $13, $e7
    .byte $e8, $cd, $ff, $00

dpad_vic20_15:
    .byte $e0, $e1, $20, $fe, $13, $ec, $e4, $7e
    .byte $fe, $13, $ed, $e9, $df, $fe, $13, $e7
    .byte $e8, $cd, $ff, $00
.segment "CHARSET"

.export keyboard_vic20_charset
keyboard_vic20_charset:
    .byte $f0, $c0, $c0, $c0, $00, $00, $00, $00
    .byte $0f, $03, $03, $03, $00, $00, $00, $00
    .byte $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff
    .byte $00, $7c, $fe, $82, $82, $82, $a2, $ba
    .byte $00, $7c, $fe, $82, $82, $92, $b2, $92
    .byte $00, $7c, $fe, $82, $82, $b2, $8a, $92
    .byte $00, $7c, $fe, $82, $82, $8a, $9a, $aa
    .byte $00, $7c, $fe, $82, $82, $ba, $a2, $b2
    .byte $00, $7c, $fe, $82, $82, $9a, $a2, $b2
    .byte $00, $7c, $fe, $82, $82, $ba, $8a, $92
    .byte $00, $7c, $fe, $82, $82, $92, $aa, $92
    .byte $00, $7c, $fe, $82, $82, $92, $aa, $9a
    .byte $00, $7c, $fe, $82, $82, $92, $aa, $aa
    .byte $00, $7c, $fe, $82, $82, $82, $92, $ba
    .byte $00, $7c, $fe, $82, $82, $82, $82, $ba
    .byte $00, $7c, $fe, $82, $82, $8a, $92, $ba
    .byte $00, $7c, $fe, $82, $82, $9a, $a2, $a2
    .byte $00, $7c, $fe, $82, $82, $92, $92, $92
    .byte $00, $07, $0f, $08, $08, $0b, $0a, $0b
    .byte $00, $fc, $fe, $02, $02, $92, $32, $12
    .byte $a2, $82, $82, $82, $fe, $7c, $00, $00
    .byte $92, $92, $82, $82, $fe, $7c, $00, $00
    .byte $a2, $ba, $82, $82, $fe, $7c, $00, $00
    .byte $8a, $b2, $82, $82, $fe, $7c, $00, $00
    .byte $ba, $8a, $82, $82, $fe, $7c, $00, $00
    .byte $aa, $92, $82, $82, $fe, $7c, $00, $00
    .byte $a2, $a2, $82, $82, $fe, $7c, $00, $00
    .byte $92, $82, $82, $82, $fe, $7c, $00, $00
    .byte $82, $82, $82, $82, $fe, $7c, $00, $00
    .byte $92, $ba, $82, $82, $fe, $7c, $00, $00
    .byte $a2, $9a, $82, $82, $fe, $7c, $00, $00
    .byte $0a, $0a, $08, $08, $0f, $07, $00, $00
    .byte $00, $00, $00, $00, $00, $00, $00, $00
    .byte $12, $12, $02, $02, $fe, $fc, $00, $00
    .byte $f0, $f0, $f0, $f0, $f0, $f0, $f0, $f0
    .byte $00, $07, $0f, $08, $08, $09, $0a, $0a
    .byte $00, $fc, $fe, $02, $02, $ba, $12, $12
    .byte $00, $7c, $fe, $82, $82, $aa, $aa, $aa
    .byte $00, $7c, $fe, $82, $82, $b2, $aa, $b2
    .byte $00, $7c, $fe, $82, $82, $ba, $92, $92
    .byte $00, $7c, $fe, $82, $82, $aa, $aa, $ba
    .byte $00, $7c, $fe, $82, $82, $aa, $92, $ba
    .byte $00, $7c, $fe, $82, $82, $92, $ba, $92
    .byte $00, $7f, $ff, $80, $80, $b3, $aa, $b3
    .byte $00, $c0, $e0, $20, $20, $a0, $20, $20
    .byte $00, $7f, $ff, $80, $80, $bb, $a0, $b1
    .byte $00, $c0, $e0, $20, $20, $20, $a0, $20
    .byte $0f, $0f, $0f, $0f, $0f, $0f, $0f, $0f
    .byte $0a, $09, $08, $08, $0f, $07, $00, $00
    .byte $12, $92, $02, $02, $fe, $fc, $00, $00
    .byte $aa, $9a, $82, $82, $fe, $7c, $00, $00
    .byte $ba, $aa, $82, $82, $fe, $7c, $00, $00
    .byte $aa, $aa, $82, $82, $fe, $7c, $00, $00
    .byte $92, $aa, $82, $82, $fe, $7c, $00, $00
    .byte $aa, $ab, $80, $80, $ff, $7f, $00, $00
    .byte $20, $a0, $20, $20, $e0, $c0, $00, $00
    .byte $a0, $a3, $80, $80, $ff, $7f, $00, $00
    .byte $a0, $20, $20, $20, $e0, $c0, $00, $00
    .byte $00, $7c, $fe, $82, $82, $92, $aa, $ba
    .byte $00, $7c, $fe, $82, $82, $9a, $a2, $92
    .byte $00, $7c, $fe, $82, $82, $b2, $aa, $aa
    .byte $00, $7c, $fe, $82, $82, $9a, $a2, $aa
    .byte $00, $7c, $fe, $82, $82, $8a, $8a, $8a
    .byte $00, $7c, $fe, $82, $82, $aa, $aa, $b2
    .byte $00, $7c, $fe, $82, $82, $a2, $a2, $a2
    .byte $00, $7c, $fe, $82, $82, $82, $92, $82
    .byte $00, $7c, $fe, $82, $82, $82, $ba, $82
    .byte $00, $fc, $fe, $02, $02, $ba, $22, $32
    .byte $82, $92, $82, $82, $fe, $7c, $00, $00
    .byte $aa, $b2, $82, $82, $fe, $7c, $00, $00
    .byte $ba, $82, $82, $82, $fe, $7c, $00, $00
    .byte $0a, $32, $02, $02, $fe, $fc, $00, $00
    .byte $00, $7c, $fe, $82, $82, $92, $aa, $a2
    .byte $c0, $80, $80, $80, $00, $00, $00, $00
    .byte $03, $01, $01, $01, $00, $00, $00, $00
    .byte $00, $00, $00, $80, $80, $80, $c0, $ff
    .byte $00, $00, $00, $01, $01, $01, $03, $ff
    .byte $00, $00, $00, $00, $00, $00, $00, $ff
    .byte $00, $7c, $fe, $82, $82, $aa, $aa, $92
    .byte $00, $7c, $fe, $82, $82, $aa, $ba, $aa
    .byte $00, $7c, $fe, $82, $82, $82, $82, $82
    .byte $00, $7c, $fe, $82, $82, $8a, $8a, $92
    .byte $00, $7c, $fe, $82, $82, $92, $aa, $82
    .byte $00, $7c, $fe, $82, $92, $a2, $92, $82
    .byte $00, $c0, $e0, $20, $20, $a0, $a0, $20
    .byte $92, $8a, $92, $82, $fe, $7c, $00, $00
    .byte $a2, $a2, $80, $80, $ff, $7f, $00, $00
    .byte $20, $20, $20, $20, $e0, $c0, $00, $00
    .byte $00, $7f, $ff, $80, $80, $80, $80, $80
    .byte $00, $ff, $ff, $00, $00, $00, $00, $00
    .byte $00, $c0, $e0, $20, $20, $20, $20, $20
    .byte $80, $80, $80, $80, $ff, $7f, $00, $00
    .byte $00, $00, $00, $00, $ff, $ff, $00, $00
    .byte $00, $00, $00, $c0, $c0, $c0, $f0, $ff
    .byte $00, $00, $00, $03, $03, $03, $0f, $ff
    .byte $1f, $31, $20, $60, $40, $44, $4c, $44
    .byte $03, $86, $84, $cc, $48, $49, $48, $48
    .byte $e0, $30, $10, $19, $09, $89, $49, $89
    .byte $7c, $c6, $82, $83, $01, $31, $09, $11
    .byte $44, $44, $40, $60, $20, $31, $1f, $00
    .byte $49, $49, $48, $cc, $84, $86, $03, $00
    .byte $09, $c9, $09, $19, $10, $30, $e0, $00
    .byte $09, $31, $01, $83, $82, $c6, $7c, $00
    .byte $1f, $3f, $3f, $7f, $7f, $7b, $73, $7b
    .byte $03, $86, $84, $cc, $c8, $c9, $c8, $c8
    .byte $7b, $7b, $7f, $7f, $3f, $3f, $1f, $00
    .byte $c9, $c9, $c8, $cc, $84, $86, $03, $00
    .byte $03, $87, $87, $cf, $4f, $4e, $4f, $4f
    .byte $e0, $f0, $f0, $f9, $f9, $79, $b9, $79
    .byte $4e, $4e, $4f, $cf, $87, $87, $03, $00
    .byte $f9, $39, $f9, $f9, $f0, $f0, $e0, $00
    .byte $03, $87, $87, $cf, $cf, $ce, $cf, $cf
    .byte $ce, $ce, $cf, $cf, $87, $87, $03, $00
    .byte $7c, $fe, $fe, $ff, $ff, $cf, $f7, $ef
    .byte $f7, $cf, $ff, $ff, $fe, $fe, $7c, $00
    .byte $00, $00, $01, $03, $06, $04, $04, $04
    .byte $00, $00, $f0, $18, $0c, $44, $e4, $a4
    .byte $3c, $66, $42, $c3, $81, $89, $98, $90
    .byte $a7, $0c, $08, $18, $10, $b2, $e3, $e1
    .byte $80, $c0, $40, $60, $20, $20, $20, $20
    .byte $98, $89, $81, $c3, $42, $66, $3c, $04
    .byte $e3, $b2, $10, $18, $08, $0c, $a7, $a4
    .byte $20, $20, $20, $60, $40, $c0, $80, $00
    .byte $04, $04, $06, $03, $01, $00, $00, $ff
    .byte $e4, $44, $0c, $18, $f0, $00, $00, $ff
    .byte $a7, $0f, $0f, $1f, $1f, $bd, $fc, $fe
    .byte $80, $c0, $c0, $e0, $e0, $e0, $e0, $e0
    .byte $fc, $bd, $1f, $1f, $0f, $0f, $a7, $a4
    .byte $f0, $c0, $c0, $c0, $00, $00, $00, $00
    .byte $0f, $03, $03, $03, $00, $00, $00, $00
    .byte $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff
    .byte $00, $7c, $fe, $fe, $fe, $fe, $de, $c6
    .byte $00, $7c, $fe, $fe, $fe, $ee, $ce, $ee
    .byte $00, $7c, $fe, $fe, $fe, $ce, $f6, $ee
    .byte $00, $7c, $fe, $fe, $fe, $f6, $e6, $d6
    .byte $00, $7c, $fe, $fe, $fe, $c6, $de, $ce
    .byte $00, $7c, $fe, $fe, $fe, $e6, $de, $ce
    .byte $00, $7c, $fe, $fe, $fe, $c6, $f6, $ee
    .byte $00, $7c, $fe, $fe, $fe, $ee, $d6, $ee
    .byte $00, $7c, $fe, $fe, $fe, $ee, $d6, $e6
    .byte $00, $7c, $fe, $fe, $fe, $ee, $d6, $d6
    .byte $00, $7c, $fe, $fe, $fe, $fe, $ee, $c6
    .byte $00, $7c, $fe, $fe, $fe, $fe, $fe, $c6
    .byte $00, $7c, $fe, $fe, $fe, $f6, $ee, $c6
    .byte $00, $7c, $fe, $fe, $fe, $e6, $de, $de
    .byte $00, $7c, $fe, $fe, $fe, $ee, $ee, $ee
    .byte $00, $07, $0f, $0f, $0f, $0c, $0d, $0c
    .byte $00, $fc, $fe, $fe, $fe, $6e, $ce, $ee
    .byte $de, $fe, $fe, $fe, $fe, $7c, $00, $00
    .byte $ee, $ee, $fe, $fe, $fe, $7c, $00, $00
    .byte $de, $c6, $fe, $fe, $fe, $7c, $00, $00
    .byte $f6, $ce, $fe, $fe, $fe, $7c, $00, $00
    .byte $c6, $f6, $fe, $fe, $fe, $7c, $00, $00
    .byte $d6, $ee, $fe, $fe, $fe, $7c, $00, $00
    .byte $de, $de, $fe, $fe, $fe, $7c, $00, $00
    .byte $ee, $fe, $fe, $fe, $fe, $7c, $00, $00
    .byte $fe, $fe, $fe, $fe, $fe, $7c, $00, $00
    .byte $ee, $c6, $fe, $fe, $fe, $7c, $00, $00
    .byte $de, $e6, $fe, $fe, $fe, $7c, $00, $00
    .byte $0d, $0d, $0f, $0f, $0f, $07, $00, $00
    .byte $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff
    .byte $ee, $ee, $fe, $fe, $fe, $fc, $00, $00
    .byte $f0, $f0, $f0, $f0, $f0, $f0, $f0, $f0
    .byte $00, $07, $0f, $0f, $0f, $0e, $0d, $0d
    .byte $00, $fc, $fe, $fe, $fe, $46, $ee, $ee
    .byte $00, $7c, $fe, $fe, $fe, $d6, $d6, $d6
    .byte $00, $7c, $fe, $fe, $fe, $ce, $d6, $ce
    .byte $00, $7c, $fe, $fe, $fe, $c6, $ee, $ee
    .byte $00, $7c, $fe, $fe, $fe, $d6, $d6, $c6
    .byte $00, $7c, $fe, $fe, $fe, $d6, $ee, $c6
    .byte $00, $7c, $fe, $fe, $fe, $ee, $c6, $ee
    .byte $00, $7f, $ff, $ff, $ff, $cc, $d5, $cc
    .byte $00, $c0, $e0, $e0, $e0, $60, $e0, $e0
    .byte $00, $7f, $ff, $ff, $ff, $c4, $df, $ce
    .byte $00, $c0, $e0, $e0, $e0, $e0, $60, $e0
    .byte $0f, $0f, $0f, $0f, $0f, $0f, $0f, $0f
    .byte $0d, $0e, $0f, $0f, $0f, $07, $00, $00
    .byte $ee, $6e, $fe, $fe, $fe, $fc, $00, $00
    .byte $d6, $e6, $fe, $fe, $fe, $7c, $00, $00
    .byte $c6, $d6, $fe, $fe, $fe, $7c, $00, $00
    .byte $d6, $d6, $fe, $fe, $fe, $7c, $00, $00
    .byte $ee, $d6, $fe, $fe, $fe, $7c, $00, $00
    .byte $d5, $d4, $ff, $ff, $ff, $7f, $00, $00
    .byte $e0, $60, $e0, $e0, $e0, $c0, $00, $00
    .byte $df, $dc, $ff, $ff, $ff, $7f, $00, $00
    .byte $60, $e0, $e0, $e0, $e0, $c0, $00, $00
    .byte $00, $7c, $fe, $fe, $fe, $ee, $d6, $c6
    .byte $00, $7c, $fe, $fe, $fe, $e6, $de, $ee
    .byte $00, $7c, $fe, $fe, $fe, $ce, $d6, $d6
    .byte $00, $7c, $fe, $fe, $fe, $e6, $de, $d6
    .byte $00, $7c, $fe, $fe, $fe, $f6, $f6, $f6
    .byte $00, $7c, $fe, $fe, $fe, $d6, $d6, $ce
    .byte $00, $7c, $fe, $fe, $fe, $de, $de, $de
    .byte $00, $7c, $fe, $fe, $fe, $fe, $ee, $fe
    .byte $00, $7c, $fe, $fe, $fe, $fe, $c6, $fe
    .byte $00, $fc, $fe, $fe, $fe, $46, $de, $ce
    .byte $fe, $ee, $fe, $fe, $fe, $7c, $00, $00
    .byte $d6, $ce, $fe, $fe, $fe, $7c, $00, $00
    .byte $c6, $fe, $fe, $fe, $fe, $7c, $00, $00
    .byte $f6, $ce, $fe, $fe, $fe, $fc, $00, $00
    .byte $00, $7c, $fe, $fe, $fe, $ee, $d6, $de
    .byte $c0, $80, $80, $80, $00, $00, $00, $00
    .byte $03, $01, $01, $01, $00, $00, $00, $00
    .byte $00, $00, $00, $80, $80, $80, $c0, $ff
    .byte $00, $00, $00, $01, $01, $01, $03, $ff
    .byte $00, $00, $00, $00, $00, $00, $00, $ff
    .byte $00, $7c, $fe, $fe, $fe, $d6, $d6, $ee
    .byte $00, $7c, $fe, $fe, $fe, $d6, $c6, $d6
    .byte $00, $7c, $fe, $fe, $fe, $fe, $fe, $fe
    .byte $00, $7c, $fe, $fe, $fe, $f6, $f6, $ee
    .byte $00, $7c, $fe, $fe, $fe, $ee, $d6, $fe
    .byte $00, $7c, $fe, $fe, $ee, $de, $ee, $fe
    .byte $00, $c0, $e0, $e0, $e0, $60, $60, $e0
    .byte $ee, $f6, $ee, $fe, $fe, $7c, $00, $00
    .byte $dd, $dd, $ff, $ff, $ff, $7f, $00, $00
    .byte $e0, $e0, $e0, $e0, $e0, $c0, $00, $00
    .byte $00, $7f, $ff, $ff, $ff, $ff, $ff, $ff
    .byte $00, $ff, $ff, $ff, $ff, $ff, $ff, $ff
    .byte $00, $c0, $e0, $e0, $e0, $e0, $e0, $e0
    .byte $ff, $ff, $ff, $ff, $ff, $7f, $00, $00
    .byte $ff, $ff, $ff, $ff, $ff, $ff, $00, $00
    .byte $00, $00, $00, $c0, $c0, $c0, $f0, $ff
    .byte $00, $00, $00, $03, $03, $03, $0f, $ff
    .byte $e0, $e0, $e0, $e0, $c0, $c0, $80, $00
    .byte $00, $00, $01, $03, $07, $07, $07, $07
    .byte $00, $00, $f0, $f8, $fc, $bc, $1c, $5c
    .byte $3f, $67, $43, $c3, $81, $89, $98, $90
    .byte $5f, $fc, $f8, $f8, $f0, $f2, $e3, $e1
    .byte $5f, $ff, $ff, $ff, $ff, $fd, $fc, $fe
    .byte $98, $89, $81, $c3, $43, $67, $3f, $07
    .byte $e3, $f2, $f0, $f8, $f8, $fc, $5f, $5c
    .byte $07, $07, $07, $03, $01, $00, $00, $ff
    .byte $1c, $bc, $fc, $f8, $f0, $00, $00, $ff
    .byte $fc, $fd, $ff, $ff, $ff, $ff, $5f, $5c
    .byte $3c, $7e, $7e, $ff, $ff, $f7, $e7, $ef
    .byte $e7, $f7, $ff, $ff, $7e, $7e, $3c, $04
    .byte $3f, $7f, $7f, $ff, $ff, $f7, $e7, $ef
    .byte $e7, $f7, $ff, $ff, $7f, $7f, $3f, $07
    .byte $00, $00, $00, $00, $00, $00, $00, $00
    .byte $00, $00, $00, $00, $00, $00, $00, $00
    .byte $00, $00, $00, $00, $00, $00, $00, $00
    .byte $00, $00, $00, $00, $00, $00, $00, $00
    .byte $00, $00, $00, $00, $00, $00, $00, $00
    .byte $00, $00, $00, $00, $00, $00, $00, $00
    .byte $00, $00, $00, $00, $00, $00, $00, $00
    .byte $00, $00, $00, $00, $00, $00, $00, $00
    .byte $00, $00, $00, $00, $00, $00, $00, $00
    .byte $00, $00, $00, $00, $00, $00, $00, $00
    .byte $00, $00, $00, $00, $00, $00, $00, $00
    .byte $00, $00, $00, $00, $00, $00, $00, $00
    .byte $00, $00, $00, $00, $00, $00, $00, $00
    .byte $00, $00, $00, $00, $00, $00, $00, $00
    .byte $00, $00, $00, $00, $00, $00, $00, $00
    .byte $00, $00, $00, $00, $00, $00, $00, $00
    .byte $00, $00, $00, $00, $00, $00, $00, $00
    .byte $00, $00, $00, $00, $00, $00, $00, $00
