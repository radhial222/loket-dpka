lparam cString, nMode
Local nSum, nCh, nEncr, i, nPlus, nDigit, cEncrypt

  if nMode = 0     
     nSum = 0
     For i = 1 to len(cString)
         nCh = ASC(SubStr(cString,i,1))
         if nCh >= 65 .and. nCh <= 69
            nPlus = 4
         else 
            if nCh >= 70 .and. nCh <= 78
         		nPlus = 7
         	else 
         	    if nCh >= 70 .and. nCh <= 94
            		nPlus = 3
         		else 
         			if nCh >= 94 .and. nCh <= 126
            			nPlus = 6
         			else
            			nPlus = 1
         			endif
         		endif
         	 endif
         endif
         nSum = nsum + nPlus
     endfor
     nDigit   = Mod(nSum,10)+70
     cEncrypt = '|'+chr(nDigit+58)
     For i   = 1 to len(cString)
         nCh = ASC(SubStr(cString,i,1))
         if nCh >= 65 .and. nCh <= 69
            nPlus = 4+nDigit
         else 
         	if nCh >= 70 .and. nCh <= 78
            	nPlus = 7+nDigit
         	else 
         		if nCh >= 80 .and. nCh <= 94
            		nPlus = 3+nDigit
         		else 
         			if nCh >= 94 .and. nCh <= 126
            			nPlus = 6+nDigit
         			else
            			nPlus = 1
         			endif
         		endif
         	endif
         endif
         cEncrypt = cEncrypt + chr(nCh+nPlus) + chr(nPlus+58)
     endfor
  else
     *nDigit   = ASC(SubStr(cString,2,1))-58
     cEncrypt = space(0)
     For i = 3 to len(cString) step 2
         nPlus = ASC(SubStr(cString,i+1,1))-58
         cEncrypt = cEncrypt + chr(ASC(SubStr(cString,i,1))-nPlus)
     endfor
  endif
Return Alltrim(cEncrypt)
