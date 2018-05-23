Lparameters cDaftar,cno_dft,dtgl_dft,dtgl_faktur,dtgl_notice,cJenis,cMerk,cTipe,cTahun,cPlat,cGuna,cTindakan,nTunggak,lcjr,cke,;
	        cc,cdump,osd_swd,tgl_sk,dosd_notice,dsd_notice,NTUNGGAK_BULAN
	        
If Parameters() # 22
	Messagebox('Parameter Kurang !',48,'Parameter')
	Return
Endif

Dimension laArray(10,4), laSave(10,4)

Local clDaftar,clno_dft,dltgl_dft,dltgl_faktur,dltgl_notice,clJenis,clMerk,clTipe,clTahun,lcPlat,lcSWDKLLJ,cdump,dosd_notice,;
	dsd_notice
Local lnDasar,lnNilai,lnPkb_Bs,lnPkb_Um,lnPajak,clJenisKend,d_pkb,d_swdkllj,clGuna,clTindakan,nlTunggak


lckdjrm       = lcjr
clDaftar      = cDaftar
clno_dft      = cno_dft
dltgl_dft     = pdtgl_trans &&dtgl_dft
dltgl_faktur  = dtgl_faktur
dltgl_notice  = dtgl_notice
dltgl_notice2 = dtgl_notice
dlsd_notice   = dsd_notice
clJenis       = cJenis
clMerk        = cMerk
clTipe        = cTipe
clTahun       = cTahun
lcPlat        = cPlat
clTindakan    = cTindakan
clGuna        = cGuna
nlTunggak     = Iif(nTunggak>=5,5,nTunggak) && tahun tunggakan max 4 tahun
nlTunggakPkb  = nlTunggak && tahun tunggakan pkb
nke           = cke
besarcc       = cc


For i = 1 To 10
	laArray(i,1) = Space(3)
	laArray(i,2) = Space(2)
	laArray(i,3) = 0
	laArray(i,4) = 0
Endfor

Store '' To lcSWDKLLJ,clJenisKend
Store 0 To lnPajak,d_pkb,d_swdkllj,lnDasar,lnNilai,lnPkb_Bs,lnPkb_Um

lplat = Iif(lcPlat='MERAH' And clGuna = '3',.T.,.F.)

If cdump && dumb

	* tunggakan swdkllj
	If dtgl_dft > osd_swd
		nlTunggak	= cek_tgl(dtgl_dft,osd_swd,'Y')
		nlTunggak   = Iif(nlTunggak>=5,5,nlTunggak)
	Else
		nlTunggak   = 0  
	Endif

	nlTunggakPkb	= date_diff(tgl_sk,dtgl_dft,'Y')
	nlTunggakPkb    = Iif(nlTunggakPkb>=5,5,nlTunggakPkb)

Endif



csql  = "SELECT * FROM aconfig "
nExec = SQLExec(gnconnhandle,csql,'aconfig')

* Batas denda pkb dan swd
csq = 'select * from batas_denda'
asg	= SQLExec(gnconnhandle,csq,'bts_denda')

If asg < 0
	=Messagebox('error get bts_denda')
	cek_error()
Else
	Select bts_denda
	d_pkb = bts_pkb
	d_swdkllj = bts_swdkllj
Endif


*\ ambil jenis kendaraan
csql = 'SELECT * FROM ajenis WHERE jenis = ?clJenis'
asg  = SQLExec(gnconnhandle,csql,'rst_jenis')

If asg > 0
	If Reccount()>0
		clJenisKend = Iif(!Isnull(rst_jenis.kend),rst_jenis.kend,'')
	Endif
ENDIF


clTipe = Iif(Alltrim(clJenis) # Alltrim(Left(clTipe,3)),Alltrim(clJenis)+Alltrim(Substr(clTipe,4,9)),clTipe)

*\ ambil dasar PKB
csql = 'select * from apkb where jenis=?clJenis and kd_merk=?clMerk and tipe =?clTipe and th_buat = ?clTahun'
asg  = SQLExec(gnconnhandle,csql,'rst_pkb')
If asg < 0
	Messagebox('error get Apkb',48,'Error')
	cek_error()
	Return
ENDIF

llktm   = .T.

*===================================================================================================================================================================
clTahun = Val(clTahun)
th_baru = ''
*===================================================================================================================================================================


*!*	If Reccount('rst_pkb')>0

*!*		Select rst_pkb
*!*		lnNilai = nilai_jual

*!*	Else && kalo tidak ketemu tipenya maka di cari bukan berdasarkan tahun
*!*		
*!*		csql = 'select * from apkb where jenis=?clJenis and kd_merk=?clMerk and tipe =?clTipe order by th_buat'
*!*		asg  = SQLExec(gnconnhandle,csql,'rst_pkb')

*!*		If asg < 0
*!*			Messagebox('error get Apkb',48,'Error')
*!*			cek_error()
*!*			Return
*!*		Endif
*!*		
*!*		clTahun = Val(clTahun)
*!*		
*!*		If Reccount('rst_pkb') > 0

*!*			Select rst_pkb

*!*			Go Top
*!*			th_lama1   = Val(th_buat)
*!*			njkb_lama1 = nilai_jual

*!*			If Reccount('rst_pkb') > 1
*!*				Skip
*!*				njkb_lama2 = nilai_jual
*!*			Else
*!*				njkb_lama2 = nilai_jual+1
*!*			Endif

*!*			Go Bottom
*!*			th_baru   = Val(th_buat)
*!*			njkb_baru = nilai_jual

*!*			Do Case
*!*			Case clTahun > th_baru &&tipe tahun terbaru
*!*				Do While .T.
*!*					If clTahun <= th_baru
*!*						Exit
*!*					Endif
*!*					th_baru = th_baru + 1
*!*					njkb_baru = pembulatan(njkb_baru + (0.05 * njkb_baru))
*!*					lnNilai = njkb_baru
*!*				Enddo

*!*			Case clTahun < th_lama1 && tipe tahun tua / lama
*!*				If njkb_lama1 # njkb_lama2
*!*					For i = 1 To 5
*!*						If clTahun = th_lama1
*!*							Exit
*!*						Endif
*!*						th_lama1 = th_lama1-1
*!*						njkb_lama1 = pembulatan(njkb_lama1 - (0.05 * njkb_lama1))
*!*						lnNilai = njkb_lama1
*!*					Endfor
*!*				Else
*!*					lnNilai = njkb_lama1
*!*				Endif
*!*			
*!*			Otherwise

*!*				th_baru1 = th_baru
*!*				Do While .T.
*!*					If clTahun = th_baru1 Or Bof()
*!*						Exit
*!*					Endif
*!*					njkb_baru = nilai_jual
*!*					th_baru1 = th_baru1 - 1
*!*					Skip - 1
*!*					If Val(th_buat) # th_baru1
*!*						For i = 1 To 5
*!*							njkb_baru = pembulatan(njkb_baru - (0.05 * njkb_baru))
*!*							lnNilai = njkb_baru
*!*							If clTahun = th_baru1
*!*								Exit
*!*							ENDIF 
*!*							th_baru1 = th_baru1 - 1
*!*						Endfor
*!*						Exit
*!*					Endif
*!*				Enddo
*!*			Endcase
*!*		Else
*!*			bobot    = 0
*!*			lnNilai  = 0
*!*			lnPkb    = 0
*!*			llktm    = .F.
*!*		Endif
*!*	ENDIF


*===================================================================================================================================================================
If Reccount('rst_pkb') > 0

	Select rst_pkb
	lnNilai = nilai_jual

Else && kalo tidak ketemu tipenya maka di cari bukan berdasarkan tahun


	csql = 'select * from apkb where jenis=?clJenis and kd_merk=?clMerk and tipe =?clTipe order by th_buat'
	asg  = SQLExec(gnconnhandle,csql,'rst_pkb')

	If asg < 0
		Messagebox('error get Apkb',48,'Error')
		cek_error()
		Return
	Endif


	If Reccount('rst_pkb') > 0

		Select rst_pkb

		Go Top
		th_lama1   = Val(th_buat)
		njkb_lama1 = nilai_jual

		nmapkb=Alltrim(rst_pkb.ket)

		If Reccount('rst_pkb') > 1
			Skip
			njkb_lama2 = nilai_jual
		Else
			njkb_lama2 = nilai_jual+1
		Endif

		Go Bottom
		th_baru   = Val(th_buat)
		njkb_baru = nilai_jual

		Do Case

		Case clTahun > th_baru &&tipe tahun terbaru

			For i = 1 To 5

				If clTahun = th_baru
					Exit
				Endif

				th_baru   = th_baru + 1
				njkb_baru = pembulatan(njkb_baru + (0.05 * njkb_baru))
				lnNilai   = njkb_baru

			Endfor

		Case clTahun < th_lama1 && tipe tahun tua / lama

			For i = 1 To 5

				If clTahun = th_lama1
					Exit
				Endif

				th_lama1   = th_lama1 - 1
				njkb_lama1 = pembulatan( njkb_lama1 - (0.05 * njkb_lama1) )
				lnNilai    = njkb_lama1

			Endfor

		Otherwise

			Do While .T.

				If clTahun = th_baru
					Exit
				Endif

				th_baru   = th_baru - 1
				njkb_baru = pembulatan(njkb_baru - (0.05 * njkb_baru))
				lnNilai   = njkb_baru

			Enddo

		Endcase

	Else

		bobot    = 0
		lnNilai  = 0
		lnPkb    = 0
		llktm    = .F.

	ENDIF

ENDIF 
*===================================================================================================================================================================



DO CASE 
Case clJenisKend= 'H'
	nk = 0.002 && alat berat
Case  clGuna = '4' Or clGuna = '6' Or clGuna = '8' Or lcPlat = 'MERAH'
	*merah = njkb * bobot * 0.005
	nk = 0.005
Case lcPlat = 'KUNING' AND nke = 1
	*mobil beban = njkb * bobot * 0.008 dan mobil penumpang = njkb * bobot * 0.006
	nk = Iif(clJenisKend= 'F' Or clJenisKend ='G',0.008, 0.006)
Case lcPlat = 'HITAM' And nke = 2
	&& plat hitam = njkb * bobot * 0.02
	nk = 0.02
Case lcPlat = 'HITAM' And nke = 3
	&& plat hitam = njkb * bobot * 0.025
	nk = 0.025
Case lcPlat = 'HITAM' And nke = 4
	&& plat hitam = njkb * bobot * 0.03
	nk = 0.03
Case lcPlat = 'HITAM' And nke >= 5
	&& plat hitam = njkb * bobot * 0.035
	nk = 0.035
Case lcPlat = 'KUNING' AND clguna='2' AND nke = 2
	*mobil beban = njkb * bobot * 0.008 dan mobil penumpang = njkb * bobot * 0.006
	nk = Iif(clJenisKend= 'F' Or clJenisKend ='G',0.5 * 0.02, 0.3 * 0.02)
Case lcPlat = 'KUNING' AND clguna='2' AND nke = 3
	*mobil beban = njkb * bobot * 0.008 dan mobil penumpang = njkb * bobot * 0.006
	nk = Iif(clJenisKend= 'F' Or clJenisKend ='G',0.5 * 0.025, 0.3 * 0.025)	
Case lcPlat = 'KUNING' AND clguna='2' AND nke = 4
	*mobil beban = njkb * bobot * 0.008 dan mobil penumpang = njkb * bobot * 0.006
	nk = Iif(clJenisKend= 'F' Or clJenisKend ='G',0.5 * 0.03, 0.3 * 0.03)	
Case lcPlat = 'KUNING' AND clguna='2' AND nke >= 5
	*mobil beban = njkb * bobot * 0.008 dan mobil penumpang = njkb * bobot * 0.006
	nk = Iif(clJenisKend= 'F' Or clJenisKend ='G',0.5 * 0.035, 0.3 * 0.035)		
Otherwise
	&& plat hitam = njkb * bobot * 0.015
	nk = 0.015
ENDCASE 

*lnPkb  = pembulatan(lnNilai * bobot * nk)

DO CASE  &&plat kuning dihitung kuning atau hitam
CASE (TRIM(lcPlat) = 'KUNING') 
    IF (clGuna<>'1')
		persen=0.015	
	ELSE 
		persen=0.009&&persen=0.0075	
    ENDIF 	
CASE (TRIM(lcPlat) = 'MERAH')
	persen=0.0075
case clGuna='4' or clGuna='6' or clGuna='8' or clGuna='7'
	persen = 0.0075
CASE (TRIM(lcPlat) = 'HITAM')
	persen=0.015	

	IF besarcc>250 AND nke>=2
		progresif=(nke-1)*0.005
		persen=persen+progresif
		persen=IIF(persen>0.05,0.05,persen)
	ENDIF 
	
ENDCASE 


selisih_tahun = 0
thnini        = YEAR(pdTgl_Trans) &&motor > 25 tahun
selisih_tahun = thnini-VAL(cTahun)

DO CASE 
	CASE selisih_tahun>=25 And (clJenis='701' Or clJenis='702')
		persen=0.0075
ENDCASE 

lnPkb        = pembulatan(lnNilai * bobot * persen)
lnPkb_Asal   = pembulatan(lnNilai * bobot * persen)
lnPkb_kuning = pembulatan(lnNilai * bobot * Iif(clJenisKend= 'F' Or clJenisKend ='G',0.5 * persen , 0.3 * persen) )  &&pkb kuning
lnPkb_merah  = pembulatan(lnNilai * bobot * persen)

DO CASE 

	CASE lcPlat = 'KUNING' 

		lnPkb = lnPkb_Kuning
	    IF (clGuna<>'1')
			lnPkb = lnPkb_asal
	    ENDIF 	

	CASE lcPlat = 'MERAH'
		lnPkb = lnPkb_merah

ENDCASE 				


golswd = golswdkllj(clJenisKend, besarcc, lcPlat, clGuna, lckdjrm)

csql = 'SELECT * FROM SWDKLLJ where gol=?golswd'
asg  = SQLExec(gnconnhandle,csql,'rst_swd')

If asg > 0
	
	If Reccount()>0
	
		If dltgl_dft < Ctod('27/03/2008')
			lnSwd_pk = pokok_old
			lnSwd_lg = leges_old
			For i = 1 To Iif(clDaftar='01',1,11)
				lnPro = 'lnProrata'+Allt(Str(i))
				lnBln = 'bln_old'+Allt(Str(i))
				&lnPro = &lnBln
			Endfor
		Else
			lnSwd_pk = pokok_new
			lnSwd_lg = leges_new
			For i = 1 To Iif(clDaftar='01',1,11)
				lnPro = 'lnProrata'+Allt(Str(i))
				lnBln = 'bln_new'+Allt(Str(i))
				&lnPro = &lnBln
			Endfor
		Endif
	
	Else
	
		lnSwd_pk = 0
		lnSwd_lg = 0
		For i = 1 To Iif(clDaftar='01',1,11)
			lnPro = 'lnProrata'+Allt(Str(i))
			&lnPro = 0
		Endfor
	Endif
Endif


*\ tentukan batas waktu kena denda BBNKB1 Batas 14 Hari dari tanggal Faktur Kendaraan Baru


ldBatas = Iif(clDaftar='01',dtgl_faktur + 14,dltgl_dft)
lnCount = 0

csql = 'select * from mslibur'
asq  = SQLExec(gnconnhandle,csql,'cs_libur')

If asq < 0
	Messagebox('error get libur')
Else

	Select cs_libur
	Do While .T.
		llLibur = .F.

		* hari minggu  libur
		If Dow(ldBatas) = 1
			llLibur = .T.
		Endif

		* hari libur nasional
		ldbatas1 = conv_tanggal(ldBatas)
		csql = 'select * from mslibur where tgl = ?ldbatas1 '
		asq  = SQLExec(gnconnhandle,csql,'cari_libur')
		
		If asq < 0
			Messagebox('error get libur')
		Else
			If Reccount('cari_libur')>0
				llLibur = .T.
			Endif
		Endif

		If llLibur
			ldBatas = ldBatas + 1
		Else
			If lnCount < 1
				ldBatas = ldBatas
				lnCount = lnCount + 1
			Else
				Exit
			Endif
		Endif
	ENDDO
	
Endif

* plat merah terkena pajak setelah tgl 01/04/2012
*MESSAGEBOX(TRANSFORM(sts_tunggak_merah))

If lcPlat = 'MERAH'
*!*	 a=year(dtgl_notice)
*!*	 b=year(date())
*!*	 if b-a>=5

*!*	 endif
*!*	 messagebox(b-a)
	batas='01/01/2000'
	IF sts_tunggak_merah=1
		batas='01/01/2000'
	ENDIF 
	mulaiDenda=CTOD(batas)
	mnotice=dltgl_notice

	IF (dltgl_notice < CTOD(batas))
	
		dltgl_notice  = plusdate(dsd_notice,(-1*nTunggak))
		dltgl_notice2 = dltgl_notice
		nlTunggakPkb=0 

		For i = 1 To nlTunggak
			If dltgl_notice < CTOD(batas)
				nlTunggakPkb = 0
			Else
				nlTunggakPkb = nlTunggakPkb+1
			ENDIF

			IF nlTunggakPkb =1
			   mulaiDenda=dltgl_notice
			ENDIF 
			
			dltgl_notice = plusdate(dltgl_notice,1)
		Endfor


	ELSE
		mulaiDenda=dltgl_notice	
		*MESSAGEBOX('2 '+TRANSFORM(mulaiDenda))
	ENDIF 



	IF sts_tunggak_merah=1
		SQLExec(gnconnhandle,'SELECT TIMESTAMPDIFF(MONTH,?mulaiDenda,DATE_ADD(?pdtgl_ttp_2,INTERVAL ?dispensasi DAY)) AS jbulan','cbulandenda')
		jbulan=val(cbulandenda.jbulan)
		persenblnbrjln=VAL(jbulan)*2
		nbulan = VAL(cbulandenda.jbulan)

		SQLExec(gnconnhandle,'SELECT TIMESTAMPDIFF(YEAR,?mulaiDenda,DATE_ADD(?pdtgl_ttp_2,INTERVAL ?dispensasi DAY)) AS jtahun','ctahundenda')
		thnDenda=nlTunggakPkb 	
		*MESSAGEBOX('1:'+TRANSFORM(jbulan ))
		*thnDenda=CEILING(val(jbulan)/12)	
	ELSE
		SQLExec(gnconnhandle,'SELECT TIMESTAMPDIFF(MONTH,?mulaiDenda,DATE_ADD(?pdtgl_ttp_2,INTERVAL ?dispensasi DAY)) AS jbulan','cbulandenda')
		jbulan=VAL(cbulandenda.jbulan)
		persenblnbrjln=VAL(jbulan)*2
		nbulan = VAL(cbulandenda.jbulan)
		
		hariAwal=DAY(mulaiDenda)
		hariAhir=DAY(pdtgl_ttp_2)+dispensasi 

		blnAwal=MONTH(mulaiDenda)
		blnAhir=month(pdtgl_ttp_2)
		
		IF (hariAhir>hariAwal) &&AND (blnAwal=blnAhir)
		*IF hariAhir<hariAwal
			nbulan=nbulan+1
			jbulan=VAL(jbulan)+1
		ENDIF 
		
		thnDenda=floor((nbulan)/12)							
		*MESSAGEBOX('2:'+TRANSFORM(jbulan))
		*MESSAGEBOX('2')						
	ENDIF 

	IF (mnotice < CTOD(batas))
		thnDenda=thnDenda-1
	ENDIF 
		
Endif


*\ hitung pajak tunggak
csql = 'Select * FROM Ajpajak WHERE j_pajak=?clDaftar'
asg  = SQLExec(gnconnhandle,csql,'rst_pajak')
If asg < 0
	Messagebox('error get APajak',48,'Error')
	cek_error()
Else

	For i = 1 To 10

		Select rst_pajak
		cf = 'jns'+Alltrim(Str(i))
		cN = &cf

		csql = 'select * from Ajsetor where jsetor=?cN'
		SQLExec(gnconnhandle,csql,'rst_jsetor')

		laArray(i,1) = Iif(Isnull(cN),'',cN)
		laArray(i,2) = rst_jsetor.jenis

		If !Empty(laArray(i,1))
			
			DO CASE 
			
			CASE laArray(i,2) = '13'  && Hitung Pokok PKB
				
				lnPajak = lnPkb * nlTunggakPkb 
				laArray(i,3) = pembulatan( lnPajak )
				
				IF clDaftar = '34'
					laArray(i,3) = 0
				ENDIF 

			CASE laArray(i,2) = '23'  && Hitung Denda PKB
				
				*===================================================================================================================================================
				If lcPlat <> 'MERAH'

					nHari   = date_diff(dltgl_notice,pdtgl_ttp_2,'D')
					nTahun  = date_diff(dltgl_notice,pdtgl_ttp_2,'Y') 
					nBulan  = date_diff(dltgl_notice,pdtgl_ttp_2,'M')
					
					*===================================================================================================================================================
					nHari_tgk   = date_diff(dltgl_notice,pdtgl_ttp_2,'D')
					nTahun_tgk  = date_diff(dltgl_notice,pdtgl_ttp_2,'Y') 
					nBulan_tgk  = date_diff(dltgl_notice,pdtgl_ttp_2,'M')
					*===================================================================================================================================================

					nbulan  = (nTahun*12) + IIF(nhari > 0,nbulan+1,nbulan)
					nbulan  = IIF(nbulan>24,24,nbulan) - bulan_denda
					
					IF status25 = 1
						nilai = (0.02*nbulan)
					ELSE
						nilai = 0.25 + (0.02*nbulan)
					ENDIF 					
									
					njkb_denda    = IIF(njkb_denda=0,nBulan+bulan_denda,njkb_denda)
					nlTunggakPkb  = IIF(bulan_denda=0 and nbulan > 13, nlTunggakPkb-1, nlTunggakPkb)

					lnPajak       =  nilai * ((IIF(nbulan+bulan_denda<=12,0,nlTunggakPkb) * lnPkb)+ lnPkb)
														
					*===================================================================================================================================================
					IF  ldbatas_tgk < pdtgl_ttp_2
					
						IF clDaftar <> '34'
					
							DO CASE 
								CASE nTahun_tgk = 2 AND nHari_tgk >= 1  
									lnPajak       =  nilai * (IIF(nbulan+bulan_denda<=12,0,3) * lnPkb)
								CASE nTahun_tgk = 3 AND nHari_tgk >= 1  
									lnPajak       =  nilai * (IIF(nbulan+bulan_denda<=12,0,4) * lnPkb)
								CASE nTahun_tgk = 4 AND nHari_tgk >= 1  
									lnPajak       =  nilai * (IIF(nbulan+bulan_denda<=12,0,5) * lnPkb)
							ENDCASE 	
						
						ENDIF 
					
					ENDIF 
					*===================================================================================================================================================
					
										
					*===================================================================================================================================================
					nTahun_5_taon = cek_tgl(dltgl_notice, plusdate(pdtgl_ttp_2,1),'Y') 
					IF nTahun_5_taon  >= 5
						lnPajak       =  nilai * ((IIF(nbulan+bulan_denda<=12,0,4) * lnPkb)+ lnPkb)
					ENDIF 
					*===================================================================================================================================================
					
					laArray(i,4)  = Iif(nlTunggakPkb = 0,0,pembulatan(lnPajak))
					
				ENDIF 	
				*===================================================================================================================================================


				*===================================================================================================================================================
				If lcPlat = 'MERAH'
				
					IF nlTunggak >= 1   
						
*!*							IF dltgl_notice2 > Ctod('01/01/2013')
*!*								nHari   = date_diff(dltgl_notice2 ,pdtgl_ttp_2,'D')
*!*								nTahun  = date_diff(dltgl_notice2 ,pdtgl_ttp_2,'Y') 
*!*								nBulan  = date_diff(dltgl_notice2 ,pdtgl_ttp_2,'M')
*!*								
*!*								*===================================================================================================================================================
*!*								nHari_tgk   = date_diff(dltgl_notice2 ,pdtgl_ttp_2,'D')
*!*								nTahun_tgk  = date_diff(dltgl_notice2 ,pdtgl_ttp_2,'Y') 
*!*								nBulan_tgk  = date_diff(dltgl_notice2 ,pdtgl_ttp_2,'M')
*!*								*===================================================================================================================================================
*!*						
*!*							ELSE
*!*							
*!*								nHari   = date_diff(Ctod('01/01/2013'),pdtgl_ttp_2,'D')
*!*								nTahun  = date_diff(Ctod('01/01/2013'),pdtgl_ttp_2,'Y') 
*!*								nBulan  = date_diff(Ctod('01/01/2013'),pdtgl_ttp_2,'M')
*!*								
*!*								*===================================================================================================================================================
*!*								nHari_tgk   = date_diff(Ctod('01/01/2013'),pdtgl_ttp_2,'D')
*!*								nTahun_tgk  = date_diff(Ctod('01/01/2013'),pdtgl_ttp_2,'Y') 
*!*								nBulan_tgk  = date_diff(Ctod('01/01/2013'),pdtgl_ttp_2,'M')
*!*								*===================================================================================================================================================
*!*							
*!*							ENDIF 
*!*							
*!*						
*!*							If nBulan = 0
*!*								nBulan = Iif(nHari >=1, nBulan+1, nBulan) && terlambat 1 hari pada bulan 1
*!*							Else
*!*								nBulan = Iif(nHari >=1, nBulan+1, nBulan) && terlambat 1 hari pada bulan 2 dst
*!*							Endif
						
						*!*							*===================================================================================================================================================
						*!*							nHari_tgk   = date_diff(Ctod('01/01/2013'),dltgl_notice,'D')
						*!*							nTahun_tgk  = date_diff(Ctod('01/01/2013'),,'Y') 
						*!*							nBulan_tgk  = date_diff(Ctod('01/01/2013'),dltgl_notice,'M')
						*!*							*===================================================================================================================================================

						*nilai     =  0.25 + ( 0.02 * nbulan )
						nilai     =  (Iif((nbulan*0.02)+0.25>=0.73,0.73,(nbulan*0.02)+0.25))
									
															
						IF sts_tunggak_merah=1
							nilai=0.25 +(persenblnbrjln/100)
							lnPajak   =  nilai * (lnPkb*thnDenda)		
							*MESSAGEBOX('1:'+TRANSFORM(nilai))
				
						ELSE
							*lnPajak   =  nilai * (lnPkb*nlTunggakPkb)
							lnPajak   =  nilai * (lnPkb*thnDenda)					
							*MESSAGEBOX('2:'+TRANSFORM(thnDenda))
						ENDIF 			
							
						laArray(i,4)  = Iif(nlTunggakPkb = 0,0,pembulatan(lnPajak))
					
					ELSE
						laArray(i,4)  = Iif(nlTunggakPkb = 0,0,0)
					ENDIF 
				
					
				ENDIF 	
				*===================================================================================================================================================
				
				IF clDaftar = '34'
					laArray(i,4)  = 0
				ENDIF 

			
			CASE laArray(i,2) = '14'  && hitung pokok swdkllj
			
				DO CASE 
					CASE lcPlat <> 'MERAH'
						lnPajak       = lnSwd_pk + lnSwd_lg
						laArray(i,3)  = lnPajak * nlTunggak  && laArray(i,3)+lnPajak
					CASE lcPlat = 'MERAH'				
						lnPajak       = lnSwd_pk + lnSwd_lg
						laArray(i,3)  = lnPajak * nlTunggak  && laArray(i,3)+lnPajak
				ENDCASE 
				
				IF clDaftar = '34'
					laArray(i,3)  = 0
				ENDIF 
	

			CASE laArray(i,2) = '24'  && hitung denda swdkllj
			
				DO CASE 
					
					CASE lcPlat <> 'MERAH'
						
						*===================================================================================================================================================
						nHari_tgk   = date_diff(dltgl_notice,pdtgl_ttp_2,'D')
						nTahun_tgk  = date_diff(dltgl_notice,pdtgl_ttp_2,'Y') 
						nBulan_tgk  = date_diff(dltgl_notice,pdtgl_ttp_2,'M')
						*===================================================================================================================================================
	
						laArray(i,4)  = Iif(lnSwd_pk > 100000,100000,lnSwd_pk) * nlTunggak

						IF  ldbatas_tgk > pdtgl_ttp_2 AND nlTunggak >=2
					
							*===================================================================================================================================================
							DO CASE 
								CASE nTahun_tgk = 2 AND nHari_tgk >= 1  
									laArray(i,4)  = Iif(lnSwd_pk > 100000,100000,lnSwd_pk) * 3
								CASE nTahun_tgk = 3 AND nHari_tgk >= 1  
									laArray(i,4)  = Iif(lnSwd_pk > 100000,100000,lnSwd_pk) * 4
								CASE nTahun_tgk = 4 AND nHari_tgk >= 1  
									laArray(i,4)  = Iif(lnSwd_pk > 100000,100000,lnSwd_pk) * 5
								CASE nTahun_tgk >= 5 AND nHari_tgk >= 1 
									laArray(i,4)  = Iif(lnSwd_pk > 100000,100000,lnSwd_pk) * 5
							ENDCASE 	
							*===================================================================================================================================================
						
						ENDIF 

					
					CASE lcPlat = 'MERAH'
					
						laArray(i,4)  = Iif(lnSwd_pk > 100000,100000,lnSwd_pk) * nlTunggak
				
				ENDCASE 
				
				IF clDaftar = '34'
					laArray(i,4)  = 0
				ENDIF 
			
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

Select temp

For i = 1 To 10
	
	cjns = laArray(i,1)
	npk  = laArray(i,3)
	ndnd = laArray(i,4)

	csql = 'select ket,LEFT(jenis,1) as iden from ajsetor where jsetor=?cJns'
	SQLExec(gnconnhandle,csql)
	cket = ket
	ciden = iden

	Select temp
	Do Case
	Case cjns = '02A' Or cjns = '02B' Or cjns = '06B' Or cjns = '06C'
		Locate For KODE = '001' &&bbn
		If ciden = '1'
			Replace pokok_t With npk,kd_as1 With cjns
		Else
			Replace denda_t With ndnd,kd_as2 With cjns
		Endif
	Case cjns = '01' Or cjns = '06A'
		Locate For KODE = '002' &&pkb
		If ciden = '1'
			Replace pokok_t With npk,kd_as1 With cjns
		Else
			Replace denda_t With ndnd,kd_as2 With cjns
		Endif
	Case cjns = '03' Or cjns = '06D'
		Locate For KODE = '003' && swd
		If ciden = '1'
			Replace pokok_t With npk,kd_as1 With cjns
		Else
			Replace denda_t With ndnd,kd_as2 With cjns
		Endif
	Case cjns = '04'
		Locate For KODE = '004' &&stnk
		Replace pokok_b With npk,kd_as1 With cjns
	Case cjns = '05'
		Locate For KODE = '005' &&tnk
		Replace pokok_t With npk,kd_as1 With cjns
	Case cjns = '08'
		Locate For KODE = '006' &&sp3
		Replace pokok_t With npk,kd_as1 With cjns
	Endcase

Endfor
