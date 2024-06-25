;  platform-plus4.s -- Plus/4 specific definitions.
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

PRESSED_COLOR = ($30 | COLOR_WHITE)
CHECKED_COLOR = ($40 | COLOR_WHITE)
UNCHECKED_COLOR = ($10 | COLOR_BLACK)

BACKGROUND_COLOR = ($60 | COLOR_WHITE)
FRAME_COLOR = ($50 | COLOR_WHITE)
CONTENT_COLOR = ($30 | COLOR_WHITE)
LABEL_COLOR = COLOR_BLACK
; LOGO_COLOR = ($20 | COLOR_WHITE)

SCREEN_TOP = 3 ; TODO

charset = $8000
charset_keyboard_top = charset + $800
charset_keyboard_bottom = charset_keyboard_top + $800

screen = $0c00
color_ram = $0800

help_screen_title = screen + 1
help_screen_text = screen + 2 * 40

VIDEO_CURRENT_LINE = TED_CURRENT_RASTER_LOW
VIDEO_BORDER_COLOR = TED_BORDER_COLOR
VIDEO_BACKGROUND_COLOR = TED_BACKGROUND_COLOR

KEYBOARD_SELECT = PIO_2
KEYBOARD_VALUE = TED_KEYBOARD

MAX_NUM_KEYS = 64

KEY_INDEX_RESET = 6 ; F3
KEY_INDEX_HELP = 3 ; Help
HOLD_FRAMES = 50

SCREEN_SIZE = 1000


.macro set_ted_charset charset {
	lda #TED_CHARACTER_ADDRESS(charset)
	sta TED_CONTROL_4
}
