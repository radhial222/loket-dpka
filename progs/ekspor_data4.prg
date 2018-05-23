FUNCTION ekspor_data_header()
LPARAMETERS ntype,ccursor,ctabel
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


	
	csq1 = 'insert into  '+ctabel+ ' ('
	csq2 = clist_field+ ') values '
	csql = csq1+csq2
ENDIF 
RETURN csql


FUNCTION ekspor_data_isi()
LPARAMETERS nrow,ccursor
**get tabel data
nmax =FCOUNT('&ccursor')
	clist_data = '('
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
				
				cisi = STRTRAN(cisi,"'"," ")
				cisi = STRTRAN(cisi,"\"," ")
				cisi = STRTRAN(cisi,"#"," ")
				cisi = STRTRAN(cisi,"%"," ")
				cisi = STRTRAN(cisi,"*"," ")
				cisi = STRTRAN(cisi,"&"," ")
				cisi = STRTRAN(cisi,"Ÿ"," ")
			ENDIF

			clist_data = clist_data + "'"+cisi+"'"
			IF F < nmax
				clist_data = clist_data +','
			ENDIF
		NEXT
		clist_data = clist_data +')'
RETURN clist_data

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
		OTHERWISE
			CRET = ' '
		ENDCASE
	RETURN cret 			

FUNCTION conv_null()
LPARAMETERS ctype
cret = ' '
DO case
	CASE ctype = 'C' 		
		cret = ' '
	CASE ctype = 'D'
		cret = '0000-00-00'	
	CASE ctype = 'N' OR ctype = 'L'				
		cret = '0'
	OTHERWISE
		CRET = ' '	
ENDCASE
RETURN cret		