;  features.inc -- general defines
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

.pre_if .defined(USE_LOADING_SCREEN)
.public INCLUDE_LOADING_SCREEN = .true
.pin loading_screen loading_screen_start
.pre_end
.public PROGRAM_NAME = "Anykey"

screen_size = 32 * 24

LABEL_COLOR = $38 ; black on grey
FRAME_COLOR = $07 ; white on black
PRESSED_COLOR =  $07 ; white on black
UNCHECKED_COLOR = $47 ; bright white on black
CHECKED_COLOR = $06 ; yellow on black

KEY_INDEX_RESET = 13
KEY_INDEX_HELP = 34
KEY_INDEX_NEXT = 35
KEY_INDEX_PREVIOUS = 25
KEY_INDEX_RETURN = 20

PRESS_DURATION = 90
