;  joyride.inc -- Global definitions for Anykey.
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


.include "c64.inc"

COLOR_BLACK = 0
COLOR_WHITE = 1
COLOR_RED = 2
COLOR_CYAN = 3
COLOR_VIOLET = 4
COLOR_PURPLE = COLOR_VIOLET
COLOR_GREEN = 5
COLOR_BLUE = 6
COLOR_YELLOW = 7
COLOR_ORANGE = 8
COLOR_BROWN = 9
COLOR_LIGHTRED = 10
COLOR_GRAY1 = 11
COLOR_GRAY2 = 12
COLOR_LIGHTGREEN = 13
COLOR_LIGHTBLUE = 14
COLOR_GRAY3 = 15

PRESSED_COLOR = COLOR_GRAY1
CHECKED_COLOR = COLOR_GRAY2
UNCHECKED_COLOR = COLOR_BLACK

MMU = $D500
; MMU_CR = $D500 ; copy at $FF00 is always visible
MMU_PCRA = $D501
MMU_PCRB = $D502
MMU_PCRC = $D503
MMU_PCRD = $D504
MMU_MCR = $D505
MMU_RCR = $D506
MMU_P0L = $D507
MMU_P0H = $D508
MMU_P1L = $D509
MMU_P1H = $D50A
MMU_VR = $D50B
MMU_CR = $FF00
MMU_LCRA = $FF01
MMU_LCRB = $FF02
MMU_LCRC = $FF03
MMU_LCRD = $FF04

charset = $8000
screen = charset + $800
sprites = screen + $400

charset_keyboard_top = charset + $2000
charset_keyboard_bottom = charset_keyboard_top + $800
color_ram = $d800

sprite_logo = (sprites & $3fff) / 64

MAX_NUM_KEYS = 91

keys_64_offset = screen + 80 + 1
keys_128_offset = screen + 80

ptr1 = $fb
ptr2 = $fd
ptr3 = $c1

top = 50 ; first raster line of screen

COMMAND_NONE = 0
COMMAND_HELP = 1
COMMAND_HELP_NEXT = 2
COMMAND_HELP_PREVIOUS = 3
COMMAND_HELP_EXIT = 4
COMMAND_RESET_KEYBOARD = 5
