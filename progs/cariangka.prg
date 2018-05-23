FUNCTION cariangka(teks)
 
  s = ''

  FOR i = 1 TO len(teks)
    c = substr(teks, i, 1)
    if (c >= '1') and (c <= '9')
      s = s + c
    endif
  ENDFOR 

  RETURN s

ENDFUNC 