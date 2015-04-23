proc arima data=LatDol;
identify var=avg(1) nlag=18;
estimate q=1 noint;
identify var=end nlag=18;
estimate p=1;
run;
