air.zoo <- read.zoo("Airline.dat", 
                        index.column = 1:2, 
                        FUN = function(year, month){ as.yearmon(paste(year, month, sep = "-"))})
air.ts = as.ts(air.zoo)
lair.ts = log(air.ts)
laird.ts = diff(lair.ts)
acf(laird.ts)
lairdd.ts = diff(laird.ts, lag = 12)
acf(lairdd.ts)

lair.arima <- arima(lair.ts,order=c(0,1,1),list(order=c(0,1,1),period=12))

tsdiag(lair.arima)

air.fore = predict(lair.arima, 120)
pred <- air.fore$pred
L95 <- pred - 1.96 * air.fore$se
U95 <- pred + 1.96 * air.fore$se
air.PL95 <- data.frame(L95, pred, U95)
air.PL95
ts.plot(lair.ts, L95, pred, U95)