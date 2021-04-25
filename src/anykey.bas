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

1000 print"{clear}computer not recognized.":end
1004 f$="anykey plus/4":d=174:goto 3000
1016 c$="c16 without ram expansion{return} ":goto 4000
1020 c$="vic 20":goto 4000
1064 f$="anykey 64":d=186:goto 3000
1128 f$="anykey 128":d=186:goto 3000

3000 print"{clear}loading "f$"."
3010 d=peek(d)
3020 if d=0 then d=8
3030 loadf$,d

4000 print"{clear}"c$" not yet supported.":end
