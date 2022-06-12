;  irq-table-vic20.s -- Table of raster IRQ handlers for VIC20 keyboard.
;  Copyright (C) 2022 Dieter Baron
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

.include "platform.inc"

.rodata

.export main_pal_irq_table
main_pal_irq_table:
	.byte SCREEN_TOP_PAL - 1
	.word top_keyboard

	.byte SCREEN_TOP_PAL + 13 * 4 - 1
	.word bottom_keyboard

    .byte SCREEN_TOP_PAL + 15 * 4 - 1
    .word top_joystick

    .byte SCREEN_TOP_PAL + 19 * 4 - 1
    .word bottom_joystick

.export main_pal_irq_table_length
main_pal_irq_table_length:
	.byte * - main_pal_irq_table


.export main_ntsc_irq_table
main_ntsc_irq_table:
	.byte SCREEN_TOP_NTSC - 1
	.word top_keyboard

	.byte SCREEN_TOP_NTSC + 13 * 4 - 1
	.word bottom_keyboard

    .byte SCREEN_TOP_NTSC + 15 * 4 - 1
    .word top_joystick

    .byte SCREEN_TOP_NTSC + 19 * 4 - 1
    .word bottom_joystick

.export main_ntsc_irq_table_length
main_ntsc_irq_table_length:
	.byte * - main_ntsc_irq_table



.export help_pal_irq_table
help_pal_irq_table:
    .byte SCREEN_TOP_PAL + 4 - 1
    .word help_top

    .byte SCREEN_TOP_PAL + 4 * 19 - 1
    .word help_bottom

.export help_pal_irq_table_length
help_pal_irq_table_length:
    .byte * - help_pal_irq_table


.export help_ntsc_irq_table
help_ntsc_irq_table:
    .byte SCREEN_TOP_NTSC + 4 - 1
    .word help_top

    .byte SCREEN_TOP_NTSC + 4 * 19 - 1
    .word help_bottom

.export help_ntsc_irq_table_length
help_ntsc_irq_table_length:
    .byte * - help_ntsc_irq_table
