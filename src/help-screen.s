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
.export display_help_page, current_help_page, help_next, help_previous

.include "defines.inc"

help_screen_start = screen + 1

help_screen_size = 38 * 20
.ifdef __C64__
num_help_screens = 6
.else
num_help_screens = 5
.endif

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
	scrcode "this program monitors the keyboard and" ;  1
	scrcode "joysticks.                            " ;  2
	scrcode "                                      " ;  3
	scrcode "the upper window shows the state of   " ;  4
	scrcode "the keyboard.                         " ;  5
	scrcode "                                      " ;  6
	scrcode "the lower window shows the state of   " ;  7
	scrcode "two joysticks connected to the        " ;  8
	scrcode "controller ports.                     " ;  9
	scrcode "                                      " ; 10
	scrcode "to test other controller types or     " ; 11
	scrcode "joystick adapters, please use the     " ; 12
	scrcode "companion program joyride which can be" ; 13
	scrcode "found at:                             " ; 14
	scrcode "  https://github.com/t-pau/joyride    " ; 15
	scrcode "                                      " ; 16
	scrcode "                                      " ; 17
	scrcode "                                      " ; 18

	invcode "keyboard                              "
	scrcode "                                      "
	scrcode "the keys are displayed in the same    " ;  1
	scrcode "layout as the physical keyboard.      " ;  2
	scrcode "                                      " ;  3
	scrcode "keys that are currently pressed are   " ;  4
	scrcode "displayed inverted.                   " ;  5
	scrcode "                                      " ;  6
	scrcode "keys that were previously pressed are " ;  7
	scrcode "displayed in a lighter gray. this     " ;  8
	scrcode "helps detect dead keys. to reset the  " ;  9
	scrcode "state of all keys to unpressed, hold  " ; 10
	scrcode "f5 for two seconds.                   " ; 11
	scrcode "                                      " ; 12
	scrcode "                                      " ; 13
	scrcode "                                      " ; 14
	scrcode "                                      " ; 15
	scrcode "                                      " ; 16
	scrcode "                                      " ; 17
	scrcode "                                      " ; 18

	invcode "joysticks                             "
	scrcode "                                      "
	scrcode "joysticks contain a stick or d-pad    " ;  1
	scrcode "with switches for the four cardinal   " ;  2
	scrcode "directions and up to three buttons.   " ;  3
	scrcode "                                      " ;  4
	scrcode "pressed directions and buttons are    " ;  5
	scrcode "displayed inverted.                   " ;  6
	scrcode "                                      " ;  7
	scrcode "buttons 2 and 3 bring an analog       " ;  8
	scrcode "potentiometer to a low value by       " ;  9
	scrcode "connecting its pin to +5v.            " ; 10
	scrcode "                                      " ; 11
	scrcode "                                      " ; 12
	scrcode "                                      " ; 13
	scrcode "                                      " ; 14
	scrcode "                                      " ; 15
	scrcode "                                      " ; 16
	scrcode "                                      " ; 17
	scrcode "                                      " ; 18
	
	invcode "special keys                          "
	scrcode "                                      "
	scrcode "shift lock and the left shift key     " ;  1
	scrcode "appear as the same key to the computer" ;  2
	scrcode "and cannot be reliably distinguished  " ;  3
	scrcode "on all computers.                     " ;  4
	scrcode "                                      " ;  5
	scrcode "the restore key cannot be read        " ;  6
	scrcode "directly. anykey can detect when the  " ;  7
	scrcode "key is pressed, but it can't detect   " ;  8
	scrcode "for how long.                         " ;  9
	scrcode "                                      " ; 10
	scrcode "                                      " ; 11
	scrcode "                                      " ; 12
	scrcode "                                      " ; 13
	scrcode "                                      " ; 14
	scrcode "                                      " ; 15
	scrcode "                                      " ; 16
	scrcode "                                      " ; 17
	scrcode "                                      " ; 18

.ifdef __C64__
	invcode "commodore 128                         "
	scrcode "                                      "
	scrcode "when run in c64 mode on a c128, anykey" ;  1
	scrcode "will display and test the full c128   " ;  2
	scrcode "keyboard.                             " ;  3
	scrcode "                                      " ;  4
	scrcode "the 40/80 display key cannot be read  " ;  5
	scrcode "in c64 mode, therefore it is displayed" ;  6
	scrcode "grayed out. to test it, use the native" ;  7
	scrcode "version, anykey 128.                  " ;  8
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
.endif

	invcode "technical limitations                 "
	scrcode "                                      "
	scrcode "joysticks interfere with reading the  " ;  1
	scrcode "keyboard. when a joystick is pressed, " ;  2
	scrcode "certain keys can't be read. these keys" ;  3
	scrcode "will be ignored while the joystick is " ;  4
	scrcode "pressed. if such a key was pressed    " ;  5
	scrcode "before the joystick, it will remain   " ;  6
	scrcode "pressed until the joystick is         " ;  7
	scrcode "released. auto fire might defeat this " ;  8
	scrcode "detection and result in phantom key   " ;  9
	scrcode "presses.                              " ; 10
	scrcode "                                      " ; 11
	scrcode "if you press certain combinations of  " ; 12
	scrcode "three keys, a fourth key will also    " ; 13
	scrcode "appear pressed. this is because the   " ; 14
	scrcode "three keys together create the same   " ; 15
	scrcode "electrical connection the fourth key  " ; 16
	scrcode "would.                                " ; 17
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

help_next:
	inc current_help_page
	jmp display_help_page

help_previous:
	dec current_help_page
	jmp display_help_page
