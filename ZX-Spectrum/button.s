;  This file is automatically created by ./../scripts/compress-screen from button.json.
;  Do not edit.

section data_user

public num_button
num_button:
    byte 2

public button
button:
    word button_0
    word button_1

button_0:
    byte $00, $01, $02, $fe, $1d, $03, $04, $05
    byte $fe, $1d, $06, $07, $08, $ff, $00

button_1:
    byte $00, $09, $02, $fe, $1d, $0a, $0b, $0c
    byte $fe, $1d, $06, $0d, $08, $ff, $00
