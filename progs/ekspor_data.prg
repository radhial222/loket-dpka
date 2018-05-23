FUNCTION ekspor_data()
LPARAMETERS ntype,ccursor,ctabel,nrow 
*** define ntype 1 = insert , 2 = update
IF ntype = 1
	SELECT &ccursor
	nmax =FCOUNT('&ccursor')
	clist_field = ''
**get structur tabel
	FOR i = 1 TO nmax
		clist_field = clist_field + FIELD(i)
		IF i < nmax
			clist_field = clist_field +','
		ENDIF
	NEXT

**get tabel data
	clist_data = ''
	SELECT &ccursor
	GO nrow
	
		FOR F = 1 TO nmax
			cfield=FIELD(F)
			cisi = &cfield
			cft = ccursor+'.'+cfield
			ctype = TYPE('&cft')
			IF ISNULL(cisi)
				cisi = conv_null(ctype)
			ELSE
				cisi = cekconv_type(cisi,ctype)
			ENDIF

			clist_data = clist_data + "'"+cisi+"'"
			IF F < nmax
				clist_data = clist_data +','
			ENDIF
		NEXT
	
	csq1 = 'insert into  '+ctabel+ ' ('
	csq2 = clist_field+ ') values('
	csq3 = clist_data + ')'
	csql = csq1+csq2+csq3
ENDIF 
RETURN csql

FUNCTION cekconv_type()
LPARAMETERS cstr,ctype
	cret = ' '
	DO case
		CASE ctype = 'C'
			cret = allt(cstr)
		CASE ctype = 'N'	
			cret = allt(STR(cstr,19))
		CASE ctype = 'L'		
			IF cstr = .T.
				cret = '1'
			ELSE
				cret = '0'		
			ENDIF
		CASE ctype ='D'
			coldate = SET('date')
			SET DATE TO YMD 
			cret = DTOC(cstr)
			SET DATE TO &coldate
		CASE ctype ='T'	
			cret = TTOC(cstr,3)
		ENDCASE
	RETURN cret 			

FUNCTION conv_null()
LPARAMETERS ctype
cret = ' '
DO case
	CASE ctype = 'C' OR ctype = 'D'			
		cret = ' '
	CASE ctype = 'N' OR ctype = 'L'				
		cret = '0'
	OTHERWISE
		CRET = ' '	
ENDCASE
RETURN cret


FUNCTION ekspor_data2()
LPARAMETERS ccursor,ctabel
	
	SELECT &ccursor
	nmax =FCOUNT('&ccursor')
	clist_field = ''
**get structur tabel
	FOR i = 1 TO nmax
		clist_field = clist_field + FIELD(i)
		IF i < nmax
			clist_field = clist_field +','
		ENDIF
	NEXT

**get tabel data
	clist_data = ''
	SELECT &ccursor
	GO top
	DO WHILE !EOF()
	
		FOR F = 1 TO nmax
			cfield=FIELD(F)
			cisi = &cfield
			cft = ccursor+'.'+cfield
			ctype = TYPE('&cft')
			IF ISNULL(cisi)
				cisi = conv_null(ctype)
			ELSE
				cisi = cekconv_type(cisi,ctype)
			ENDIF

			clist_data = clist_data + "'"+cisi+"'"
			IF F < nmax
				clist_data = clist_data +','
			ENDIF
		NEXT
		
	SELECT &ccursor
	IF !EOF()
	clist_data = clist_data +';'
	ENDIF 
	SKIP
	ENDDO 
	
	csq1 = 'insert into  '+ctabel+ ' ('
	csq2 = clist_field+ ') values('
	csq3 = clist_data + ')'
	csql = csq1+csq2+csq3

RETURN csql
