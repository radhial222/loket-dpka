
Function ask_data()
Lparameters cnopol
Local csend
xckode = get_kode()
csend ='rq1;'+xckode+';'+cnopol+';#'
cflname =xckode+'.txt'
send_file(csend,cflname)
Endfunc


Function update_remote()
Lparameters cnopol,dtgl,xcno_urut,dtgl_daft
xckode = get_kode()
Local csend
csend = 'up1;'+xckode+';'+cnopol+';'
Use Data\dbsamsat.Dbc Again  Shared
If Used('PKB_HEADER')
	Use pkb_header Again In 0 Alias PKB
Else
	Use pkb_header  In 0 Alias PKB
Endif

If Used('PKB_biasa')
	Use pkb_biasa Again In 0 Alias PKB_b
Else
	Use pkb_biasa  In 0 Alias PKB_b
Endif

Select PKB
Set Order To daftar
Seek(Dtos(dtgl)+xcno_urut)
If Found()
	
	njum = FCOUNT('pkb')
	FOR nf = 1 TO njum
		
			nmf = FIELD(nf)
			cisi = &nmf
		IF !EMPTY(cisi)	
			csend=csend+cek_type('cisi',cisi)+';'
		ELSE
			csend=csend+'-;'
		ENDIF
	NEXT
endif			

SELECT pkb
USE

SELECT pkb_b
Set Order To daftar
Seek(Dtos(dtgl)+xcno_urut)
If Found()
	njum = FCOUNT('pkb_b')
	FOR q = 3 TO njum	
			nmf = FIELD(q)
			cisi = &nmf
		IF !EMPTY(cisi)	
			csend=csend+cek_type('cisi',cisi)+';'
		ELSE
			csend=csend+'-;'
		ENDIF
	NEXT
ENDIF
SELECT pkb_b
use
csend=csend+'#'
cflname =xckode+'.txt'
send_file(csend,cflname)
Endfunc




Function send_file()
Lparameters cexp,cfilename
cfil = cath+'Inbox\'+cfilename
Strtofile(cexp,cfil,0)
Endfunc


Function send_file2()
Lparameters cexp,cfilename
cfil = cath2+'Inbox\'+cfilename
Strtofile(cexp,cfil,0)
Endfunc

Function rem_file()
Lparameters csource,cdest,cfile
Local fsource,fdest
fsource=Alltrim(csource)+Alltrim(cfile)
fdest = Alltrim(cdest)+Alltrim(cfile)
If File('&fdest')
	Delete File &fdest
Endif

Copy File &fsource To &fdest
Delete File &fsource
Endfunc


Function get_kode
Local ckode

If Used('komdat_conf')
	Select komdat_conf
	Use
Endif

ctab = 'data/komdat_conf.dbf'
Use &ctab Alias komdat_conf In 0 Shared


Select komdat_conf
cdate = tanggal
cno = replwz(Val(no_kirim)+1,3)
ckd_upt = Alltrim(kode_upt)
Replace no_kirim With cno
**** pengkodean tanggal
cyear = Alltrim(Str(Year(cdate)))
cbln =	 Alltrim(Str(Month(cdate)))
cday =	 Alltrim(Str(Day(cdate)))

ckode =ckd_upt+cyear+cbln+cday+cno

Return ckode

















