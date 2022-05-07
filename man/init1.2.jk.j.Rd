\name{init1.2.jk.j}
\alias{init1.2.jk.j}
\title{
2nd step of Initialization 1 for the \eqn{\beta_{jk}} (\eqn{m=1}) or \eqn{\beta_{j}} (\eqn{m=2}) parameterization.
}
\description{
This function is the second step of the two-step small initialization procedure (Initialization 1), used for parameterizations \eqn{m=1} or \eqn{m=2}. At first, \code{init1.1.jk.j} is called for each condition \eqn{j=1,\ldots,J}. The values obtained from the first step are used for initializing the second step of the small EM algorithm for fitting the overall mixture \eqn{\sum_{k=1}^{K}\pi_j\prod_{j=1}^{J}\prod_{\ell=1}^{L_j}f(y_{ij\ell})}. The selected values from the second step are the ones that initialize the EM algorithm (\code{bjkmodel} or \code{bjmodel}), when \eqn{K=K_{min}}.
}
\usage{
init1.2.jk.j(reference, response, L, K, m1, m2, t1, t2, model,mnr)
}
\arguments{
  \item{reference}{a numeric array of dimension \eqn{n\times V} containing the \eqn{V} covariates for each of the \eqn{n} observations.
}
  \item{response}{a numeric array of count data with dimension \eqn{n\times d} containing the \eqn{d} response variables for each of the \eqn{n} observations.
}
  \item{L}{numeric vector of positive integers containing the partition of the \eqn{d} response variables into \eqn{J\leq d} blocks, with \eqn{\sum_{j=1}^{J}L_j=d}.
}
  \item{K}{positive integer denoting the number of mixture components.
}
  \item{m1}{positive integer denoting the number of iterations for each run of \code{init1.1.jk.j}.
}
  \item{m2}{positive integer denoting the number of iterations for each run of \code{init1.2.jk.j}.
}
  \item{t1}{positive integer denoting the number of different runs of \code{init1.1.jk.j}.
}
  \item{t2}{positive integer denoting the number of different runs of \code{init1.2.jk.j}.
}
  \item{model}{binary variable denoting the parameterization of the model: 1 for \eqn{\beta_{jk}} and 2 for \eqn{\beta_{j}} parameterization.
}
  \item{mnr}{positive integer denoting the maximum number of Newton-Raphson iterations.
}
}
\value{
\item{alpha }{numeric array of dimension \eqn{J \times K} containing the selected values \eqn{\alpha_{jk}^{(0)}}, \eqn{j=1,\ldots,J}, \eqn{k=1,\ldots,K} that will be used to initialize main EM.}
\item{beta }{numeric array of dimension \eqn{J \times K \times T} (if \code{model = 1}) or \eqn{J \times T} (if \code{model = 2}) containing the selected values of \eqn{\beta_{jk\tau}^{(0)}} (or \eqn{\beta_{j\tau}^{(t)}}), \eqn{j=1,\ldots,J}, \eqn{k=1,\ldots,K}, \eqn{\tau=1,\ldots,T}, that will be used to initialize the main EM.}
\item{psim }{numeric vector of length \eqn{K} containing the weights that will initialize the main EM.}
\item{ll }{numeric, the value of the loglikelihood, computed according to the \code{mylogLikePoisMix} function.}
}
\author{
Panagiotis Papastamoulis
}


\seealso{
\code{\link{init1.1.jk.j}}, \code{\link{bjkmodel}}, \code{\link{bjmodel}}
}
\examples{
############################################################
#1.            Example with beta_jk (m=1) model            #
############################################################
## load a simulated dataset according to the b_jk model
## number of observations: 500
## design: L=(3,2,1)
data("simulated_data_15_components_bjk")
x <- sim.data[,1]
x <- array(x,dim=c(length(x),1))
y <- sim.data[,-1]
## initialize the parameters for a 2 component mixture
## the number of the overall small runs are t2 = 2
## each one consisting of m2 = 2 iterations of the EM.
## the number of the small runs for the first step small EM
## is t1 = 2, each one consisting of m1 = 2 iterations.
start2 <- init1.2.jk.j(reference=x, response=y, L=c(3,2,1), 
                       K=2, m1=2, m2=2, t1=2, t2=2, model=1,mnr = 3)
summary(start2)

############################################################
#2.            Example with beta_j (m=2) model             #
############################################################

## initialize the parameters for a 2 component mixture
## the number of the overall small runs are t2 = 3
## each one consisting of m2 = 2 iterations of the EM.
## the number of the small runs for the first step small EM
## is t1 = 2, each one consisting of m1 = 2 iterations.
start2 <- init1.2.jk.j(reference=x, response=y, L=c(3,2,1), 
                       K=2, m1=2, m2=2, t1=2, t2=3, model=2,mnr = 5)
summary(start2)



}
