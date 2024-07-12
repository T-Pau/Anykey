;  screen.s -- Screen contents.
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

.include "features.inc"

.section code

.public display_main_screen {
    .if .defined(USE_VICII) {
        rl_expand_typed screen, main_screen_c64, main_screen_c128, main_screen_mega65_c64
        memcpy color_ram, main_color_save, 1000
        .if .defined(C64) {
            lda machine_type
            beq c64
            bpl c128
        }
        .if .defined(C64) || .defined(MEGA65) {
            ldx #<main_mega65_c64_irq_table
            ldy #>main_mega65_c64_irq_table
            lda #.sizeof(main_mega65_c64_irq_table)
        }
        .if .defined(C64) {
            bne set
        c128:
        }
        .if .defined(C64) || .defined(C128) {
            ldx #<main_128_irq_table
            ldy #>main_128_irq_table
            lda #.sizeof(main_128_irq_table)
        }
        .if .defined(C64) {
            bne set
        c64:
            lda acellerated
            bne fast_table
            ldx #<main_64_irq_table
            ldy #>main_64_irq_table
            lda #.sizeof(main_64_irq_table)
            bne set
        fast_table:
            ldx #<main_64_acellerated_irq_table
            ldy #>main_64_acellerated_irq_table
            lda #.sizeof(main_64_acellerated_irq_table)
        set:
        }
    }
    .else {
        rl_expand screen, main_screen
        .if .defined(USE_COLOR_SAVE) {
            memcpy color_ram, main_color_save, 1000
        }
        .else {
            rl_expand color_ram, main_color
            jsr keyboard_restore_color
        }
        ldx #<main_irq_table
        ldy #>main_irq_table
        lda #.sizeof(main_irq_table)
    }
    jsr set_irq_table
    rts
}


.public display_help_screen {
    ldx #<help_irq_table
    ldy #>help_irq_table
    lda #.sizeof(help_irq_table)
    jsr set_irq_table

    .if .defined(USE_VICII) {
        lda #0
        ldy #7
    :	sta VIC_SPRITE_0_X,y
        dey
        bpl :-
        lda VIC_SPRITE_X_MSB
        and #$f0
        sta VIC_SPRITE_X_MSB
    }

    .if .defined(USE_COLOR_SAVE) {
        memcpy main_color_save, color_ram, 1000
    }
    rl_expand screen, help_screen
    rl_expand color_ram, help_color
    ldx #0
    stx current_help_page
    jsr display_help_page
    rts
}
