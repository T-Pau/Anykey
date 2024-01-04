USE_VIC = 1
USE_SKIP = 1

COLOR_BLACK = 0
COLOR_WHITE = 1
COLOR_RED = 2
COLOR_CYAN = 3
COLOR_PURPLE = 4
COLOR_GREEN = 5
COLOR_BLUE = 6
COLOR_YELLOW = 7

COLOR_ORANGE = 8
COLOR_LIGHT_ORANGE = 9
COLOR_LIGHT_RED = 10
COLOR_LIGHT_CYAN = 11
COLOR_LIGHT_PURPLE = 12
COLOR_LIGHT_GREEN = 13
COLOR_LIGHT_BLUE = 14
COLOR_LIGHT_YELLOW = 15

VIC_H_POS = VIC_CR0
VIC_V_POS = VIC_CR1
VIC_COLUMNS = VIC_CR2
VIC_VIDEO_ADDRESS = VIC_CR5
VIC_LPEN_X = VIC_CR6
VIC_LPEN_Y = VIC_CR7
VIC_POT_X = VIC_CR8
VIC_POT_Y = VIC_CR9
VIC_BASS = VIC_CRA
VIC_ALTO = VIC_CRB
VIC_SOPRANO = VIC_CRC
VIC_NOISE = VIC_CRD
VIC_AUX_COLOR = VIC_CRE
VIC_LOUDNESS = VIC_CRE



MAX_NUM_KEYS = 65

USE_KEYBOARD_SELECT_BITMASK = 1

KEYBOARD_SELECT = VIA2_PA1
KEYBOARD_VALUE = VIA2_PB


FRAME_COLOR = COLOR_YELLOW
BACKGROUND_COLOR = COLOR_BLACK
CONTENT_COLOR = COLOR_YELLOW
LABEL_COLOR = COLOR_BLUE

PRESSED_COLOR = COLOR_YELLOW
CHECKED_COLOR = COLOR_GREEN
UNCHECKED_COLOR = COLOR_WHITE
SKIPPED_COLOR = COLOR_YELLOW

SCREEN_TOP_PAL = 38
SCREEN_TOP_NTSC = 25

KEY_INDEX_RESET = 62 ; F5
KEY_INDEX_HELP = 63 ; F7
HOLD_FRAMES = 50

.section zero_page

.public tmp1 .reserve 1
.public ptr1 .reserve 2
.public ptr2 .reserve 2
.public ptr3 .reserve 2

screen = $1000
color_ram = $9400

help_screen_title = screen + 1
help_screen_text = screen + 2 * 22

SCREEN_SIZE = 506

POSITION_LEFT = 12
POSITION_RIGHT = 13

DPAD_OFFSET = 15 * 22 + 7
BUTTONS_OFFSET = DPAD_OFFSET + 22 + 3

KEYBOARD_OFFSET = 22 * 2
KEYBOARD_SIZE = 22 * 10

.section code

.public display_main_screen {
    ldx is_ntsc
    beq pal
    ldx #<main_ntsc_irq_table
    ldy #>main_ntsc_irq_table
    lda main_ntsc_irq_table_length
    bne both
pal:
    ldx #<main_pal_irq_table
    ldy #>main_pal_irq_table
    lda main_pal_irq_table_length
both:
    jsr set_irq_table
    ldx is_ntsc
    lda main_h_pos,x
    sta VIC_H_POS
    store_word main_screen, ptr1
    store_word screen, ptr2
    jsr rl_expand
    ldx #0
:   lda main_color_save,x
    sta color_ram,x
    lda main_color_save + 250,x
    sta color_ram + 250,x
    dex
    bne :-
    rts
}

.public top_keyboard {
    inc VIC_H_POS
    lda #SCREEN_TOP_PAL + 4 - 1
    jsr wait_line
    jsr wait_20
    nop
    nop
    ldx #(BACKGROUND_COLOR << 4) | $8 | FRAME_COLOR
    ldy #$cd
    stx VIC_COLOR
    sty VIC_VIDEO_ADDRESS
    lda #SCREEN_TOP_PAL + 4 * 4 -1
    ldx VIC_H_POS
    ldy #2
shift_loop:
    dex
    jsr wait_line
    stx VIC_H_POS
    clc
    adc #8
    inx
    jsr wait_line
    stx VIC_H_POS
    clc
    adc #8
    dey
    bne shift_loop
    rts
}


.public bottom_keyboard {
    ldx #(LABEL_COLOR << 4) | FRAME_COLOR
    ldy #$cf
    lda #SCREEN_TOP_PAL + 4 * 13 - 1
    jsr wait_line
    stx VIC_COLOR
    sty VIC_VIDEO_ADDRESS
    rts
}


.public top_joystick {
    ldx #(BACKGROUND_COLOR << 4) | $8 | FRAME_COLOR
    ldy #$cd
    lda #SCREEN_TOP_PAL + 15 * 4 - 1
    jsr wait_line
    stx VIC_COLOR
    sty VIC_VIDEO_ADDRESS
    jsr read_restore
    jsr read_joystick
    rts
}


; waits for 20 cycles
wait_20 {
    nop
.private wait_18:
    nop
    nop
    nop
.private wait_12
    rts
}


; waits for border of raster line a
wait_line {
    pha
    sec
    sbc hline_offset
:   cmp VIC_RASTER
    bne :-
    jsr wait_20
    jsr wait_20
    jsr wait_20
    jsr wait_18
    jsr wait_12
    lda is_ntsc
    beq :+
    jsr wait_18
:   pla
    rts
}


.public bottom_joystick {
    ldx #(LABEL_COLOR << 4) | FRAME_COLOR
    ldy #$cf
    lda #SCREEN_TOP_PAL + 19 * 4 - 1
    jsr wait_line
    stx VIC_COLOR
    sty VIC_VIDEO_ADDRESS
    dec VIC_H_POS

    jsr read_restore

    ; TODO: move to keyboard skip code
  	lda #$ff
  	sta VIA2_DDRA
   	lda #$00
  	sta VIA2_DDRB

    lda #$ff
    sta VIA2_PA1
  	lda VIA2_PB
  	sta port_b

    jsr read_keyboard

    lda #$ff
    sta VIA2_PA1
    lda VIA2_PB
    and port_b
    and #$80
    eor #$80
    asl
    rol
    sta skip_key + $07
    sta skip_key + $0f
    sta skip_key + $17
    sta skip_key + $1f
    sta skip_key + $27
    sta skip_key + $2f
    sta skip_key + $37
    sta skip_key + $3f

    jsr process_restore
    lda command
    bne :+
    ldx #0
    ldy num_keys
    jsr display_keyboard
    jsr process_command_keys
    jsr display_joystick
:
    rts
}


.public reset_keyboard {
    ; y runs from KEYBOARD_SIZE to 1, so offset address by -1
    ldy #KEYBOARD_SIZE + 1
loop:
    lda color_ram + KEYBOARD_OFFSET -1,y
    and #$0f
    cmp #CHECKED_COLOR
    bne :+
    lda #UNCHECKED_COLOR
    sta color_ram + KEYBOARD_OFFSET - 1,y
:   dey
    bne loop
    rts
}


read_joystick {
    lda #$ff
    sta VIA2_DDRA
    sta VIA2_PA1
    lda #0
    sta VIA2_DDRB
    sta VIA1_DDRA
    lda VIA1_PA1
    lsr
    and #$1e
    eor #$1e
    tax
    lda VIA2_PB
    bmi :+
    inx
:   txa
    ldx VIC_POT_X
    bmi :+
    ora #$20
:   ldx VIC_POT_Y
    bmi :+
    ora #$40
:   sta joystick_value
    rts
}


display_joystick {
    lda joystick_value
    and #$0f
    asl
    tax
    lda dpad_vic20,x
    inx
    sta ptr1
    lda dpad_vic20,x
    sta ptr1 + 1
    store_word screen + DPAD_OFFSET, ptr2
    jsr rl_expand

    lda joystick_value
    and #$70
    lsr
    lsr
    lsr
    tax
    lda buttons_vic20,x
    inx
    sta ptr1
    lda buttons_vic20,x
    sta ptr1 + 1
    store_word screen + BUTTONS_OFFSET, ptr2
    jmp rl_expand
}


.public display_help_screen {
    ; x runs from KEYBOARD_SIZE to 1, so offset address by -1
    ldx #KEYBOARD_SIZE + 1
:   lda color_ram + KEYBOARD_OFFSET - 1,x
    and #$0f
    sta main_color_save + KEYBOARD_OFFSET - 1,x
    dex
    bne :-

    ldx is_ntsc
    beq pal
    ldx #<help_ntsc_irq_table
    ldy #>help_ntsc_irq_table
    lda help_ntsc_irq_table_length
    bne both
pal:
    ldx #<help_pal_irq_table
    ldy #>help_pal_irq_table
    lda help_pal_irq_table_length
both:
    jsr set_irq_table

    store_word help_screen, ptr1
    store_word screen, ptr2
    jsr rl_expand
    lda #FRAME_COLOR
    ldy #0
:   sta color_ram,y
    sta color_ram + $100,y
    dey
    bne :-
    sty current_help_page
    jsr display_help_page
    rts
}


.public help_top {
    ldx #(BACKGROUND_COLOR << 4) | $8 | FRAME_COLOR
    ldy #$cf
    lda #SCREEN_TOP_PAL + 4 - 2
    jsr wait_line
    jsr wait_20
    jsr wait_20
    jsr wait_20
    jsr wait_20
    jsr wait_20
    jsr wait_20
    nop
    nop
    nop
    sty VIC_VIDEO_ADDRESS
    stx VIC_COLOR
    rts
}


.public help_bottom {
    ldx #(LABEL_COLOR << 4) | FRAME_COLOR
    lda #SCREEN_TOP_PAL + 4 * 19 - 1
    jsr wait_line
    stx VIC_COLOR

    jsr read_keyboard
    lda command
    bne :+
    jsr handle_help_keys
:   rts
}


read_restore {
    lda VIA1_IFR
    and #$02
    beq :+
    jsr trigger_restore
:   rts
}


.section charset

charset {
    .binary_file "charset-vic20.bin"
}

.section data

.public main_color {
    .data $ff, 22 * 2, FRAME_COLOR
    .data $ff, 21, UNCHECKED_COLOR, FRAME_COLOR
    .data $ff, 21, UNCHECKED_COLOR, FRAME_COLOR
    .data FRAME_COLOR, $ff, 20, UNCHECKED_COLOR, FRAME_COLOR
    .data FRAME_COLOR, $ff, 20, UNCHECKED_COLOR, FRAME_COLOR
    .data $ff, 21, UNCHECKED_COLOR, FRAME_COLOR
    .data $ff, 21, UNCHECKED_COLOR, FRAME_COLOR
    .data FRAME_COLOR, $ff, 20, UNCHECKED_COLOR, FRAME_COLOR
    .data FRAME_COLOR, $ff, 20, UNCHECKED_COLOR, FRAME_COLOR
    .data $ff, 21, UNCHECKED_COLOR, FRAME_COLOR
    .data $ff, 21, UNCHECKED_COLOR, FRAME_COLOR
    .data $ff, 22 * 11, FRAME_COLOR
    .data $ff, 0
}


.public help_keys {
    .data help_keys_table
}


help_keys_table {
    .data 4, COMMAND_HELP_NEXT ; space
    .data 40, COMMAND_HELP_NEXT ; +
    .data 47, COMMAND_HELP_PREVIOUS; -
    .data 1, COMMAND_HELP_EXIT ; left arrow
    .data $ff
}


main_h_pos {
    .data 12, 4
}

.section reserve

port_b .reserve 1
joystick_value .reserve 1
