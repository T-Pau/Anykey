;  irq-table.s -- Table of raster IRQ handlers.
;  Copyright (C) 2020 Dieter Baron
;
;  This file is part of Joyride, a controller test program for C64.
;  The authors can be contacted at <joyride@tpau.group>.
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
.export main_irq_table, main_irq_table_length
.export help_irq_table, help_irq_table_length

.include "anykey.inc"

.data

main_irq_table:
	.word top - 1, top_label
	.word top + 8 - 2, switch_keyboard_top
	.word top + 8 * 4 - 1, switch_keyboard_bottom
	.word top + 8 * 13 - 1, switch_joystick_label
	.word top + 8 * 15 - 1, switch_joystick
	.word top + 8 * 22, label_background
	.word top + 24 * 8 + 7, switch_bottom
main_irq_table_length:
	.byte * - main_irq_table


help_irq_table:
	.word top - 1, top_label
	.word top + 8 - 1, content_background
	.word top + 21 * 8, label_background
	.word top + 24 * 8 + 7, handle_help
help_irq_table_length:
	.byte * - help_irq_table
