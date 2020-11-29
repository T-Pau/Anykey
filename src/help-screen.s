;  help-screen.s -- Text for help screens.
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


.autoimport +
.export display_help_page, current_help_page

.include "anykey.inc"

help_screen_start = screen + 1

help_screen_size = 38 * 20
num_help_screens = 1

.macpack cbm
.macpack cbm_ext

.bss

current_help_page:
	.res 1

.rodata

help_screens:
	.repeat num_help_screens, i
	.word help_screens_data + help_screen_size * i
	.endrep

help_screens_data:
	invcode "anykey                                "
	scrcode "                                      "
	scrcode "this program displays the state of the" ;  1
	scrcode "keyboard and joysticks.               " ;  2
	scrcode "                                      " ;  3
	scrcode "                                      " ;  4
	scrcode "                                      " ;  5
	scrcode "                                      " ;  6
	scrcode "                                      " ;  7
	scrcode "                                      " ;  8
	scrcode "                                      " ;  9
	scrcode "                                      " ; 10
	scrcode "                                      " ; 11
	scrcode "                                      " ; 12
	scrcode "                                      " ; 13
	scrcode "                                      " ; 14
	scrcode "                                      " ; 15
	scrcode "                                      " ; 16
	scrcode "                                      " ; 17
	scrcode "                                      " ; 18


.code

display_help_page:
	lda current_help_page
	bmi negative
	cmp #<num_help_screens
	bne ok
	lda #0
	beq ok
negative:
	lda #<(num_help_screens - 1)
ok:
	sta current_help_page
	asl
	tax

	lda help_screens,x
	sta ptr1
	lda help_screens + 1,x
	sta ptr1 + 1
	lda #<help_screen_start
	sta ptr2
	lda #>help_screen_start
	sta ptr2 + 1
	ldx #38
	ldy #20
	jmp copyrect
