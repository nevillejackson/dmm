dae.specific.S <-
function(zpre1,zpost1,zpre2,zpost2,zop,mmat,factorno,componentname,effnames,effcodes,effnandc,comcodes,cnames,emat,vmat,icol,gls)
# dae.specific.S() - expectations for a specific component
#               zpre, zpost are zi or zm or zc
#               returns incremented icol which is next vacant col of W
#               special case with two expectations ANDed together
#               no rel matrix for either expectation
{

#   zaz <- matrix(0,nrows(emat),nrows(emat)

    nfactorcodes <- length(effcodes[[factorno]])
    k <- 0
    for ( i in 1:nfactorcodes) {
      for( j in 1:nfactorcodes) {
        k <- k + 1
        specificcomponentname <- paste(comcodes[[factorno]][k],componentname,sep=":") 
#print(specificcomponentname)
        szpre1 <- zpre1[[effnandc[[factorno]][i]]]
#print(szpre1)
        szpost1 <- zpost1[[effnandc[[factorno]][j]]]
#print(szpost1)
        szpre2 <- zpre2[[effnandc[[factorno]][i]]]
        szpost2 <- zpost2[[effnandc[[factorno]][j]]]
        zaz <- eval(parse(text=paste("(szpre1 %*% t(szpost1))", zop, "(szpre2 %*% t(szpost2))"," + 0",sep="")))
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
