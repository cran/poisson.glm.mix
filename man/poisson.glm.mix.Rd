\name{poisson.glm.mix}
\alias{poisson.glm.mix}
\docType{package}
\title{Estimation of high dimensional Poisson GLM's via EM algorithm.}
\description{
This package can be used to cluster high dimensional count data under the presence of covariates. A mixture of Poisson Generalized Linear models (GLM's) is proposed. Conditionally to the covariates, Poisson multivariate distribution describing each cluster is a product of independent Poisson distributions. Different parameterizations for the slopes are proposed. Case of partioning the response variables into a set of replicates is considered. Poisson GLM mixture is estimated via Expectation Maximization (EM) algorithm with Newton-Raphson steps. An efficient initialization of EM algorithm is proposed to improve parameter estimation. It is a splitting scheme which is combined with a Small EM strategy. The user is referred to the function \code{\link{pois.glm.mix}} for an automatic evaluation of the proposed methodology.
}
\details{
\tabular{ll}{
Package: \tab poisson.glm.mix\cr
Type: \tab Package\cr
Version: \tab 1.0\cr
Date: \tab 2012-07-17\cr
License: \tab What license is it under?\cr}

Assume that the observed data can be written as \eqn{y = (y_{1},\ldots,y_{n})} where \eqn{y_i=\{y_{ij\ell};j = 1, \ldots,J,\ell = 1, \ldots,L_{j}\}}, \eqn{y_i\in Z_+^{d}}, \eqn{i = 1,\ldots,n}, with \eqn{d = \sum_{j=1}^{J}L_{j}} and \eqn{L_j \geq 1}, \eqn{j=1,\ldots,J}. Index \eqn{i} denotes the observation, while the vector \eqn{L=(L_1,\ldots,L_J)} defines a partition of the \eqn{d} variables into \eqn{J} blocks: the first block consists of the first \eqn{L_1} variables, the second block consists of the next \eqn{L_2} variables and so on. We will refer to \eqn{j} and \eqn{\ell} using the terms ``condition'' and ``replicate'', respectively. In addition to \eqn{y}, consider that a vector of \eqn{V} covariates is observed, denoted by \eqn{x_{i} := \{x_{iv};v=1,\ldots,V\}}, for all \eqn{i = 1, \ldots,n}.  Assume now that conditional to \eqn{x_{i}}, a model indicator \eqn{m} taking values in the  discrete set \eqn{\{1,2,3\}} and a positive integer \eqn{K}, the response \eqn{y_{i}}, is a realization of the corresponding random vector \deqn{Y_{i}|x_{i}, m\sim \sum_{k = 1}^{K}\pi_{k}\prod_{j=1}^{J}\prod_{\ell=1}^{L_{j}}\mathcal P(\mu_{ij\ell k;m})} where \eqn{\mathcal P} denotes the Poisson distribution. The following parameterizations for the Poisson means \eqn{\mu_{ij\ell k;m}} are considered: If \eqn{m=1} (the ``\eqn{\beta_{jk}}'' parameterization), then \deqn{\mu_{ij\ell k;m}:=\alpha_{jk}+\gamma_{j\ell}+\sum_{v=1}^{V}\beta_{jkv}x_i.} If \eqn{m=2} (the ``\eqn{\beta_{j}}'' parameterization), then \deqn{\mu_{ij\ell k;m}:=\alpha_{jk}+\gamma_{j\ell}+\sum_{v=1}^{V}\beta_{jv}x_i.} If \eqn{m=3} (the ``\eqn{\beta_{k}}'' parameterization), then \deqn{\mu_{ij\ell k;m}:=\alpha_{jk}+\gamma_{j\ell}+\sum_{v=1}^{V}\beta_{kv}x_i.} For identifiability purposes assume that \eqn{\sum_{\ell=1}^{L_j}\gamma_{j\ell}=0}, \eqn{j=1,\ldots,J}.}
\author{Papastamoulis Panagiotis
Maintainer: Papastamoulis Panagiotis <papapast@yahoo.gr>
}
\references{
Papastamoulis, P., Martin-Magniette, M. L., & Maugis-Rabusseau, C. (2016). On the estimation of mixtures of Poisson regression models with large number of components. Computational Statistics & Data Analysis, 93, 97-106.
}
\keyword{ package }
\examples{
## load a small dataset of 500 observations
data("simulated_data_15_components_bjk")
## in this example there is V = 1 covariates (x)
##   and d = 6 response variables (y). The design is
##   L = (3,2,1).
V <- 1
x <- array(sim.data[,1],dim=c(dim(sim.data)[1],V))
y <- sim.data[,-1]

## We will run the algorithm using parameterization
##   m = 1 and the number of components in the set
##   {2,3,4}.

rr<-pois.glm.mix(reference=x, response=y, L=c(3,2,1), m=1, 
                  max.iter=1000, Kmin=2, Kmax= 4, 
                  m1=3, m2=3, t1=3, t2=3, msplit=4, tsplit=3,mnr = 5)

# note: useR should specify larger values for Kmax, m1, m2, t1,
#	 t2, msplit and tsplit for a complete analysis.

# retrieve the selected models according to BIC or ICL
rr$sel.mod.icl
rr$sel.mod.bic
# retrieve the estimates according to ICL
# alpha
rr$est.sel.mod.icl$alpha
# beta
rr$est.sel.mod.icl$beta
# gamma
rr$est.sel.mod.icl$gamma
# pi
rr$est.sel.mod.icl$pi
# frequency table with estimated clusters
table(rr$est.sel.mod.icl$clust)
# histogram of the maximum conditional probabilities
hist(apply(rr$est.sel.mod.icl$tau,1,max),30)

##(the full data of 5000 observations can be loaded using 
##     data("simulated_data_15_components_bjk_full")

}
