FUNCTION ENKODE
LPARAMETERS cdata
cret = ''
IF !ISNULL(cdata)
LOCAL clet

store 3 TO nstep,nmark
FOR k = 1 TO LEN(cdata)
	 clet = ASC(SUBSTR(ALLTRIM(cdata),k,1))
	 IF k >= nstep
	 	nmark = nmark+nstep
	 endif
	 	clet = clet+nmark
	 	 cret = cret+CHR(clet)
NEXT
endif
RETURN cret

FUNCTION DEKODE
LPARAMETERS cdata
LOCAL clet
store 3 TO nstep,nmark
cret = ''
FOR k = 1 TO LEN(cdata)
	 clet = ASC(SUBSTR(ALLTRIM(cdata),k,1))
	 IF k >= nstep
	 	nmark = nmark+nstep
	 ENDIF
	 
	 clet = clet-nmark
	 cret = cret+CHR(clet)
NEXT
RETURN cret


FUNCTION cryt_date()
LPARAMETERS dtgl,cnmfield
nkali= LEN(cnmfield)
nadd = 0
FOR D = 1 TO LEN(cnmfield)
	cdt = ASC(SUBSTR(ALLTRIM(cnmfield),D,1))
	nadd = nadd+cdt
NEXT
nadd = nadd*nkali
dtgl_ret = dtgl+nadd
RETURN dtgl_ret
	
	
FUNCTION decryt_date()
LPARAMETERS dtgl,cnmfield
nkali= LEN(cnmfield)
nadd = 0
FOR D = 1 TO LEN(cnmfield)
	cdt = ASC(SUBSTR(ALLTRIM(cnmfield),D,1))
	nadd = nadd+cdt
NEXT
nadd = nadd*nkali
dtgl_ret = dtgl-nadd
RETURN dtgl_ret
		
*!*	FUNCTION tes_enkode
*!*	CREATE CURSOR temp( nopol c(30),nama c(120),rangka c(90))
*!*	SELECT list_kend
*!*	GO top
*!*	DO WHILE !EOF()
*!*		cnopol = enkode(ALLTRIM(nopol))
*!*		cnama = enkode(ALLTRIM(nama))
*!*		ckd_pos = enkode(ALLTRIM(rangka))
*!*		SELECT temp
*!*		APPEND BLANK
*!*			REPLACE nopol WITH cnopol,nama WITH cnama,rangka WITH ckd_pos
*!*		SELECT list_kend
*!*		SKIP
*!*	ENDDO
*!*	ENDFUNC

*!*	FUNCTION tes_dekode
*!*	CREATE CURSOR temp2( nopol c(30),nama c(120))
*!*	SELECT temp
*!*	GO top
*!*	DO WHILE !EOF()
*!*		cnopol = dekode(ALLTRIM(nopol))
*!*		cnama = dekode(ALLTRIM(nama))
*!*		SELECT temp2
*!*		APPEND BLANK
*!*			REPLACE nopol WITH cnopol,nama WITH cnama
*!*		SELECT temp
*!*		SKIP
*!*	ENDDO
*!*	endfunc

*!*				
*!*	 	 	