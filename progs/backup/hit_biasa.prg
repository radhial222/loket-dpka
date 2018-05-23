* 07-02-2011 09.51
*!*	SET STEP ON
Lparameters cDaftar, cno_dft, dtgl_dft, dtgl_faktur, dtgl_notice_sd, cJenis, cMerk, cTipe, ;
	cTahun, cPlat, cGuna, cTindakan, nDenda, ltetap, ckdjrm, cke, dtgl_notice,;
	cjns_dft2,cjns_dft3,cjns_dft4, dTGL_kwt,dTGL_FISKAL,cnilai_jual, ctgl_sk, cc, cBulanswd,dtglA

If Parameters() # 27
	Messagebox('Parameter Kurang !',48,'Parameter')
	Return
Endif

Dimension laArray (10,4), laSave (10,4), laSwd (2)

Local clDaftar1,clDaftar2,clDaftar3,clDaftar4,clno_dft, dltgl_dft, dltgl_faktur, dltgl_notice_sd, clJenis, clMerk, clTipe, clTahun, ;
	lcPlat, lcSWDKLLJ, dltgl_kuitansi, dltgl_fiskal
Local lnDasar, lnNilai, lnPkb_Bs, lnPkb_Um, lnPajak, clJenisKend, d_pkb, d_swdkllj, clGuna, clTindakan, nlDenda, nke,thnini

llpkb_nihil     = .F.  && tambahan

lckdjrm         = ckdjrm
clDaftar1       = cDaftar
clDaftar2       = cjns_dft2
clDaftar3       = cjns_dft3
clDaftar4       = cjns_dft4
clno_dft        = cno_dft
dltgl_dft       = dtgl_dft && pdtgl_trans
dltgl_faktur    = dtgl_faktur
dltgl_kuitansi	= dTGL_kwt
dltgl_fiskal	= dTGL_FISKAL
dltgl_notice	= dtgl_notice &&tgl notice
dltgl_notice_sd = dtgl_notice_sd && tgl notice s/d

clJenis         = cJenis
clMerk          = cMerk
clTipe          = cTipe
clTahun         = cTahun
lcPlat          = cPlat
clTindakan      = cTindakan
clGuna          = cGuna
besarcc			= cc
nlDenda         = nDenda && bulan
nke             = cke && untuk progresif -- seperti kendaraan yang ke
clnilai_jual	= cnilai_jual
cltgl_sk 		= ctgl_sk
clBulanswd		= cBulanswd

Store '' To lcSWDKLLJ, clJenisKend
Store 0  To lnPajak, d_pkb, d_swdkllj, lnDasar, lnNilai, lnPkb_Bs, lnPkb_Um

lplat = Iif( lcPlat='MERAH' And clGuna = '3',.T.,.F.)

csql  = "SELECT * FROM aconfig "
nExec = SQLExec(gnconnhandle,csql,'konfig')

* njkb lampiran 2
csql  = "SELECT * FROM lamp_2 where jenis_b = ?clJenis and jenis_a = ?cojenis order by tahun"
asg   = SQLExec(gnconnhandle,csql,'lamp_2')

If asg > 0

	If Reccount('lamp_2') > 0

		Go Top

		th_njkb_lamp2_tua 	= tahun
		njkb_lamp2_tua 		= harga

		Go Bottom

		th_njkb_lamp2_muda	= tahun
		njkb_lamp2_muda 	= harga

		Do Case

		Case clTahun < th_njkb_lamp2_tua
			njkb_lamp2 = njkb_lamp2_tua
		Case clTahun > th_njkb_lamp2_muda
			njkb_lamp2 = njkb_lamp2_muda
		Otherwise
			Scan For Between(clTahun,th_njkb_lamp2_tua,th_njkb_lamp2_muda)
				If clTahun = tahun && tahun sama
					njkb_lamp2 = harga
					Exit
				Endif
			Endscan

		Endcase

	Endif

Endif

njkb_tambah  = .F.

If clDaftar1 = '51' Or clDaftar2 = '51' Or clDaftar3 = '51' Or clDaftar4 = '51' && rubah bentuk

	rbh_btk    = .T.
	no_rbh_btk = 2

	If !Isnull(cojenis) Or Len(Alltrim(cojenis)) # 0

		If (cojenis = '301') Or  (cojenis = '351') Or (cojenis = '401') Or (cojenis ='514')

			clTipe      = Alltrim(clJenis) + Alltrim(Substr(clTipe,4,9))
			njkb_tambah = .T.

		Endif

	Endif

Else

	no_rbh_btk =  1
	rbh_btk    = .F.

Endif

*-------------------------------------------------------------------------------------------------------------------------------------------------------------------

csql = 'select * from apkb where jenis=?clJenis and kd_merk=?clMerk and tipe=?clTipe order by th_buat'
asg  = SQLExec(gnconnhandle,csql,'rst_pkb_cek_thn')

Select rst_pkb_cek_thn
Go Bottom

th_teratas   = Val(th_buat)

Select rst_pkb_cek_thn
Go Top

th_terbawah  = Val(th_buat)

Do Case

* kondisi tahun pembuatan di atas tahun yg paling baru yg ada pada njkb
Case Val(clTahun) > th_teratas

*\ ambil dasar PKB
	csql = 'select * from apkb where jenis=?clJenis and kd_merk=?clMerk and tipe=?clTipe and th_buat=?clTahun'
	asg  = SQLExec(gnconnhandle,csql,'rst_pkb')

	If asg < 0
		Messagebox('error get Apkb',48,'Error')
		cek_error()
		Return
	Endif

* kondisi tahun pembuatan di antara tahun terbaru dan terlama pada njkb
Case Val(clTahun) <= th_teratas And Val(clTahun) >= th_terbawah

*\ ambil dasar PKB
	csql = 'select * from apkb where jenis=?clJenis and kd_merk=?clMerk and tipe=?clTipe and th_buat=?clTahun'
	asg  = SQLExec(gnconnhandle,csql,'rst_pkb')

	If asg < 0
		Messagebox('error get Apkb',48,'Error')
		cek_error()
		Return
	Endif

* kondisi tahun pembuatan di bawah tahun terlama pada njkb
Case Val(clTahun) < th_terbawah

*\ ambil dasar PKB
	csql = 'select * from apkb where jenis=?clJenis and kd_merk=?clMerk and tipe=?clTipe and th_buat=?cltahun'
	asg  = SQLExec(gnconnhandle,csql,'rst_pkb')

	If asg < 0
		Messagebox('error get Apkb',48,'Error')
		cek_error()
		Return
	Endif

Endcase


*---------------------------------------------------------------------------------------------------------------------------------------------------------------


*\ ambil jenis kendaraan

csql = 'SELECT * FROM ajenis WHERE jenis = ?clJenis'
asg  = SQLExec(gnconnhandle,csql,'rst_jenis')

If asg > 0

	If Reccount() > 0
		clJenisKend = Iif(!Isnull(rst_jenis.kend),rst_jenis.kend,'')
	Endif

Endif

llktm   = .T.
clTahun = Val(clTahun)
th_baru = ''


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

Endif

njkb1   = lnNilai
lnNilai = lnNilai

Do Case

	Case clJenisKend= 'H'
		nk = 0.002 && alat berat
	Case  clGuna = '4' Or clGuna = '6' Or clGuna = '8' Or lcPlat = 'MERAH'
	Case lcPlat = 'KUNING'
		*mobil beban = njkb * bobot * 0.008 dan mobil penumpang = njkb * bobot * 0.006
		nk = Iif(clJenisKend= 'F' Or clJenisKend ='G',0.8 * 0.0075 , 0.6 * 0.0075)
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

Endcase


DO CASE  &&plat kuning dihitung kuning atau hitam

	CASE (TRIM(lcPlat) = 'KUNING') 

	    IF (clGuna<>'1')
			persen=0.015	
		ELSE 
			persen=0.0075	
	    ENDIF 	
	    
	    IF clGuna = '6'
			persen=0.0075	
		ENDIF  

	CASE (TRIM(lcPlat) = 'MERAH')
		persen = 0.0075

	CASE (TRIM(lcPlat) = 'HITAM')

		IF clGuna = '6'
			persen=0.0075	
		ELSE 
			persen=0.015	
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
lnPkb_kuning = pembulatan(lnNilai * bobot * Iif(clJenisKend= 'F' Or clJenisKend ='G',0.8 * persen , 0.6 * persen) )  &&pkb kuning
lnPkb_merah  = pembulatan(lnNilai * bobot * persen)

njkb_hitung  = Transform(lnNilai,'999,999,999')+' x '+Transform(bobot)+' x '+Transform(persen*100,"999.99")+'% = '+Transform(lnPkb,'999,999,999')


DO CASE 
CASE lcPlat = 'KUNING'

	lnPkb = lnPkb_kuning
	If (clJenisKend= 'F' Or clJenisKend ='G')
		njkb_hitung=Transform(lnNilai,'999,999,999')+' x '+Transform(bobot)+' x '+Transform(persen*100,"999.99")+'% x 80% = '+Transform(lnPkb,'999,999,999')
	Else
		njkb_hitung=Transform(lnNilai,'999,999,999')+' x '+Transform(bobot)+' x '+Transform(persen*100,"999.99")+'% x 60% = '+Transform(lnPkb,'999,999,999')
	ENDIF
	
    IF (clGuna<>'1')
		lnPkb = lnPkb_asal
		njkb_hitung=Transform(lnNilai,'999,999,999')+' x '+Transform(bobot)+' x '+Transform(persen*100,"999.99")+'% = '+Transform(lnPkb,'999,999,999')
    ENDIF 	
	
CASE lcPlat = 'MERAH'

	lnPkb       = lnPkb_merah
	njkb_hitung = Transform(lnNilai,'999,999,999')+' x '+Transform(bobot)+' x '+Transform(persen*100,"999.99")+'% = '+Transform(lnPkb,'999,999,999')

ENDCASE 

lnNilai_tanpa_bobot = lnNilai
lnNilai             = lnNilai * bobot

For nrbh = 1 To no_rbh_btk

	If rbh_btk

		If nrbh = 1
			clJenis = cojenis
			clGuna  = Alltrim(lst_header.okd_guna)
		Else
			clJenis = cJenis
			clGuna  = cGuna
		Endif

	Endif

	*\ ambil jenis kendaraan
	csql = 'SELECT * FROM ajenis WHERE jenis = ?clJenis'
	asg  = SQLExec(gnconnhandle,csql,'rst_jenis')

	If asg > 0

		If Reccount()>0
			clJenisKend = Iif(!Isnull(rst_jenis.kend),rst_jenis.kend,'')
		Endif

	Endif


	golswd = golswdkllj(clJenisKend, besarcc, lcPlat, clGuna, lckdjrm)

	csql   = 'SELECT * FROM SWDKLLJ where gol=?golswd'
	asg    = SQLExec(gnconnhandle,csql,'rst_swd')

	If asg > 0

		If Reccount() > 0

			If dltgl_dft < Ctod('27/03/2008')

				laSwd(nrbh) = pokok_old+leges_old
				lnSwd_pk    = pokok_old
				lnSwd_lg    = leges_old
				lnnew       = bln_new1

				For i = 1 To Iif(clDaftar1='01',1,11)
					lnPro  = 'lnProrata'+Allt(Str(i))
					lnBln  = 'bln_old'+Allt(Str(i))
					&lnPro = &lnBln
				Endfor

			Else

				laSwd(nrbh) = pokok_new+leges_new
				lnSwd_pk    = pokok_new
				lnSwd_lg    = leges_new
				lnnew       = bln_new1

				For i = 1 To Iif(clDaftar1='01',1,11)
					lnPro  = 'lnProrata'+Allt(Str(i))
					lnBln  = 'bln_new'+Allt(Str(i))
					&lnPro = &lnBln
				Endfor

			Endif

		Else

			lnSwd_pk = 0
			lnSwd_lg = 0
			lnnew    = bln_new1

			For i = 1 To Iif(clDaftar1='01',1,11)
				lnPro = 'lnProrata'+Allt(Str(i))
				&lnPro = 0
			Endfor

		Endif

	Endif

Endfor 	&&nrbh

If cDaftar <> '01'
	lnnew = 0
Endif

*--------------------------------------------------------------------------------------------------------------------------------------------------------------

nHari   = cek_tgl(dltgl_notice,pdtgl_ttp_2,'D')
nBulan  = cek_tgl(dltgl_notice,pdtgl_ttp_2,'M')

nlDendabbn = Iif(nBulan > 12,12,nBulan) && n bulan denda bbn
nlDendabbn = Iif(nBulan < 1, 0, nBulan)


*-- denda berjalan
*---------------------------------------------------------------------------------------------------------------------------------------------------------------

dltgl_dft        = dtgl_dft        && pdtgl_trans
dltgl_notice_sd  = dtgl_notice_sd  && tgl notice s/d

hari_perpjg      = cek_tgl(dltgl_dft ,dltgl_notice_sd,'D')
bulan_perpjg     = cek_tgl(dltgl_dft ,dltgl_notice_sd,'M')
tahun_perpjg     = cek_tgl(dltgl_dft ,dltgl_notice_sd,'Y')



If tahun_perpjg  = 1 And bulan_perpjg >= 1 And hari_perpjg >= 1
	perpanjangan = .T.
Else
	perpanjangan = .F.
Endif


If perpanjangan
	pntunggak_tes = pntunggak - 1
	If pntunggak_tes <= 0
		nlDendapkb = 0
		nlDendaswd = 0
		dtglA      = Ctod(Alltrim(Str(Day(dtglA)))+'/'+Alltrim(Str(Month(dtglA)))+'/'+Alltrim(Str(Year(dtglA))))
	Else
		dtglA = Ctod(Alltrim(Str(Day(dtglA)))+'/'+Alltrim(Str(Month(dtglA)))+'/'+Alltrim(Str(Year(dtglA)-1)))
	Endif
Else
	pntunggak_tes = pntunggak
Endif

*---------------------------------------------------------------------------------------------------------------------------------------------------------------

Do Case

Case pntunggak_tes = 0

	nHarid   = cek_tgl(dtglA,dltgl_dft,'D')
	nBuland  = cek_tgl(dtglA,dltgl_dft,'M')

	If nBuland = 0
		nBuland = Iif(nHarid >=1  , nBuland+1,nBuland) && terlambat 1 hari pada bulan 1
	Else
		nBuland = Iif(nHarid >=1 , nBuland+1,nBuland) && terlambat 1 hari pada bulan 2 dst
	Endif

	nlDendapkb = nBuland && n bulan denda pkb
	nlDendaswd = nBuland && n bulan denda swdkllj

Case pntunggak_tes = 1

	nHarid   = cek_tgl(dtglA,dltgl_dft,'D')
	nBuland  = cek_tgl(dtglA,dltgl_dft,'M')

	If nBuland = 0
		nBuland = Iif(nHarid >=1 , nBuland+1,nBuland) && terlambat 1 hari pada bulan 1
	Else
		nBuland = Iif(nHarid >=1 , nBuland+1,nBuland) && terlambat 1 hari pada bulan 2 dst
	Endif

	nlDendapkb = nBuland && n bulan denda pkb
	nlDendaswd = nBuland && n bulan denda swdkllj

Case pntunggak_tes >= 2

	nHarid   = cek_tgl(dtglA,dltgl_dft,'D')
	nBuland  = cek_tgl(dtglA,dltgl_dft,'M')

	If nBuland = 0
		nBuland = Iif(nHarid >=1, nBuland+1,nBuland)  && terlambat 1 hari pada bulan 1
	Else
		nBuland = Iif(nHarid >=1 , nBuland+1,nBuland) && terlambat 1 hari pada bulan 2 dst
	Endif

	nlDendapkb = nBuland && n bulan denda pkb
	nlDendaswd = nBuland && n bulan denda swdkllj

Endcase


*---------------------------------------------------------------------------------------------------------------------------------------------------------------


* Untuk Mutasi Keluar 33,34 di Pangkalanbun
*--------------------------------------------------------------------------------------------------------------------------------------------------------------

nbulan_mutklr   = cek_tgl(dltgl_notice,dltgl_notice_sd,'M')
nyear_mutklr    = cek_tgl(dltgl_notice,dltgl_notice_sd,'Y')
nbulan_mutklr   = ( nyear_mutklr * 12 ) + nbulan_mutklr

If nbulan_mutklr < 12
	mutklr = .T.
Else
	&&mutklr = .F.
	mutklr = .T.
Endif

*--------------------------------------------------------------------------------------------------------------------------------------------------------------


If perpanjangan

	If pntunggak_tes <= 0
		
		ldbatas      = plusdate(dltgl_notice_sd,-1)
		ldbatas_tgk  = plusdate(dltgl_notice_sd,-1)
		
	Else
		ldbatas     = plusdate(dltgl_notice_sd,-2)
		ldbatas_tgk = plusdate(dltgl_notice_sd,-2)
	
	Endif

Else
	ldbatas      = plusdate(dltgl_notice_sd,-1)
	ldbatas_tgk  = plusdate(dltgl_notice_sd,-1)
Endif


*** khusus jr
ldbatasjr      = plusdate(dltgl_notice_sd,-1)
ldbatas_mutklr = dltgl_notice


clBulanPkb = 12
clBulanswd = 12
proPkb     = 0
lnCount    = 0
lninyong    = 0

lcDumb     = .F.
propk      = .F.
proSw      = .F.



* hari libur
*====================================================================================================================================================================
csql = 'select * from mslibur'
asq  = SQLExec(gnconnhandle,csql,'cs_libur')

If asq < 0
	Messagebox('error get libur')
Else
	
	Select cs_libur
	Do While .T.

		llLibur   = .F.
		llLiburjr = .F.

		* hari libur nasional
		ldbatas1 = conv_tanggal(ldbatas)
		ldbatas3 = conv_tanggal(ldbatasjr)

		csql     = 'select * from mslibur where tgl = ?ldbatas1 '
		asq      = SQLExec(gnconnhandle,csql,'cari_libur')

		csql     = 'select * from mslibur where tgl = ?ldbatas3 '
		asq      = SQLExec(gnconnhandle,csql,'cari_liburjr')
		

		If asq < 0
			Messagebox('error get libur')
		Else
			
			If Reccount('cari_libur') > 0
				llLibur = .T.
			ENDIF
			
		Endif

		If llLibur
			ldbatas        = ldbatas        + 1
			ldbatasjr      = ldbatasjr      + 1
			lninyong       = lninyong       + 1       
		Else
			If lnCount < 1
				ldbatas        = ldbatas
				ldbatasjr      = ldbatasjr
				lnCount        = lnCount + 1
			Else
				Exit
			Endif

		Endif

	Enddo

ENDIF


&&hitung libur hari minggu
*===================================================================================================================================================================
a = ldbatas        
FOR i = 1 TO Val(konfig.bts_pkb)+1

	b = a + i

	IF DOW(b) = 1
		
		IF i <= Val(konfig.bts_pkb) - lninyong       
			ldbatas        = ldbatas   + 1
			ldbatasjr      = ldbatasjr + 1
		ENDIF 
	
	ELSE 

		cs = "select * from mslibur where tgl = ?b "
		SQLEXEC(gnconnhandle,cs,'tempor')
		IF RECCOUNT('tempor')>0
			ldbatas   = ldbatas   + 1
			ldbatasjr = ldbatasjr + 1
		ENDIF 

	ENDIF 

ENDFOR 


llDendaPkb           = Iif( ldbatas   + Val(konfig.bts_pkb)  < pdtgl_ttp_2, .T., .F.)
llDendaSwd           = Iif( ldbatasjr + Val(konfig.bts_pkb)  < pdtgl_ttp_2, .T., .F.)  &&llDendaPkb

llDendaBbn           = .F.
nTahun               = cek_tgl(dltgl_notice,dltgl_dft,'Y')   &&menghitung tahun tunggakan
nTahun_tunggakan     = cek_tgl(dltgl_notice,pdtgl_ttp_2,'Y') &&menghitung tahun tunggakan


* hitung tunggakan swd
*===================================================================================================================================================================
nTahun_tunggakan_thn     = cek_tgl(dltgl_notice,pdtgl_ttp_2,'Y') &&menghitung tahun tunggakan
nTahun_tunggakan_hri     = cek_tgl(dltgl_notice,pdtgl_ttp_2,'D') &&menghitung tahun tunggakan

nTahun_tunggakan_swd     = IIF( nTahun_tunggakan >= 5, 5, nTahun_tunggakan )

DO CASE 
	CASE nTahun_tunggakan_thn = 4 AND nTahun_tunggakan_hri >= 1
		nTahun_tunggakan_swd = 5
ENDCASE 
*===================================================================================================================================================================





*===================================================================================================================================================================
If lcPlat = 'MERAH'
	
	IF dltgl_notice > Ctod('01/01/2013')

		nHarid   = cek_tgl(dtglA,pdtgl_ttp_2,'D')
		nBuland  = cek_tgl(dtglA,pdtgl_ttp_2,'M')

		If nBuland = 0
			nBuland = Iif(nHarid >=1, nBuland+1,nBuland)  
		Else
			nBuland = Iif(nHarid >=1, nBuland+1,nBuland)
		Endif

		nlDendapkb = nBuland 
		nlDendaswd = nBuland
		
	ELSE
	
		nHarid   = cek_tgl(Ctod('01/01/2013'),pdtgl_ttp_2,'D')
		nBuland  = cek_tgl(Ctod('01/01/2013'),pdtgl_ttp_2,'M')

		If nBuland = 0
			nBuland = Iif(nHarid >=1, nBuland+1,nBuland)  
		Else
			nBuland = Iif(nHarid >=1, nBuland+1,nBuland)
		Endif

		nlDendapkb = nBuland 
		nlDendaswd = nBuland 
	
	ENDIF 
	
Endif
*===================================================================================================================================================================





For j = 1 To 4

	lcJns_Dft = 'clDaftar'+Allt(Str(j))
	lcMohon   = &lcJns_Dft

	*\ tentukan batas waktu kena denda
	lcMohon = Iif(Isnull(lcMohon),'',lcMohon)
	lcMohon = Alltrim(lcMohon)

	If Len(lcMohon) # 0

		Do Case
		Case  lcMohon = '01' && BBN1

			dltgl_dft    = pdTgl_Trans
			beda_nama    = .T.
			dltgl_faktur = Iif(!Isnull(dltgl_faktur),dltgl_faktur,dltgl_dft)
			dltgl_faktur = Iif(dltgl_dft < dltgl_faktur, dltgl_dft,dltgl_faktur)
			nBulan 	     = cek_tgl(dltgl_faktur,pdtgl_ttp_2,'M')
			nTahun		 = cek_tgl(dltgl_faktur,pdtgl_ttp_2,'Y')
			nBulan       = (nTahun * 12) + nBulan

			nlDendabbn   = Iif(nBulan > 24,24,nBulan)  && n bulan denda bbn
			nlDendabbn   = Iif(nBulan < 1,0,nBulan)
			nlDendapkb   = nlDendabbn                  && n bulan denda pkb
			nlDendaswd   = nlDendabbn                  && n bulan denda swdkllj

			llDendaBbn   = Iif(dltgl_faktur+31 < pdtgl_ttp_2, .T.,.F.) && 30 hari dari tgl faktur
			llDendaPkb   = llDendaBbn
			llDendaSwd   = llDendaBbn

		Case  lcMohon = '41' Or lcMohon = '42' Or lcMohon = '43' Or lcMohon = '44' Or lcMohon = '47' Or lcMohon = '52' Or lcMohon = '46'  && BBN2

			beda_nama      = .T.
			
			dltgl_kuitansi = Iif(!Isnull(dltgl_kuitansi), dltgl_kuitansi , dltgl_dft)
			dltgl_kuitansi = Iif(dltgl_dft < dltgl_kuitansi, dltgl_dft , dltgl_kuitansi)

			nBulan         = cek_tgl(dltgl_kuitansi,pdtgl_ttp_2,'M')
			nTahun         = cek_tgl(dltgl_kuitansi,pdtgl_ttp_2,'Y')
			nBulan         = (nTahun * 12) + nBulan

			nlDendabbn     = Iif(nBulan > 24,24,nBulan)                   && n bulan denda bbn
			nlDendabbn     = Iif(nlDendabbn < 1, 0 , nlDendabbn)
			llDendaBbn     = Iif(dltgl_kuitansi + 30 < pdtgl_ttp_2,.T.,.F.) && 30 hari dari tgl kuitansi

			&& tambahan
			cseltgl_b = cek_tgl(dltgl_notice_sd,pdtgl_ttp_2,'M')
			cseltgl_y = cek_tgl(dltgl_notice_sd,pdtgl_ttp_2,'Y')
			cseltgl_d = cek_tgl(dltgl_notice_sd,pdtgl_ttp_2,'D')

			If cseltgl_b >=1 And cseltgl_y < 1

				If dltgl_notice > dltgl_dft

					llDendaPkb  = .F.
					llpkb_nihil = .T.
					llDendaSwd  = .F.

				Endif

			Endif

		Case  lcMohon = '45'  Or lcMohon = '77' 	&& dumb

			beda_nama	 = .T.
			lcDumb		 = .T.  && dumb

			dlosd_swd	 = Iif(!Isnull(dosd_swd),dosd_swd,dltgl_dft)
			cltgl_sk 	 = Iif(!Isnull(cltgl_sk),cltgl_sk,dltgl_dft)
			cltgl_sk	 = Iif(dltgl_dft < cltgl_sk, dltgl_dft , cltgl_sk)

			nHari	     = cek_tgl(cltgl_sk,pdtgl_ttp_2,'D')
			nBulan       = cek_tgl(cltgl_sk,pdtgl_ttp_2,'M')
			nTahun       = cek_tgl(cltgl_sk,pdtgl_ttp_2,'Y')

			If nHari >= 1
				nBulan = nBulan + 1
			Endif

			nlDendabbn   = ( nTahun * 12 ) + nBulan
			nlDendabbn   = Iif(nlDendabbn >= 24, 24,nlDendabbn) && n bulan denda bbn
			nlDendabbn   = Iif(nlDendabbn < 1, 0, nlDendabbn)

			llDendaBbn   = Iif(cltgl_sk + 30 < pdtgl_ttp_2,.T.,.F.) && 30 hari dari tgl sk risalah lelang

			Do Case

			Case  dltgl_dft <= dosd_notice  && pajak masih berlaku

				th_tunggak     = cek_tgl(cltgl_sk,dltgl_dft,'Y')
				tgl_pajak_lalu = plusdate(cltgl_sk,th_tunggak)
				nHari	       = cek_tgl(tgl_pajak_lalu,pdtgl_ttp_2,'D')
				nBulan	       = cek_tgl(tgl_pajak_lalu,pdtgl_ttp_2,'M') && prorata

				nlDendapkb     = Iif(nBulan > 12,12,nBulan)   && n bulan denda pkb
				nlDendapkb     = Iif(th_tunggak = 0, nlDendapkb , Iif(nHari >= 1, nlDendapkb+1,nlDendapkb))
				nBulan         = cek_tgl(dosd_notice,pdtgl_ttp_2,'M')
				nTahun         = cek_tgl(dosd_notice,pdtgl_ttp_2,'Y')
				nBulan         = Iif(nTahun >= 1 , 12, nBulan)
				a              = (12 - nBulan)
				clBulanPkb     = a && ngga penting &&IIF(tgl_pajak_lalu < dltgl_dft, 12 + nBulan ,12 - nBulan)
				proPkb	       = (lnPkb-lnPkb_merah) + ((lnPkb / 12) * a)
				llDendaPkb     = Iif(tgl_pajak_lalu + Val(konfig.bts_pkb) < pdtgl_ttp_2,.T.,.F.)

			Otherwise

				nBulan     = Iif(nBulan > 12,12, nBulan)  &&denda
				nBulan     = Iif(nBulan < 1, 0, nBulan)
				clBulanPkb = 12 + Iif(nBulan = 12, 0,nBulan) &&prorata
				proPkb     = ( lnPkb / 12 ) * (nBulan)
				nlDendapkb = Iif( nHari >= 1, nBulan+1 , nBulan)
				nlDendapkb = Iif( nlDendapkb > 12,12,nlDendapkb)
				llDendaPkb = Iif(cltgl_sk+Val(konfig.bts_pkb) < pdtgl_ttp_2, .T.,.F.)

			Endcase

			propk      = Iif(clBulanPkb = 12,.F.,.T.)

			nBulan     = cek_tgl(dlosd_swd,pdtgl_ttp_2,'M')
			nTahun     = cek_tgl(dlosd_swd,pdtgl_ttp_2,'Y')
			clBulanswd = Iif(dlosd_swd < dltgl_dft, 12+nBulan, 12-Iif(nTahun >= 1, 12,nBulan))
			nlDendaswd = Iif(clBulanswd > 12, clBulanswd -12, clBulanswd)
			llDendaSwd = Iif(dlosd_swd+Val(konfig.bts_pkb)<pdtgl_ttp_2, .T.,.F.)
			proSw      = Iif(nlDendaswd = 12,.F.,.T.)

			* mencari tanggal faktur
			&&clnilai_jual      = Iif(clnilai_jual > 0 Or !Isnull(clnilai_jual) , clnilai_jual,lnNilai)

			clnilai_jual      = lnNilai

			hnotice           = Alltrim(Str(Day(dosd_notice)))
			bnotice           = Alltrim(Str(Month(dosd_notice)))
			ynotice           = Alltrim(Str(clTahun)) && tahun buat
			tgl_faktur_kosong = Ctod(hnotice+'/'+bnotice+'/'+ynotice)
			dltgl_faktur      = Iif(!Isnull(dltgl_faktur) Or dltgl_faktur # Ctod('  /  /    '),dltgl_faktur,tgl_faktur_kosong)
			ndumb             = 0.01


		Case  lcMohon = '31' && mutasi masuk dalam prop


			dltgl_fiskal 	= Iif(!Isnull(dltgl_fiskal),dltgl_fiskal,dltgl_dft)
			dltgl_fiskal	= Iif(dltgl_dft < dltgl_fiskal, dltgl_dft, dltgl_fiskal)
			dltgl_kuitansi	= Iif(!Isnull(dltgl_kuitansi),dltgl_kuitansi,dltgl_dft)
			dltgl_kuitansi	= Iif(dltgl_dft < dltgl_kuitansi, dltgl_dft, dltgl_kuitansi)
			dlosd_swd		= Iif(!Isnull(dosd_swd),dosd_swd,dltgl_dft)

			nBulan          = cek_tgl(dltgl_fiskal,pdtgl_ttp_2,'M')
			nTahun          = cek_tgl(dltgl_fiskal,pdtgl_ttp_2,'Y')
			nHari           = cek_tgl(dltgl_fiskal,pdtgl_ttp_2,'D')

			nBulan 	        = Iif(nHari >= 1, nBulan+1,nBulan)
			nBulan          = (nTahun * 12) + nBulan
			nBulan 	        = Iif(nBulan >= 24, 24,nBulan)
			nlDendabbn      = Iif(nBulan < 1, 0 ,nBulan)

			
			
			* PKB
			*====================================================================================================
			nBulan31        = cek_tgl(dosd_notice,dltgl_notice_sd,'M')
			nHari31         = cek_tgl(dosd_notice,dltgl_notice_sd,'D')
			nYear31         = cek_tgl(dosd_notice,dltgl_notice_sd,'Y')

			If nBulan31 = 0 And nYear31 = 1
				nBulan    = 12
			Else
				nBulan 	  = Iif(nHari31 >= 1,  nBulan31+1, nBulan31) && terlambat 1 hari dihitung 1 bulan
			Endif

			nlDendapkb      = Iif(nBulan > 12,12,nBulan)   && n bulan denda pkb
			nlDendapkb      = Iif(nBulan < 1, 0,nBulan)
			proPkb          = (lnPkb / 12) * (nlDendapkb) && harga pkb n bulan

			If nBulan31 = 0 And nYear31 = 1
				clBulanPkb  = 12
			Else
				clBulanPkb  = ( nYear31 * 12 ) + nlDendapkb
			ENDIF
			
			
			* DENDA_PKB
			*===================================================================================================
			nBulan31_2        = cek_tgl(dtglA,pdtgl_ttp_2,'M')
			nHari31_2         = cek_tgl(dtglA,pdtgl_ttp_2,'D')
			nYear31_2         = cek_tgl(dtglA,pdtgl_ttp_2,'Y')

			If nBulan31_2 = 0 And nYear31_2 = 1
				nBulan_2    = 12
			Else
				nBulan_2 	= Iif(nHari31_2 >= 1,  nBulan31_2+1, nBulan31_2) && terlambat 1 hari dihitung 1 bulan
			Endif

			nlDendapkb_2    = Iif(nBulan_2 > 12,12,nBulan_2)   && n bulan denda pkb
			nlDendapkb_2    = Iif(nBulan_2 < 1, 0,nBulan_2)
			

			* SWD
			*====================================================================================================
			nBulan          = cek_tgl(dosd_notice,dltgl_notice_sd,'M')
			nHari31         = cek_tgl(dosd_notice,dltgl_notice_sd,'D')
			nYear31         = cek_tgl(dosd_notice,dltgl_notice_sd,'Y')

			nBulan 	        = Iif(nHari31 >= 1,  nBulan+1, nBulan) && terlambat 1 hari dihitung 1 bulan

			nlDendaswd      = Iif(nBulan > 12,12,nBulan)   && n bulan denda pkb
			nlDendaswd      = Iif(nBulan < 1, 0,nBulan)
			clBulanswd      = ( nYear31 * 12 ) + nlDendaswd

			
			*====================================================================================================
			*!*				llDendaBbn      = Iif(dltgl_fiskal + 60 < pdtgl_ttp_2,.T.,.F.) && 60 hari dari tgl kuitansi
			*!*				llDendaSwd      = Iif((dlosd_swd        < pdtgl_ttp_2 ), .T. , .F.)
			
			llDendaPkb           = Iif( ldbatas   + Val(konfig.bts_pkb)  < pdtgl_ttp_2, .T., .F.)
			llDendaSwd           = Iif( ldbatasjr + Val(konfig.bts_pkb)  < pdtgl_ttp_2, .T., .F.)  


			proSw           = Iif(nlDendaswd  = 12,.F.,.T.)
			propk           = Iif(nlDendapkb  = 12,.F.,.T.)
			
			IF dosd_notice = dltgl_notice_sd
				proSw = .F.        
			ENDIF 			
			*====================================================================================================

		Case  lcMohon = '32' && mutasi masuk luar prop

			* Perbaikan mutasi keluar luar propinsi
			dltgl_fiskal 	= IIF(!ISNULL(dltgl_fiskal),dltgl_fiskal,dltgl_dft)
			dltgl_fiskal	= IIF(dltgl_dft < dltgl_fiskal, dltgl_dft, dltgl_fiskal)
			dltgl_kuitansi	= IIF(!ISNULL(dltgl_kuitansi),dltgl_kuitansi,dltgl_dft)
			dltgl_kuitansi	= IIF(dltgl_dft < dltgl_kuitansi, dltgl_dft, dltgl_kuitansi)
			dlosd_swd		= IIF(!isnull(dosd_swd),dosd_swd,dltgl_dft)

			
			* BBN
			*====================================================================================================
			nBulan          = cek_tgl(dltgl_fiskal,pdtgl_ttp_2,'M')
			nTahun          = cek_tgl(dltgl_fiskal,pdtgl_ttp_2,'Y')
			nhari_bbn_32    = cek_tgl(dltgl_fiskal,pdtgl_ttp_2,'D')
			
			IF nBulan = 0 AND nTahun = 1
				nBulan    = 12
			ELSE 
				nBulan 	  = IIF(nhari_bbn_32 >= 1,  nBulan + 1, nBulan ) && terlambat 1 hari dihitung 1 bulan
			ENDIF 

			nBulan          = (nTahun * 12) + nBulan
			nBulan 	        = IIF(nBulan >= 24, 24,nBulan)
			nlDendabbn      = IIF(nBulan < 1, 0 ,nBulan)
			
			
		
			* PKB
			*====================================================================================================
			nBulan31        = cek_tgl(dltgl_fiskal,dltgl_notice_sd,'M')
			nHari31         = cek_tgl(dltgl_fiskal,dltgl_notice_sd,'D')
			nYear31         = cek_tgl(dltgl_fiskal,dltgl_notice_sd,'Y')
			
			IF nBulan31 = 0 AND nyear31 = 1 AND nHari31 = 0         
				nBulan    = 12
			ELSE 
				nBulan 	  = IIF(nHari31 >= 1, nBulan31 + 1, nBulan31 ) && terlambat 1 hari dihitung 1 bulan
			ENDIF 
			
			nlDendapkb      = Iif(nBulan > 12,12,nBulan)   && n bulan denda pkb
			nlDendapkb      = IIF(nBulan < 1, 0,nBulan)
			proPkb          = (lnPkb / 12) * (nlDendapkb) && harga pkb n bulan 
			
			IF nBulan31 = 0 AND nyear31 = 1 AND nHari31 = 0 
				clBulanPkb   = 12
			ELSE
				clBulanPkb   = ( nYear31 * 12 ) + nlDendapkb
			ENDIF 
			

			* DENDA_PKB
			*===================================================================================================
			nBulan32_2        = cek_tgl(dltgl_fiskal,pdtgl_ttp_2,'M')
			nHari32_2         = cek_tgl(dltgl_fiskal,pdtgl_ttp_2,'D')
			nYear32_2         = cek_tgl(dltgl_fiskal,pdtgl_ttp_2,'Y')

			If nBulan32_2 = 0 And nYear32_2 = 1
				nBulan_2    = 12
			Else
				nBulan_2 	= Iif(nHari32_2 >= 1,  nBulan32_2+1, nBulan32_2) && terlambat 1 hari dihitung 1 bulan
			Endif

			nlDendapkb_2    = Iif(nBulan_2 > 12,12,nBulan_2)   && n bulan denda pkb
			nlDendapkb_2    = Iif(nBulan_2 < 1, 0,nBulan_2)
			
			
			
			* SWD
			*====================================================================================================
			nBulan          = cek_tgl(dosd_notice,dltgl_notice_sd,'M')
			nHari31         = cek_tgl(dosd_notice,dltgl_notice_sd,'D')
			nYear31         = cek_tgl(dosd_notice,dltgl_notice_sd,'Y')
			
			nBulan 	        = IIF( nHari31 >= 1,  nBulan+1, nBulan ) && terlambat 1 hari dihitung 1 bulan
			
			nlDendaSWD      = Iif(nBulan > 12,12,nBulan)   && n bulan denda pkb
			nlDendaSWD      = IIF(nBulan < 1, 0,nBulan)
			clBulanSWD      = ( nYear31 * 12 ) + nlDendaSWD
			*====================================================================================================
			
			llDendaBbn      = Iif(dltgl_fiskal + 60 < pdtgl_ttp_2,.T.,.F.) && 60 hari dari tgl kuitansi
			llDendaPkb      = Iif(dltgl_fiskal + 60 < pdtgl_ttp_2,.T.,.F.) && 60 hari dari tgl fiskal 
			llDendaSwd      = iif((dlosd_swd < pdtgl_ttp_2 ), .t. , .f.)
		
			prosw           = IIF(nlDendaswd  = 12,.f.,.t.) 
			propk           = IIF(nlDendapkb  = 12,.f.,.t.)



		Case ( lcMohon = '33' Or lcMohon = '34' ) And !mutklr && mutasi keluar

			dltgl_notice = Iif(dltgl_dft + 7 < dltgl_notice,dltgl_notice+90,dltgl_notice) && 7 hari sebelum mati pajak baru bisa bayar 1 th kedepan

		Case ( lcMohon = '33' Or lcMohon = '34' ) And mutklr
			
			ldbatas_mutklr = dltgl_notice
			
			* hari libur
			*====================================================================================================================================================================
			csql = 'select * from mslibur'
			asq  = SQLExec(gnconnhandle,csql,'cs_libur_mutklr')

			If asq < 0
				Messagebox('error get libur')
			Else
				
				Select cs_libur_mutklr
				Do While .T.

					llLibur   = .F.

					* hari libur nasional
					ldbatas4 = conv_tanggal(ldbatas_mutklr)
					csql     = 'select * from mslibur where tgl = ?ldbatas4 '
					asq      = SQLExec(gnconnhandle,csql,'cari_libur_mutklr')

					If asq < 0
						Messagebox('error get libur')
					Else
						If Reccount('cari_libur_mutklr') > 0
							llLibur = .T.
						ENDIF
					Endif

					IF llLibur
						ldbatas_mutklr = ldbatas_mutklr + 1
					ELSE 

						IF  lnCount < 1
							ldbatas_mutklr = ldbatas_mutklr 
							lnCount        = lnCount + 1
						ELSE 
							EXIT 
						ENDIF 

					Endif

				Enddo

			Endif

			
			* Hitung libur hari libur
			*===================================================================================================================================================================
			aa = ldbatas_mutklr 
			FOR i = 1 TO Val(konfig.bts_pkb)
				bb              = aa + i
				ldbatas3_mutklr = conv_tanggal(bb)
				csql            = 'select * from mslibur where tgl = ?ldbatas3_mutklr '
				asq             = SQLExec(gnconnhandle,csql,'cari_libur_lagi')
					
				If Reccount('cari_libur_lagi') > 0
					ldbatas_mutklr = ldbatas_mutklr + 1
				ENDIF 
			ENDFOR 
			*===================================================================================================================================================================

			&&hitung libur hari minggu
			*===================================================================================================================================================================
			a = ldbatas_mutklr 
			FOR i = 1 TO Val(konfig.bts_pkb)
				b = a + i
				IF DOW(b) = 1
					ldbatas_mutklr = ldbatas_mutklr + 1
				ENDIF 
			ENDFOR 
			*===================================================================================================================================================================

			
			
			
			
			
						
			*===============================================================================
			nHarid_34   = cek_tgl(ldbatas_mutklr,pdtgl_ttp_2,'D')
			nBuland_34  = cek_tgl(ldbatas_mutklr,pdtgl_ttp_2,'M')
			nTahun_34   = cek_tgl(ldbatas_mutklr,pdtgl_ttp_2,'Y')

			If nHarid_34  >= 1
				nBuland_34 = nBuland_34 + 1
			Endif

			nlDendapkb = ( nTahun_34 * 12 ) + nBuland_34 
			nlDendapkb = IIF(nlDendapkb > 24, 24, nlDendapkb )
			

			* PKB
			*===============================================================================
			
			llDendaPkb = Iif( ldbatas_mutklr + Val(konfig.bts_pkb) < pdtgl_ttp_2, .T., .F.)
			llDendaSwd = Iif( ldbatas_mutklr + Val(konfig.bts_pkb) < pdtgl_ttp_2, .T., .F.)  

			nbulan_mutklr_d   = date_diff(dltgl_notice,dltgl_notice_sd,'D')
			nbulan_mutklr_m   = date_diff(dltgl_notice,dltgl_notice_sd,'M')
			nbulan_mutklr_y   = date_diff(dltgl_notice,dltgl_notice_sd,'Y')

			If nbulan_mutklr_d >= 1
				nbulan_mutklr_m   = nbulan_mutklr_m  + 1
			Endif

			nbulan_mutklr   = ( nbulan_mutklr_y * 12 ) + nbulan_mutklr_m   
			nbulan_mutklr   = IIF(nbulan_mutklr > 60, 60, nbulan_mutklr )
			
			clBulanPkb      =  nbulan_mutklr

			* SWD
			*===============================================================================
			clBulanswd_bln      =  nbulan_mutklr_m
			nlDendaswd_bln      =  nbulan_mutklr_m
			clBulanswd      	= clBulanswd_bln      
			nlDendaswd      	= clBulanswd_bln      
			
			clBulanswd_thn      =  nbulan_mutklr_y
			clBulanswd_thn      =  IIF(clBulanswd_thn > 5, 5, clBulanswd_thn )
			
			nlDendaswd_thn      =  nbulan_mutklr_y
			*===============================================================================

			proPkb          =  ( lnPkb/12 ) * nbulan_mutklr
			propk           =  .T.
			proSw           =  .T.

		Case  lcMohon = '55' &&ganti warna plat

			*mencari nilai pkb
			If cOWARNA_PLA = 'KUNING' And lcPlat = 'HITAM' And (dltgl_notice_sd = dltgl_notice)

				nHari      =  cek_tgl(dltgl_notice_sd,pdtgl_ttp_2,'D')
				nBulan     =  cek_tgl(dltgl_notice_sd,pdtgl_ttp_2,'M')
				nTahun     =  cek_tgl(dltgl_notice_sd,pdtgl_ttp_2,'Y')
				nBulan     =  Iif(nTahun >= 1, 12, nBulan)

				clBulanPkb =  nBulan

				clBulanPkb =  Iif(nBulan = 12, 11 ,nBulan)
				nlDendapkb =  nBulan

				clBulanswd =  nBulan
				nlDendaswd =  nBulan &&nBulan
				proPkb     =  (lnPkb/12)*nlDendapkb
				llDendaPkb =  .F.
				llDendaSwd =  .F.

				propk      =  .T.
				proSw      =  .T.

			Endif

			If cOWARNA_PLA = 'HITAM' And lcPlat = 'KUNING' And (dltgl_notice_sd = dltgl_notice)

				clBulanPkb = 0
				nlDendapkb = 0
				clBulanswd = 0
				nlDendaswd = 0
				proPkb	   = 0 && pkb selisih per bulan
				llDendaPkb = .F.
				llDendaSwd = .F.

				propk      = .T.
				proSw      = .T.

			Endif


		Case lcMohon = '51' && rubah bentuk

			dlubh_btk  = Iif(!Isnull(cubh_btk),cubh_btk,dltgl_dft)
			dlubh_btk  = Iif(dltgl_dft < cubh_btk, dltgl_dft,cubh_btk)

			nBulan     = cek_tgl(dlubh_btk,pdtgl_ttp_2,'M')
			nTahun     = cek_tgl(dlubh_btk,pdtgl_ttp_2,'Y')
			nBulan     = (nTahun * 12) + nBulan
			nBulan 	   = Iif(nBulan >= 24, 24,nBulan)
			nlDendabbn = Iif(nBulan < 1, 0 ,nBulan)
			llDendaBbn = Iif(dlubh_btk + 30 < pdtgl_ttp_2,.T.,.F.) && 30 hari dari tgl kuitansi

			If dltgl_notice_sd = dltgl_notice

				nBulan    = cek_tgl(dltgl_notice_sd,pdtgl_ttp_2,'M')
				nTahun51  = cek_tgl(dltgl_notice_sd,pdtgl_ttp_2,'Y')

				nBulan    = ( nTahun51 * 12 ) + nBulan

				If lnPkb > lnPkb_Asal
					proPkb     = ((lnPkb -lnPkb_Asal)/12)*nBulan
					clBulanPkb = nBulan
					nlDendapkb = nBulan
					propk      = .T.
				Endif

				If laSwd(1) < laSwd(2)  &&laSwd2= harga jr terbaru
					clBulanswd = nBulan
					nlDendaswd = clBulanswd
				Else
					clBulanswd = 0
					nlDendaswd = 0
				Endif

				proSw = .T.

			Endif

			beda_nama = .T.

		Endcase

		*\ hitung pajak biasa
		csql = 'Select * FROM Ajpajak WHERE j_pajak=?lcMohon'
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

				Do Case
				Case Jenis = '11' Or Jenis = '12' &&pokok bbn
					laArray(1,1) = Iif(Isnull(cN),'',cN)
					laArray(1,2) = rst_jsetor.Jenis
					laArray(1,3) = 0
					laArray(1,4) = 0
				Case Jenis = '21' Or Jenis = '22' &&denda bbn
					laArray(2,1) = Iif(Isnull(cN),'',cN)
					laArray(2,2) = rst_jsetor.Jenis
					laArray(2,3) = 0
					laArray(2,4) = 0
				Case Jenis = '13' &&pkb
					laArray(3,1) = Iif(Isnull(cN),'',cN)
					laArray(3,2) = rst_jsetor.Jenis
					laArray(3,3) = 0
					laArray(3,4) = 0
				Case Jenis = '23' &&denda pkb
					laArray(4,1) = Iif(Isnull(cN),'',cN)
					laArray(4,2) = rst_jsetor.Jenis
					laArray(4,3) = 0
					laArray(4,4) = 0
				Case Jenis = '14' &&pokok swd
					laArray(5,1) = Iif(Isnull(cN),'',cN)
					laArray(5,2) = rst_jsetor.Jenis
					laArray(5,3) = 0
					laArray(5,4) = 0
				Case Jenis = '24' &&denda swd
					laArray(6,1) = Iif(Isnull(cN),'',cN)
					laArray(6,2) = rst_jsetor.Jenis
					laArray(6,3) = 0
					laArray(6,4) = 0
				Case Jenis = '15' &&stnk
					laArray(7,1) = Iif(Isnull(cN),'',cN)
					laArray(7,2) = rst_jsetor.Jenis
					laArray(7,3) = 0
					laArray(7,4) = 0
				Case Jenis = '16' &&tnk
					laArray(8,1) = Iif(Isnull(cN),'',cN)
					laArray(8,2) = rst_jsetor.Jenis
					laArray(8,3) = 0
					laArray(8,4) = 0
				Case Jenis = '18' &&sp3
					laArray(9,1) = Iif(Isnull(cN),'',cN)
					laArray(9,2) = rst_jsetor.Jenis
					laArray(9,3) = 0
					laArray(9,4) = 0
				Otherwise
					laArray(10,1) = Iif(Isnull(cN),'',cN)
					laArray(10,2) = rst_jsetor.Jenis
					laArray(10,3) = 0
					laArray(10,4) = 0

				Endcase

			Endfor

		Endif

	Endif

Endfor




*\ hitung pajak biasa
For i = 1 To 10

	If !Empty(laArray(i,1))

		Do Case

		Case  laArray(i,2) = '11' Or laArray(i,2) = '12' 	    && Hitung Pokok BBNKB I & II

			DO CASE 

				Case  lcDumb   	&& dumb
					lnPajak = lnNilai_tanpa_bobot * ndumb
				Case rbh_btk    && rubah bentuk
					lnPajak = lnNilai_tanpa_bobot * Iif(laArray(i,2)='11', 0.13, 0.01)
				Case lcPlat = 'KUNING' AND clGuna='1'
					lnPajak = lnNilai_tanpa_bobot * Iif(laArray(i,2)='11', Iif(clJenisKend= 'F' Or clJenisKend ='G', 0.8, 0.6) * 0.13, Iif(clJenisKend= 'F' Or clJenisKend ='G', 0.8, 0.6) * 0.01 ) &&
				Case lcPlat = 'MERAH' 	&& merah
					lnPajak = lnNilai_tanpa_bobot * Iif(laArray(i,2)='11', 0.13, 0.01 )
				Case lcPlat = 'KUNING' AND clGuna='2'
					lnPajak = lnNilai_tanpa_bobot * Iif(laArray(i,2)='11', 0.13, 0.01 ) 
				Otherwise && plat merah & hitam
					lnPajak = lnNilai_tanpa_bobot * Iif(laArray(i,2)='11', 0.13, 0.01 )

			ENDCASE
			
			
			IF clJenis = '702'
				lnPajak = (( lnNilai_tanpa_bobot - 2000000 ) * Iif(laArray(i,2)='11', 0.13, 0.01 )) + Iif(laArray(i,2)='11',(2000000* 0.10),0)
			ENDIF
				
	
			IF clDaftar1 = '01'
				IF BETWEEN(VAL(clJenis),402,439) OR BETWEEN(VAL(clJenis),352,362) OR BETWEEN(VAL(clJenis),302,306)		
					SQLEXEC(gnconnhandle,"select harga from lamp_2 where jenis_b=?clJenis and tahun=?clTahun ","cs_lampiran_rb")
					nharga_rb = IIF(!ISNULL(cs_lampiran_rb.harga),cs_lampiran_rb.harga,0)
					lnPajak   = (( lnNilai_tanpa_bobot - nharga_rb  ) * Iif(laArray(i,2)='11', 0.13, 0.01 )) + Iif(laArray(i,2)='11',( nharga_rb * 0.10),0)
				ENDIF 
			ENDIF 
			

			IF clDaftar1 = '51' 
				
					nharga_rb = 0
				
					IF BETWEEN(VAL(clJenis),402,439) OR BETWEEN(VAL(clJenis),352,362) OR BETWEEN(VAL(clJenis),302,306)		
					
						SQLEXEC(gnconnhandle,"select harga from lamp_2 where jenis_b=?clJenis and tahun=?clTahun ","cs_lampiran_rb")
						nharga_rb = IIF(!ISNULL(cs_lampiran_rb.harga),cs_lampiran_rb.harga,0)
						
						SELECT cs_lampiran_rb
						IF RECCOUNT() = 0
							SQLEXEC(gnconnhandle," select MIN(harga) AS jum_bawah from lamp_2 where jenis_b=?clJenis ","cs_lampiran_rb_2")
							SELECT cs_lampiran_rb_2
							nharga_rb = IIF(!ISNULL(cs_lampiran_rb_2.jum_bawah ),cs_lampiran_rb_2.jum_bawah ,0)
						ENDIF 
							
					ENDIF 
						
					lnPajak   = Iif(laArray(i,2)='12',( nharga_rb * 0.10),0)
			
			ENDIF 

						
			DO CASE 
			CASE clDaftar1 <> '32' 
				laArray(i,3) = Iif(beda_nama,pembulatan(lnPajak),0)
			CASE clDaftar1 = '32' AND pdTgl_Trans <= konfig.tgl_pemutihan  
				laArray(i,3) = Iif(beda_nama,0,0)
			CASE clDaftar1 = '32' AND pdTgl_Trans > konfig.tgl_pemutihan  
				laArray(i,3) = Iif(beda_nama,pembulatan(lnPajak),0)
			ENDCASE 
			

		Case  laArray(i,2) = '21' .Or. laArray(i,2) = '22' 		&& Hitung Denda BBNKB I & II


			If llDendaBbn

				Do Case
				Case  lcDumb  && dumb
					lnPajak = lnNilai_tanpa_bobot * ndumb * (Iif(nlDendabbn>2,nlDendabbn * 0.02,0)) && 2%
				Case rbh_btk  && rubah bentuk
					lnPajak  = ( lnNilai_tanpa_bobot * Iif( laArray(i,2)='21', 0.13, 0.01 ) ) * (Iif(nlDendabbn>2,nlDendabbn * 0.02,0))
				Case lcPlat = 'KUNING' && Umum
					lnPajak  = lnNilai_tanpa_bobot * Iif( laArray(i,2) = '21', 0.13, 0.01 ) * Iif(clJenisKend= 'F' Or clJenisKend ='G', 0.8,0.6) * (Iif(nlDendabbn>2,nlDendabbn * 0.02,0))
				Case lcPlat = 'MERAH' && merah
					lnPajak  = lnNilai_tanpa_bobot * Iif( laArray(i,2) = '21', 0.13, 0.01 ) * (Iif(nlDendabbn>2,nlDendabbn * 0.02,0))
				Otherwise && plat merah & hitam
					lnPajak  = ( lnNilai_tanpa_bobot * Iif( laArray(i,2)='21', 0.13, 0.01 ) ) * ( Iif( nlDendabbn>=1,nlDendabbn * 0.02,0))
				Endcase
				
				DO CASE 
					CASE clDaftar1 = '32' AND pdTgl_Trans <= konfig.tgl_pemutihan
						If beda_nama
							laArray(i,4) = 0 		
						Else
							laArray(i,4) = 0
						ENDIF
					CASE clDaftar1 = '32' AND pdTgl_Trans > konfig.tgl_pemutihan
						If beda_nama
							laArray(i,4) = pembulatan(lnPajak) 		
						Else
							laArray(i,4) = 0
						ENDIF
					CASE clDaftar1 <> '32'
						If beda_nama
							laArray(i,4) = pembulatan(lnPajak) 		
						Else
							laArray(i,4) = 0
						ENDIF
				ENDCASE 

			Endif

		Case laArray(i,2) = '13'  && Hitung Pokok PKB
			
			DO CASE 
			Case clDaftar1 <> '31' And clDaftar1 <> '32'

				Do Case
					Case propk And clBulanPkb # 12				
						lnPajak = Iif(clBulanPkb > 12,lnPkb+proPkb,proPkb)												
					Case propk And clBulanPkb = 12
						lnPajak = proPkb
					Otherwise
						lnPajak = lnPkb
				ENDCASE
						
				IF clDaftar1 = '34'
					lnPajak = proPkb
				ENDIF 
							
			Case clDaftar1 = '31' Or clDaftar1 = '32'
				
				lnPajak = IIF(clBulanPkb > 12,lnPkb + proPkb,lnPkb )
				
				IF ( YEAR(dltgl_notice_sd)=YEAR(dltgl_notice) AND clDaftar1 = '31' )
					lnpajak = 0
				ENDIF 
				
			ENDCASE 

			laArray(i,3) =  Iif( ( Year(dltgl_notice_sd) > Year(dltgl_notice) ) Or ( propk And clBulanPkb # 12 ) Or ( propk And clBulanPkb = 12 ) , pembulatan(lnPajak),0)

		Case laArray(i,2) = '23'  && Hitung Denda PKB

			Do Case

			Case clDaftar1 <> '31' And clDaftar1 <> '32'
			
				*===================================================================================================================================================
				If lcPlat <> 'MERAH'

					nTahun     = nTahun+1
					nTahun     = IIF( nTahun > 5,5,nTahun) 
					nlDendapkb = Iif(nlDendapkb=0,1,nlDendapkb)

					If !perpanjangan

						If (llDendaPkb And !propk) Or (llDendaPkb And propk And clBulanPkb > 12) Or (llDendaPkb And lcDumb)

							lnPajak     = (lnPkb * nTahun *  0.25)   + (lnPkb * nTahun * nlDendapkb * 0.02) && 2%

							lnPajak     = Iif(llDendaSwd,lnPajak,0)
							status25    = Iif(llDendaSwd,1,0)
							bulan_denda = Iif(llDendaSwd,nlDendapkb,0)

							laArray(i,4) = Iif((Year(dltgl_notice_sd) > Year(dltgl_notice)) ,pembulatan(lnPajak),0)

						Endif
					
					Else

						If (llDendaPkb And !propk) Or (llDendaPkb And propk And clBulanPkb > 12) Or (llDendaPkb And lcDumb)

							lnPajak      = (lnPkb * nTahun *  0.25) + (lnPkb * nTahun *  nlDendapkb * 0.02) && 2%

							lnPajak      = Iif(llDendaSwd,lnPajak,0)
							status25     = Iif(llDendaSwd,1,0)
							bulan_denda  = Iif(llDendaSwd,nlDendapkb,0)

							laArray(i,4) = Iif((Year(dltgl_notice_sd) > Year(dltgl_notice)) ,pembulatan(lnPajak),0)


						Endif

					Endif

					nlDendapkb  = Iif(llDendaSwd,nlDendapkb,0)
					thtunggak   = Iif(nTahun > 1,((nTahun-1)*12),0)
					jbulan      = thtunggak+nlDendapkb

					txtdenda    = 'Denda '+Transform(jbulan)+' bulan = '+Transform(jbulan*2)+'%+25% denda ='+Transform( Iif((jbulan*2)+25>73,73,(jbulan*2)+25))+'% denda'
					njkb_denda  = Iif(llDendaSwd,jbulan,0)
					
				ENDIF 	
				*===================================================================================================================================================

			
				*===================================================================================================================================================
				If lcPlat = 'MERAH'

					nTahun     = nTahun+1
					nTahun     = IIF( nTahun > 5,5,nTahun) 
					nlDendapkb = Iif(nlDendapkb=0,1,nlDendapkb)

					If !perpanjangan

						If (llDendaPkb And !propk) Or (llDendaPkb And propk And clBulanPkb > 12) Or (llDendaPkb And lcDumb)
							
							&&lnPajak     = (lnPkb * nTahun *  0.25)   + (lnPkb * nTahun * nlDendapkb * 0.02) && 2%
							lnPajak     = (lnPkb * 1 *  0.25)   + (lnPkb * 1 * nlDendapkb * 0.02) && 2%
							
							lnPajak     = Iif(llDendaSwd,lnPajak,0)
							status25    = Iif(llDendaSwd,1,0)
							bulan_denda = Iif(llDendaSwd,nlDendapkb,0)

							laArray(i,4) = Iif((Year(dltgl_notice_sd) > Year(dltgl_notice)) ,pembulatan(lnPajak),0)
							&&laArray(i,4) = Iif((Year(dltgl_notice_sd) > Year(dltgl_notice)) ,0,0)
						
						Endif
					
					Else

						If (llDendaPkb And !propk) Or (llDendaPkb And propk And clBulanPkb > 12) Or (llDendaPkb And lcDumb)

							lnPajak      = (lnPkb * nTahun *  0.25) + (lnPkb * nTahun *  nlDendapkb * 0.02) && 2%
							lnPajak      = Iif(llDendaSwd,lnPajak,0)
							status25     = Iif(llDendaSwd,1,0)
							bulan_denda  = Iif(llDendaSwd,nlDendapkb,0)

							laArray(i,4) = Iif((Year(dltgl_notice_sd) > Year(dltgl_notice)) , pembulatan(lnPajak),0)

						Endif

					Endif

					nlDendapkb  = Iif(llDendaSwd,nlDendapkb,0)
					jbulan      = nlDendapkb

					txtdenda    = 'Denda '+Transform(jbulan)+' bulan = '+Transform(jbulan*2)+'%+25% denda ='+Transform( Iif((jbulan*2)+25>73,73,(jbulan*2)+25))+'% denda'
					njkb_denda  = Iif(llDendaSwd,jbulan,0)
					
				ENDIF 	
				*===================================================================================================================================================
				
				
				IF clDaftar1 = '34'
				
					If llDendaPkb 
						
						&&lnPajak      = ( proPkb * nTahun *  0.25)   + ( proPkb * nTahun * nlDendapkb * 0.02) && 2%
						lnPajak      = ( proPkb * 0.25)   + ( proPkb * nlDendapkb * 0.02) && 2%
						
						lnPajak      = Iif(llDendaSwd,lnPajak,0)
						status25     = Iif(llDendaSwd,1,0)
						bulan_denda  = Iif(llDendaSwd,nlDendapkb,0)
						laArray(i,4) = pembulatan(lnPajak)
						
						*-------------------------------------------------------------------------------------------------------------------------------------------
						
						nlDendapkb  = Iif(llDendaSwd,nlDendapkb,0)
						thtunggak   = Iif( nTahun_tunggakan > 1,((nTahun_tunggakan-1)*12),0)
						jbulan      = thtunggak+nlDendapkb

						txtdenda    = 'Denda '+Transform(jbulan)+' bulan = '+Transform(jbulan*2)+'%+25% denda ='+Transform( Iif((jbulan*2)+25>73,73,(jbulan*2)+25))+'% denda'
						njkb_denda  = Iif(llDendaSwd,jbulan,0)
						*-------------------------------------------------------------------------------------------------------------------------------------------
						
					Endif

				ENDIF 


			Case clDaftar1 = '32'
			
				DO CASE 
					CASE llDendaPkb And propk And clBulanPkb > 12 
							lnPajak      = ( lnPkb + proPkb )  * ( ( ( IIF(clDaftar1='31' or clDaftar1='32',nlDendapkb_2,nlDendapkb) ) * 0.02 ) + 0.25 )
							laArray(i,4) = Iif((Year(dltgl_notice_sd) > Year(dltgl_notice)),pembulatan(lnPajak),0)
					CASE llDendaPkb And !propk 
							lnPajak      = lnPkb   * ( ( ( IIF(clDaftar1='31' or clDaftar1='32',nlDendapkb_2,nlDendapkb) ) * 0.02 ) + 0.25 )
							laArray(i,4) = Iif((Year(dltgl_notice_sd) > Year(dltgl_notice)),pembulatan(lnPajak),0)
					CASE llDendaPkb And lcDumb 
							lnPajak      = lnPkb   * ( ( ( IIF(clDaftar1='31' or clDaftar1='32',nlDendapkb_2,nlDendapkb) ) * 0.02 ) + 0.25 )
							laArray(i,4) = Iif((Year(dltgl_notice_sd) > Year(dltgl_notice)),pembulatan(lnPajak),0)
				ENDCASE
				
			
			Case clDaftar1 = '31' 
			
				*===================================================================================================================================================
				If lcPlat <> 'MERAH'

					nTahun     = nTahun+1
					nTahun     = IIF( nTahun > 5,5,nTahun) 
					nlDendapkb = Iif(nlDendapkb=0,1,nlDendapkb)

					If !perpanjangan

						If (llDendaPkb And !propk) Or (llDendaPkb And propk And clBulanPkb > 12) Or (llDendaPkb And lcDumb)

							lnPajak     = (lnPkb * nTahun *  0.25)   + (lnPkb * nTahun * nlDendapkb * 0.02) && 2%

							lnPajak     = Iif(llDendaSwd,lnPajak,0)
							status25    = Iif(llDendaSwd,1,0)
							bulan_denda = Iif(llDendaSwd,nlDendapkb,0)

							laArray(i,4) = Iif((Year(dltgl_notice_sd) > Year(dltgl_notice)) ,pembulatan(lnPajak),0)

						Endif
					
					Else

						If (llDendaPkb And !propk) Or (llDendaPkb And propk And clBulanPkb > 12) Or (llDendaPkb And lcDumb)

							lnPajak      = (lnPkb * nTahun *  0.25) + (lnPkb * nTahun *  nlDendapkb * 0.02) && 2%

							lnPajak      = Iif(llDendaSwd,lnPajak,0)
							status25     = Iif(llDendaSwd,1,0)
							bulan_denda  = Iif(llDendaSwd,nlDendapkb,0)

							laArray(i,4) = Iif((Year(dltgl_notice_sd) > Year(dltgl_notice)) ,pembulatan(lnPajak),0)


						Endif

					Endif

					nlDendapkb  = Iif(llDendaSwd,nlDendapkb,0)
					thtunggak   = Iif(nTahun > 1,((nTahun-1)*12),0)
					jbulan      = thtunggak+nlDendapkb

					txtdenda    = 'Denda '+Transform(jbulan)+' bulan = '+Transform(jbulan*2)+'%+25% denda ='+Transform( Iif((jbulan*2)+25>73,73,(jbulan*2)+25))+'% denda'
					njkb_denda  = Iif(llDendaSwd,jbulan,0)
					
				ENDIF 	
				*===================================================================================================================================================

			
				*===================================================================================================================================================
				If lcPlat = 'MERAH'

					nTahun     = nTahun+1
					nTahun     = IIF( nTahun > 5,5,nTahun) 
					nlDendapkb = Iif(nlDendapkb=0,1,nlDendapkb)

					If !perpanjangan

						If (llDendaPkb And !propk) Or (llDendaPkb And propk And clBulanPkb > 12) Or (llDendaPkb And lcDumb)
							
							&&lnPajak     = (lnPkb * nTahun *  0.25)   + (lnPkb * nTahun * nlDendapkb * 0.02) && 2%
							lnPajak     = (lnPkb * 1 *  0.25)   + (lnPkb * 1 * nlDendapkb * 0.02) && 2%
							
							lnPajak     = Iif(llDendaSwd,lnPajak,0)
							status25    = Iif(llDendaSwd,1,0)
							bulan_denda = Iif(llDendaSwd,nlDendapkb,0)

							laArray(i,4) = Iif((Year(dltgl_notice_sd) > Year(dltgl_notice)) ,pembulatan(lnPajak),0)
							&&laArray(i,4) = Iif((Year(dltgl_notice_sd) > Year(dltgl_notice)) ,0,0)
						
						Endif
					
					Else

						If (llDendaPkb And !propk) Or (llDendaPkb And propk And clBulanPkb > 12) Or (llDendaPkb And lcDumb)

							lnPajak      = (lnPkb * nTahun *  0.25) + (lnPkb * nTahun *  nlDendapkb * 0.02) && 2%
							lnPajak      = Iif(llDendaSwd,lnPajak,0)
							status25     = Iif(llDendaSwd,1,0)
							bulan_denda  = Iif(llDendaSwd,nlDendapkb,0)

							laArray(i,4) = Iif((Year(dltgl_notice_sd) > Year(dltgl_notice)) , pembulatan(lnPajak),0)

						Endif

					Endif

					nlDendapkb  = Iif(llDendaSwd,nlDendapkb,0)
					jbulan      = nlDendapkb

					txtdenda    = 'Denda '+Transform(jbulan)+' bulan = '+Transform(jbulan*2)+'%+25% denda ='+Transform( Iif((jbulan*2)+25>73,73,(jbulan*2)+25))+'% denda'
					njkb_denda  = Iif(llDendaSwd,jbulan,0)
					
				ENDIF 	
				*===================================================================================================================================================
			
			Endcase

		Case laArray(i,2) = '14'  && hitung pokok swdkllj

			nlDendaswd = Iif(nlDendaswd >= 12,12,nlDendaswd)
			lnPro      = 'lnProrata'+Allt(Str(nlDendaswd))
			lnSWDKLLJ  = lnSwd_pk + lnSwd_lg

			If nlDendaswd >= 12
				lnProrata12 = 0
			Endif

			If nlDendaswd = 0
				lnProrata0 = 0
			Endif

			If !proSw Or clBulanswd = 12 &&btidak prorata

				If ( Year(dltgl_notice_sd) = Year(dltgl_notice) And clDaftar1='71' )  OR  ( Year(dltgl_notice_sd) = Year(dltgl_notice) And clDaftar1='41' ) ;
      				OR  ( Year(dltgl_notice_sd) = Year(dltgl_notice) And clDaftar1='31' )  OR  ( Year(dltgl_notice_sd) = Year(dltgl_notice) And clDaftar1='06' )
					&&laArray(i,3) = lnSwd_lg
					laArray(i,3) = 0
				Else
					laArray(i,3) = Iif((Year(dltgl_notice_sd) > Year(dltgl_notice)) ,lnSWDKLLJ,0)
				Endif

			Else
				If clBulanswd > 12 &&lebih dari 12 bulan
					laArray(i,3) = lnSWDKLLJ + &lnPro
				Else
					laArray(i,3) = Iif(clBulanswd # 0,&lnPro,0)
				Endif
			ENDIF
			
			
			*=====================================================================================================================================================
			IF clDaftar1 = '34'
				laArray(i,3) = ( clBulanswd_thn * lnSWDKLLJ ) + &lnPro
			ENDIF 			
			*=====================================================================================================================================================
			

		Case laArray(i,2) = '24' && denda swd
			
			DO CASE 
			Case clDaftar1 <> '31' And clDaftar1 <> '32'
				
				If (llDendaSwd And !proSw  ) Or (llDendaSwd And proSw And clBulanswd > 12 )
					laArray(i,4) = Iif((Year(dltgl_notice_sd) > Year(dltgl_notice)) , Iif(lnSwd_pk>100000,100000,lnSwd_pk) ,0)
				ENDIF
				
				IF clDaftar1 = '34'

					If llDendaSwd 
						
						*===================================================================================================================================================
						nHari_tgk_biasa   = date_diff(dltgl_notice,pdtgl_ttp_2,'D')
						nTahun_tgk_biasa  = date_diff(dltgl_notice,pdtgl_ttp_2,'Y') 
						nBulan_tgk_biasa  = date_diff(dltgl_notice,pdtgl_ttp_2,'M')
						*===================================================================================================================================================
						
						laArray(i,4) = Iif(lnSwd_pk>100000,100000,lnSwd_pk) + ( Iif(lnSwd_pk>100000,100000,lnSwd_pk) * ntahun_tunggakan_swd )
		
						DO CASE 
							CASE nTahun_tgk_biasa = 1 AND nHari_tgk_biasa >= 1  
									laArray(i,4)  = Iif(lnSwd_pk > 100000,100000,lnSwd_pk) * 2
							CASE nTahun_tgk_biasa = 2 AND nHari_tgk_biasa >= 1  
									laArray(i,4)  = Iif(lnSwd_pk > 100000,100000,lnSwd_pk) * 3
							CASE nTahun_tgk_biasa = 3 AND nHari_tgk_biasa >= 1  
									laArray(i,4)  = Iif(lnSwd_pk > 100000,100000,lnSwd_pk) * 4
							CASE nTahun_tgk_biasa = 4 AND nHari_tgk_biasa >= 1  
									laArray(i,4)  = Iif(lnSwd_pk > 100000,100000,lnSwd_pk) * 5
							CASE nTahun_tgk_biasa >= 5 AND nHari_tgk_biasa >= 1 
									laArray(i,4)  = Iif(lnSwd_pk > 100000,100000,lnSwd_pk) * 5
						ENDCASE 
						
					ENDIF
				
				ENDIF 
			
			Case clDaftar1 = '31' or clDaftar1 = '32'
		
				If (llDendaSwd And !proSw AND propk ) Or (llDendaSwd And proSw And clBulanswd > 12 AND propk)
					laArray(i,4) = Iif((Year(dltgl_notice_sd) > Year(dltgl_notice)) , Iif(lnSwd_pk>100000,100000,lnSwd_pk) ,0)
				Endif

			ENDCASE 

		Case laArray(i,2) = '15'  && hitung adm STNK
			If clJenisKend ='R' && Jenis SEPEDA MOTOR, SPM R3, SEPEDA MOTOR R4
				laArray(i,3) = Iif(!Isnull(konfig.stnk_bpkb),konfig.stnk_bpkb,0)
			Else
				laArray(i,3) = Iif(!Isnull(konfig.stnk_bpkb4),konfig.stnk_bpkb4,0)
			Endif

		Case laArray(i,2) = '16'  && hitung adm TNKB
			If clJenisKend ='R' && Jenis SEPEDA MOTOR, SPM R3, SEPEDA MOTOR R4
				laArray(i,3) = Iif(!Isnull(konfig.stnk_bpkb),konfig.nkb,0)
			Else
				laArray(i,3) = Iif(!Isnull(konfig.stnk_bpkb4),konfig.nkbii,0)
			Endif

		Case laArray(i,2) = '18'  && sp3

			Do Case

			Case clDaftar1 = '01'

				If clJenisKend ='R' && Jenis SEPEDA MOTOR, SPM R3, SEPEDA MOTOR R4
					laArray(i,3) = Iif(!Isnull(konfig.pendapatan_2),konfig.pendapatan_2,0)
				Else
					Do Case
					Case clJenisKend  = 'A' Or clJenisKend  = 'B' Or clJenisKend  = 'G' Or (clJenisKend  = 'F' And ;
							(clJenis='301'Or clJenis='302'Or clJenis='303'Or clJenis='304'Or clJenis='305' Or clJenis='306'))
						laArray(i,3) = Iif(!Isnull(konfig.pendapatan_4a),konfig.pendapatan_4a,0)
					Case clJenisKend = 'C' Or clJenis='301'Or clJenis='302'Or clJenis='303'Or clJenis='304'Or clJenis='305' Or clJenis='306'
						laArray(i,3) = Iif(!Isnull(konfig.pendapatan_4b),konfig.pendapatan_4b,0)
					Case clJenisKend = 'D' Or clJenisKend  = 'E'
						laArray(i,3) = Iif(!Isnull(konfig.pendapatan_4c),konfig.pendapatan_4c,0)
					Otherwise
						laArray(i,3) = Iif(!Isnull(konfig.pendapatan_4a),konfig.pendapatan_4a,0)
					Endcase
				Endif

			Case clDaftar1 = '33' Or clDaftar1 = '34'

				If  clJenisKend ='R' && Jenis SEPEDA MOTOR, SPM R3, SEPEDA MOTOR R4
					laArray(i,3) = Iif(!Isnull(konfig.akdpr2),konfig.akdpr2,0)
				Else
					laArray(i,3) = Iif(!Isnull(konfig.akdpr4),konfig.akdpr4,0)
				Endif

			Endcase

		Endcase

	Else
		laArray(i,1) = ''
		laArray(i,3) = 0
		laArray(i,4) = 0
	Endif
Endfor

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

If ltetap

	Select temp
	cnum = 6

	For i = 1 To 10

		cjns  = laArray(i,1)
		npk   = laArray(i,3)
		ndnd  = laArray(i,4)

		csql  = 'select ket,LEFT(jenis,1) as iden from ajsetor where jsetor=?cJns'
		SQLExec(gnconnhandle,csql)

		cket  = ket
		ciden = iden

		Select temp
		Do Case
		Case cjns = '02A' Or cjns = '02B' Or cjns = '06B' Or cjns = '06C'
			Locate For KODE = '001' &&bbn
			If ciden = '1'
				Replace pokok_b With npk,kd_as1 With cjns
			Else
				Replace denda_b With ndnd,kd_as2 With cjns
			Endif
		Case cjns = '01' Or cjns = '06A'
			Locate For KODE = '002' &&pkb
			If ciden = '1'
				Replace pokok_b With npk,kd_as1 With cjns
			Else
				Replace denda_b With ndnd,kd_as2 With cjns
			Endif
		Case cjns = '03' Or cjns = '06D'
			Locate For KODE = '003' &&swd
			If ciden = '1'
				Replace pokok_b With npk,kd_as1 With cjns
			Else
				Replace denda_b With ndnd,kd_as2 With cjns
			Endif
		Case cjns = '04'
			Locate For KODE = '004' &&stnk
			Replace pokok_b With npk,kd_as1 With cjns
		Case cjns = '05'
			Locate For KODE = '005' &&tnk
			Replace pokok_b With npk,kd_as1 With cjns
		Case cjns = '08'
			Locate For KODE = '006' &&sp3
			Replace pokok_b With npk,kd_as1 With cjns
		Endcase

	Endfor

Endif


If !ltetap
	csql1 = 'insert into pkb_biasa(no_dft , tgl_dft , jumlah ,'
	csql2 = ''
	csql3 = ''
	csql4 = ''
	csql5 = 'values (?clno_dft,?dltgl_dft,?lnjumlah, '
	csql6 = ''
	csql7 = ''
	csql8 = ''

	For i = 1 To 10

		ctextj ='jenis'+Alltrim(Str(i))+','
		ctextP ='pokok'+Alltrim(Str(i))+','
		ctextD ='denda'+Alltrim(Str(i))

		cisij = '?lasave('+Alltrim(Str(i))+',1),'
		cisiP = '?lasave('+Alltrim(Str(i))+',3),'
		cisid = '?lasave('+Alltrim(Str(i))+',4)'

		If i < 10
			ctextD=ctextD+','
			cisid=cisid+','
		Else
			ctextD=ctextD+')'
			cisid=cisid+')'
		Endif

		csql2 = csql2+ctextj
		csql3 = csql3+ctextP
		csql4 = csql4+ctextD
		csql6 = csql6+cisij
		csql7 = csql7+cisiP
		csql8 = csql8+cisid

	Next

	cstr = ''

	For k = 1 To 8
		ctext = 'csql'+Alltrim(Str(k))
		cstr = cstr+&ctext
	Next

	asq = SQLExec(gnconnhandle,cstr)
	If asq<0
		Messagebox('error Update PKB_Biasa',48,'Error')
		cek_error()
	Else
		hist_pkb_biasa(clTindakan,clno_dft,dltgl_dft)
	Endif

Endif

