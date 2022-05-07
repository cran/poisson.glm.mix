\name{bjmodel}
\alias{bjmodel}
\title{
EM algorithm for the \eqn{\beta_{j}} (m=2) Poisson GLM mixture.
}
\description{
This function applies  EM algorithm for estimating a \eqn{K}-component mixture of Poisson GLM's, using parameterization \eqn{m=2}, that is the \eqn{\beta_{j}} model. Initialization can be done using two different intialization schemes. The first one is a two-step small EM procedure. The second  one is  a random splitting small EM procedure based on results of a mixture with less components. Output of the function is the updates of the parameters at each iteration of the EM algorithm, the estimate of \eqn{\gamma}, the estimated clusters and conditional probabilities of the observations, as well as the values of the BIC, ICL and loglikelihood of the model.
}
\usage{
bjmodel(reference, response, L, m, K, nr, maxnr, m1, m2, t1, t2, 
        msplit, tsplit, prev.z, prev.clust, start.type, 
        prev.alpha, prev.beta)
}
\arguments{
  \item{reference}{a numeric array of dimension \eqn{n\times V} containing the \eqn{V} covariates for each of the \eqn{n} observations.
}
  \item{response}{a numeric array of count data with dimension \eqn{n\times d} containing the \eqn{d} response variables for each of the \eqn{n} observations.
}
  \item{L}{numeric vector of positive integers containing the partition of the \eqn{d} response variables into \eqn{J\leq d} blocks, with \eqn{\sum_{j=1}^{J}L_j=d}.
}
  \item{m}{positive integer denoting the maximum number of EM iterations.
}
  \item{K}{positive integer denoting the number of mixture components.
}
  \item{nr}{negative number denoting the tolerance for the convergence of the Newton Raphson iterations.
}
  \item{maxnr}{positive integer denoting the maximum number of Newton Raphson iterations.
}
  \item{m1}{positive integer denoting the number of iterations for each call of the 1st small EM iterations used by Initialization 1 (\code{init1.1.jk.j}).
}
  \item{m2}{positive integer denoting the number of iterations for each call of the 2nd small EM iterations used by Initialization 1 (\code{init1.2.jk.j}).
}
  \item{t1}{positive integer denoting the number of different runs of the 1st small EM used by Initialization 1 (\code{init1.1.jk.j}).
}
  \item{t2}{positive integer denoting the number of different runs of the 2nd small EM used by Initialization 1 (\code{init1.2.jk.j}).
}
  \item{msplit}{positive integer denoting the number of different runs for each call of the splitting small EM used by Initialization 2 (\code{init2.jk.j}).
}
  \item{tsplit}{positive integer denoting the number of different runs for each call of the splitting small EM used by Initialization 2 (\code{init2.jk.j}).
}
  \item{prev.z}{numeric array of dimension \eqn{n\times(K-1)} containing the estimates of the posterior probabilities according to the previous run of EM. This is used when Initialization 2 is adopted.
}
  \item{prev.clust}{numeric vector of length \eqn{n} containing the estimated clusters according to the MAP rule obtained by the previous run of EM. This is used when Initialization 2 is adopted.
}
  \item{start.type}{binary variable (1 or 2) indicating the type of initialization (1 for initialization 1 and 2 for initialization 2).
}
  \item{prev.alpha}{numeric array of dimension \eqn{J\times (K-1)} containing the matrix of the ML estimates of the regression constants \eqn{\alpha_{jk}}, \eqn{j=1,\ldots,J}, \eqn{k=1,\ldots,K-1}, based on the previous run of EM algorithm. This is used in case of Initialization 2.
}
  \item{prev.beta}{numeric array of dimension \eqn{J\times T} containing the matrix of the ML estimates of the regression coefficients \eqn{\beta_{j\tau}},\eqn{j=1,\ldots,J}, \eqn{\tau=1,\ldots,T}, based on the previous run of EM algorithm. This is used in case of Initialization 2.
}
}
\value{
\item{alpha }{numeric array of dimension \eqn{t_{EM}\times J \times K} containing the updates of regression constants \eqn{\alpha_{jk}^{(t)}}, \eqn{j=1,\ldots,J}, \eqn{k=1,\ldots,K}, for each iteration \eqn{t=1,2,\ldots,t_{EM}} of the EM algorithm.}
\item{beta }{numeric array of dimension \eqn{t_{EM}\times J \times T} containing the updates of regression coefficients \eqn{\beta_{j\tau}^{(t)}}, \eqn{j=1,\ldots,J}, \eqn{\tau=1,\ldots,T}, for each iteration \eqn{t=1,2,\ldots,t_{EM}} of the EM algorithm.}
\item{gamma }{numeric array of dimension \eqn{J \times \max(L)} containing the MLE of \eqn{\gamma_{j\ell}}, \eqn{j=1,\ldots,J}, \eqn{\ell=1,\ldots,L_j}.}
\item{psim }{numeric array of dimension \eqn{t_{EM}\times K} containing the updates of mixture weights \eqn{\pi_{k}^{(t)}}, \eqn{k=1,\ldots,K}, for each iteration \eqn{t=1,2,\ldots,t_{EM}} of the EM algorithm.}
\item{clust }{numeric vector of length \eqn{n} containing the estimated cluster for each observation according to the MAP rule.}
\item{z }{numeric array of length \eqn{n\times K} containing the estimated conditional probabilities \eqn{\tau_{ik}}, \eqn{i=1,\ldots,n}, \eqn{k=,\ldots,K}, according to the last iteration of the EM algorithm.}
\item{bic }{numeric, the value of the BIC.}
\item{icl }{numeric, the value of the ICL.}
\item{ll }{numeric, the value of the loglikelihood, computed according to the \code{mylogLikePoisMix} function.}
}
\author{
Panagiotis Papastamoulis
}

%% ~Make other sections like Warning with \section{Warning }{....} ~

\seealso{
\code{\link{init1.1.jk.j}}, \code{\link{init1.2.jk.j}}, \code{\link{init2.jk.j}}
}
\examples{
############################################################
#1.            Example with Initialization 1               #
############################################################


## load a simulated dataset according to the b_jk model
## number of observations: 500
## design: L=(3,2,1)
data("simulated_data_15_components_bjk")
x <- sim.data[,1]
x <- array(x,dim=c(length(x),1))
y <- sim.data[,-1]
## use Initialization 1 with 2 components
## the number of different 1st small runs equals t1=2, 
##	each one consisting of m1 = 5 iterations
## the number of different 2nd small runs equals t2=5, 
##	each one consisting of m2 = 10 iterations
## the maximum number of EM iterations is set to m = 1000.
nc <- 2
run <- bjmodel(reference=x, response=y, L=c(3,2,1), m=1000, K=nc, nr=-10*log(10), 
                maxnr=10, m1=5, m2=10, t1=2, t2=5, msplit, tsplit, prev.z, 
                prev.clust, start.type=1, prev.alpha, prev.beta) 
## retrieve the iteration that the small em converged:
tem <- length(run$psim)/nc
## print the estimate of regression constants alpha.
run$alpha[tem,,]
## print the estimate of regression coefficients beta.
beta <- run$beta[tem,,]
## print the estimate of gamma.
run$gamma
## print the estimate of mixture weights.
run$psim[tem,]
## frequency table of the resulting clustering of the 
##		500 observations among the 2 components.
table(run$clust)
## print the value of the ICL criterion
run$icl
## print the value of the BIC
run$bic
## print the value of the loglikelihood
run$ll


############################################################
#2.            Example with Initialization 2               #
############################################################

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# Given the estimates of Example 1, estimate a 11-component mixture using  ~
# Initialization 2. The number of different runs is set to $tsplit=2$ with ~
# each one of them using $msplit=5$ em iterations.                         ~
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ 
run.previous<-run
## number of conditions
q <- 3
## number of covariates
tau <- 1
## number of components
nc <- 3
## estimated conditional probabilities for K=10
z <- run.previous$z
## number of iteration that the previous EM converged
ml <- length(run.previous$psim)/(nc - 1) 	
## estimates of alpha when K=2
alpha <- array(run.previous$alpha[ml, , ], dim = c(q, nc - 1)) 
## estimates of beta when K=2
beta <- array(run.previous$beta[ml, , ], dim = c(q, tau))
clust <- run.previous$clust ##(estimated clusters when K=2)

run <- bjmodel(reference=x, response=y, L=c(3,2,1), m=1000, K=3, nr=-10*log(10), 
                maxnr=10, m1, m2, t1, t2, msplit=5, tsplit=2, prev.z=z, 
                prev.clust=clust, start.type=2, prev.alpha=alpha, prev.beta=beta)

# retrieve the iteration that EM converged 
tem <- length(run$psim)/nc
# estimates of the mixture weights
run$psim[tem,]
# estimates of the regression constants alpha_{jk}, j = 1,2,3, k=1,..,3
run$alpha[tem,,]
# estimates of the regression coefficients beta_{j\tau}, j = 1,2,3, \tau=1
run$beta[tem,,]


# note: useR should specify larger values for Kmax, m1, m2, t1, t2, msplit
#	 and tsplit for a complete analysis.


}
