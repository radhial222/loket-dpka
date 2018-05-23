aerror(laErr)
lcErrMsg = ''
for each lxErr in laErr
	lcErrMsg = lcErrMsg + CHR(13) + transform( lxErr, "" )
ENDFOR
   
MESSAGEBOX(lcErrMsg ,48,'Kesalahan')