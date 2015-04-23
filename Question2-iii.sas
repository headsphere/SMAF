ODS LISTING CLOSE;
ODS HTML;
data LatDol;
infile 'latdol.txt' delimiter='09'x MISSOVER DSD lrecl=32767 ;
       informat year best32. ;
       informat month   best32. ;
       informat avg  best32. ;
       informat end  best32. ;
       format year best12. ;
       format month   best12. ;
       format avg  best12. ;
       format end  best12. ;
    input
                year
                month
                avg
                end
    ;
date = mdy(month,1,year);
format date year4.;
proc print data=LatDol;
proc timeplot data=LatDol;
plot avg;

proc arima data=LatDol;
identify var=end nlag=18;
estimate p=1;

identify var=avg(1) nlag=18;
estimate q=1 noint;

identify var=avg(1) crosscor=end nlag=18;
estimate q=1 input=(2 $ / (1) end) noint;

forecast lead=3 out=results;

run;

ODS HTML CLOSE;
ODS LISTING;
