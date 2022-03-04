10 if peek(53)=255 then 350
20 size=peek(53)/4
30 a$="8k"
40 if size<8 then 300
50 if size>8 then a$="full"
60 f$="anykey pet "+a$
70 print chr$(142)
100 print"{clear}{down}{down}{down}{down}"
110 printspc(17)"UCCCCI"
120 printspc(17)"B{CBM-D}{CBM-I}{CBM-I}{CBM-F}H"
130 printspc(17)"B {rvon}{CBM-K}{rvof}{CBM-K} H"
130 printspc(17)"B {rvon}{CBM-K}{rvof}{CBM-K} H"
140 printspc(17)"B {CBM-C}{CBM-V} H"
150 printspc(17)"JFFFFK{down}"
160 printspc(13)"anykey / t'pau{down}{down}{down}{down}{down}{down}{down}{down}"
170 printspc(16-len(f$)/2)"loading "f$
180 d=peek(186)
190 if d=0 then d=8
200 loadf$,d
300 print"anykey requires at least 8k ram."
310 end
350 print"anykey requires at least rom version 2."
