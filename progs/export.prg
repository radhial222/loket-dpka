FUNCTION read_file()
LPARAMETERS cfile
LOCAL cstr
	cstr=FILETOSTR('&cfile')
	
RETURN cstr

	
FUNCTION send_file()
LPARAMETERS cexp,cfilename
cfil = cpath+'Outbox\'+cfilename
STRTOFILE(cexp,cfil,0)
ENDFUNC

FUNCTION rem_file()
LPARAMETERS csource,cdest,cfile
LOCAL fsource,fdest
	fsource=ALLTRIM(csource)+ALLTRIM(cfile)
	fdest = ALLTRIM(cdest)+ALLTRIM(cfile)
	IF FILE('&fdest')
		DELETE FILE &fdest
	endif	
	
	COPY FILE &fsource TO &fdest
	DELETE FILE &fsource
ENDFUNC


FUNCTION get_kode
	LOCAL ckode

	IF USED('komdat_conf')
		SELECT komdat_conf
		USE
	ENDIF
	
	ctab = cpath+'komdat_conf.dbf'
	USE &ctab ALIAS komdat_conf IN 0 SHARED 
	
	
	SELECT komdat_conf
	cdate = tanggal
	cno = replwz(VAL(no_kirim)+1,3)
	ckd_upt = ALLTRIM(kode_upt)
	REPLACE no_kirim WITH cno
	**** pengkodean tanggal
	cyear = ALLTRIM(STR(YEAR(cdate)))
	cbln =	 ALLTRIM(str(month(cdate)))
	cday =	 ALLTRIM(str(day(cdate)))
	
	ckode =ckd_upt+cyear+cbln+cday+cno
		
RETURN ckode
		
FUNCTION ask_data()
LPARAMETERS cnopol
	LOCAL csend
	xckode = get_kode()
	csend ='rq1;'+xckode+';'+cnopol+';#'
	cflname =xckode+'.txt'
	send_file(csend,cflname)
ENDFUNC



	 
	
	
	


	
		
		
	
			
	
	
			