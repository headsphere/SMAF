ODS LISTING CLOSE;
ODS HTML;
data LatDol;
infile '\\psf\Home\Documents\RStudioProjects\SMAF - Time Series\latdol.txt' delimiter='09'x MISSOVER DSD lrecl=32767 ;
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
identify var=end(1) nlag=18;
estimate noint;
forecast lead=10 out=results;

proc arima data=LatDol;
identify var=avg(1) nlag=18;
estimate q=1 noint;
forecast lead=10 out=results;

run;

ODS HTML CLOSE;
ODS LISTING;
