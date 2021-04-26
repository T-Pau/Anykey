10 if peek(43)<>1 goto 100
20 if peek(44)=8 and peek(56)=160 goto 1064
30 if peek(44)=4 and peek(56)=30 goto 1020:rem 3k
40 if peek(44)=16 goto 200
50 if peek(44)<>18 goto 1000
60 if peek(56)=64 goto 1020:rem 8k
70 if peek(56)=96 goto 1020:rem 16k
80 if peek(56)=128 goto 1020:rem 24k
90 goto 1000
100 if peek(46)=28 and peek(45)=1 goto 1128
110 goto 1000
200 if peek(56)=30 goto 1020
210 if peek(56)=63 goto 1016
220 if peek(56)=253 goto 1004
230 goto 1000

500 poke 53280,15
510 poke 53281,15
520 print"{dark gray}";
530 d=186
540 return

600 color 0,2,6
610 color 4,2,6
620 color 1,2,3
630 d=174
640 return

1000 print"{clear}computer not recognized.":end
1004 f$="anykey plus/4":gosub 600:goto 3000
1016 c$="c16 without ram expansion{return} ":goto 4000
1020 c$="vic 20":goto 4000
1064 f$="anykey 64":gosub 500:goto 3000
1128 f$="anykey 128":gosub 500:goto 3000

3000 print"{clear}{down}{down}{down}{down}"
3010 printspc(17)"UCCCCI"
3020 printspc(17)"B{CBM-D}{CBM-I}{CBM-I}{CBM-F}B"
3030 printspc(17)"B {rvon}{CBM-K}{rvof}{CBM-K} B"
3030 printspc(17)"B {rvon}{CBM-K}{rvof}{CBM-K} B"
3030 printspc(17)"B {CBM-C}{CBM-V} B"
3010 printspc(17)"JCCCCK{down}"
3020 printspc(13)"anykey / t'pau{down}{down}{down}{down}{down}{down}{down}{down}"
3030 printspc(16-len(f$)/2)"loading "f$
3040 d=peek(d)
3050 if d=0 then d=8
3060 loadf$,d

4000 print"{clear}"c$" not yet supported.":end
