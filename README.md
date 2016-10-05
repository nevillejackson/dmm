# dmm #
R package that does variance component estimation and genetic parameters for  linear mixed effect models. Variance components can be for individual and/or mateernal genetic variation, and can be for additive, dominance, epistatic or sexlinked genetic variation.

## how does _dmm_ differ from other pedigree analysis packages? ##
Most other packages use iterative likelihood maximization techniques for variance component estimation. _dmm_ uses a dyadic model which in effect reduces variance component estimation to a regression problem. This has the advantage of being non-iterative and allowing any of the standard regression techniques to be used. The package currently offers least squares, partial least squares and robust regression. The results obtained with _dmm_ are equivalent to MINQUE and bias-corrected-ML estimates, if least squares regression is used.

## To obtain _dmm_ ##
* From CRAN
 * see the package page for the latest release of _dmm_ on CRAN, download the package source, and install with R CMD INSTALL
 * install the package dirctly in R with install.packages("dmm")

* From GitHub
 * clone or download the latest development version. The version found on GitHub may be a later development than the CRAN release

## You may be interested in using or contributing to _dmm_ for the following reasons ##

* analysis of small multi-trait datasets with pedigree information
* individual, maternal, and cohort environmental component estimates and standard errors
* individual and maternal additive, dominance, epistatic, and sex-linked genetic component estimates and standard errors
* cross-effect and cross-trait covariance components
* multicollinearities among the components
* genetic parameters (ie proportion of variance and correlation) and standard errors for all fitted components
* genetic response to phenotypic selection for individual additive and maternal additive cases with autosomal and sexlinked components
* data preparation tools
* S3 methods to organize output
* test example datasets
* alternative approach to iterative ML and REML estimation procedures
* component estimates equivalent to MINQUE (after fixed effects by OLS) and bias-corrected-ML (after fixed effects by GLS)
* multi-trait or traitspairwise or traitsblockwise analyses to deal with unequal replication across traits
* _dmm_ was developed for analysis of sheep breeding data. Workers from other fields would certainly be able to broaden its approach, and contributions would be welcome.

