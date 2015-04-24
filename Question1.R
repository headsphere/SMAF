# ---- Question1-dataload ----

source("binaryHMMRcode.r")
MelbourneRain <- read.table("MelbourneAirport.txt",header=TRUE)
attach(MelbourneRain)

# ---- Question1-i ----
mean(Rain)
tapply(Rain,Month,mean)


m <- 1
pi0 <- c(mean(Rain))
gamma0 <- matrix(c(1),nrow=m)
Melbourne.mle1 <- binary.HMM.mle(Rain,m,pi0,gamma0)
Melbourne.mle1
m <- 2
pi0 <- c(0.001,0.9)
gamma0 <- matrix(c(0.8,0.2,0.4,0.6),nrow=m,byrow=TRUE)
Melbourne.mle2 <- binary.HMM.mle(Rain,m,pi0,gamma0)
Melbourne.mle2
m <- 3
pi0 <- c(0.01,0.5,0.99)
gamma0 <-matrix(c(0.8,0.1,0.1,0.1,0.8,0.1,0.2,0.2,0.6),nrow=m,byrow=TRUE)
Melbourne.mle3 <- binary.HMM.mle(Rain,m,pi0,gamma0)
Melbourne.mle3
m <- 3
pi <- Melbourne.mle3$pi
gamma <- Melbourne.mle3$gamma
Melbourne.mle3probs <- binary.HMM.state_probs(MelbourneRain$Rain,m,pi,gamma)
Melbourne.mle3local <- binary.HMM.local_decoding(MelbourneRain$Rain,m,pi,gamma)
Melbourne.mle3global <- binary.HMM.viterbi(MelbourneRain$Rain,m,pi,gamma)
p1 <- round(Melbourne.mle3probs[1,],3)
p2 <- round(Melbourne.mle3probs[2,],3)
p3 <- round(Melbourne.mle3probs[3,],3)
ld <- Melbourne.mle3local
gd <- Melbourne.mle3global
Melbournedecode <- cbind(MelbourneRain,p1,p2,p3,ld,gd)
Melbournedecode.txt <- write.table(Melbournedecode,file="Melbournedecode.txt",
                                  quote = FALSE,sep="\t", row.names = FALSE)
rm(Melbourne.mle3probs,Melbourne.mle3local,Melbourne.mle3global)
rm(p1,p2,p3,ld,gd)
detach(MelbourneRain)
attach(Melbournedecode)
table(ld)
table(gd)
table(ld,gd)
Melbournedecode[gd==2,]
table(Rain,gd)
table(Rain,ld)
detach(Melbournedecode)
