;  color.s -- Contents of color RAM.
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

.export main_color_64, main_color_128, help_color

.rodata

main_color_64:
	.res 40 * 2, $c
	.res 40 * 10, $0
	.res 40 * 4, $c
	.repeat 5, i
	.res 4, $c
	.res 32, $b
	.res 4, $c
	.endrep
	.res 40 * 4, $c

main_color_128:
	.res 40 * 2, $c
	.res 16, $0
	.res 2, $b
	.res 22, $0
	.res 16, $0
	.res 2, $b
	.res 22, $0
	.res 40 * 10, $0
	.res 40 * 3, $c
	.repeat 5, i
	.res 5, $c
	.res 30, $b
	.res 5, $c
	.endrep
	.res 40 * 3, $c

help_color:
	.res 2 * 40, $c
	.res 18 * 40, $b
	.res 5 * 40, $c
