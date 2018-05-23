Function getdate()
Lparameter dldate
Do Case
Case Month(dldate) = 1
	lcdate = 'Januari'
Case Month(dldate) = 2
	lcdate = 'Februari'
Case Month(dldate) = 3
	lcdate = 'Maret'
Case Month(dldate) = 4
	lcdate = 'April'
Case Month(dldate) = 5
	lcdate = 'Mei'
Case Month(dldate) = 6
	lcdate = 'Juni'
Case Month(dldate) = 7
	lcdate = 'Juli'
Case Month(dldate) = 8
	lcdate = 'Agustus'
Case Month(dldate) = 9
	lcdate = 'September'
Case Month(dldate) = 10
	lcdate = 'Oktober'
Case Month(dldate) = 11
	lcdate = 'November'
OTHERWISE
	lcdate = 'Desember'
Endcase
lreturn = Allt(Str(Day(dldate))) + ' ' + lcdate + ' ' + Allt(Str(Year(dldate)))
Return lreturn



*\ lTable = .T. --> commit all record
*\ lTable = .F. --> commit the current record

Procedure update_buffer()
	lPARAMETER lTable

	if TYPE('lTable') <> 'L'
		lTable = .F.
	endif	

	begin transaction
		lSuccess = TABLEUPDATE(lTable,.T.)
	end transaction
	
			
*!*		begin Transaction
*!*			lSuccess = TABLEUPDATE(lTable,.T.)
*!*			if lSuccess = .F.
*!*				ROLLBACK
*!*			else
*!*				end transaction
*!*			endif
endproc

Procedure revert_buffer()
	=TABLEREVERT(.T.)
endproc

FUNCTION replwz
lpar angka,jum
local i, hasil, temp
  temp = alltrim(str(angka,jum,0))
  do while len(temp) < jum
    temp = '0'+ temp
  enddo    
return temp

************************************************************** untuk konek encryp
Function genecpkonek()
Lparameter cstringk
Local cencryptk
c ="`qwertyuioplkjhgfdsazxcvbnm#$%^&*()_+|1234567890- =\~!@QWERTYUIOP[]ASDFGHJKL;'ZXCVBNM,./{}:<>?"
C1="!@#$%^&*ZXC9M()_+|~`',./AHJKL;]FG87654POIUSDVB�NYT0321[REWQ<>?:mnbvcxzasdfghjklpoiuytrewq{}\=-"
C2="QWERTYUIOPLKJHGFDSAZXCVBNMasdfg123jkl;']�[poiuytrewqz5678xcvbnm,./?><:}{-=\`|+_)(*&490h^%#$!@~"
C3="ZXCVBNM,./?><';LKJHGFDSA�:][}{\=-54321`|+_)098TREPOIUYWQ#@!~qwertyuioplkjhgfdsamnbvcxz76(*&^%$"
C4="LKJHGFDSAZQWERXCVBNM,./TYUIOP|+_)%$#@(�*&^!}{:672348?><~159asdfghjklpoiuytrewqzxcvbnm0-=\`[]';"
*ENCRYPT LOGIC

cencryptk = ""
For I=1 To Len(Alltrim(cstringk))
	IPOS = At(Substr(cstringk,I,1),c)
	IMOD = Iif(Mod(I + Len(Alltrim(cstringk)),4) <>0,;
		MOD(I + Len(Alltrim(cstringk)),4) ,4)
	CSTR = "C" + Alltrim(Str(IMOD))
	cencryptk = cencryptk + Substr(&CSTR,IPOS,1)
Next
Return cencryptk
Endfunc
********************************************************************************

************************************************************** untuk konek decryp
Function wrecpkonek()
Lparameter cstringk
Local cdecryptk

c ="`qwertyuioplkjhgfdsazxcvbnm#$%^&*()_+|1234567890- =\~!@QWERTYUIOP[]ASDFGHJKL;'ZXCVBNM,./{}:<>?"
C1="!@#$%^&*ZXC9M()_+|~`',./AHJKL;]FG87654POIUSDVB�NYT0321[REWQ<>?:mnbvcxzasdfghjklpoiuytrewq{}\=-"
C2="QWERTYUIOPLKJHGFDSAZXCVBNMasdfg123jkl;']�[poiuytrewqz5678xcvbnm,./?><:}{-=\`|+_)(*&490h^%#$!@~"
C3="ZXCVBNM,./?><';LKJHGFDSA�:][}{\=-54321`|+_)098TREPOIUYWQ#@!~qwertyuioplkjhgfdsamnbvcxz76(*&^%$"
C4="LKJHGFDSAZQWERXCVBNM,./TYUIOP|+_)%$#@(�*&^!}{:672348?><~159asdfghjklpoiuytrewqzxcvbnm0-=\`[]';"

cdecryptk = ""
For I=1 To Len(Allt(cstringk))
	IMOD = Iif(Mod(I + Len(Alltrim(cstringk)),4) <>0,;
		MOD(I + Len(Alltrim(cstringk)),4) ,4)
	CSTR = "C" + Alltrim(Str(IMOD))
	IPOS = At(Substr(cstringk,I,1),&CSTR)
	cdecryptk = cdecryptk + Substr(c,IPOS,1)
Next
Return cdecryptk

ENDFUNC

**********************

Function genecp()
Lparameter cstring
Local cencrypt
c ="`1234567890- =\~!@qwertyuioplkjhgfdsazxcvbnm#$%^&*()_+|QWERTYUIOP[]ASDFGHJKL;'ZXCVBNM,./{}:<>?"
C1=",./AHJKL;]FG87654POIUSDVB�NYT0321[REWQ<>?:mnbvcxzasdfghjklpoiuytrewq{}\=-!@#$%^&*ZXC9M()_+|~`'"
C2="asdfg123jkl;']�[poiuytQWERTYUIOPLKJHGFDSAZXCVBNMrewqz5678xcvbnm,./?><:}{-=\`|+_)(*&490h^%#$!@~"
C3="ZXCVBNM,./?><';LKJHGFDSA�:][}{\=-54321`|+_)098qwertyuioplkjhgfdsamnbvcxz76(*&^%$TREPOIUYWQ#@!~"
C4="|+_)%$#@(�*&^!}{:672348?><~159asdfghjklpoiuytrewqzxcvbnm0-=\`[]';LKJHGFDSAZQWERXCVBNM,./TYUIOP"

*ENCRYPT LOGIC

cencrypt = ""
For I=1 To Len(Alltrim(cstring))
	IPOS = At(Substr(cstring,I,1),c)
	IMOD = Iif(Mod(I + Len(Alltrim(cstring)),4) <>0,;
		MOD(I + Len(Alltrim(cstring)),4) ,4)
	CSTR = "C" + Alltrim(Str(IMOD))
	cencrypt = cencrypt + Substr(&CSTR,IPOS,1)
Next
Return cencrypt
Endfunc



Function wrecp()
Lparameter cstring
Local cdecrypt

c ="`1234567890- =\~!@qwertyuioplkjhgfdsazxcvbnm#$%^&*()_+|QWERTYUIOP[]ASDFGHJKL;'ZXCVBNM,./{}:<>?"
C1=",./AHJKL;]FG87654POIUSDVB�NYT0321[REWQ<>?:mnbvcxzasdfghjklpoiuytrewq{}\=-!@#$%^&*ZXC9M()_+|~`'"
C2="asdfg123jkl;']�[poiuytQWERTYUIOPLKJHGFDSAZXCVBNMrewqz5678xcvbnm,./?><:}{-=\`|+_)(*&490h^%#$!@~"
C3="ZXCVBNM,./?><';LKJHGFDSA�:][}{\=-54321`|+_)098qwertyuioplkjhgfdsamnbvcxz76(*&^%$TREPOIUYWQ#@!~"
C4="|+_)%$#@(�*&^!}{:672348?><~159asdfghjklpoiuytrewqzxcvbnm0-=\`[]';LKJHGFDSAZQWERXCVBNM,./TYUIOP"

cdecrypt = ""
For I=1 To Len(Allt(cstring))
	IMOD = Iif(Mod(I + Len(Alltrim(cstring)),4) <>0,;
		MOD(I + Len(Alltrim(cstring)),4) ,4)
	CSTR = "C" + Alltrim(Str(IMOD))
	IPOS = At(Substr(cstring,I,1),&CSTR)
	cdecrypt = cdecrypt + Substr(c,IPOS,1)
Next
Return cdecrypt

ENDFUNC

FUNCTION get_no_dft()
LOCAL cnomor
cnomor = ''
csql = 'SELECT * FROM aconfig'
asg = SQLEXEC(gnconnhandle,csql,'aconfig')
IF asg < 0
	=MESSAGEBOX('Error Koneksi Aconfig',0,'Kesalahan')
else	
	cno_urut=nulstr( val(aconfig.no_dft)+1, 4 )	 
	ckdupt =ALLTRIM(kode_upt)
	cnomor = ckdupt+cno_urut
ENDIF

RETURN cnomor	

FUNCTION ctk_kendaraan()
SET PRINTER TO  
SET DEVICE TO print

@0.5,120 say "Kode Upt  :"
@1.5,120 say "Nama Upt :"
@2.5,120 say "Tanggal    :"
@0.5,132 say "pckdupt"
@1.5,132 say ALLTRIM(konfig.company)
@2.5,132 say conv_tanggal(pdtgl_trans)
@3,60 say "DATA KENDARAAN"
@5,5 say "1. NO POLISI"
@5,40 say ":"
@5,42 say ALLTRIM(nopol)
@6,5 say "2. NO KTP "
@6,40 say ":"
@6,42 say ALLTRIM(ktp)
@7,5 say "3. NAMA PEMILIK"
@7,40 say ":"
@7,42 say ALLTRIM(nama)
@8,5 say "4. PEKERJAAN"
@8,40 say ":"
@8,42 say ALLTRIM(kerja)
@9,5 say "5. ALAMAT"
@9,40 say ":"
@9,42 say ALLTRIM(Alamat)
@10,5 say "6. JENIS KENDARAAN"
@10,40 say ":"
@10,42 say ALLTRIM(jenis)
@11,5 say "7. MERK KENDARAAN "
@11,40 say ":"
@11,42 say ALLTRIM(merk)
@12,5 say "8. TAHUN BUAT"
@12,40 say ":"
@12,42 say ALLTRIM(thn_buat)
@13,5 say "9. TIPE KENDARAAN"
@13,40 say ":"
@13,42 say ALLTRIM(tipe)
@14,5 say "10. ISI CILINDER"
@14,40 say ":"
@14,42 say ALLTRIM(cyl)
@15,5 say "11. WARNA KENDARAAN "
@15,40 say ":"
@15,42 say ALLTRIM(warna)
@16,5 say "12. NO RANGKA/NIK"
@16,40 say ":"
@16,42 say ALLTRIM(rangka)
@17,5 say "13. NO MESIN "
@17,40 say ":"
@17,42 say ALLTRIM(mesin)
@18,5 say "14. NO BPKB/REGISTRASI"
@18,40 say ":"
@18,42 say ALLTRIM(bpkb)
@19,5 say "15. BAHAN BAKAR"
@19,40 say ":"
@19,42 say ALLTRIM(bbm)
@20,5 say "16. WARNA TNKB"
@20,40 say ":"
@20,42 say ALLTRIM(warna_plat)
@21,5 say "17. KEPEMILIKAN"
@21,40 say ":"
@21,42 say ALLTRIM(milik)
@22,5 say "18. PENGGUNAAN"
@22,40 say ":"
@22,42 say ALLTRIM(guna)

*!*	SET PRINT OFF
*!*	SET DEVICE TO SCREEN
*!*	SET PRINTER TO 
*!*	SET CONSOLE ON
SET DEVICE TO screen
SET PRINTER TO 

*!*	set print to
*!*	set device to SCREEN
ENDFUNC	

FUNCTION ambil_tabel()
LPARAMETERS ctabel
SELECT &ctabel
BROWSE
ENDFUNC


PROCEDURE rem_spasi_2()
LPARAMETERS cnopol
LOCAL cret_n
cret_n = ''
nlen = LEN(ALLTRIM(cnopol))
FOR m = 1 TO nlen
*!*		zz=AT(SUBSTR(cnopol,m,1)," -_,.")
*!*		IF zz>0
	cseek = SUBSTR(cnopol,m,1)
	IF !INLIST(cseek,'.','-','_',',',' ')
		cret_n = cret_n+SUBSTR(cnopol,m,1)
	ENDIF
NEXT
RETURN cret_n


PROCEDURE fix_nopol_tabel()

csql = 'select nopol from akend order by nopol'
asg = SQLEXEC(gnconnhandle,csql,'kend')		
IF asg<0
	=MESSAGEBOX('Gagal Konek')
ELSE
	SELECT kend
	njum = RECCOUNT('kend')
	j = 1
	GO top
	DO WHILE !EOF()
	*WAIT wind(' proses data ke ' +ALLTRIM(STR(j)) + 'dari '+ALLTRIM(STR(njum))+' record')nowait
	cnopol = ALLTRIM(nopol)
	cfix = rem_spasi_2(cnopol)
	IF cnopol <> cfix
*!*			?STR(j)+' '+ cnopol +' - '+ cfix
		
		csql = 'update akend set nopol=?cfix where nopol =?cnopol '
		asg = SQLEXEC(gnconnhandle,csql)		
		IF asg<0
			=MESSAGEBOX('Gagal Konek')
			RETURN
		ENDIF
	endif
	j=j+1
	SKIP
	ENDDO
ENDIF
ENDPROC 		 		
		
Function Toolbar_Foxpro
Lparameters lShow

Dimension aToolbar(13)

aToolbar(1)  = "Color Palette"
aToolbar(2)  = "Database Designer"
aToolbar(3)  = "Debugger"
aToolbar(4)  = "Form Controls"
aToolbar(5)  = "Form Designer"
aToolbar(6)  = "Layout"
aToolbar(7)  = "Print Preview"
aToolbar(8)  = "Query Designer"
aToolbar(9)  = "Report Controls"
aToolbar(10) = "Report Designer"
aToolbar(11) = "Standard"
aToolbar(12) = "View Designer"
aToolbar(13) = "project manager"

For i=1 To 13
	If !lShow
		If Wvisible(aToolbar(i))
			Deactivate Window(aToolbar(i))
		Endif
	Else
		If !Wvisible(aToolbar(i))
			If Wexist(aToolbar(i))
				Activate Window(aToolbar(i))
			Endif
		Endif
	Endif
Endfor
ENDFUNC

Procedure Samsat_screen
Lparameters lStatus

If lStatus
 	
 	IF !(TYPE("_Screen.imGBACK")='O')
		_Screen.AddObject('imgBack','image')
	ENDIF
	
	_Screen.imGBACK.Picture = _screen.Picture 
	_Screen.imGBACK.Width = _Screen.Width
	_Screen.imGBACK.Height = _Screen.Height
	_Screen.imGBACK.Stretch = 2
	_Screen.imGBACK.Anchor = 15
	_Screen.imGBACK.Visible = .T.

	IF !(TYPE("_Screen.cnt_info")='O')
		_Screen.AddObject('cnt_info','cnt_info')
	ENDIF
	
	_Screen.cnt_info.visible = .T.
	_Screen.cnt_info.left = 10
*!*		_Screen.cnt_info.top = 10 + IIF(TYPE("frm_shortcut")='O',frm_shortcut.height,0)
	_Screen.cnt_info.lblUser.Caption = c_user
	
	_Screen.cnt_info.lbl_login_date.Caption = IIF(_Screen.cnt_info.lbl_login_date.Caption='',DTOC(DATE()),_Screen.cnt_info.lbl_login_date.Caption)
	_Screen.cnt_info.lbl_login_time.Caption = IIF(_Screen.cnt_info.lbl_login_time.Caption='',TIME(),_Screen.cnt_info.lbl_login_time.Caption)

	_Screen.cnt_info.lblServer.Caption = pcServer 
	_Screen.cnt_info.lblDatabase.Caption = pcdbname
	
	_Screen.cnt_info.lblStatus.Caption = IIF(plOnline,'On-Line','Off-Line')
	_Screen.cnt_info.ToolTipText = IIF(plOnline,pcServerUrl,'')
	
	_Screen.cnt_info.lblTransaksi.Caption = DTOC(pdTgl_Trans)
	
	*---
	
	csqlDB = "SELECT COUNT(*) AS jumlah FROM pkb_header WHERE tgl_dft = ?pdTgl_Trans and gol_dft='B' and upt_bayar=?pckdupt"
	csqlDU = "SELECT COUNT(*) AS jumlah FROM pkb_header WHERE tgl_dft = ?pdTgl_Trans and gol_dft='U' and upt_bayar=?pckdupt"
	csqlDM = "SELECT COUNT(*) AS jumlah FROM pkb_header WHERE tgl_dft = ?pdTgl_Trans and gol_dft='D' and upt_bayar=?pckdupt"
	csqlDMM = "SELECT COUNT(*) AS jumlah FROM pkb_header WHERE tgl_dft = ?pdTgl_Trans and gol_dft='M' and upt_bayar=?pckdupt"
	csqlDMK = "SELECT COUNT(*) AS jumlah FROM pkb_header WHERE tgl_dft = ?pdTgl_Trans and gol_dft='K' and upt_bayar=?pckdupt"

	
	csqlTP1 = "SELECT COUNT(*) AS total,SUM(jumlah) AS  jumlah FROM pkb_biasa WHERE tgl_dft = ?pdTgl_Trans "+;
			  "AND no_dft IN (SELECT no_dft FROM pkb_header WHERE tgl_dft = ?pdTgl_Trans AND ctk_ttp=1 and upt_bayar=?pckdupt)"
	csqlTP2 = "SELECT COUNT(*) AS total,SUM(jumlah) AS  jumlah FROM pkb_tunggak WHERE tgl_dft = ?pdTgl_Trans "+;
			  "AND no_dft IN (SELECT no_dft FROM pkb_header WHERE tgl_dft = ?pdTgl_Trans AND ctk_ttp_tg=1 and upt_bayar=?pckdupt)"
	csqlTP3 = "SELECT COUNT(*) AS total FROM pkb_header WHERE tgl_dft = ?pdTgl_Trans AND (ctk_ttp=1 or ctk_ttp_tg=1) and upt_bayar=?pckdupt"
	
	csqlTR1 = "SELECT COUNT(*) AS total,SUM(jumlah) AS  jumlah FROM pkb_biasa WHERE tgl_dft = ?pdTgl_Trans "+;
			  "AND no_dft IN (SELECT no_dft FROM pkb_header WHERE tgl_dft = ?pdTgl_Trans AND ctk_trm=1 and upt_bayar=?pckdupt)"
 	csqlTR2 = "SELECT COUNT(*) AS total,SUM(jumlah) AS  jumlah FROM pkb_tunggak WHERE tgl_dft = ?pdTgl_Trans "+;
			  "AND no_dft IN (SELECT no_dft FROM pkb_header WHERE tgl_dft = ?pdTgl_Trans AND ctk_trm_tg=1 and upt_bayar=?pckdupt)"
 	csqlTR3 = "SELECT COUNT(*) AS total FROM pkb_header WHERE tgl_dft = ?pdTgl_Trans AND (ctk_trm=1 or ctk_ttp_tg=1 and upt_bayar=?pckdupt)"
	
 	*---
 	STORE 0 TO nTotDf,nTotTP,nJumTP,nTotTR,nJumTR
	
	ts = SQLExec(gnconnhandle,csqlDB)
	nTotDf = nTotDf + VAL(jumlah)
	_Screen.cnt_info.lblDaftbaru.Caption = ALLTRIM(jumlah) && IIF(ISNULL(jumlah),'0',ALLTRIM(STR(jumlah)))
	
	SQLExec(gnconnhandle,csqlDU)
	nTotDf = nTotDf + VAL(jumlah)
	_Screen.cnt_info.lblDaftUlang.Caption = ALLTRIM(jumlah) && IIF(ISNULL(jumlah),'0',ALLTRIM(STR(jumlah)))
	
	SQLExec(gnconnhandle,csqlDM)
	nTotDf = nTotDf + VAL(jumlah)
	_Screen.cnt_info.lblDaftModif.Caption = ALLTRIM(jumlah) && IIF(ISNULL(jumlah),'0',ALLTRIM(STR(jumlah)))
	
	_Screen.cnt_info.lblPendaftaran.Caption = ALLTRIM(STR(nTotDf)) && IIF(ISNULL(jumlah),'0',ALLTRIM(STR(jumlah)))
	
	
	SQLExec(gnconnhandle,csqlDMM)
	nTotDf = nTotDf + VAL(jumlah)
	_Screen.cnt_info.lblmutasimasuk.Caption = ALLTRIM(jumlah) && IIF(ISNULL(jumlah),'0',ALLTRIM(STR(jumlah))
	
	
	SQLExec(gnconnhandle,csqlDmk)
	nTotDf = nTotDf + VAL(jumlah)
	_Screen.cnt_info.lblmutasikeluar.Caption = ALLTRIM(jumlah) && IIF(ISNULL(jumlah),'0',ALLTRIM(STR(jumlah))
	*---
	
	SQLExec(gnconnhandle,csqlTP1)
	nTotTP = nTotTP + VAL(total)
	nJumTP = nJumTP + IIF(ISNULL(jumlah),0,jumlah)
	_Screen.cnt_info.lblPenetapan_biasa.Caption = ALLTRIM(total)+' ('+IIF(ISNULL(jumlah),'0',ALLTRIM(TRANSFORM(jumlah,'@R 999,999,999')))+')' && IIF(ISNULL(total),'0',ALLTRIM(STR(total)))+' ('+IIF(ISNULL(jumlah),'0',TRANSFORM(jumlah,'@R 999,999,999'))+')'
	
	SQLExec(gnconnhandle,csqlTP2)
	nTotTP = nTotTP + VAL(total)
	nJumTP = nJumTP + IIF(ISNULL(jumlah),0,jumlah)
	_Screen.cnt_info.lblPenetapan_tunggak.Caption = ALLTRIM(total)+' ('+IIF(ISNULL(jumlah),'0',ALLTRIM(TRANSFORM(jumlah,'@R 999,999,999')))+')' && IIF(ISNULL(total),'0',ALLTRIM(STR(total)))+' ('+IIF(ISNULL(jumlah),'0',TRANSFORM(jumlah,'@R 999,999,999'))+')'
	
	SQLExec(gnconnhandle,csqlTP3)
	_Screen.cnt_info.lblPenetapan.Caption = ALLTRIM(total)+' ('+IIF(ISNULL(nJumTP),'0',ALLTRIM(TRANSFORM(nJumTP,'@R 999,999,999')))+')' && IIF(ISNULL(total),'0',ALLTRIM(STR(total)))+' ('+IIF(ISNULL(jumlah),'0',TRANSFORM(jumlah,'@R 999,999,999'))+')'
	
	*---
 
	SQLExec(gnconnhandle,csqlTR1)
	nTotTR = nTotTR + VAL(total)
	nJumTR = nJumTR + IIF(ISNULL(jumlah),0,jumlah)
	_Screen.cnt_info.lblPenerimaan_biasa.Caption = ALLTRIM(total)+' ('+IIF(ISNULL(jumlah),'0',ALLTRIM(TRANSFORM(jumlah,'@R 999,999,999')))+')'&& IIF(ISNULL(total),'0',ALLTRIM(STR(total)))+' ('+IIF(ISNULL(jumlah),'0',TRANSFORM(jumlah,'@R 999,999,999'))+')'
	
	SQLExec(gnconnhandle,csqlTR2)
	nTotTR = nTotTR + VAL(total)
	nJumTR = nJumTR + IIF(ISNULL(jumlah),0,jumlah)
	_Screen.cnt_info.lblPenerimaan_tunggak.Caption = ALLTRIM(total)+' ('+IIF(ISNULL(jumlah),'0',ALLTRIM(TRANSFORM(jumlah,'@R 999,999,999')))+')'&& IIF(ISNULL(total),'0',ALLTRIM(STR(total)))+' ('+IIF(ISNULL(jumlah),'0',TRANSFORM(jumlah,'@R 999,999,999'))+')'
	
	SQLExec(gnconnhandle,csqlTR3)
	_Screen.cnt_info.lblPenerimaan.Caption = ALLTRIM(total)+' ('+IIF(ISNULL(nJumTR),'0',ALLTRIM(TRANSFORM(nJumTR,'@R 999,999,999')))+')'&& IIF(ISNULL(total),'0',ALLTRIM(STR(total)))+' ('+IIF(ISNULL(jumlah),'0',TRANSFORM(jumlah,'@R 999,999,999'))+')'
	
	*---
	
	IF POPUP('utilitas')
		SET MARK OF BAR 12 OF utilitas TO .T.
	ENDIF 
		

Else

	IF TYPE("_Screen.imGBACK")='O'
		_Screen.RemoveObject('imgBack')
	ENDIF 

	IF TYPE("_Screen.cnt_info")='O'
		_Screen.RemoveObject('cnt_info')
	ENDIF 
	
Endif

Endproc
		

		
Procedure Samsat_screen
Lparameters lStatus

*!*	If lStatus
*!*	 	
*!*	 	IF !(TYPE("_Screen.imGBACK")='O')
*!*			_Screen.AddObject('imgBack','image')
*!*		ENDIF
*!*		
*!*		_Screen.imGBACK.Picture = _screen.Picture 
*!*		_Screen.imGBACK.Width = _Screen.Width
*!*		_Screen.imGBACK.Height = _Screen.Height
*!*		_Screen.imGBACK.Stretch = 2
*!*		_Screen.imGBACK.Anchor = 15
*!*		_Screen.imGBACK.Visible = .T.

*!*		IF !(TYPE("_Screen.cnt_info")='O')
*!*			_Screen.AddObject('cnt_info','cnt_info')
*!*		ENDIF
*!*		
*!*		_Screen.cnt_info.visible = .T.
*!*		_Screen.cnt_info.left = 10
*!*		_Screen.cnt_info.top = 10 + IIF(TYPE("frm_shortcut")='O',frm_shortcut.height,0)
*!*		_Screen.cnt_info.lblUser.Caption = c_user
*!*		
*!*		_Screen.cnt_info.lbl_login_date.Caption = IIF(_Screen.cnt_info.lbl_login_date.Caption='',DTOC(DATE()),_Screen.cnt_info.lbl_login_date.Caption)
*!*		_Screen.cnt_info.lbl_login_time.Caption = IIF(_Screen.cnt_info.lbl_login_time.Caption='',TIME(),_Screen.cnt_info.lbl_login_time.Caption)

*!*		_Screen.cnt_info.lblServer.Caption = pcServer 
*!*		_Screen.cnt_info.lblDatabase.Caption = pcdbname
*!*		
*!*		_Screen.cnt_info.lblStatus.Caption = IIF(plOnline,'On-Line','Off-Line')
*!*		_Screen.cnt_info.ToolTipText = IIF(plOnline,pcServerUrl,'')
*!*		
*!*		_Screen.cnt_info.lblTransaksi.Caption = DTOC(pdTgl_Trans)
*!*		
*!*		*---
*!*		
*!*		csqlDB = "SELECT COUNT(*) AS jumlah FROM pkb_header WHERE tgl_dft = ?pdTgl_Trans and gol_dft='B' and upt_bayar=?pckdupt"
*!*		csqlDU = "SELECT COUNT(*) AS jumlah FROM pkb_header WHERE tgl_dft = ?pdTgl_Trans and gol_dft='U' and upt_bayar=?pckdupt"
*!*		csqlDM = "SELECT COUNT(*) AS jumlah FROM pkb_header WHERE tgl_dft = ?pdTgl_Trans and gol_dft='D' and upt_bayar=?pckdupt"
*!*		csqlDMM = "SELECT COUNT(*) AS jumlah FROM pkb_header WHERE tgl_dft = ?pdTgl_Trans and gol_dft='M' and upt_bayar=?pckdupt"
*!*		csqlDMK = "SELECT COUNT(*) AS jumlah FROM pkb_header WHERE tgl_dft = ?pdTgl_Trans and gol_dft='K' and upt_bayar=?pckdupt"

*!*		
*!*		csqlTP1 = "SELECT COUNT(*) AS total,SUM(jumlah) AS  jumlah FROM pkb_biasa WHERE tgl_dft = ?pdTgl_Trans "+;
*!*				  "AND no_dft IN (SELECT no_dft FROM pkb_header WHERE tgl_dft = ?pdTgl_Trans AND ctk_ttp=1 and upt_bayar=?pckdupt)"
*!*		csqlTP2 = "SELECT COUNT(*) AS total,SUM(jumlah) AS  jumlah FROM pkb_tunggak WHERE tgl_dft = ?pdTgl_Trans "+;
*!*				  "AND no_dft IN (SELECT no_dft FROM pkb_header WHERE tgl_dft = ?pdTgl_Trans AND ctk_ttp_tg=1 and upt_bayar=?pckdupt)"
*!*		csqlTP3 = "SELECT COUNT(*) AS total FROM pkb_header WHERE tgl_dft = ?pdTgl_Trans AND (ctk_ttp=1 or ctk_ttp_tg=1) and upt_bayar=?pckdupt"
*!*		
*!*		csqlTR1 = "SELECT COUNT(*) AS total,SUM(jumlah) AS  jumlah FROM pkb_biasa WHERE tgl_dft = ?pdTgl_Trans "+;
*!*				  "AND no_dft IN (SELECT no_dft FROM pkb_header WHERE tgl_dft = ?pdTgl_Trans AND ctk_trm=1 and upt_bayar=?pckdupt)"
*!*	 	csqlTR2 = "SELECT COUNT(*) AS total,SUM(jumlah) AS  jumlah FROM pkb_tunggak WHERE tgl_dft = ?pdTgl_Trans "+;
*!*				  "AND no_dft IN (SELECT no_dft FROM pkb_header WHERE tgl_dft = ?pdTgl_Trans AND ctk_trm_tg=1 and upt_bayar=?pckdupt)"
*!*	 	csqlTR3 = "SELECT COUNT(*) AS total FROM pkb_header WHERE tgl_dft = ?pdTgl_Trans AND (ctk_trm=1 or ctk_ttp_tg=1 and upt_bayar=?pckdupt)"
*!*		
*!*	 	*---
*!*	 	STORE 0 TO nTotDf,nTotTP,nJumTP,nTotTR,nJumTR
*!*		
*!*		ts = SQLExec(gnconnhandle,csqlDB)
*!*		nTotDf = nTotDf + VAL(jumlah)
*!*		_Screen.cnt_info.lblDaftbaru.Caption = ALLTRIM(jumlah) && IIF(ISNULL(jumlah),'0',ALLTRIM(STR(jumlah)))
*!*		
*!*		SQLExec(gnconnhandle,csqlDU)
*!*		nTotDf = nTotDf + VAL(jumlah)
*!*		_Screen.cnt_info.lblDaftUlang.Caption = ALLTRIM(jumlah) && IIF(ISNULL(jumlah),'0',ALLTRIM(STR(jumlah)))
*!*		
*!*		SQLExec(gnconnhandle,csqlDM)
*!*		nTotDf = nTotDf + VAL(jumlah)
*!*		_Screen.cnt_info.lblDaftModif.Caption = ALLTRIM(jumlah) && IIF(ISNULL(jumlah),'0',ALLTRIM(STR(jumlah)))
*!*		
*!*		_Screen.cnt_info.lblPendaftaran.Caption = ALLTRIM(STR(nTotDf)) && IIF(ISNULL(jumlah),'0',ALLTRIM(STR(jumlah)))
*!*		
*!*		
*!*		SQLExec(gnconnhandle,csqlDMM)
*!*		nTotDf = nTotDf + VAL(jumlah)
*!*		_Screen.cnt_info.lblmutasimasuk.Caption = ALLTRIM(jumlah) && IIF(ISNULL(jumlah),'0',ALLTRIM(STR(jumlah))
*!*		
*!*		
*!*		SQLExec(gnconnhandle,csqlDmk)
*!*		nTotDf = nTotDf + VAL(jumlah)
*!*		_Screen.cnt_info.lblmutasikeluar.Caption = ALLTRIM(jumlah) && IIF(ISNULL(jumlah),'0',ALLTRIM(STR(jumlah))
*!*		
*!*		*---
*!*		
*!*		SQLExec(gnconnhandle,csqlTP1)
*!*		nTotTP = nTotTP + VAL(total)
*!*		nJumTP = nJumTP + IIF(ISNULL(jumlah),0,jumlah)
*!*		_Screen.cnt_info.lblPenetapan_biasa.Caption = ALLTRIM(total)+' ('+IIF(ISNULL(jumlah),'0',ALLTRIM(TRANSFORM(jumlah,'@R 999,999,999')))+')' && IIF(ISNULL(total),'0',ALLTRIM(STR(total)))+' ('+IIF(ISNULL(jumlah),'0',TRANSFORM(jumlah,'@R 999,999,999'))+')'
*!*		
*!*		SQLExec(gnconnhandle,csqlTP2)
*!*		nTotTP = nTotTP + VAL(total)
*!*		nJumTP = nJumTP + IIF(ISNULL(jumlah),0,jumlah)
*!*		_Screen.cnt_info.lblPenetapan_tunggak.Caption = ALLTRIM(total)+' ('+IIF(ISNULL(jumlah),'0',ALLTRIM(TRANSFORM(jumlah,'@R 999,999,999')))+')' && IIF(ISNULL(total),'0',ALLTRIM(STR(total)))+' ('+IIF(ISNULL(jumlah),'0',TRANSFORM(jumlah,'@R 999,999,999'))+')'
*!*		
*!*		SQLExec(gnconnhandle,csqlTP3)
*!*		_Screen.cnt_info.lblPenetapan.Caption = ALLTRIM(total)+' ('+IIF(ISNULL(nJumTP),'0',ALLTRIM(TRANSFORM(nJumTP,'@R 999,999,999')))+')' && IIF(ISNULL(total),'0',ALLTRIM(STR(total)))+' ('+IIF(ISNULL(jumlah),'0',TRANSFORM(jumlah,'@R 999,999,999'))+')'
*!*		
*!*		*---
*!*	 
*!*		SQLExec(gnconnhandle,csqlTR1)
*!*		nTotTR = nTotTR + VAL(total)
*!*		nJumTR = nJumTR + IIF(ISNULL(jumlah),0,jumlah)
*!*		_Screen.cnt_info.lblPenerimaan_biasa.Caption = ALLTRIM(total)+' ('+IIF(ISNULL(jumlah),'0',ALLTRIM(TRANSFORM(jumlah,'@R 999,999,999')))+')'&& IIF(ISNULL(total),'0',ALLTRIM(STR(total)))+' ('+IIF(ISNULL(jumlah),'0',TRANSFORM(jumlah,'@R 999,999,999'))+')'
*!*		
*!*		SQLExec(gnconnhandle,csqlTR2)
*!*		nTotTR = nTotTR + VAL(total)
*!*		nJumTR = nJumTR + IIF(ISNULL(jumlah),0,jumlah)
*!*		_Screen.cnt_info.lblPenerimaan_tunggak.Caption = ALLTRIM(total)+' ('+IIF(ISNULL(jumlah),'0',ALLTRIM(TRANSFORM(jumlah,'@R 999,999,999')))+')'&& IIF(ISNULL(total),'0',ALLTRIM(STR(total)))+' ('+IIF(ISNULL(jumlah),'0',TRANSFORM(jumlah,'@R 999,999,999'))+')'
*!*		
*!*		SQLExec(gnconnhandle,csqlTR3)
*!*		_Screen.cnt_info.lblPenerimaan.Caption = ALLTRIM(total)+' ('+IIF(ISNULL(nJumTR),'0',ALLTRIM(TRANSFORM(nJumTR,'@R 999,999,999')))+')'&& IIF(ISNULL(total),'0',ALLTRIM(STR(total)))+' ('+IIF(ISNULL(jumlah),'0',TRANSFORM(jumlah,'@R 999,999,999'))+')'
*!*		
*!*		*---
*!*		
*!*		IF POPUP('utilitas')
*!*			SET MARK OF BAR 12 OF utilitas TO .T.
*!*		ENDIF 
*!*			

*!*	Else

*!*		IF TYPE("_Screen.imGBACK")='O'
*!*			_Screen.RemoveObject('imgBack')
*!*		ENDIF 

*!*		IF TYPE("_Screen.cnt_info")='O'
*!*			_Screen.RemoveObject('cnt_info')
*!*		ENDIF 
*!*		
*!*	Endif

ENDPROC

PROCEDURE hack_frx
LPARAMETERS lAll

	IF lAll
		REPLACE expr WITH ''
	ELSE
		mExpr = expr 
		n = AT('ORIENTATION',mExpr)
		IF n>0
			cOrientation = SUBSTR(mExpr,n,13)
			REPLACE expr WITH cOrientation 
		ENDIF 
	ENDIF 

	REPLACE tag WITH '', tag2 WITH ''

ENDPROC 

PROCEDURE hack_reports
LPARAMETERS lAll
	SET DEFAULT TO PCHOME+'REPORTS'
	ADIR(aReports,'*.FRX')
	FOR i=1 TO ALEN(aReports,1)
		WAIT WINDOW 'Proses Reports '+aReports(i,1) NOWAIT 
		tutup(aReports(i,1))
		USE aReports(i,1)
		hack_frx(lAll)
		USE 
	ENDFOR 
	WAIT CLEAR 
	SET DEFAULT TO FULLPATH(PCHOME) 

ENDPROC 

FUNCTION tutup
	lparam cfile

	if used(cfile)
		sele (cfile)
		use
	endi
ENDFUNC 


FUNCTION ambil_ip
DECLARE INTEGER GetIpAddrTable IN iphlpapi;
  STRING @ pIpAddrTable,;
  INTEGER @ pdwSize,;
  INTEGER  bOrder
DECLARE STRING inet_ntoa IN ws2_32 INTEGER in_addr

pdwSize =0
=GetIpAddrTable (NULL, @pdwSize, 1)

pIpAddrTable = REPLICATE(CHR(0), pdwSize)
=GetIpAddrTable (@pIpAddrTable, @pdwSize, 1)

nombre = buf2dword(SUBSTR(pIpAddrTable, 1, 4))

FOR i=1 TO nombre
 Adresse = INET_NTOA(buf2dword(SUBSTR(pIpAddrTable, 5 + (i-1)*24, 4)))
 Masque = INET_NTOA(buf2dword(SUBSTR(pIpAddrTable, 13 + (i-1)*24, 4)))
*!*	 ? adresse + "/" + masque
Next
RETURN Adresse 

FUNCTION buf2dword(cBuffer)
RETURN Asc(SUBSTR(cBuffer, 1,1)) + ;
  Asc(SUBSTR(cBuffer, 2,1)) * 256 +;
  Asc(SUBSTR(cBuffer, 3,1)) * 65536 +;
  Asc(SUBSTR(cBuffer, 4,1)) * 16777216
  
  
FUNCTION recall_NOPOL 
LPARAMETERS cnopol

		CSQL33 = 'DELETE FROM AKEND WHERE NOPOL=?CNOPOL'
		SDS    = SQLExec(gnconnhandle,CSQL33)
		
		TEXT TO XSQL NOSHOW 
		INSERT INTO akend SELECT 
  NOPOL,
  NOPOL_EKS,
  KOHIR,
  KTP,
  NAMA,
  KERJA,
  ALAMAT,
  KD_POS,
  JENIS,
  KD_MERK,
  TIPE,
  THN_BUAT,
  KD_BBM,
  CYL,
  RANGKA,
  MESIN,
  NO_BPKB,
  KD_MILIK,
  KD_GUNA,
  KE,
  WARNA,
  WARNA_PLAT,
  NO_STNKB,
  TG_CTK_ST,
  DFT_STNK,
  TGL_STNK,
  SD_STNK,
  TGL_NOTICE,
  SD_NOTICE,
  TGL_SWD,
  SD_SWD,
  TGL_FAKTUR,
  TGL_KWT,
  TGL_FISKAL,
  UBH_BTK,
  UBH_MSN,
  TGL_DFT,
  TGL_TTP,
  TGL_TRM,
  KD_LOKASI,
  NON_AKTIF,
  SPPKB,
  NO_STNK,
  NO_HP,
  KODE_UPT,
  skum,
  no_kwt,
  nm_pjual,
  almt_pjual,
  no_skuasa,
  kd_jrm,
  kd_samsat_lama,
  kd_jns_umum,
  no_notice_lama
FROM h_akend WHERE  tindakan='HISTORY'  AND nopol = ?CNOPOL
AND waktu = (SELECT MAX(waktu) FROM   h_akend WHERE  tindakan='HISTORY'  AND nopol = ?CNOPOL)
ENDTEXT 

		
			SDS    = SQLExec(gnconnhandle,XSQL )	
			
ENDFUNC 			

 
FUNCTION CARIANGKAHURUF(TEKS)
	 	  
	  S = ''

	  FOR I = 1 TO LEN(TEKS)
	    C = SUBSTR(LOWER(TEKS), I, 1)
	    IF ( (C >= '0') AND (C <= '9') ) or ( c='a' OR c='b' or c='c' or c='d' or c='e' or c='f' or c='g' or c='h' or c='i' or c='j' or c='k' or c='l' or c='m' ;
	    	or c='n' or c='o' or c='p' or c='q' or c='r' or c='s' or c='t' or c='u' or c='v' or c='w' or c='x' or c='y' or c='z' )
        S = S + C
	    ENDIF
	  ENDFOR 

	  RETURN S

ENDFUNC 

function rangka(teks)
  s = ''
  for i = 1 to len(teks)
    c = substr(teks, i, 1)
    if (upper(c) >= 'A') and (upper(c) <= 'Z') OR (c >= '0') and (c <= '9')
      s = s + c
    endif
  endfor
  return s
ENDFUNC

FUNCTION romawi 
LPARAMETERS angka
 
cangka = alltrim(str(int(angka)))
cromawi = ''
 
IF angka < 4000 AND !EMPTY(angka)
	FOR i = 1 TO LEN(cangka)
		IF SUBSTR(cangka,i,1)#'0'
			cromawi = cromawi + bil(VAL(SUBSTR(cangka,i,1)),LEN(cangka)-i+1)
		ENDIF 
	ENDFOR 
ENDIF 

RETURN cromawi

FUNCTION bil(sat,xjumlah)
	crom = ''
	dime satuan[4,2]
	satuan[1,1] = 'I'
	satuan[1,2] = 'V'
	satuan[2,1] = 'X'
	satuan[2,2] = 'L'
	satuan[3,1] = 'C'
	satuan[3,2] = 'D'
	satuan[4,1] = 'M'
	satuan[4,2] = ' '
	
	DO case
		CASE sat = 5
			crom = satuan[xjumlah,2]
		CASE sat < 5
			IF MOD(sat,5)=4
				crom = satuan[xjumlah,1]+satuan[xjumlah,2]
			ELSE
				FOR n = 1 TO MOD(sat,5)
					crom = crom + satuan[xjumlah,1]
				ENDFOR 
			ENDIF 
		CASE sat >5
			IF MOD(sat,5)=4
				crom = satuan[xjumlah,1]+satuan[xjumlah+1,1]
			ELSE
				crom = satuan[xjumlah,2]
				FOR n = 1 TO MOD(sat,5)
					crom = crom + satuan[xjumlah,1]
				ENDFOR 
			ENDIF 
	ENDCASE 
		
	RETURN crom
ENDFUNC 


	FUNCTION date_diff
 *
   * BTWNDATE.PRG
   *

   PARAMETERS startdate, enddate,ctype
   IF startdate > enddate

        WAIT WINDOW "Start date must " + CHR(13) ;
        + "be earlier than End date"
        RETURN

   ENDIF
   IF PARAMETERS() <> 3

        WAIT WINDOW "Not Correct Number of Parameters"
        RETURN

   ENDIF

   PRIVATE  precmpdate, vyears, vmonths, vdays
   precmpdate={}
   vyears=0
   vmonths=0
   vdays=0
   
   * Calculate:
   *     endofmonth is the last day of month prior to month of enddate
   *
   
   endofmonth = CTOD(ALLTRIM(STR(MONTH(enddate))) + '/' + "01" + '/' + ;
   ALLTRIM(STR(YEAR(enddate)))) - 1
   *
   IF MONTH(startdate) <= MONTH(enddate)

        vyears = YEAR(enddate) - YEAR(startdate)
        IF DAY(startdate) <= DAY(enddate)
             vmonths = MONTH(enddate) - MONTH(startdate)
             vdays = DAY(enddate) - DAY(startdate)
        ELSE
             IF MONTH(startdate) = MONTH(enddate)
                  vyears = vyears - 1
             ENDIF
             vmonths = MOD(MONTH(enddate) - MONTH(startdate) - 1 + 12, 12)
             vdays = endofmonth - precmpdate + DAY(enddate)
        ENDIF

   ELSE

        vyears = YEAR(enddate) - YEAR(startdate) - 1
        IF DAY(startdate) > DAY(enddate)
             vmonths = MONTH(enddate) - MONTH(startdate) + 12 - 1
             vdays = endofmonth - precmpdate + DAY(enddate)
        ELSE
             vmonths = MONTH(enddate) - MONTH(startdate) + 12
             vdays = DAY(enddate) - DAY(startdate)
        ENDIF

   ENDIF
*!*	   CLEAR
*!*	   WAIT WINDOW  CHR(13) + ;
*!*	             '  Years: '  + STR(vyears) + CHR(13) + ;
*!*	             ' Months: ' + STR(vmonths) + CHR(13) + ;
*!*	             '   Days: ' + STR(vdays) + CHR(13) + ;
*!*	             CHR(13) + ;
*!*	             ' Between ' + DTOC(startdate) + CHR(13) +;
*!*	             '     and 'vmo + DTOC(enddate)

*!*		IF vdays>0 
*!*			vmonths=vmonths+1
*!*		ENDIF
	
	DO CASE 
	CASE ctype = 'Y'
		njum =vyears
	CASE ctype = 'M'
		njum = vmonths
	CASE ctype ='D'
		njum = vdays
ENDCASE  		  	 	
   RETURN njum	