***tambahan by odel sept 2009

****hapus data di server
FUNCTION del_data()
LPARAMETERS csql
IF LOWER(LEFT(ALLTRIM(csql),6))='delete'
	DO wwSOAP
	oSOAP = CREATEOBJECT("wwSOAP")
	oSOAP.cserverUrl = pcServerUrl
	oSOAP.AddParameter("select",csql)
	cdata = oSOAP.CallMethod('hapus')

	IF oSOAP.lError
		lret = .F.
		MESSAGEBOX('Jaringan Online Bermasalah  ',0+16,'Error in connection ')
		cdata = 0
	ELSE
		IF cdata = '0'
			MESSAGEBOX('Querry anda salah, cek dan  ulangi lagi',0+16,'ERROR in querry')
			cdata = 0
		ELSE
			cdata = 1
			lret=.t.
		ENDIF

	ENDIF

ELSE
	lret =.F.
ENDIF

RETURN lret


RELEASE oSOAP
ENDFUNC


****entry data di server
FUNCTION ins_data()
LPARAMETERS csql
IF LOWER(LEFT(ALLTRIM(csql),6))='insert'
	DO wwSOAP
	oSOAP = CREATEOBJECT("wwSOAP")
	oSOAP.cserverUrl = pcServerUrl
	oSOAP.AddParameter("select",csql)
	cdata = oSOAP.CallMethod("tambah")

	IF oSOAP.lError
		lret = .F.
		MESSAGEBOX('Jaringan Online Bermasalah  ',0+16,'Error in connection ')
		cdata = ''
	ELSE
	
		IF cdata = '0'
			MESSAGEBOX('Querry anda salah, cek dan  ulangi lagi',0+16,'ERROR in querry')
			cdata = 0
			lret = .f.
		ELSE
			cdata = 1
			lret = .t.
		ENDIF

	ENDIF

ELSE
	cdata = 0
	lret = .f.
ENDIF

RETURN lret 
RELEASE oSOAP
ENDFUNC



FUNCTION select_data()
LPARAMETERS csql
cdata=''
IF LOWER(LEFT(ALLTRIM(csql),6))='select'
	cmethod ='tampil'

	oSOAP = CREATEOBJECT("wwSOAP")
	oSOAP.cserverUrl = pcServerUrl
	oSOAP.AddParameter("select",csql)
	cdata = oSOAP.CallMethod(cmethod)


	IF oSOAP.lError
		lret = .F.
		MESSAGEBOX('Jaringan Online Bermasalah  ',0+16,'Error in connection ')
		cdata=''
	ELSE
		IF UPPER(ALLTRIM(cdata))<> 'NULL'
		ELSE
			MESSAGEBOX('Hasil querry = null (Tidak ada data)   ',0+16)
			cdata = ''
		ENDIF
	ENDIF
ENDIF

RETURN cdata 
RELEASE oSOAP
ENDFUNC



FUNCTION upd_data()

LPARAMETERS csql

IF LOWER(LEFT(ALLTRIM(csql),6))='update'
	DO wwSOAP
	oSOAP = CREATEOBJECT("wwSOAP")
	oSOAP.cserverUrl = pcServerUrl
	oSOAP.AddParameter("select",csql)
	cdata = oSOAP.CallMethod('ubah')

	IF oSOAP.lError
		lret = .F.
		MESSAGEBOX('Jaringan Online Bermasalah  ',0+16,'Error in connection ')
		cdata = 0
	ELSE
		IF cdata = '0'
			cdata = 0
			lret = .f.
		ELSE
			cadata = 1
			lret =.t.
		ENDIF

	ENDIF
ELSE
****kesalahan querry'
	cdata = 0
ENDIF

RETURN cdata
RELEASE oSOAP
ENDFUNC


