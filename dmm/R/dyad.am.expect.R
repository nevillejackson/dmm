dyad.am.expect <-
function(am, gls,dmeopt){
# dyad.am.expect()
# evaluate parts of dyadic model equation  including emat and emat.qr
# am is an ante-model object
# am$zi, am$zm,am$zc are a lists of Z matrices
# am$rel is a list of  relationship matrices
# returns a list object containing emat, emat.qr, and cnames(col names for emat)
#
# Note: This code sets the order of components in siga[,]
#
# setup m matrix
  mmat <- diag(am$n) - am$x %*% ginv(am$x)
# cat("mmat:\n")
# print(mmat)
#
  dae <- list(cnames="VarE(I)",emat=matrix(0,am$n * am$n, am$v),vmat=matrix(0,am$n * am$n, am$v),icol=1)
# initial values
# cnames <- "VarE(I)"  # character vector
# emat <- matrix(0,am$n * am$n, am$v)
# vmat <- matrix(0,am$n * am$n, am$v)
# icol <- 1
  nsf <- length(am$specific.components)

  ctable <- make.ctable()

# nonspecific
  if(length(am$components) > 0 ) {
    for (kc in 1: length(am$components)) {
      index <- match(am$components[kc],ctable$all)
      pre <- ctable$allzpre[index]  
      post <- ctable$allzpost[index]  
      prel <- ctable$allrel[index]
      if((pre != "S") & (post != "S") & (prel != "I") ) { # normal cases
        zpre <- eval(parse(text=paste("am$",pre,sep="")))
        zpost <- eval(parse(text=paste("am$",post,sep="")))
        rel <- eval(parse(text=paste("am$rel$",prel,sep="")))
        dae <- dae.nonspecific(zpre,rel,zpost,mmat,am$components[kc],dae$cnames,dae$emat,dae$vmat,dae$icol,gls)
      }
      else if((pre != "S") & (post != "S") & (prel == "I") ){ # cases with no rel matrix
        zpre <- eval(parse(text=paste("am$",pre,sep="")))
        zpost <- eval(parse(text=paste("am$",post,sep="")))
        dae <- dae.nonspecific.I(zpre,zpost,mmat,am$components[kc],dae$cnames,dae$emat,dae$vmat,dae$icol,gls)
      }
      else if((pre == "S") & (post == "S") & (prel == "S") ) { # cases with 2 parts AND'ed
        indexs <- match(am$components[kc],ctable$cohort)
        pre1 <- ctable$cohortzpre1[indexs]
        pre2 <- ctable$cohortzpre2[indexs]
        post1 <- ctable$cohortzpost1[indexs]
        post2 <- ctable$cohortzpost2[indexs]
        op <- ctable$cohortop[indexs]
        zpre1 <- eval(parse(text=paste("am$",pre1,sep="")))
        zpost1 <- eval(parse(text=paste("am$",post1,sep="")))
        zpre2 <- eval(parse(text=paste("am$",pre2,sep="")))
        zpost2 <- eval(parse(text=paste("am$",post2,sep="")))
        zop <- paste(" ",op," ",sep="")
        dae <- dae.nonspecific.S(zpre1,zpost1,zpre2,zpost2,zop,mmat,am$components[kc],dae$cnames,dae$emat,dae$vmat,dae$icol,gls)
      }
      else {   
        stop("Expectation for component not recognised:\n")
      }
    }
  }


  
# specific

  if(nsf > 0) {
    for(kf in 1:length(am$effnames)) {

      for(lc in 1:length(am$specific.components[[kf]])){
        index <- match(am$specific.components[[kf]][lc],ctable$all)
        pre <-  ctable$allzpre[index]
        post <- ctable$allzpost[index]
        prel <- ctable$allrel[index]

        if((pre != "S") & (post != "S") & (prel != "I") ) {  # normal cases
          zpre <- eval(parse(text=paste("am$",pre,sep="")))
          zpost <- eval(parse(text=paste("am$",post,sep="")))
          rel <- eval(parse(text=paste("am$rel$",prel,sep="")))
          dae <- dae.specific(zpre, rel, zpost, mmat, kf ,am$specific.components[[kf]][lc], am$effnames,am$effcodes,am$effnandc,am$comcodes,dae$cnames,dae$emat,dae$vmat,dae$icol,gls)
        }
        else if((pre != "S") & (post != "S") & (prel == "I") ) {  # cases with no rel matrix
          zpre <- eval(parse(text=paste("am$",pre,sep="")))
          zpost <- eval(parse(text=paste("am$",post,sep="")))
          dae <- dae.specific.I(zpre, zpost, mmat, kf ,am$specific.components[[kf]][lc], am$effnames,am$effcodes,am$effnandc,am$comcodes,dae$cnames,dae$emat,dae$vmat,dae$icol,gls)
        }
        else if((pre == "S") & (post == "S") & (prel == "S") ) {  # cases with 2 parts ANDed
      indexs <- match(am$specific.components[[kf]][lc],ctable$cohort)
cat("indexs:\n")
      pre1 <- ctable$cohortzpre1[indexs]
      pre2 <- ctable$cohortzpre2[indexs]
      post1 <- ctable$cohortzpost1[indexs]
      post2 <- ctable$cohortzpost2[indexs]
      op <- ctable$cohortop[indexs]
      zpre1 <- eval(parse(text=paste("am$",pre1,sep="")))
      zpost1 <- eval(parse(text=paste("am$",post1,sep="")))
      zpre2 <- eval(parse(text=paste("am$",pre2,sep="")))
      zpost2 <- eval(parse(text=paste("am$",post2,sep="")))
      zop <- paste(" ",op," ",sep="")
      dae <- dae.specific.S(zpre1,zpost1,zpre2,zpost2,zop,mmat,kf,am$specific.components[[kf]][lc],am$effnames,am$effcodes,am$effnandc,am$comcodes,dae$cnames,dae$emat,dae$vmat,dae$icol,gls)
        }
        else {
          stop("Expectation for component not recognised:\n")
        }
      }
    }
  }


# summarize emat
  dimnames(dae$emat) <- list(NULL,dae$cnames)
  dimnames(dae$vmat) <- list(NULL,dae$cnames)
    cat("Checking dyadic model equations:\n")
#   cat("emat:\n")
#   print(dae$emat)
#   emat.sum <- apply(dae$emat,2,sum)
#   cat("column.sums:\n")
#   print(emat.sum)
    emat.mean <- apply(dae$emat,2,mean)
#   cat("column.means:\n")
#   print(emat.mean)
    emat.var <- apply(dae$emat,2,var)
#   cat("column.variances:\n")
#   print(emat.var)
    emat.cor <- cor(dae$emat,dae$emat)
#   cat("column.correlations:\n")
#   print(emat.cor)

#  do QR transform on emat
  emat.qr <- qr(dae$emat)

# check emat for E'E positive definite - ie emat.qr$rank should be am$v
  if(emat.qr$rank != am$v) {
    cat(" Rank of DME matrix = ",emat.qr$rank," no of components = ",am$v,"\n")
    if(dmeopt != "pcr") stop("Dyadic model equations not of full rank: either omit some components or try dmeopt='pcr' \n")
  }

# do qr on vmat  - only need if gls=T
  if(gls) {
    vmat.qr <- qr(dae$vmat)
  }
  else {
    vmat.qr <- NULL
  }

  explist <- list(emat=dae$emat, emat.qr=emat.qr, cnames=dae$cnames, vmat=dae$vmat, vmat.qr=vmat.qr,
                  emat.mean=emat.mean,emat.var=emat.var,emat.cor=emat.cor) 
  return(explist)
}
