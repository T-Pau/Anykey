;  defines.inc -- Global definitions for Anykey.
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

.if .defined(__C64__)
.include "c64.inc"
USE_VICII = 1

.elseif .defined(__C128__)
.include "c128.inc"
.include "mmu.inc"
USE_VICII = 1

.elseif .defined(__PLUS4__)
.include "plus4.inc"
USE_TED = 1

.else
.error "Target not supported"
.endif

.if .defined(USE_VICII)
.include "vic-ii.inc"

ptr1 = $fb
ptr2 = $fd
ptr3 = $c1

PRESSED_COLOR = COLOR_DARK_GRAY
CHECKED_COLOR = COLOR_MID_GRAY
UNCHECKED_COLOR = COLOR_BLACK

BACKGROUND_COLOR = COLOR_LIGHT_GRAY
FRAME_COLOR = COLOR_MID_GRAY
LABEL_COLOR = COLOR_BLACK
LOGO_COLOR = COLOR_DARK_GRAY

SCREEN_TOP = 50

charset = $8000
screen = charset + $800
sprites = screen + $400

charset_keyboard_top = charset + $2000
charset_keyboard_bottom = charset_keyboard_top + $800
color_ram = $d800

sprite_logo = (sprites & $3fff) / 64

MAX_NUM_KEYS = 91

.elseif .defined(USE_TED)
.include "ted.inc"

ptr1 = $d8
ptr2 = $da
ptr3 = $dc

PRESSED_COLOR = ($20 | COLOR_WHITE)
CHECKED_COLOR = ($40 | COLOR_WHITE)
UNCHECKED_COLOR = COLOR_BLACK

BACKGROUND_COLOR = ($60 | COLOR_WHITE)
FRAME_COLOR = ($40 | COLOR_WHITE)
LABEL_COLOR = COLOR_BLACK
LOGO_COLOR = ($20 | COLOR_WHITE)

SCREEN_TOP = 20 ; TODO

charset = $8000
charset_keyboard_top = charset + $800
charset_keyboard_bottom = charset_keyboard_top + $800

screen = $0c00
color_ram = $0800

MAX_NUM_KEYS = 64

.endif

COMMAND_NONE = 0
COMMAND_HELP = 1
COMMAND_HELP_NEXT = 2
COMMAND_HELP_PREVIOUS = 3
COMMAND_HELP_EXIT = 4
COMMAND_RESET_KEYBOARD = 5
