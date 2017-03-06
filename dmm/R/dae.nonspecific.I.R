dae.nonspecific.I <-
function(zpre,zpost,mmat,componentname,cnames,emat,vmat,icol,gls)
# dae.nonspecific.I() - expectations for a nonspecific component
#             zpre,zposr are zi or zm or zc
#             special case with no rel matrix
{

  nszpre <- zpre[["NS"]]
  nszpost <- zpost[["NS"]]
#   zaz <- matrix(0,nrows(emat),nrows(emat)
    zaz <- nszpre %*% t(nszpost)
    emat[,icol] <- as.vector(mmat %*% zaz %*% mmat) # one col of W matrix
    if(gls) {
      vmat[,icol] <- as.vector(zaz) # one col of V matrix
    }
    cnames[icol] <- componentname # name for this col
    icol <- icol + 1

   daelist <- list(cnames=cnames,emat=emat,vmat=vmat,icol=icol)
   return(daelist)
}
