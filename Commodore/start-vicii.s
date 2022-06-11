;  start.s -- Entry point of program.
;  Copyright (C) 2020 Dieter Baron
;
;  This file is part of Anykey, a keyboard test program for C64.
;  The authors can be contacted at <anykey@tpau.group>.
;
;  Redistribution and use in source and binary forms, with or without
;  modification, are permitted provided that the following conditions
;  are met:
;  1. Redistributions of source code must retain the above copyright
;     notice, this list of conditions and the following disclaimer.
;  2. The names of the authors may not be used to endorse or promote
;     products derived from this software without specific prior
;     written permission.
;
;  THIS SOFTWARE IS PROVIDED BY THE AUTHORS ``AS IS'' AND ANY EXPRESS
;  OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
;  WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
;  ARE DISCLAIMED.  IN NO EVENT SHALL THE AUTHORS BE LIABLE FOR ANY
;  DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
;  DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE
;  GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
;  INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER
;  IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR
;  OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN
;  IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.


.autoimport +

.export start

.include "defines.inc"

.macpack cbm_ext
.macpack utility
.macpack c128

.code

start:
.scope
.if .defined(__C64__)
    ; detect machine type
    lda #1
    sta VIC_SPR0_X
    lda #VIC_KNOCK_IV_1
    sta VIC_KEY
    lda #VIC_KNOCK_IV_2
    sta VIC_KEY
    lda #0
    sta VIC_PALETTE_RED
    lda VIC_SPR0_X
    beq not_m65
    lda #$ff
    bne end_detect
not_m65:
    lda VIC_CLK_128
    cmp #$ff
    beq not_128
    lda #1
    bne end_detect
not_128:
    ldx VIC_HLINE
    inx
    inx
    inx
    ldy #$40
:   dey
    bpl :-
    cpx VIC_HLINE
    bcs acelleration_detected
    lda #0
    sta acellerated
    beq end_detect
acelleration_detected:
    lda #1
    sta acellerated
;    sta main_screen_64
    lda #0
end_detect:
	sta machine_type
.elseif .defined(__C128__)
	lda MMU_CR
	ora #$0e
	sta MMU_CR
	lda #1
	sta machine_type
.elseif .defined(__MEGA65__)
    ; Set up C64 environment, taken from mega65-tools c65toc64wrapper.asm
    sei
    lda #$37
    sta $01
    lda #0
    tax
    tay
    taz
    map
    eom
    ;; Enable fast CPU for quick depack
    lda #65
    sta 0
    ;; Enable IO for DMA
    lda #$47
    sta $d02f
    lda #$53
    sta $d02f
    ;; Reset C64 mode KERNAL stuff
    jsr $fda3 ; init I/O
    jsr $fd15 ; set I/O vectors
    lda #>$0400             ; Make sure screen memory set to sensible location
    sta $0288               ; before we call screen init $FF5B
    jsr $ff5b ; more init
    jsr $f7a9 ; C65 DOS reinit

    lda #VIC_KNOCK_IV_1
    sta VIC_KEY
    lda #VIC_KNOCK_IV_2
    sta VIC_KEY
    lda $d05d
    and #$7f
    sta $d05d
    ; swtich to 40 column mode
    lda #60
    sta VIC_CHAR_X_SCALE
    lda #40
    sta VIC_CHAR_COUNT
    sta VIC_LINE_STEP
    store_word screen + $03f8, VIC_SPRITE_POINTER
    lda #$00 ; $80
    sta VIC_SPRITE_BANK
    inc VIC_SDBDRWD
    clc
    lda VIC_TEXT_X_POSITION
    adc #3
    sta VIC_TEXT_X_POSITION
    lda #$ff
	sta machine_type
.endif

	jsr init_state

	memcpy charset, charset_data, $800
	memcpy_128 charset_keyboard_top, keyboard_64_charset_top, keyboard_128_charset_top, keyboard_mega65_c64_charset_top, $0400
	memcpy_128 charset_keyboard_top + $400, keyboard_64_charset_top_inv, keyboard_128_charset_top_inv, keyboard_mega65_c64_charset_top_inv, $0400
	memcpy_128 charset_keyboard_bottom, keyboard_64_charset_bottom, keyboard_128_charset_bottom, keyboard_mega65_c64_charset_bottom, $0400
	memcpy_128 charset_keyboard_bottom + $400, keyboard_64_charset_bottom_inv, keyboard_128_charset_bottom_inv, keyboard_mega65_c64_charset_bottom_inv, $0400
	memcpy sprites, sprite_data, (64 * 8)
.if .defined(__MEGA65__)
    ; The xmega65 emulator ignores the VIC-II bank, so copy it in both banks.
	memcpy $0800, sprite_data, (64 * 8)
.endif

	jsr display_main_screen
	lda #FRAME_COLOR
	sta VIDEO_BORDER_COLOR

	set_vic_bank $8000
	set_vic_text screen, charset

	lda #$0f
	sta VIC_SPR_ENA
	lda #0
	sta VIC_SPR_BG_PRIO
	sta VIC_SPR_EXP_X
	sta VIC_SPR_EXP_Y
	sta VIC_SPR_MCOLOR

	jsr setup_logo

	lda #$ff
	sta CIA1_DDRA
	sta CIA1_DDRB

	jsr init_irq
	
	jmp main_loop
.endscope
