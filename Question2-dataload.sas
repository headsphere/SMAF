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
                         
run;                     

