\name{init2.k}
\alias{init2.k}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{
%%  ~~function to do ... ~~
Initialization 2 for the  \eqn{\beta_k} parameterization (\eqn{m=3}).
}
\description{
%%  ~~ A concise (1-5 lines) description of what the function does. ~~
This function applies a random splitting small EM initialization scheme (Initialization 2), for parameterization \eqn{m=3}. It can be implemented only in case where a previous run of the EM algorithm is available (with respect to the same parameterization). The initialization scheme proposes random splits of the existing clusters, increasing the number of mixture components by one. Then EM is ran for (\code{m2}) iterations, and the procedure is repeated for \code{t2} times. The best values in terms of observed loglikelihood are chosen in order to initialize the main EM algorithm (\code{bkmodel}), when \eqn{K>K_{min}}.
}
\usage{
init2.k(reference, response, L, K, t2, m2, previousz, previousclust, 
        previous.alpha, previous.beta,mnr)
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{reference}{a numeric array of dimension \eqn{n\times V} containing the \eqn{V} covariates for each of the \eqn{n} observations.
%%     ~~Describe \code{reference} here~~
}
  \item{response}{a numeric array of count data with dimension \eqn{n\times d} containing the \eqn{d} response variables for each of the \eqn{n} observations.
%%     ~~Describe \code{response} here~~
}
  \item{L}{numeric vector of positive integers containing the partition of the \eqn{d} response variables into \eqn{J\leq d} blocks, with \eqn{\sum_{j=1}^{J}L_j=d}.
%%     ~~Describe \code{L} here~~
}
  \item{K}{positive integer denoting the number of mixture components.
%%     ~~Describe \code{K} here~~
}
  \item{t2}{positive integer denoting the number of different runs.
%%     ~~Describe \code{t2} here~~
}
  \item{m2}{positive integer denoting the number of iterations for each run.
%%     ~~Describe \code{m2} here~~
}
  \item{previousz}{numeric array of dimension \eqn{n\times(K-1)} containing the estimates of the posterior probabilities according to the previous run of EM. 
%%     ~~Describe \code{previousz} here~~
}
  \item{previousclust}{numeric vector of length \eqn{n} containing the estimated clusters according to the MAP rule obtained by the previous run of EM.
%%     ~~Describe \code{previousclust} here~~
}
  \item{previous.alpha}{numeric array of dimension \eqn{J\times (K-1)} containing the matrix of the ML estimates of the regression constants \eqn{\alpha_{jk}}, \eqn{j=1,\ldots,J}, \eqn{k=1,\ldots,K-1}, based on the previous run of EM algorithm.
%%     ~~Describe \code{previous.alpha} here~~
}
  \item{previous.beta}{numeric array of dimension \eqn{(K-1)\times T} containing the matrix of the ML estimates of the regression coefficients \eqn{\beta_{k\tau}}, \eqn{k=1,\ldots,K-1}, \eqn{\tau=1,\ldots,T}, based on the previous run of EM algorithm.
%%     ~~Describe \code{previous.beta} here~~
}
  \item{mnr}{positive integer denoting the maximum number of Newton-Raphson iterations.
%%     ~~Describe \code{mnr} here~~
}
}
\value{
%%  ~Describe the value returned
%%  If it is a LIST, use
%%  \item{comp1 }{Description of 'comp1'}
%%  \item{comp2 }{Description of 'comp2'}
%% ...
\item{alpha }{numeric array of dimension \eqn{J \times K} containing the selected values \eqn{\alpha_{jk}^{(0)}}, \eqn{j=1,\ldots,J}, \eqn{k=1,\ldots,K} that will be used to initialize main EM.}
\item{beta }{numeric array of dimension \eqn{K \times T} containing the selected values of \eqn{\beta_{k\tau}^{(0)}}, \eqn{k=1,\ldots,K}, \eqn{\tau=1,\ldots,T}, that will be used to initialize the main EM.}
\item{psim }{numeric vector of length \eqn{K} containing the weights that will initialize the main EM.}
\item{ll }{numeric, the value of the loglikelihood, computed according to the \code{mylogLikePoisMix} function.}
}
\author{
%%  ~~who you are~~
Panagiotis Papastamoulis
}
\note{
%%  ~~further notes~~
In case that an exhaustive search is desired instead of a random selection of the splitted components, use\code{t2 = -1}.
}

%% ~Make other sections like Warning with \section{Warning }{....} ~

\seealso{
%% ~~objects to See Also as \code{\link{help}}, ~~~
\code{\link{init1.k}}, \code{\link{bkmodel}}
}
\examples{
# this is to be used as an example with the simulated data

data("simulated_data_15_components_bjk")
x <- sim.data[,1]
x <- array(x,dim=c(length(x),1))
y <- sim.data[,-1]

# At first a 2 component mixture is fitted using parameterization $m=1$.
run.previous<-bkmodel(reference=x, response=y, L=c(3,2,1), m=100, K=2, 
                      nr=-10*log(10), maxnr=5, m2=3, t2=3, prev.z, 
                      prev.clust, start.type=1, prev.alpha, prev.beta)
## Then the estimated clusters and parameters are used to initialize a 
##  3 component mixture using Initialization 2. The number of different 
##  runs is set to tsplit=3 with each one of them using msplit = 5
##  em iterations. 
q <- 3
tau <- 1
nc <- 3
z <- run.previous$z
ml <- length(run.previous$psim)/(nc - 1)
alpha <- array(run.previous$alpha[ml, , ], dim = c(q, nc - 1))
beta <- array(run.previous$beta[ml, , ], dim = c(nc - 1, tau))
clust <- run.previous$clust
run<-init2.k(reference=x, response=y, L=c(3,2,1), K=nc, t2=3, m2=5, previousz=z, 
             previousclust=clust, previous.alpha=alpha, previous.beta=beta,mnr = 5)
summary(run)
# note: useR should specify larger values for m2, t2 for a complete analysis.
}
