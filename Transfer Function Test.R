# Simulated data
x = 2+arima.sim(list(ar=0.75),202)
y = 4+3*x[1:200]+arima.sim(list(ma=c(-0.8,-0.6)),200,sd=2)
x = ts(x[3:202])
#plot(ts(x),ylim=range(x,y))
#lines(ts(y),col=2)

# fit x and check cross-correlation
library(TSA)
mx = arima(x, order=c(1,0,0))
summary(mx)
ccf(x,y)
pw = prewhiten(x,y,mx)
# transfer function
tf2 = arimax(window(y,3,200), order=c(0,0,2),xtransf=data.frame(x=x[1:198]),transfer=list(c(0,0)))

tf2

x = 2 + arima.sim(list(ar=0.4,ma=-0.3),404)
y = 4 + 0.5*x[5:404] + 1.0*x[4:403] + 2*x[3:402] + 0.7*x[2:401] + 0.3*x[1:400] + arima.sim(list(ar=0.7),400,sd=1.5) 
x = ts(x[5:404])
plot(ts(x),ylim=range(x,y))
lines(ts(y),col=2)

# fit x and check cross-correlation
mx = TSA::arima(x, order=c(1,0,1))
summary(mx)
ccf(x,y)
# Fix bug in prewhiten() using trace(): swap phi/theta filter in # filter.mod()
pw = prewhiten(x,y,mx)
# transfer function
tf2 = TSA::arima(y, order=c(1,0,0),xtransf=data.frame(x=x), transfer=list(c(0,4)))
summary(tf2)

