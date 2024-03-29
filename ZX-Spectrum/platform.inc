;  platform.inc -- general defines
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

global charset, screen_main, colors_main, screen_help, colors_help, keys_48k

IF PLATFORM_48K
include "platform-48k.inc"
ELIFDEF PLATFORM_PLUS
include "platform-plus.inc"
ELIFDEF PLATFORM_PLUS2
include "platform-plus2.inc"
ELIFDEF PLATFORM_NEXT
include "platform-next.inc"
ELIFDEF PLATFORM_N_GO
include "platform-n-go.inc"
ELSE
ERROR "platform not supported"
ENDIF

screen_size = 32 * 24
screen = $4000
color = screen + screen_size * 8


PRESSED_COLOR =  $07 ; white on black
UNCHECKED_COLOR = $47 ; bright white on black
CHECKED_COLOR = $06 ; yellow on black

KEY_INDEX_RESET = 13
KEY_INDEX_HELP = 34
KEY_INDEX_NEXT = 35
KEY_INDEX_PREVIOUS = 25
KEY_INDEX_RETURN = 20

PRESS_DURATION = 90
