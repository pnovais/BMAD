# From: Bayesian Models for Astrophysical Data, Cambridge Univ. Press
# (c) 2017,  Joseph M. Hilbe, Rafael S. de Souza and Emille E. O. Ishida 
# 
# you are kindly asked to include the complete citation if you used this 
# material in a publication

# Appendix A - Bayesian Modeling using INLA

# install INLA
#source("http://www.math.ntnu.no/inla/givemeINLA.R")

library(MASS)
library(INLA)
names(inla.models()$likelihood)

set.seed(141)

nobs <- 2500

x1 <- rbinom(nobs,size = 1, prob = 0.6)
x2 <- runif(nobs)

xb <- 1 + 2.0*x1 - 1.5*x2
a <- 3.3
theta <- 0.303                        #1/a

exb <- exp(xb)
nby <- rnegbin(n = nobs, mu = exb, theta = theta)
negbml <-data.frame(nby, x1, x2)

# Load and run INLA negative binomial
require(INLA)                                  # if installed INLA in earlier session

fl <- nby ~ 1 + x1 + x2
NB <- inla(fl, family = "nbinomial", data = negbml,
           control.compute = list(dic = TRUE))

summary(NB)