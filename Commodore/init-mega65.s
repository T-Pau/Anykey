;  init-mega65.s -- MEGA65 specific initialization
;  Copyright (C) Dieter Baron
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
;  THIS SOFTWARE IS PROVIDED BY THE AUTHORS "AS IS" AND ANY EXPRESS
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

.section code

.public init {
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
    store_word VIC_SPRITE_POINTER, screen + $03f8
    lda #$00 ; $80
    sta VIC_SPRITE_BANK
    inc VIC_SDBDRWD
    clc
    lda VIC_TEXT_X_POSITION
    adc #3
    sta VIC_TEXT_X_POSITION
    lda #MACHINE_TYPE_MEGA65
    sta machine_type

    ; The xmega65 emulator ignores the VIC-II bank, so copy it in both banks.
   	memcpy $0800, sprite_data, (64 * 8)

    rts
}