;  defines.inc -- Global definitions for Anykey.
;  Copyright (C) 2020-2022 Dieter Baron
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

.if 0

.if .defined(USE_VICII)
.include "vic-ii.inc"

; TODO: Do these work on MEGA65?
tmp1 = $02
ptr1 = $fb
ptr2 = $fd
ptr3 = $c1

PRESSED_COLOR = COLOR_DARK_GRAY
CHECKED_COLOR = COLOR_MID_GRAY
UNCHECKED_COLOR = COLOR_BLACK

BACKGROUND_COLOR = COLOR_LIGHT_GRAY
FRAME_COLOR = COLOR_MID_GRAY
CONTENT_COLOR = COLOR_DARK_GRAY
LABEL_COLOR = COLOR_BLACK
LOGO_COLOR = COLOR_DARK_GRAY

SCREEN_TOP = 50

screen = $8c00

charset = $a000
charset_keyboard_top = charset + $800
charset_keyboard_bottom = charset_keyboard_top + $800
.if .defined(__MEGA65__)
sprites = $8800
.else
sprites = charset_keyboard_bottom + $800
.endif
color_ram = $d800

sprite_logo = (sprites & $3fff) / 64

VIDEO_CURRENT_LINE = VIC_HLINE
VIDEO_BORDER_COLOR = VIC_BORDERCOLOR
VIDEO_BACKGROUND_COLOR = VIC_BG_COLOR0

KEYBOARD_SELECT = CIA1_PRA
KEYBOARD_VALUE = CIA1_PRB

MAX_NUM_KEYS = 91

KEY_INDEX_RESET = 6 ; F5
KEY_INDEX_HELP = 3 ; F7
HOLD_FRAMES = 50

.elseif .defined(USE_TED)
.include "ted.inc"

ptr1 = $d8
ptr2 = $da
ptr3 = $dc

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

VIDEO_CURRENT_LINE = TED_VLINELO
VIDEO_BORDER_COLOR = TED_BORDERCOLOR
VIDEO_BACKGROUND_COLOR = TED_BGCOLOR

KEYBOARD_SELECT = $FD30
KEYBOARD_VALUE = TED_KBD

MAX_NUM_KEYS = 64

KEY_INDEX_RESET = 6 ; F3
KEY_INDEX_HELP = 3 ; Help
HOLD_FRAMES = 50


.elseif .defined(USE_VIC)

; TODO

.elseif .defined(USE_PET)

screen = $8000

KEYBOARD_SELECT = $E810 ; PIA1_PA
KEYBOARD_VALUE = $E812 ; PIA1_PB

MAX_NUM_KEYS = 80

ptr1 = $54
ptr2 = $56
ptr3 = $b7
tmp1 = $58
tmp2 = $59

HOLD_FRAMES = 60

LNMX = $d5 ; Physical Screen Line Length (not on 2001, 80xx)


ROUND_TOP_LEFT = $55
ROUND_TOP_RIGHT = $49
ROUND_BOTTOM_LEFT = $4a
ROUND_BOTTOM_RIGHT = $4b
ROUND_TOP = $43
ROUND_BOTTOM = $46
ROUND_LEFT = $42
ROUND_RIGHT = $48

SQUARE_TOP_LEFT = $70
SQUARE_TOP_RIGHT = $6e
SQUARE_BOTTOM_LEFT = $6d
SQUARE_BOTTOM_RIGHT = $7d

PRESSED_TOP_LEFT = $6c
PRESSED_TOP_RIGHT = $7b
PRESSED_BOTTOM_LEFT = $7c
PRESSED_BOTTOM_RIGHT = $7e
PRESSED_TOP = $62
PRESSED_BOTTOM = $e2
PRESSED_LEFT = $e1
PRESSED_RIGHT = $61

SQUARE_HORIZONTAL = $40
SQUARE_VERTICAL = $5d

.endif

.endif

.include "platform.inc"

COMMAND_NONE = 0
COMMAND_HELP = 1
COMMAND_HELP_NEXT = 2
COMMAND_HELP_PREVIOUS = 3
COMMAND_HELP_EXIT = 4
COMMAND_RESET_KEYBOARD = 5

.include "cbm_kernal.inc"
