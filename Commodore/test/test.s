.include "../mega65.inc"

color_ram = $d800
colmem = 0

VICIII_SM_H640    = $80
VICIII_SM_V400    = $08
VICIII_SCRNMODE  = $D031
VICIV_SM_FCLRHI  = $04
VIVIV_SM_FCLRLO  = $02
VICIV_SM_CHR16   = $01
VICIV_SCRNMODE   = $D054
VICIV_LINESTEPLO = $D058
VICIV_LINESTEPHI = $D059
VICIV_CHRCOUNT   = $D05E
VICIV_SCRNPTR1   = $D060
VICIV_SCRNPTR2   = $D061
VICIV_SCRNPTR3   = $D062
VICIV_SCRNPTR4   = $D063
VICIV_COLPTRLO   = $D064
VICIV_COLPTRHI   = $D065
VICIV_CHARPTRLO  = $D068
VICIV_CHARPTRHI  = $D069
VICIV_CHARPTRBN  = $D06A

.code

start:
    ; enable VIC IV
    lda #$47
    sta VIC_KEY
    lda #$53
    sta VIC_KEY

    ; disable hot registers
    lda $d05d
    and #$7f
    sta $d05d

        lda #(VICIII_SM_H640|VICIII_SM_V400)
        trb VICIII_SCRNMODE                   ; clear H640 and V400 for 320x200
        lda VICIV_SCRNMODE
        ora #(VICIV_SM_FCLRHI|VIVIV_SM_FCLRLO|VICIV_SM_CHR16) ; set FCLRHI + CHR16
;        and #(~VIVIV_SM_FCLRLO)               ; clear FCLRLO for super extended attr mode
        sta VICIV_SCRNMODE

        lda #80
        sta VICIV_LINESTEPLO
        lda #0
        sta VICIV_LINESTEPHI    ; one line of 40 chars is 80 byte

        lda #40
        sta VICIV_CHRCOUNT      ; we are drawing only 40 chars, high bits are in VICIV_SCRNPTR4

        lda #<screen            ; set screen start address (28bit)
        sta VICIV_SCRNPTR1
        lda #>screen
        sta VICIV_SCRNPTR2
        lda #0
        sta VICIV_SCRNPTR3
        lda #0
        sta VICIV_SCRNPTR4      ; also clears EXGLYPH and CHRCOUNT in high nibble

        lda #<colmem
        sta VICIV_COLPTRLO
        lda #>colmem
        sta VICIV_COLPTRHI      ; set colorram start address

    .if 0 {
        ; raster height = 1
        lda $d073
        and #$0f
        ora #$10
        sta $d073

        ldx #1
        stx VIC_CHAR_Y_SCALE

        ldx #<screen
        stx VIC_SCREEN_POINTER
        ldx #>screen
        stx VIC_SCREEN_POINTER + 1
        ldx #0
        stx VIC_SCREEN_POINTER + 2
        stx VIC_CHARSET_POINTER + 2
        ldx 160
        stx VIC_LINE_STEP
        ldx #80
        stx VIC_CHAR_COUNT
        lda VIC + $54
        ora #$07
        sta VIC + $54
    }

    ldx #<charset
    stx VIC_CHARSET_POINTER
    ldx #>charset
    stx VIC_CHARSET_POINTER + 1
    ldx #0
    stx VIC_CHARSET_POINTER + 2

    ldx #160
:   lda text-1,x
    sta screen-1,x
    lda text+160-1,x
    sta screen+160-1,x
    lda color-1,x
    sta color_ram-1,x
    lda color+160-1,x
    sta color_ram+160-1,x
    dex
    bne :-

    ; palette
    ldx 0
:   txa
    and #$f
    tay

    sta $d100,x
    sta $d200,x
    sta $d300,x
    dex
    bne :-


loop:
    jmp loop

.section data

charset:
    .byte $00, $00, $00, $00, $00, $00, $00, $00
    .byte $00, $00, $00, $11, $00, $00, $00, $00
    .byte $00, $00, $11, $22, $11, $00, $00, $00
    .byte $00, $11, $22, $33, $22, $11, $00, $00
    .byte $00, $11, $22, $33, $22, $11, $00, $00
    .byte $00, $00, $11, $22, $11, $00, $00, $00
    .byte $00, $00, $00, $11, $00, $00, $00, $00
    .byte $00, $00, $00, $00, $00, $00, $00, $00

    ;.binary_file "../charset.bin"
    ;.binary_file "../charset-mega65.bin"

text:
    .repeat 80, i
    .word 0; i
    .endrepeat
    .repeat 80, i
    .word 0; i + $60
    .endrepeat

color:
    .repeat 160, i
    .byte i & $f, $00
    .endrepeat


screen:
    .repeat 160 * 25
    .word 0
    .endrepeat
