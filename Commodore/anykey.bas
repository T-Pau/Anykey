0 c=40:r$="B":d$="C"
10 if peek(43)<>1 goto 150
20 if peek(44)=8 and peek(56)=160 goto 1064
30 if peek(44)=4 and peek(56)=30 goto 2000:rem vic-20 3k
40 if peek(44)=16 goto 200
50 if peek(44)<>18 goto 150
60 if peek(56)=64 goto 1020:rem 8k
70 if peek(56)=96 goto 1020:rem 16k
80 if peek(56)=128 goto 1020:rem 24k

150 if peek(46)=28 and peek(45)=1 goto 1128:rem c128
160 if peek(223)=1 and peek(224)=8 goto 1216:rem x16
170 if peek(194)=1 and peek(195)=32 goto 1065:rem mega65
180 goto 1000

200 if peek(56)=30 goto 2000:rem vic-20 0k
210 if peek(56)=63 goto 1016:rem c16
220 if peek(56)=253 goto 1004:rem plus/4
230 goto 1000

400 if peek(215)>127 then c=80
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

700 poke 36879, 127
710 print"{blue}";
720 d=186
730 c=22:r$="H":d$="F"
740 return

1000 print"{clear}computer not recognized.":end
1004 f$="anykey plus/4":gosub 600:goto 3000
1016 f$="anykey c16":gosub 600:goto 3000
1020 f$="anykey vic-20":gosub 700:goto 3000
1064 f$="anykey c64":gosub 500:goto 3000
1065 f$="anykey mega65":c=80:gosub 500:goto 3000
1128 f$="anykey c128":gosub 400:goto 3000
1216 c$="commander x16":goto 4000
2000 print"{clear}sorry, at least 8k"
2001 print"ram expansion required.":end

3000 print"{clear}{down}{down}{down}{down}"
3010 p=c/2-7
3020 if c<80 then gosub 3100
3030 if c=80 then gosub 3200
3040 printspc(p)"{down}anykey / t'pau{down}{down}{down}{down}{down}{down}{down}{down}"
3050 printspc(p+3-len(f$)/2)"loading "f$
3060 d=peek(d)
3070 if d=0 then d=8
3080 loadf$,d

3100 printspc(p+4)"UCCCCI"
3110 printspc(p+4)"B{CBM-D}{CBM-I}{CBM-I}{CBM-F}"r$
3120 printspc(p+4)"B {rvon}{CBM-K}{rvof}{CBM-K} "r$
3130 printspc(p+4)"B {rvon}{CBM-K}{rvof}{CBM-K} "r$
3140 printspc(p+4)"B {CBM-C}{CBM-V} "r$
3150 printspc(p+4)"J"d$d$d$d$"K"
3160 return

3200 printspc(p+2)"UCCCCCCCCI"
3210 printspc(p+2)"B {CBM-I}{CBM-I}{CBM-I}{CBM-I}{CBM-I}{CBM-I} B"
3220 printspc(p+2)"B   {rvon}  {rvof}   B"
3230 printspc(p+2)"B   {rvon}  {rvof}   B"
3240 printspc(p+2)"B   {rvon}{CBM-I}{CBM-I}{rvof}   B"
3250 printspc(p+2)"JCCCCCCCCK{down}"
3260 return

4000 print"{clear}sorry, there is no version of anykey for the "c$" yet.":end
