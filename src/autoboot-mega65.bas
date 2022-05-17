10 background 15
20 border 15
30 f$="anykey mega65"
40 d=peek(186)
50 if d=0 then d=8
100 print"{dark gray}{clear}";
105 rem adapt to 80 columns
110 print"{clear}{down}{down}{down}{down}"
120 printspc(35)"UCCCCCCCCI"
130 printspc(35)"B {CBM-I}{CBM-I}{CBM-I}{CBM-I}{CBM-I}{CBM-I} B"
140 printspc(35)"B   {rvon}  {rvof}   B"
150 printspc(35)"B   {rvon}  {rvof}   B"
160 printspc(35)"B   {rvon}{CBM-I}{CBM-I}{rvof}   B"
170 printspc(35)"JCCCCCCCCK{down}"
180 printspc(33)"anykey / t'pau{down}{down}{down}{down}{down}{down}{down}{down}"
190 printspc(36-len(f$)/2)"loading "f$
200 loadf$,d
