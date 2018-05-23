lParameter xnArg1, xnArg2

local lcLocal1, lcLocal2, lcLocal3

lcLocal1 = ltrim( str(xnArg1,xnArg2) )
lcLocal2 = replicate( "0", xnArg2 )
lcLocal3 = substr( lcLocal2, 1, xnArg2-len(lcLocal1) ) + lcLocal1

return lcLocal3
