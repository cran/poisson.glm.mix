\name{init1.k}
\alias{init1.k}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{
%%  ~~function to do ... ~~
Initialization 1 for the \eqn{\beta_{k}} parameterization (\eqn{m=3}).
}
\description{
%%  ~~ A concise (1-5 lines) description of what the function does. ~~
This function is the small initialization procedure (Initialization 1) for parameterization \eqn{m=3}. The selected values are the ones that initialize the EM algorithm \code{bkmodel}.
}
\usage{
init1.k(reference, response, L, K, t2, m2)
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
}
\value{
%%  ~Describe the value returned
%%  If it is a LIST, use
%%  \item{comp1 }{Description of 'comp1'}
%%  \item{comp2 }{Description of 'comp2'}
%% ...
\item{alpha, }{numeric array of dimension \eqn{J \times K} containing the selected values \eqn{\alpha_{jk}^{(0)}}, \eqn{j=1,\ldots,J}, \eqn{k=1,\ldots,K} that will be used to initialize main EM.}
\item{beta }{numeric array of dimension \eqn{K \times T} containing the selected values of \eqn{\beta_{k\tau}^{(0)}}, \eqn{k=1,\ldots,K}, \eqn{\tau=1,\ldots,T}, that will be used to initialize the main EM.}
\item{psim }{numeric vector of length \eqn{K} containing the weights that will initialize the main EM.}
\item{ll }{numeric, the value of the loglikelihood, computed according to the \code{mylogLikePoisMix} function.}
}
\author{
%%  ~~who you are~~
Panagiotis Papastamoulis
}

%% ~Make other sections like Warning with \section{Warning }{....} ~

\seealso{
\code{\link{bkmodel}}, \code{\link{init2.k}}
}
\examples{
## load a simulated dataset according to the b_jk model
## number of observations: 500
## design: L=(3,2,1)
data("simulated_data_15_components_bjk")
x <- sim.data[,1]
x <- array(x,dim=c(length(x),1))
y <- sim.data[,-1]
## initialize the parameters for a 2 component mixture
## the number of the small runs are t2 = 3
## each one consisting of m2 = 5 iterations of the EM.
start1 <- init1.k(reference=x, response=y, L=c(3,2,1), 
                       K=2, m2=5, t2=3)
summary(start1)


}
