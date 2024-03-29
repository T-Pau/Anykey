PRESSED_COLOR = COLOR_GREY_1
CHECKED_COLOR = COLOR_GREY_2
UNCHECKED_COLOR = COLOR_BLACK

BACKGROUND_COLOR = COLOR_GREY_3
FRAME_COLOR = COLOR_GREY_2
CONTENT_COLOR = COLOR_GREY_1
LABEL_COLOR = COLOR_BLACK
LOGO_COLOR = COLOR_GREY_1

SCREEN_TOP = 50

VIDEO_CURRENT_LINE = VIC_RASTER
VIDEO_BORDER_COLOR = VIC_BORDER_COLOR
VIDEO_BACKGROUND_COLOR = VIC_BACKGROUND_COLOR

KEYBOARD_SELECT = CIA1_PRA
KEYBOARD_VALUE = CIA1_PRB

MAX_NUM_KEYS = 91

KEY_INDEX_RESET = 6 ; F5
KEY_INDEX_HELP = 3 ; F7
HOLD_FRAMES = 50

; this needs to be below $4000 to work in C128, so place it in unused screen space
nmi_vector = $07e8

help_screen_title = screen + 1
help_screen_text = screen + 2 * 40

SCREEN_SIZE = 1000

.macro set_vic_bank base_address {
    .if  !.defined(MEGA65) {
        lda CIA2_PRA ; switch VIC bank
        and #$fc
        ora #(base_address >> 14) ^ 3
        sta CIA2_PRA
    }
}

.macro set_vic_text screen, charset {
    .if .defined(MEGA65) {
        lda #<screen
        sta VIC_SCREEN_POINTER
        lda #>screen
        sta VIC_SCREEN_POINTER + 1
        lda #<charset
        sta VIC_CHARSET_POINTER
        lda #>charset
        sta VIC_CHARSET_POINTER + 1
    }
    .else {
        lda #VIC_ADDRESS(screen, charset)
        sta VIC_ADDRESS
    }
}

.macro set_vic_24_lines {
    lda VIC_CONTROL_1
    and #$08 ^ $ff
    sta VIC_CONTROL_1
}

.macro set_vic_25_lines {
    lda VIC_CONTROL_1
    ora #$08
    sta VIC_CONTROL_1
}
