dae.specific <-
function(zpre,rel,zpost,mmat,factorno,componentname,effnames,effcodes,effnandc,comcodes,cnames,emat,vmat,icol,gls)
# dae.specific() - expectations for a specific component
#               zpre, zpost are zi or zm or zc
#               returns incremented icol which is next vacant col of W
{

#   zaz <- matrix(0,nrows(emat),nrows(emat)

    nfactorcodes <- length(effcodes[[factorno]])
    k <- 0
    for ( i in 1:nfactorcodes) {
      for( j in 1:nfactorcodes) {
        k <- k + 1
        specificcomponentname <- paste(comcodes[[factorno]][k],componentname,sep=":") 
print(specificcomponentname)
        szpre <- zpre[[effnandc[[factorno]][i]]]
        szpost <- zpost[[effnandc[[factorno]][j]]]
        zaz <- szpre %*% rel %*% t(szpost)
        emat[,icol] <- as.vector(mmat %*% zaz %*% mmat) # one col of W matrix
        if(gls) {
          vmat[,icol] <- as.vector(zaz) # one col of V matrix
        }
        cnames[icol] <- specificcomponentname # name for this col
        icol <- icol + 1

      }
    }
#print(emat)
   daelist <- list(cnames=cnames,emat=emat,vmat=vmat,icol=icol)
   return(daelist)
}
