LPARAMETERS cDaftar,cno_dft,dtgl_dft,dtgl_faktur,dtgl_notice_sd,cJenis,cMerk,cTipe,cTahun,cPlat,cGuna,cTindakan,nTunggak,nDenda,lTambahTahun

IF PARAMETERS()#15
	MESSAGEBOX('Parameter Kurang !',48,'Parameter')
	return
ENDIF 
 
Dimension laArray(10,4), laSave(10,4)

LOCAL clDaftar,clno_dft,dltgl_dft,dltgl_faktur,dltgl_notice_sd,clJenis,clMerk,clTipe,clTahun,lcPlat,lcSWDKLLJ,lcTambahTahun
LOCAL lnDasar,lnNilai,lnPkb_Bs,lnPkb_Um,lnPajak,clJenisKend,d_pkb,d_swdkllj,clGuna,clTindakan,nlTunggak,nlDenda

clDaftar = cDaftar
clno_dft = cno_dft
dltgl_dft = dtgl_dft
dltgl_faktur = dtgl_faktur
dltgl_notice_sd = dtgl_notice_sd
clJenis = cJenis
clMerk = cMerk
clTipe = cTipe
clTahun = cTahun
lcPlat = cPlat
clTindakan = cTindakan
clGuna = cGuna
nlTunggak = nTunggak
nlDenda = nDenda
lcTambahTahun = lTambahTahun

STORE '' TO lcSWDKLLJ,clJenisKend 
STORE 0 TO lnPajak,d_pkb,d_swdkllj,lnDasar,lnNilai,lnPkb_Bs,lnPkb_Um

lplat = Iif(lcPlat='MERAH' And clGuna = '3',.T.,.F.)

***

csql = "SELECT * FROM aconfig "
nExec = SQLEXEC(gnconnhandle,csql,'aconfig') 

* Batas denda pkb dan swd
csq = 'select * from batas_denda'
asg	= SQLEXEC(gnconnhandle,csq,'bts_denda')
IF asg < 0
	=MESSAGEBOX('error get bts_denda')
	cek_error()
ELSE
	SELECT bts_denda
	d_pkb = bts_pkb
	d_swdkllj = bts_swdkllj
ENDIF

*\ ambil dasar PKB dan SWDKLLJ
csql = 'select * from apkb where jenis=?clJenis and kd_merk=?clMerk and tipe =?clTipe and th_buat = ?clTahun'
asg = SQLExec(gnconnhandle,csql,'rst_pkb')
If asg<0
	Messagebox('error get Apkb',48,'Error')
	cek_error()
	RETURN
ENDIF 

If Reccount('rst_pkb')>0
	Select rst_pkb
	lnDasar = dasar_pkb
	lnNilai = nilai_jual
	lnPkb_Bs = pkb_bs
	lnPkb_Um = pkb_um

	If lcPlat = 'KUNING'
		lcSWDKLLJ = gol_um && * umum
	Else
		lcSWDKLLJ = gol_bs && * non umum
	Endif
	
	csql = 'SELECT * FROM SWDKLLJ where gol=?lcSWDKLLJ'
	asg = SQLExec(gnconnhandle,csql,'rst_swd')
	If asg>0
		IF RECCOUNT()>0
			If dltgl_dft < Ctod('16/08/2001')
				lnSwd_pk = pokok_old
				lnSwd_lg = leges_old
				for i = 1 to IIF(clDaftar='01',1,11)
					lnPro = 'lnProrata'+Allt(Str(i))
					lnBln = 'bln_old'+Allt(Str(i))
					&lnPro = &lnBln
				ENDFOR
			ELSE
				lnSwd_pk = pokok_new
				lnSwd_lg = leges_new
				FOR i = 1 TO IIF(clDaftar='01',1,11)
					lnPro = 'lnProrata'+Allt(Str(i))
					lnBln = 'bln_new'+Allt(Str(i))
					&lnPro = &lnBln
				Endfor	
			ENDIF 
		ELSE
			lnSwd_pk = 0
			lnSwd_lg = 0
			for i = 1 to IIF(clDaftar='01',1,11)
				lnPro = 'lnProrata'+Allt(Str(i))
				&lnPro = 0
			Endfor
		ENDIF 
	ENDIF
ENDIF

*\ ambil jenis kendaraan
csql = 'SELECT * FROM ajenis WHERE jenis = ?clJenis'
asg = SQLExec(gnconnhandle,csql,'rst_jenis')
If asg>0
	IF RECCOUNT()>0
		clJenisKend = Iif(!Isnull(rst_jenis.kend),rst_jenis.kend,'')
	ENDIF 
ENDIF 

*** Sementara di kasih komen, jadi batas denda tidak berpengaruh----

*!*	*\ tentukan batas waktu kena denda BBNKB1 Batas 14 Hari dari tanggal Faktur Kendaraan Baru
*!*	ldBatas = IIF(clDaftar='01',dtgl_faktur + 14,dltgl_notice_sd) && dltgl_dft
*!*	lnCount = 0

*!*	csql = 'select * from mslibur'
*!*	asq = SQLExec(gnconnhandle,csql,'cs_libur')
*!*	If asq<0
*!*		Messagebox('error get libur')
*!*	Else
*!*		Select cs_libur
*!*		Do While .T.
*!*			llLibur = .F.

*!*	* hari minggu dan hari sabtu libur
*!*			If Dow(ldBatas) = 7 Or Dow(ldBatas) = 1
*!*				llLibur = .T.
*!*			Endif

*!*	* hari libur nasional
*!*			ldbatas1= conv_tanggal(ldBatas)
*!*			csql = 'select * from mslibur where tgl = ?ldbatas1 '
*!*			asq = SQLExec(gnconnhandle,csql,'cari_libur')
*!*			If asq<0
*!*				Messagebox('error get libur')
*!*			Else
*!*				If Reccount('cari_libur')>0
*!*					llLibur = .T.
*!*				Endif
*!*			Endif

*!*			If llLibur
*!*				ldBatas = ldBatas + 1
*!*			Else
*!*				If lnCount < 1
*!*					ldBatas = ldBatas
*!*					lnCount = lnCount + 1
*!*				Else
*!*					Exit
*!*				Endif
*!*			Endif
*!*		Enddo
*!*	Endif

*!*	If ldBatas + VAL(aconfig.bts_pkb) < dltgl_dft
*!*		llDenda = .T.
*!*	Else
*!*		llDenda = .F.
*!*	Endif

*!*	&& DENDA SWDKLLJ bila lewat 3 hari dari tanggal batas
*!*	If ldBatas + VAL(aconfig.bts_swdkllj) < dltgl_dft
*!*		llSWDKL = .T.
*!*	Else
*!*		llSWDKL = .F.
*!*	ENDIF

IF nlDenda>0
	llDenda = .T.
	llSWDKL = .T.
ELSE
	llDenda = .F.
	llSWDKL = .F.
ENDIF 

IF nldenda < 2
	nldenda = 0
ELSE 
	nldenda = nldenda - 1
ENDIF 
	
	

*\ hitung pajak biasa
csql = 'Select * FROM Ajpajak WHERE j_pajak=?clDaftar'
asg = SQLExec(gnconnhandle,csql,'rst_pajak')
If asg<0
	Messagebox('error get APajak',48,'Error')
	cek_error()
ELSE
	FOR i=1 TO 10

		SELECT rst_pajak
		cf = 'jns'+ALLTRIM(STR(i))
		cN = &cf
		
		csql = 'select * from Ajsetor where jsetor=?cN'
		SQLExec(gnconnhandle,csql,'rst_jsetor')
		
		laArray(i,1) = IIF(ISNULL(cN),'',cN)
		laArray(i,2) = rst_jsetor.jenis
		laArray(i,3) = 0
		laArray(i,4) = 0
		
		If !Empty(laArray(i,1))
			DO case
				&& 1 digit pertama = 1>'POKOK', 2>'DENDA'
				&& 2 digit kedua = 1>'BBNKB I', 2>'BBNKB II', 3>'PKB', 4>'SWDKLLJ', 5>'Adm. STNK', 
				&& 				   6>'Adm. TNKB', 7>'Adm. SPPKB', 8>'Penerimaan Lain-Lain',
				
				CASE laArray(i,2) = '11' or laArray(i,2) = '12' && Hitung Pokok BBNKB I & II
					IF lcPlat='KUNING' && Umum
						lnPajak = (lnNilai * Iif(laArray(i,2)='11', 0.1, 0.01)) - ;
								  (0.4 * lnNilai * Iif(laArray(i,2)='11', 0.1, 0.01))
					ELSE
						lnPajak = (lnNilai * Iif(laArray(i,2)='11', 0.1, 0.01))
					ENDIF 
					* pembulatan pokok BBN KB dan kendaraan dinas tidak kena BBNKB
					laArray(i,3) = IIF(lPlat,0,pembulatan(lnPajak)) * IIF(lcTambahTahun,2,1)
				
				CASE laArray(i,2) = '21' .Or. laArray(i,2) = '22' && Hitung Denda BBNKB I & II
					If llDenda
						IF lcPlat='KUNING' && Umum
							lnPajak = ((lnNilai * Iif(laArray(i,2)='21', 0.1, 0.01)) - ;
									   (0.4 * lnNilai * Iif(laArray(i,2)='21', 0.1, 0.01))) * IIF(nlTunggak>1,0.49,(0.25 + (nlDenda*0.02))) && 0.25
						ELSE
							lnPajak = (lnNilai * Iif(laArray(i,2)='21', 0.1, 0.01)) * IIF(nlTunggak>1,0.49,(0.25 + (nlDenda*0.02))) && 0.25
						ENDIF 
						&& * pembulatan denda BBN KB dan kendaraan dinas tidak kena denda BBNKB
						laArray(i,4) = IIF(lPlat,0,pembulatan(lnPajak))  
					ENDIF 
					
				CASE laArray(i,2) = '13'  && Hitung Pokok PKB
					IF clJenisKend = 'D1' OR clJenisKend ='R' && Jenis SEPEDA MOTOR, SPM R3, SEPEDA MOTOR R4
						lnPajak = lnPkb_Bs
					ELSE
						IF lcPlat='KUNING'
							lnPajak = lnPkb_Um
						ELSE
							lnPajak = lnPkb_Bs
						ENDIF 
					ENDIF 
					&& * pembulatan PKB dan kendaraan dinas tidak kena PKB
					laArray(i,3) = IIF(lPlat,0,pembulatan(lnPajak)) * IIF(lcTambahTahun,2,1)
				
				CASE laArray(i,2) = '23'  && Hitung Denda PKB
					If llDenda
						IF clJenisKend = 'D1' OR clJenisKend ='R' && Jenis SEPEDA MOTOR, SPM R3, SEPEDA MOTOR R4
							lnPajak = lnPkb_Bs * (0.25 + (nlDenda*0.02)) && 0.25
						ELSE
							IF lcPlat='KUNING'
								lnPajak = lnPkb_Um * (0.25 + (nlDenda*0.02))
							ELSE
								lnPajak = lnPkb_Bs * (0.25 + (nlDenda*0.02))
							ENDIF 
						ENDIF 
						&& * pembulatan Denda PKB dan kendaraan dinas tidak kena denda PKB
						laArray(i,4) = IIF(lPlat,0,pembulatan(lnPajak))  

					ENDIF 
				
				CASE laArray(i,2) = '14'  && hitung pokok swdkllj 
					lnSWDKLLJ = lnSwd_pk + lnSwd_lg  
					laArray(i,3) = lnSWDKLLJ * IIF(lcTambahTahun,2,1)
					
				CASE laArray(i,2) = '24'  && hitung denda swdkllj 
					If llSWDKL
						laArray(i,4) = lnSwd_pk  
					Endif
					
				CASE laArray(i,2) = '15'  && hitung adm STNK
					IF clJenisKend = 'D1' OR clJenisKend ='R' && Jenis SEPEDA MOTOR, SPM R3, SEPEDA MOTOR R4
						laArray(i,3) = IIF(!ISNULL(aconfig.stnk_bpkb),aconfig.stnk_bpkb,0)
					ELSE
						laArray(i,3) = IIF(!ISNULL(aconfig.stnk_bpkb4),aconfig.stnk_bpkb4,0)
					endif
					
				CASE laArray(i,2) = '16'  && hitung adm TNKB
					IF clJenisKend = 'D1' OR clJenisKend ='R' && Jenis SEPEDA MOTOR, SPM R3, SEPEDA MOTOR R4
						laArray(i,3) = IIF(!ISNULL(aconfig.stnk_bpkb),aconfig.nkb,0)
					ELSE
						laArray(i,3) = IIF(!ISNULL(aconfig.stnk_bpkb4),aconfig.nkbii,0)
					endif
					
				CASE laArray(i,2) = '17'  && hitung adm RPBA atau SPPKB
					IF clJenisKend = 'D1' OR clJenisKend ='R' && Jenis SEPEDA MOTOR, SPM R3, SEPEDA MOTOR R4
						laArray(i,3) = IIF(!ISNULL(IIF(clDaftar='01',aconfig.adm_tambahan1,aconfig.adm_tambahan2)),IIF(clDaftar='01',aconfig.adm_tambahan1,aconfig.adm_tambahan2),0)
					ELSE
						laArray(i,3) = IIF(!ISNULL(IIF(clDaftar='01',aconfig.adm_tambahan3,aconfig.adm_tambahan4)),IIF(clDaftar='01',aconfig.adm_tambahan3,aconfig.adm_tambahan4),0)
					endif
					
				CASE laArray(i,2) = '18'  && hitung pendapatan lain-lain dari dealer
					IF clJenisKend = 'D1' OR clJenisKend ='R' && Jenis SEPEDA MOTOR, SPM R3, SEPEDA MOTOR R4
						laArray(i,3) = IIF(!ISNULL(aconfig.pendapatan_2),aconfig.pendapatan_2,0)
					ELSE
						DO case
							CASE clJenisKend  = 'A' OR clJenisKend  = 'B' OR clJenisKend  = 'G' OR (clJenisKend  = 'F' AND (clJenis='301'or clJenis='302'or clJenis='303'or clJenis='304'or clJenis='305' OR clJenis='306'))
								laArray(i,3) = IIF(!ISNULL(aconfig.pendapatan_4a),aconfig.pendapatan_4a,0)
							CASE clJenisKend = 'C' OR clJenis='301'or clJenis='302'or clJenis='303'or clJenis='304'or clJenis='305' OR clJenis='306'
								laArray(i,3) = IIF(!ISNULL(aconfig.pendapatan_4b),aconfig.pendapatan_4b,0)
							CASE clJenisKend = 'D' OR clJenisKend  = 'E'
								laArray(i,3) = IIF(!ISNULL(aconfig.pendapatan_4c),aconfig.pendapatan_4c,0)
							OTHERWISE
								laArray(i,3) = IIF(!ISNULL(aconfig.pendapatan_4a),aconfig.pendapatan_4a,0)
						endcase
					endif
				
			ENDCASE 
		ENDIF 
	ENDFOR 
	
ENDIF 
 
*\ update data array ke array simpan
j = 1
lnJumlah = 0
For i = 1 To 10
	If laArray(i,3) > 0 Or laArray(i,4) > 0
		laSave(j,1) = laArray(i,1)
		laSave(j,2) = laArray(i,2)
		laSave(j,3) = laArray(i,3)
		laSave(j,4) = laArray(i,4)

		j = j+1
		lnJumlah = lnJumlah+(laArray(i,3)+laArray(i,4))
	Endif
Endfor

For i = 1 To 10
	If Empty(laSave(i,1))
		laSave(i,1) = Space(3)
		laSave(i,2) = Space(2)
		laSave(i,3) = 0
		laSave(i,4) = 0
	Endif
Endfor

*** Proses Simpan ke PKB_Biasa

csql1 = 'insert into pkb_biasa(no_dft , tgl_dft , jumlah ,'
csql2 = ''
csql3=''
csql4=''
csql5= 'values (?clno_dft,?dltgl_dft,?lnjumlah, '
csql6=''
csql7=''
csql8=''

For i = 1 To 10
	ctextj ='jenis'+Alltrim(Str(i))+','
	ctextP ='pokok'+Alltrim(Str(i))+','
	ctextD ='denda'+Alltrim(Str(i))

	cisij = '?lasave('+Alltrim(Str(i))+',1),'
	cisiP = '?lasave('+Alltrim(Str(i))+',3),'
	cisid = '?lasave('+Alltrim(Str(i))+',4)'

	If i <10
		ctextD=ctextD+','
		cisid=cisid+','
	Else
		ctextD=ctextD+')'
		cisid=cisid+')'
	Endif

	csql2 = csql2+ctextj
	csql3 = csql3+ctextP
	csql4 = csql4+ctextD
	csql6= csql6+cisij
	csql7= csql7+cisiP
	csql8= csql8+cisid
Next
cstr = ''

For k = 1 To 8
	ctext = 'csql'+Alltrim(Str(k))
	cstr = cstr+&ctext
NEXT

asq = SQLExec(gnconnhandle,cstr)
If asq<0
	Messagebox('error Update PKB_Biasa',48,'Error')
	cek_error()
ELSE
	hist_pkb_biasa(clTindakan,clno_dft,dltgl_dft)
endif			
			



