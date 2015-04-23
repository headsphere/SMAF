proc varmax data=LatDol;
model end avg /
minic = (type=sbc p=(0:10) q=0) noint dif=(end(1) avg(1)) PRINT=DIAGNOSE;
output lead=3;
run;
