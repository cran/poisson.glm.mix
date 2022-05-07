\name{pois.glm.mix}
\alias{pois.glm.mix}
\title{
Main call function of the package.
}
\description{
This function is the main function of the package. User has only to call it by specifying the data (\eqn{x} and \eqn{y}), the vector \eqn{L}, the parameterization (\eqn{m\in \{1,2,3\}}), the desirable range for the number of components, the type of initialization and the number of EM runs and iterations for the  small-EM strategy. When \eqn{K=K_{min}}, EM algorithm is initialized according to Initialization scheme 1 (the functions \code{init1.1.jk.j}, \code{init1.2.jk.j}, \code{init1.k}). For consecutive run (\eqn{K>K_{min}}), EM algorithm is initialized using Initialization 2 (the functions \code{init2.jk.j} or \code{init2.k}).
}
\usage{
pois.glm.mix(reference, response, L, m, max.iter, Kmin, Kmax, 
             m1, m2, t1, t2, msplit, tsplit,mnr)
}
\arguments{
  \item{reference}{a numeric array of dimension \eqn{n\times V} containing the \eqn{V} covariates for each of the \eqn{n} observations.
}
  \item{response}{a numeric array of count data with dimension \eqn{n\times d} containing the \eqn{d} response variables for each of the \eqn{n} observations.
}
  \item{L}{numeric vector of positive integers containing the partition of the \eqn{d} response variables into \eqn{J\leq d} blocks, with \eqn{\sum_{j=1}^{J}L_j=d}.
}
  \item{m}{variable denoting the parameterization of the model: 1 for \eqn{\beta_{jk}} , 2 for \eqn{\beta_{j}} and 3 for \eqn{\beta_{k}} parameterization.
}
  \item{max.iter}{positive integer denoting the maximum number of EM iterations.
}
  \item{Kmin}{the minimum number of mixture components.
}
  \item{Kmax}{the maximum number of mixture components.
}
  \item{m1}{positive integer denoting the number of iterations for each call of the 1st small EM iterations used by Initialization 1 (\code{init1.1.jk.j}). Leave blank in case of parameterization \eqn{m=3}.
}
  \item{m2}{positive integer denoting the number of iterations for each call of the overall small EM iterations used by Initialization 1 (\code{init1.2.jk.j} or \code{init1.k}). 
}
  \item{t1}{positive integer denoting the number of different runs of the 1st small EM used by Initialization 1 (\code{init1.1.jk.j}). Leave blank in case of parameterization \eqn{m=3}.
}
  \item{t2}{positive integer denoting the number of different runs of the overall small EM used by Initialization 1 (\code{init1.2.jk.j} or \code{init1.k}).
}
  \item{msplit}{positive integer denoting the number of different runs for each call of the splitting small EM used by Initialization 2 (\code{init2.jk.j} or \code{init2.k}).
}
  \item{tsplit}{positive integer denoting the number of different runs for each call of the splitting small EM used by Initialization 2 (\code{init2.jk.j} or \code{init2.k}).
}
  \item{mnr}{positive integer denoting the maximum number of Newton-Raphson iterations.
}
}
\details{
The output of the function is a list of lists. During the run of the function \code{pois.glm.mix} two \code{R} graphic devices are opened: The first one contains the graph of the information criteria (BIC and ICL). In the second graphe, the resulting fitted clusters per condition are plotted until the ICL criterion no longer selects a better model. Notice that in this graph the \eqn{L_j} replicates of condition \eqn{j=1,\ldots,J} are summed. 

The EM algorithm is run until the increase to the loglikelihood of the mixture model is less than \eqn{10^{-6}}. The Newton - Raphson iterations at the Maximization step of EM algorithm are repeated until the square Euclidean norm of the gradient vector of the component specific parameters is less than \eqn{10^{-10}}. 
}
\value{
\item{information.criteria }{numeric array of dimension \eqn{(Kmax-Kmin + 1)\times 3} containing the values of BIC, ICL and loglikelihood for each \eqn{K}. The latter is computed according to the function \code{mylogLikePoisMix}.}
\item{runs }{A list containing the output for the estimated mixture for each \eqn{K}. The output is the same as in the functions \code{bjkmodel}, \code{bjmodel} and \code{bkmodel}.}
\item{sel.mod.icl }{The selected number of mixture components according to the ICL criterion.}
\item{sel.mod.bic }{The selected number of mixture components according to the BIC.}
\item{est.sel.mod.icl }{The final estimates for the selected number of mixture components according to the ICL criterion. It is a list containing \eqn{\widehat{\pi}_k}, \eqn{\widehat{\alpha}_{jk}}, \eqn{\widehat{\beta}_{jkv}}, \eqn{\widehat{\gamma}_{j\ell}}, \eqn{\widehat{c}_{i}}, \eqn{\widehat{\tau}_{ik}}, \eqn{i=1,\ldots,n}, \eqn{j=1,\ldots,J}, \eqn{\ell=1,\ldots,L_j}, \eqn{k=1,\ldots,\widehat{K}_{icl}}, \eqn{v=1,\ldots,V}, while \eqn{\widehat{c}_i} denotes the estimated cluster of observation \eqn{i}, according to the MAP rule.} 
\item{est.sel.mod.bic }{The final estimates for the selected number of mixture components according to the BIC. It is a list containing \eqn{\widehat{\pi}_k}, \eqn{\widehat{\alpha}_{jk}}, \eqn{\widehat{\beta}_{jkv}}, \eqn{\widehat{\gamma}_{j\ell}}, \eqn{\widehat{c}_{i}}, \eqn{\widehat{\tau}_{ik}}, \eqn{i=1,\ldots,n}, \eqn{j=1,\ldots,J}, \eqn{\ell=1,\ldots,L_j}, \eqn{k=1,\ldots,\widehat{K}_{bic}}, \eqn{v=1,\ldots,V}.}
}
\author{
Panagiotis Papastamoulis
}
\note{
In case that an exhaustive search is desired instead of a random selection of the splitted components, use \code{tsplit = -1}.
}


\seealso{
\code{\link{bjkmodel}}, \code{\link{bjmodel}}, \code{\link{bkmodel}}, \code{\link{init1.1.jk.j}}, \code{\link{init1.2.jk.j}}, \code{\link{init1.k}}, \code{\link{init2.jk.j}}, \code{\link{init2.k}}, \code{\link{mylogLikePoisMix}}
}
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
                  m1=3, m2=3, t1=3, t2=3, msplit=3, tsplit=3,mnr = 5)

# note: useR should specify larger values for Kmax, m1, m2, 
#	t1, t2, msplit and tsplit for a complete analysis.


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
