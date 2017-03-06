dae.nonspecific <-
function(zpre,rel,zpost,mmat,componentname,cnames,emat,vmat,icol,gls)
# dae.nonspecific() - expectations for a nonspecific component
#             zpre,zposr are zi or zm or zc
{

  nszpre <- zpre[["NS"]]
  nszpost <- zpost[["NS"]]
#   zaz <- matrix(0,nrows(emat),nrows(emat)
    zaz <- nszpre %*% rel %*% t(nszpost)
    emat[,icol] <- as.vector(mmat %*% zaz %*% mmat) # one col of W matrix
    if(gls) {
      vmat[,icol] <- as.vector(zaz) # one col of V matrix
    }
    cnames[icol] <- componentname # name for this col
    icol <- icol + 1

   daelist <- list(cnames=cnames,emat=emat,vmat=vmat,icol=icol)
   return(daelist)
}
