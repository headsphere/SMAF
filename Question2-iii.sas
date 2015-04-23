proc arima data=LatDol;
identify var=end(1) nlag=18;
estimate q=1 noint;
identify var=avg(1) crosscor=end(1) nlag=18;
estimate q=1 input=(1 $ (1) /  end) noint;
forecast lead=3 out=results;
run;
