;  irq-table-vic20.s -- Table of raster IRQ handlers for VIC20 keyboard.
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

.section data

.public main_pal_irq_table {
    .data SCREEN_TOP_PAL - 1:2
    .data top_keyboard

    .data SCREEN_TOP_PAL + 13 * 4 - 1:2
    .data bottom_keyboard

    .data SCREEN_TOP_PAL + 15 * 4 - 1:2
    .data top_joystick

    .data SCREEN_TOP_PAL + 19 * 4 - 1:2
    .data bottom_joystick
}

.public main_ntsc_irq_table {
    .data SCREEN_TOP_NTSC - 1:2
    .data top_keyboard

    .data SCREEN_TOP_NTSC + 13 * 4 - 1:2
    .data bottom_keyboard

    .data SCREEN_TOP_NTSC + 15 * 4 - 1:2
    .data top_joystick

    .data SCREEN_TOP_NTSC + 19 * 4 - 1:2
    .data bottom_joystick
}


.public help_pal_irq_table {
    .data SCREEN_TOP_PAL + 4 - 2:2
    .data help_top

    .data SCREEN_TOP_PAL + 4 * 19 - 1:2
    .data help_bottom
}

.public help_ntsc_irq_table {
    .data SCREEN_TOP_NTSC + 4 - 2:2
    .data help_top

    .data SCREEN_TOP_NTSC + 4 * 19 - 1:2
    .data help_bottom
}
