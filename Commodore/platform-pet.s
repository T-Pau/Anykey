;  platform-pet.s -- PET specific definitions.
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

USE_PET = 1

screen = $8000

USE_KEYBOARD_SELECT_INDEX = 1
KEYBOARD_SELECT = $E810 ; PIA1_PA
KEYBOARD_VALUE = $E812 ; PIA1_PB

MAX_NUM_KEYS = 80


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
