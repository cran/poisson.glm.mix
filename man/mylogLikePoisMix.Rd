\name{mylogLikePoisMix}
\alias{mylogLikePoisMix}
\title{Function to compute the loglikelihood of the mixture.
}
\description{This function computes the observed loglikelihood given the means and the mixing proportions of each component. Instead of computing \eqn{L_{i}=\log\sum_{k=1}^{K}g_{ik}}, \eqn{i=1,\ldots,n}, where \eqn{g_{ik}:=\pi_{k}\prod_{j=1}^{J}\prod_{\ell=1}^{L_j}f(y_{ij\ell}|\mu_{ijlk;m})}, \eqn{h_{ik}:=\log g_{ik}} are computed for all \eqn{ i }. Let \eqn{h_{i}^{*}=\max\{h_{ik},k=1,\ldots,K\}}, then  \eqn{L_{i}=h_{i}^{*}+\log\sum_{k=1}^{K}\exp(h_{ik}-h^{*}_{i})}.
}
\usage{
mylogLikePoisMix(y, mean, pi)
}
\arguments{
  \item{y}{a numeric array of count data with dimension \eqn{n\times d}.
}
  \item{mean}{a list of length K (the number of mixture components) of positive data. Each list element is a matrix with dimension \eqn{n\times d} containing \eqn{d} Poisson means for each of the \eqn{n} observations.
}
  \item{pi}{a numeric vector of length K (the number of mixture components) containing the mixture weights.
}
}
\value{
\item{ll }{the value of the loglikelihood.}
}
\author{
Panagiotis Papastamoulis
}

\examples{
## This example computes the loglikelihood of a K = 10 component 
##      Poisson GLM mixture. The number of response variables is
##      d = 6, while the sample size equals to n = 5000. They are
##      stored in the array sim.data[,-1]. The number of covariates
##      equals 1 (corresponding to sim.data[,1]). We will use a 
##      random generation of the regression coefficients alpha and 
##      beta, in order to show that the loglikelihood can be computed 
##      without computational errors even in cases where the parameters
##      are quite ''bad'' for the data.   

data("simulated_data_15_components_bjk_full")
K <- 10
d <- 6
n <- dim(sim.data)[1]
condmean=vector("list",length=K)
weights<-rep(1,K)/K
ar<-array(data=NA,dim=c(n,d))
for (k in 1:K){
for (i in 1:d){
ar[,i]<-runif(n)+(1+0.1*(runif(n)-1))*sim.data[,1]}
condmean[[k]]<-ar}
mylogLikePoisMix(sim.data[,-1],condmean,weights)

}
