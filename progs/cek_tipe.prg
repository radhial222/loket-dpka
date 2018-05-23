LPARAMETERS cTipe

IF PARAMETERS()#1
	MESSAGEBOX('Parameter Kurang',48,'Parameter')
	return
ENDIF 

LOCAL cCek,cCtipe

cCek = ''
cCtipe = cTipe

IF LEN(ALLTRIM(cCtipe))#12
	RETURN .F.
ENDIF 

FOR i=1 TO 12
	cCek = SUBSTR(cCtipe,i,1)
	
	IF i=7
		IF cCek#' '
			RETURN .F.
			EXIT 
		ENDIF 
	ELSE
		IF !(cCek$'0123456789')
			RETURN .F.
			exit
		ENDIF 
	ENDIF 
ENDFOR 

RETURN .T.