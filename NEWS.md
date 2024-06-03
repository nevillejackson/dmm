# dmm_2.1-10 Release notes
 There has been a gap in versions when dmm was unable to use nadiv() due to problems with modifications to the {Matrix} package. That has now been corrected, and from release 2.1-10 onwards dmm() must use release 2.18.0 of the {nadiv} package.
 Apologies for any inconvenience, and assistance from Matthew Wolak ( author of nadiv) is greatly appreciated.
  dmm_2.1-10 has been completely retested against all examples in dmmOverview.pdf and gives the same results as in that document.

# dmm_2.1-7 Release notes

## Comment
  Considerable improvement in execution times with dmm() can be obtained by linking R with the Openblas library instead of the Rblas library. Hints on setting up R with Openblas libraries have been added to dmmOverview.pdf, Section 8, page 108.

# dmm_2.1-6 Release notes

##Comment
  This is just a fix of the namespace.

# dmm_2.1-5 Release notes

## Comment
  There have been some annoying problems with class-specific analyses. 
Hopefully the fixes in dmm_2.1-5 have dealt with these issues.

## Bug fixes and improvements

 * Bug with message
Error in if (class1 == class2) { : missing value where TRUE/FALSE needed
This affected class-specific analyses only
Fixed

 * Bug with message
Error in match.crosseffect.vars(rownames(siga)[i]) :
                match.crosseffect.vars() - should never get here:
This occurred in class-specific amnalyses only
Fixed

 * Labelling bug with VarG(Ia:a) effect when class specific
Was due to ":" clashing with use of ":" for class specific labels
Fixed

 * Component checking enhanced in dmesolve()
Checks for components defined as both nonspecific and specific

 * Correlation output
print.dmm() now prints the correlations between columns of the 
W matrix of the dyadic model equations

# dmm_2.1-4 Release notes

## Comment
  Apologies for the NAMELIST problem which affected some of my print 
 methods in dmm_2.1-3.  It is fixed in dmm_2.1-4

## Bug fixes and improvements

 * added ability to estimate maternal founder  line and
   paternal founder  line components (VarGml(I) and VarGpl(I))

 * fixed bug in gsummary() introduced in dmm_2.1-3

 * fixed NAMELIST problem and align version numbers
