* 07-02-2011 09.51

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
Local lnDasar, lnNilai, lnPkb_Bs, lnPkb_Um, lnPajak, clJenisKend, d_pkb, d_swdkllj, clGuna, clTindakan, nlDenda, nke

llpkb_nihil     = .f.  && tambahan


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

IF asg > 0

	IF reccount('lamp_2') > 0
		
		GO TOP
			
			th_njkb_lamp2_tua 	= tahun
			njkb_lamp2_tua 		= harga
		
		GO BOTTOM 
			
			th_njkb_lamp2_muda	= tahun
			njkb_lamp2_muda 	= harga
		
		DO CASE 
			
			CASE clTahun < th_njkb_lamp2_tua
				njkb_lamp2 = njkb_lamp2_tua
			CASE clTahun > th_njkb_lamp2_muda
				njkb_lamp2 = njkb_lamp2_muda
			OTHERWISE 
				SCAN FOR BETWEEN(clTahun,th_njkb_lamp2_tua,th_njkb_lamp2_muda)
					IF clTahun = tahun && tahun sama
						njkb_lamp2 = harga
						EXIT
					ENDIF 
				ENDSCAN
		ENDCASE 
	ENDIF	  

ENDIF 

njkb_tambah  = .f.

IF clDaftar1 = '51' OR clDaftar2 = '51' OR clDaftar3 = '51' OR clDaftar4 = '51' && rubah bentuk
	
	rbh_btk    = .t.
	no_rbh_btk = 2
	
	IF !ISNULL(cojenis) OR LEN(ALLTRIM(cojenis)) # 0 
		
		IF (cojenis = '301') OR  (cojenis = '351') OR (cojenis = '401') OR (cojenis ='514')
			
			clJenis     = cojenis
			cltipe      = ALLTRIM(clJenis) + ALLTRIM(SUBSTR(cltipe,4,9))
			njkb_tambah = .t.
		
		ENDIF 
	
	ENDIF 

ELSE

	no_rbh_btk =  1
	rbh_btk    = .f.

ENDIF 


*\ ambil dasar PKB 
csql = 'select * from apkb where jenis=?clJenis and kd_merk=?clMerk and tipe =?clTipe and th_buat = ?clTahun'
asg  = SQLExec(gnconnhandle,csql,'rst_pkb')

If asg < 0
	Messagebox('error get Apkb',48,'Error')
	cek_error()
	Return
Endif


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
		
			Do While .T.
				If clTahun <= th_baru
					Exit
				Endif
				th_baru = th_baru + 1
				njkb_baru = pembulatan(njkb_baru + (0.05 * njkb_baru))
				lnNilai = njkb_baru
			Enddo

		Case clTahun < th_lama1 && tipe tahun tua / lama
			
			If njkb_lama1 # njkb_lama2
				For i = 1 To 5
					If clTahun = th_lama1
						Exit
					Endif
					th_lama1 = th_lama1-1
					njkb_lama1 = pembulatan(njkb_lama1 - (0.05 * njkb_lama1))
					lnNilai = njkb_lama1

				Endfor
			Else
				lnNilai = njkb_lama1
			Endif

		Otherwise

			th_baru1 = th_baru
			Do While .T.
				If clTahun = th_baru1 Or Bof()
					Exit
				Endif
				njkb_baru = nilai_jual
				th_baru1 = th_baru1 - 1
				Skip - 1
				If Val(th_buat) # th_baru1
					For i = 1 To 5
						njkb_baru = pembulatan(njkb_baru - (0.05 * njkb_baru))
						lnNilai = njkb_baru
						If clTahun = th_baru1
							Exit
						Endif
						th_baru1 = th_baru1 - 1
					Endfor
					Exit
				Endif
			Enddo
		
		Endcase
	
	Else

		bobot    = 0
		lnNilai  = 0
		lnPkb    = 0
		llktm    = .F.

	Endif

Endif

njkb1   = IIF(njkb_tambah,lnNilai+njkb_lamp2,lnNilai)
lnNilai = IIF(rbh_btk ,njkb1,lnNilai)

DO CASE 

Case clJenisKend= 'H'
	nk = 0.002 && alat berat
Case  clGuna = '4' Or clGuna = '6' Or clGuna = '8' Or lcPlat = 'MERAH'
	*merah = njkb * bobot * 0.005
	nk = 0.005
Case lcPlat = 'KUNING'
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
Otherwise
	&& plat hitam = njkb * bobot * 0.015
	nk = 0.015
ENDCASE


lnPkb        = pembulatan(lnNilai * bobot * nk)

lnPkb_Asal   = pembulatan(IIF(njkb_tambah,(lnNilai-njkb_lamp2),(lnNilai+njkb_lamp2)) * bobot * nk)
lnPkb_kuning = pembulatan(lnNilai * bobot * 0.0075)  &&Iif(clJenisKend= 'F' Or clJenisKend ='G',0.008, 0.006) pkb kuning
lnPkb_merah  = pembulatan(lnNilai * bobot * 0.0075)


FOR nrbh = 1 TO no_rbh_btk

	IF rbh_btk 
	
		IF nrbh = 1
			clJenis = cojenis
			clGuna  = ALLTRIM(lst_header.okd_guna)
		ELSE   
			clJenis = cjenis
			clguna  = cGuna
		ENDIF 
		
	ENDIF  

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
				
				IF dltgl_dft < Ctod('27/03/2008')
					
					laSwd(nrbh) = pokok_old+leges_old
					lnSwd_pk    = pokok_old
					lnSwd_lg    = leges_old
					lnnew       = bln_new1

					For i = 1 To Iif(clDaftar1='01',1,11)
						lnPro  = 'lnProrata'+Allt(Str(i))
						lnBln  = 'bln_old'+Allt(Str(i))
						&lnPro = &lnBln
					Endfor
				
				ELSE
				
					laSwd(nrbh) = pokok_new+leges_new
					lnSwd_pk    = pokok_new
					lnSwd_lg    = leges_new
					lnnew       = bln_new1

					For i = 1 To Iif(clDaftar1='01',1,11)
						lnPro  = 'lnProrata'+Allt(Str(i))
						lnBln  = 'bln_new'+Allt(Str(i))
						&lnPro = &lnBln
					Endfor
				
				ENDIF 
			
			ELSE 

				lnSwd_pk = 0
				lnSwd_lg = 0
				lnnew    = bln_new1

				For i = 1 To Iif(clDaftar1='01',1,11)
					lnPro = 'lnProrata'+Allt(Str(i))
					&lnPro = 0
				Endfor
			
			ENDIF 
		
		ENDIF 

ENDFOR 	&&nrbh

If cDaftar <> '01'
	lnnew = 0
Endif

*--------------------------------------------------------------------------------------------------------------------------------------------------------------


nHari   = cek_tgl(dltgl_notice,dltgl_dft,'D')
nBulan  = cek_tgl(dltgl_notice,dltgl_dft,'M')

IF nbulan = 0
	nBulan 	= IIF(nHari >= 16, nBulan+1, nBulan) && terlambat 16 hari dihitung 1 bulan
ELSE 
	nBulan 	= IIF(nHari >= 1,  nBulan+1, nBulan) && terlambat 1 hari dihitung 1 bulan
ENDIF 

nlDendabbn = Iif(nBulan > 12,12,nBulan) && n bulan denda bbn
nlDendabbn = IIF(nBulan < 1, 0, nBulan)


*-- denda berjalan
*--------------------------------------------------------------------------------------------------------------------------------------------------------------


nHarid   = cek_tgl(dtglA,dltgl_dft,'D')
nBuland  = cek_tgl(dtglA,dltgl_dft,'M')

IF nbuland = 0
	nBuland = IIF(nHarid >= 16, nBuland+1,nBuland) && terlambat 16 hari pada bulan 1
ELSE 
	nBuland = IIF(nHarid >= 1 , nBuland+1,nBuland) && terlambat 1 hari pada bulan 2 dst
ENDIF 

nlDendapkb = nBuland && n bulan denda pkb
nlDendaswd = nbuland && n bulan denda swdkllj


* Untuk Mutasi Keluar 33,34 di Pangkalanbun
*--------------------------------------------------------------------------------------------------------------------------------------------------------------

nbulan_mutklr   = cek_tgl(dltgl_notice,dltgl_notice_sd,'M')
nyear_mutklr    = cek_tgl(dltgl_notice,dltgl_notice_sd,'Y')

nbulan_mutklr   = ( nyear_mutklr * 12 ) + nbulan_mutklr

IF nbulan_mutklr < 12
	mutklr = .T.
ELSE
	mutklr = .F.
ENDIF 

*--------------------------------------------------------------------------------------------------------------------------------------------------------------




ldbatas    = plusdate(dltgl_notice_sd,-1)

clBulanPkb = 12
clBulanSwd = 12
proPkb     = 0
lnCount    = 0

lcDumb     = .F.
propk      = .f.
proSw      = .f.

csql = 'select * from mslibur'
asq  = SQLExec(gnconnhandle,csql,'cs_libur')

If asq < 0
	Messagebox('error get libur')
Else
	
	Select cs_libur
	Do While .T.
		
		llLibur = IIF(Dow(ldBatas) = 1,.t.,.f.)

		* hari libur nasional
		ldbatas1 = conv_tanggal(ldBatas)
		csql     = 'select * from mslibur where tgl = ?ldbatas1 '
		asq      = SQLExec(gnconnhandle,csql,'cari_libur')
		
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
				EXIT 
			Endif
		
		Endif
	
	ENDDO 

ENDIF 

llDendaBbn = .f.
llDendaPkb = Iif( ldbatas + Val(konfig.bts_pkb) < dltgl_dft, .T., .F.)
llDendaSwd = llDendaPkb




For j = 1 To 4

	lcJns_Dft = 'clDaftar'+Allt(Str(j))
	lcMohon   = &lcJns_Dft
	
	
	*\ tentukan batas waktu kena denda
	lcMohon = Iif(Isnull(lcMohon),'',lcMohon)
	lcMohon = Alltrim(lcMohon)
	
	If Len(lcMohon) # 0
		
		DO  CASE 
		CASE  lcMohon = '01' && BBN1
			
			dltgl_dft    = pdtgl_trans
			beda_nama    = .T.
			dltgl_faktur = Iif(!Isnull(dltgl_faktur),dltgl_faktur,dltgl_dft)
			dltgl_faktur = IIF(dltgl_dft < dltgl_faktur, dltgl_dft, dltgl_faktur)
			nBulan 	     = cek_tgl(dltgl_faktur,dltgl_dft,'M')
			nTahun		 = cek_tgl(dltgl_faktur,dltgl_dft,'Y')
			nBulan       = (nTahun * 12) + nBulan						
			
			nlDendabbn   = Iif(nBulan > 24,24,nBulan)  && n bulan denda bbn
			nlDendabbn   = Iif(nBulan < 1,0,nBulan)
			nlDendapkb   = nlDendabbn                  && n bulan denda pkb
			nlDendaswd   = nlDendabbn                  && n bulan denda swdkllj
			
			llDendaBbn   = Iif(dltgl_faktur+30 < dltgl_dft,.T.,.F.) && 30 hari dari tgl faktur
			llDendaPkb   = llDendaBbn
			llDendaSwd   = llDendaBbn	
			
		CASE  lcMohon = '41' Or lcMohon = '42' Or lcMohon = '43' Or lcMohon = '44' Or lcMohon = '47' Or lcMohon = '52'  && BBN2
			
			beda_nama      = .T.
			dltgl_kuitansi = IIF(!ISNULL(dltgl_kuitansi), dltgl_kuitansi , dltgl_dft)
			dltgl_kuitansi = IIF(dltgl_dft < dltgl_kuitansi, dltgl_dft , dltgl_kuitansi)
			
			nBulan         = cek_tgl(dltgl_kuitansi,dltgl_dft,'M')
			nTahun         = cek_tgl(dltgl_kuitansi,dltgl_dft,'Y')
			nBulan         = (nTahun * 12) + nBulan
									
			nlDendabbn     = Iif(nBulan > 24,24,nBulan)                   && n bulan denda bbn
			nlDendabbn     = IIF(nlDendabbn < 1, 0 , nlDendabbn)
			llDendaBbn     = Iif(dltgl_kuitansi + 30 < dltgl_dft,.T.,.F.) && 30 hari dari tgl kuitansi
			
			&& tambahan
			cseltgl_b = cek_tgl(dltgl_notice_sd,dltgl_dft,'M')
			cseltgl_y = cek_tgl(dltgl_notice_sd,dltgl_dft,'Y')
			cseltgl_d = cek_tgl(dltgl_notice_sd,dltgl_dft,'D')
			
			IF cseltgl_b >=1 AND cseltgl_y < 1
				
				IF dltgl_notice > dltgl_dft
				
					llDendaPkb  = .f.
					llpkb_nihil = .t.
					llDendaSwd  = .f.
				
				ENDIF 
		
			ENDIF 
					
		
		CASE  lcMohon = '45' Or lcMohon = '46' Or lcMohon = '77' 	&& dumb
		
					
			*!*				beda_nama	 = .T.
			*!*				lcDumb		 = .T. && dumb
			*!*				
			*!*				dlosd_swd	 = IIF(!isnull(dosd_swd),dosd_swd,dltgl_dft)
			*!*				cltgl_sk 	 = IIF(!ISNULL(cltgl_sk),cltgl_sk,dltgl_dft)
			*!*				cltgl_sk	 = IIF(dltgl_dft < cltgl_sk, dltgl_dft , cltgl_sk)
			*!*				
			*!*				nHari	     = date_diff(cltgl_sk,dltgl_dft,'D')
			*!*				nBulan       = date_diff(cltgl_sk,dltgl_dft,'M')
			*!*				nTahun       = date_diff(cltgl_sk,dltgl_dft,'Y')
			*!*				
			*!*				IF nhari >= 1
			*!*					nbulan = nbulan + 1
			*!*				ENDIF 	
			*!*				
			*!*				nlDendabbn   = ( nTahun * 12 ) + nBulan
			*!*				nlDendabbn   = IIF(nlDendabbn >= 24, 24,nlDendabbn) && n bulan denda bbn
			*!*				nlDendabbn   = IIF(nlDendabbn < 1, 0, nlDendabbn)
			*!*				
			*!*				llDendaBbn   = Iif(cltgl_sk + 30 < dltgl_dft,.T.,.F.) && 30 hari dari tgl sk risalah lelang
			*!*				
			*!*				DO CASE 
			*!*					
			*!*					CASE  dltgl_dft <= dosd_notice  && pajak masih berlaku
			*!*											
			*!*						th_tunggak     = date_diff(cltgl_sk,dltgl_dft,'Y')
			*!*						tgl_pajak_lalu = plusdate(cltgl_sk,th_tunggak)																	
			*!*						nHari	       = date_diff(tgl_pajak_lalu,dltgl_dft,'D') 
			*!*						nBulan	       = date_diff(tgl_pajak_lalu,dltgl_dft,'M') && prorata
			*!*						
			*!*						nlDendapkb     = Iif(nBulan > 12,12,nBulan)   && n bulan denda pkb
			*!*						nlDendapkb     = IIF(th_tunggak = 0, nlDendapkb , IIF(nHari > 0, nlDendapkb+1,nlDendapkb))
			*!*						nBulan         = cek_tgl(dosd_notice,dltgl_dft,'M')
			*!*						nTahun         = cek_tgl(dosd_notice,dltgl_dft,'Y')
			*!*						nBulan         = IIF(nTahun >= 1 , 12, nBulan)
			*!*						a              = (12 - nBulan)										
			*!*						clBulanPkb     = a && ngga penting &&IIF(tgl_pajak_lalu < dltgl_dft, 12 + nBulan ,12 - nBulan)
			*!*						proPkb	       = (lnPkb-lnPkb_Merah) + ((lnPkb / 12) * a)
			*!*						llDendaPkb     = IIF(tgl_pajak_lalu + Val(konfig.bts_pkb) < dltgl_dft,.t.,.f.)
			*!*				
			*!*					OTHERWISE 	
			*!*					
			*!*						nBulan     = Iif(nBulan > 12,12, nBulan)  &&denda 
			*!*						nBulan     = IIF(nBulan < 1, 0, nBulan)
			*!*						clBulanPkb = 12 + IIF(nBulan = 12, 0,nBulan) &&prorata
			*!*						proPkb     = ( lnPkb / 12 ) * (nBulan)
			*!*						nlDendapkb = IIF( nHari > 0, nBulan+1 , nBulan)
			*!*						nlDendapkb = Iif( nlDendapkb > 12,12,nlDendapkb)
			*!*						llDendaPkb = Iif(cltgl_sk+Val(konfig.bts_pkb)<dltgl_dft, .T.,.F.)
			*!*				
			*!*				ENDCASE  
			*!*				
			*!*				propk      = IIF(clBulanPkb = 12,.f.,.t.)
			*!*								
			*!*				nBulan     = cek_tgl(dlosd_swd,dltgl_dft,'M')
			*!*				nTahun     = cek_tgl(dlosd_swd,dltgl_dft,'Y')
			*!*				clBulanswd = IIF(dlosd_swd < dltgl_dft, 12+nBulan, 12-IIF(ntahun >= 1, 12,nBulan))
			*!*				nlDendaswd = IIF(clBulanswd > 12, clBulanswd -12, clBulanswd)
			*!*				llDendaSwd = Iif(dlosd_swd+Val(konfig.bts_pkb)<dltgl_dft, .T.,.F.)
			*!*				prosw      = IIF(nlDendaswd = 12,.f.,.t.)
			*!*							
			*!*				* mencari tanggal faktur
			*!*				
			*!*				clnilai_jual      = Iif(clnilai_jual > 0 Or !Isnull(clnilai_jual) , clnilai_jual,lnNilai)
			*!*				hnotice           = Alltrim(Str(Day(dosd_notice)))
			*!*				bnotice           = Alltrim(Str(Month(dosd_notice)))
			*!*				ynotice           = Alltrim(STR(clTahun)) && tahun buat
			*!*				tgl_faktur_kosong = Ctod(hnotice+'/'+bnotice+'/'+ynotice)
			*!*				dltgl_faktur      = Iif(!Isnull(dltgl_faktur) Or dltgl_faktur # Ctod('  /  /    '),dltgl_faktur,tgl_faktur_kosong)
			*!*				&&ndumb             = Iif(dltgl_faktur < Ctod('01/04/2011'),0.15,0.01) && < 01/04/2012 = 12,5%, > 01/04/2012 = 1%
			*!*				ndumb             = 0.01
	
		
		
			beda_nama	 = .T.
			lcDumb		 = .T.  && dumb
			
			dlosd_swd	 = IIF(!isnull(dosd_swd),dosd_swd,dltgl_dft)
			cltgl_sk 	 = IIF(!ISNULL(cltgl_sk),cltgl_sk,dltgl_dft)
			cltgl_sk	 = IIF(dltgl_dft < cltgl_sk, dltgl_dft , cltgl_sk)
			
			nHari	     = cek_tgl(cltgl_sk,dltgl_dft,'D')
			nBulan       = cek_tgl(cltgl_sk,dltgl_dft,'M')
			nTahun       = cek_tgl(cltgl_sk,dltgl_dft,'Y')
			
			IF nhari >= 1
				nbulan = nbulan + 1
			ENDIF 	
			
			nlDendabbn   = ( nTahun * 12 ) + nBulan
			nlDendabbn   = IIF(nlDendabbn >= 24, 24,nlDendabbn) && n bulan denda bbn
			nlDendabbn   = IIF(nlDendabbn < 1, 0, nlDendabbn)
			
			llDendaBbn   = Iif(cltgl_sk + 30 < dltgl_dft,.T.,.F.) && 30 hari dari tgl sk risalah lelang
			
			DO CASE 
				
				CASE  dltgl_dft <= dosd_notice  && pajak masih berlaku
										
					th_tunggak     = cek_tgl(cltgl_sk,dltgl_dft,'Y')
					tgl_pajak_lalu = plusdate(cltgl_sk,th_tunggak)																	
					nHari	       = cek_tgl(tgl_pajak_lalu,dltgl_dft,'D') 
					nBulan	       = cek_tgl(tgl_pajak_lalu,dltgl_dft,'M') && prorata
					
					nlDendapkb     = Iif(nBulan > 12,12,nBulan)   && n bulan denda pkb
					nlDendapkb     = IIF(th_tunggak = 0, nlDendapkb , IIF(nHari > 0, nlDendapkb+1,nlDendapkb))
					nBulan         = cek_tgl(dosd_notice,dltgl_dft,'M')
					nTahun         = cek_tgl(dosd_notice,dltgl_dft,'Y')
					nBulan         = IIF(nTahun >= 1 , 12, nBulan)
					a              = (12 - nBulan)										
					clBulanPkb     = a && ngga penting &&IIF(tgl_pajak_lalu < dltgl_dft, 12 + nBulan ,12 - nBulan)
					proPkb	       = (lnPkb-lnPkb_Merah) + ((lnPkb / 12) * a)
					llDendaPkb     = IIF(tgl_pajak_lalu + Val(konfig.bts_pkb) < dltgl_dft,.t.,.f.)
			
				OTHERWISE 	
				
					nBulan     = Iif(nBulan > 12,12, nBulan)  &&denda 
					nBulan     = IIF(nBulan < 1, 0, nBulan)
					clBulanPkb = 12 + IIF(nBulan = 12, 0,nBulan) &&prorata
					proPkb     = ( lnPkb / 12 ) * (nBulan)
					nlDendapkb = IIF( nHari > 0, nBulan+1 , nBulan)
					nlDendapkb = Iif( nlDendapkb > 12,12,nlDendapkb)
					llDendaPkb = Iif(cltgl_sk+Val(konfig.bts_pkb)<dltgl_dft, .T.,.F.)
			
			ENDCASE  
			
			propk      = IIF(clBulanPkb = 12,.f.,.t.)
							
			nBulan     = cek_tgl(dlosd_swd,dltgl_dft,'M')
			nTahun     = cek_tgl(dlosd_swd,dltgl_dft,'Y')
			clBulanswd = IIF(dlosd_swd < dltgl_dft, 12+nBulan, 12-IIF(ntahun >= 1, 12,nBulan))
			nlDendaswd = IIF(clBulanswd > 12, clBulanswd -12, clBulanswd)
			llDendaSwd = Iif(dlosd_swd+Val(konfig.bts_pkb)<dltgl_dft, .T.,.F.)
			prosw      = IIF(nlDendaswd = 12,.f.,.t.)
						
			* mencari tanggal faktur
			
			clnilai_jual      = Iif(clnilai_jual > 0 Or !Isnull(clnilai_jual) , clnilai_jual,lnNilai)
			hnotice           = Alltrim(Str(Day(dosd_notice)))
			bnotice           = Alltrim(Str(Month(dosd_notice)))
			ynotice           = Alltrim(STR(clTahun)) && tahun buat
			tgl_faktur_kosong = Ctod(hnotice+'/'+bnotice+'/'+ynotice)
			dltgl_faktur      = Iif(!Isnull(dltgl_faktur) Or dltgl_faktur # Ctod('  /  /    '),dltgl_faktur,tgl_faktur_kosong)
			&&ndumb             = Iif(dltgl_faktur < Ctod('01/04/2011'),0.15,0.01) && < 01/04/2012 = 12,5%, > 01/04/2012 = 1%
			ndumb             = 0.01
						
		
		
		
		CASE  lcMohon = '31' && mutasi masuk dalam prop
					
			
			* CODING PERTAMA HANYA BBN SAJA
			
			*===========================================================================================================
			*!*				dltgl_kuitansi	= IIF(!ISNULL(dltgl_kuitansi),dltgl_kuitansi,dltgl_dft)
			*!*				dltgl_kuitansi	= IIF(dltgl_dft < dltgl_kuitansi, dltgl_dft, dltgl_kuitansi)
			*!*				
			*!*				nBulan          = cek_tgl(dltgl_kuitansi,dltgl_dft,'M')
			*!*				nTahun          = cek_tgl(dltgl_kuitansi,dltgl_dft,'Y')
			*!*				nBulan          = (nTahun * 12) + nBulan

			*!*				nBulan          = IIF(nBulan >= 24, 24,nBulan)
			*!*				nlDendabbn      = IIF(nBulan < 1, 0 ,nBulan)
			*!*							
			*!*				llDendaBbn      = Iif(dltgl_kuitansi + 30 < dltgl_dft,.T.,.F.) && 30 hari dari tgl kuitansi
			*===========================================================================================================
			
									
			dltgl_fiskal 	= IIF(!ISNULL(dltgl_fiskal),dltgl_fiskal,dltgl_dft)
			dltgl_fiskal	= IIF(dltgl_dft < dltgl_fiskal, dltgl_dft, dltgl_fiskal)
			dltgl_kuitansi	= IIF(!ISNULL(dltgl_kuitansi),dltgl_kuitansi,dltgl_dft)
			dltgl_kuitansi	= IIF(dltgl_dft < dltgl_kuitansi, dltgl_dft, dltgl_kuitansi)
			dlosd_swd		= IIF(!isnull(dosd_swd),dosd_swd,dltgl_dft)
					
			
			* BBN
			*===========================================================================================================
			nBulan          = cek_tgl(dltgl_kuitansi,dltgl_dft,'M')
			nTahun          = cek_tgl(dltgl_kuitansi,dltgl_dft,'Y')
			nBulan          = (nTahun * 12) + nBulan
			nBulan 	        = IIF(nBulan >= 24, 24,nBulan)
			nlDendabbn      = IIF(nBulan < 1, 0 ,nBulan)
			
			
			* PKB
			*====================================================================================================
			*!*				nBulan          = cek_tgl(dltgl_fiskal,dltgl_dft,'M')
			*!*				nHari31         = cek_tgl(dltgl_fiskal,dltgl_dft,'D')
			*!*				
			*!*				nBulan 	        = IIF(nHari31 >= 1,  nBulan+1, nBulan) && terlambat 1 hari dihitung 1 bulan
			*!*				
			*!*				nlDendapkb      = Iif(nBulan > 12,12,nBulan)   && n bulan denda pkb
			*!*				nlDendapkb      = IIF(nBulan < 1, 0,nBulan)
			*!*				proPkb          = (lnPkb / 12) * (nlDendapkb) && harga pkb n bulan 
			*!*				clBulanPkb      = IIF(dltgl_fiskal < dltgl_dft, 12+nlDendapkb, 12)
				
			
			* PKB
			*====================================================================================================
			nBulan31        = cek_tgl(dosd_notice,dltgl_notice_sd,'M')
			nHari31         = cek_tgl(dosd_notice,dltgl_notice_sd,'D')
			nYear31         = cek_tgl(dosd_notice,dltgl_notice_sd,'Y')
			
			IF nBulan31 = 0 AND nyear31 = 1
				nBulan    = 12
			ELSE 
				nBulan 	  = IIF(nHari31 >= 1,  nBulan31+1, nBulan31) && terlambat 1 hari dihitung 1 bulan
			ENDIF 
						
			nlDendapkb      = Iif(nBulan > 12,12,nBulan)   && n bulan denda pkb
			nlDendapkb      = IIF(nBulan < 1, 0,nBulan)
			proPkb          = (lnPkb / 12) * (nlDendapkb) && harga pkb n bulan 
			
			IF nBulan31 = 0 AND nyear31 = 1
				clBulanPkb  = 12
			ELSE
				clBulanPkb  = ( nYear31 * 12 ) + nlDendapkb
			ENDIF 			
			 
			
			* SWD
			*====================================================================================================
			*!*				nBulan          = cek_tgl(dlosd_swd,dltgl_dft,'M')
			*!*				nHari31         = cek_tgl(dlosd_swd,dltgl_dft,'D')
			*!*				
			*!*				nBulan 	        = IIF(nHari31 >= 1,  nBulan+1, nBulan) && terlambat 1 hari dihitung 1 bulan
			*!*				
			*!*				nlDendaswd      = nBulan
			*!*				clBulanswd      = IIF(dlosd_swd < dltgl_dft, 12+nBulan, 12-nBulan)
			*!*				nlDendaswd      = IIF(clBulanswd > 12, clBulanswd -12, clBulanswd)
			
			nBulan          = cek_tgl(dosd_notice,dltgl_notice_sd,'M')
			nHari31         = cek_tgl(dosd_notice,dltgl_notice_sd,'D')
			nYear31         = cek_tgl(dosd_notice,dltgl_notice_sd,'Y')
			
			nBulan 	        = IIF(nHari31 >= 1,  nBulan+1, nBulan) && terlambat 1 hari dihitung 1 bulan
			
			nlDendaSWD      = Iif(nBulan > 12,12,nBulan)   && n bulan denda pkb
			nlDendaSWD      = IIF(nBulan < 1, 0,nBulan)
			clBulanSWD      = ( nYear31 * 12 ) + nlDendaSWD

			*====================================================================================================
			
			llDendaBbn      = Iif(dltgl_kuitansi + 30 < dltgl_dft,.T.,.F.) && 30 hari dari tgl kuitansi
			llDendaPkb      = Iif(dltgl_fiskal + 30 < dltgl_dft,.T.,.F.) && 30 hari dari tgl fiskal 
			llDendaSwd      = iif((dlosd_swd < dltgl_dft), .t. , .f.)
		
			prosw           = IIF(nlDendaswd  = 12,.f.,.t.) 
			propk           = IIF(nlDendapkb  = 12,.f.,.t.)
			
			*====================================================================================================
				
		CASE  lcMohon = '32' && mutasi masuk luar prop
		
			* CODING AWAL
					
			*=============================================================================================================		
			*!*				dltgl_fiskal 	= IIF(!ISNULL(dltgl_fiskal),dltgl_fiskal,dltgl_dft)
			*!*				dltgl_fiskal	= IIF(dltgl_dft < dltgl_fiskal, dltgl_dft, dltgl_fiskal)
			*!*				dltgl_kuitansi	= IIF(!ISNULL(dltgl_kuitansi),dltgl_kuitansi,dltgl_dft)
			*!*				dltgl_kuitansi	= IIF(dltgl_dft < dltgl_kuitansi, dltgl_dft, dltgl_kuitansi)
			*!*				dlosd_swd		= IIF(!isnull(dosd_swd),dosd_swd,dltgl_dft)
			*!*				
			*!*				nBulan          = cek_tgl(dltgl_kuitansi,dltgl_dft,'M')
			*!*				nTahun          = cek_tgl(dltgl_kuitansi,dltgl_dft,'Y')
			*!*				nBulan          = (nTahun * 12) + nBulan
			*!*				nBulan 	        = IIF(nBulan >= 24, 24,nBulan)
			*!*				nlDendabbn      = IIF(nBulan < 1, 0 ,nBulan)
			*!*				
			*!*				nBulan          = cek_tgl(dltgl_fiskal,dltgl_dft,'M')
			*!*				nlDendapkb      = Iif(nBulan > 12,12,nBulan)   && n bulan denda pkb
			*!*				nlDendapkb      = IIF(nBulan < 1, 0,nBulan)
			*!*				proPkb          = (lnPkb / 12) * (nlDendapkb) && harga pkb n bulan 
			*!*				clBulanPkb      = IIF(dltgl_fiskal < dltgl_dft, 12+nlDendapkb, 12)
			*!*				
			*!*				nBulan          = cek_tgl(dlosd_swd,dltgl_dft,'M')
			*!*				nlDendaswd      = nBulan
			*!*				clBulanswd      = IIF(dlosd_swd < dltgl_dft, 12+nBulan, 12-nBulan)
			*!*				nlDendaswd      = IIF(clBulanswd > 12, clBulanswd -12, clBulanswd)
			*!*							
			*!*				llDendaBbn      = Iif(dltgl_kuitansi + 30 < dltgl_dft,.T.,.F.) && 30 hari dari tgl kuitansi
			*!*				llDendaPkb      = Iif(dltgl_fiskal + 30 < dltgl_dft,.T.,.F.) && 30 hari dari tgl fiskal 
			*!*				llDendaSwd      = iif((dlosd_swd < dltgl_dft), .t. , .f.)
			*!*							
			*!*				prosw           = IIF(nlDendaswd = 12,.f.,.t.) 
			*!*				propk           = IIF(nlDendapkb = 12,.f.,.t.)
			*=============================================================================================================		
			
			
			dltgl_fiskal 	= IIF(!ISNULL(dltgl_fiskal),dltgl_fiskal,dltgl_dft)
			dltgl_fiskal	= IIF(dltgl_dft < dltgl_fiskal, dltgl_dft, dltgl_fiskal)
			dltgl_kuitansi	= IIF(!ISNULL(dltgl_kuitansi),dltgl_kuitansi,dltgl_dft)
			dltgl_kuitansi	= IIF(dltgl_dft < dltgl_kuitansi, dltgl_dft, dltgl_kuitansi)
			dlosd_swd		= IIF(!isnull(dosd_swd),dosd_swd,dltgl_dft)
					
			
			* BBN
			*====================================================================================================
			nBulan          = cek_tgl(dltgl_kuitansi,dltgl_dft,'M')
			nTahun          = cek_tgl(dltgl_kuitansi,dltgl_dft,'Y')
			nBulan          = (nTahun * 12) + nBulan
			nBulan 	        = IIF(nBulan >= 24, 24,nBulan)
			nlDendabbn      = IIF(nBulan < 1, 0 ,nBulan)
			
			
			* PKB
			*====================================================================================================
			nBulan31        = cek_tgl(dosd_notice,dltgl_notice_sd,'M')
			nHari31         = cek_tgl(dosd_notice,dltgl_notice_sd,'D')
			nYear31         = cek_tgl(dosd_notice,dltgl_notice_sd,'Y')
			
			IF nBulan31 = 0 AND nyear31 = 1
				nBulan    = 12
			ELSE 
				nBulan 	  = IIF(nHari31 >= 1,  nBulan31+1, nBulan31) && terlambat 1 hari dihitung 1 bulan
			ENDIF 
			
			nlDendapkb      = Iif(nBulan > 12,12,nBulan)   && n bulan denda pkb
			nlDendapkb      = IIF(nBulan < 1, 0,nBulan)
			proPkb          = (lnPkb / 12) * (nlDendapkb) && harga pkb n bulan 
			
			IF nBulan31 = 0 AND nyear31 = 1
				clBulanPkb   = 12
			ELSE
				clBulanPkb   = ( nYear31 * 12 ) + nlDendapkb
			ENDIF 
			
			
			* SWD
			*====================================================================================================
			nBulan          = cek_tgl(dosd_notice,dltgl_notice_sd,'M')
			nHari31         = cek_tgl(dosd_notice,dltgl_notice_sd,'D')
			nYear31         = cek_tgl(dosd_notice,dltgl_notice_sd,'Y')
			
			nBulan 	        = IIF(nHari31 >= 1,  nBulan+1, nBulan) && terlambat 1 hari dihitung 1 bulan
			
			nlDendaSWD      = Iif(nBulan > 12,12,nBulan)   && n bulan denda pkb
			nlDendaSWD      = IIF(nBulan < 1, 0,nBulan)
			clBulanSWD      = ( nYear31 * 12 ) + nlDendaSWD

			*====================================================================================================
			
			llDendaBbn      = Iif(dltgl_kuitansi + 30 < dltgl_dft,.T.,.F.) && 30 hari dari tgl kuitansi
			llDendaPkb      = Iif(dltgl_fiskal + 30 < dltgl_dft,.T.,.F.) && 30 hari dari tgl fiskal 
			llDendaSwd      = iif((dlosd_swd < dltgl_dft), .t. , .f.)
		
			prosw           = IIF(nlDendaswd = 12,.f.,.t.) 
			propk           = IIF(nlDendapkb = 12,.f.,.t.)


		
		CASE  ( lcMohon = '33' Or lcMohon = '34' ) AND !MUTKLR && mutasi keluar
		
			dltgl_notice = Iif(dltgl_dft + 7 < dltgl_notice,dltgl_notice+90,dltgl_notice) && 7 hari sebelum mati pajak baru bisa bayar 1 th kedepan
			
			
		CASE ( lcMohon = '33' Or lcMohon = '34' ) AND MUTKLR
			
			nbulan_mutklr   = cek_tgl(dltgl_notice,dltgl_notice_sd,'M')
							
			clBulanPkb      =  nbulan_mutklr
			nlDendapkb      =  nbulan_mutklr
			clBulanswd      =  nbulan_mutklr
			nlDendaSwd      =  nbulan_mutklr
			
			proPkb          =  ( lnPkb/12 ) * nbulan_mutklr
			
			llDendaPkb      =  .f.
			llDendaSwd      =  .f.

			proPK           =  .t.
			PROSW           =  .t.	
		
		CASE  lcMohon = '55' &&ganti warna plat
			
			*mencari nilai pkb
			 
			IF cOWARNA_PLA = 'KUNING' AND lcPlat = 'HITAM' AND (dltgl_notice_sd = dltgl_notice)
			
				nHari      =  cek_tgl(dltgl_notice_sd,dltgl_dft,'D')
				nBulan     =  cek_tgl(dltgl_notice_sd,dltgl_dft,'M')
				nTahun     =  cek_tgl(dltgl_notice_sd,dltgl_dft,'Y')
				nBulan     =  IIF(nTahun >= 1, 12, nBulan)
								
				clBulanPkb =  nBulan
				
				clBulanPkb =  IIF(nBulan = 12, 11 ,nBulan)
				nlDendapkb =  nBulan
				
				clBulanswd =  nBulan
				nlDendaSwd =  nBulan &&nBulan 
				proPkb     =  (lnPkb/12)*nlDendapkb
				llDendaPkb =  .f.
				llDendaSwd =  .f.

				proPK      =  .t.
				PROSW      =  .t.
				
			ENDIF 
			
			IF cOWARNA_PLA = 'HITAM' AND lcPlat = 'KUNING' AND (dltgl_notice_sd = dltgl_notice)
				
				clBulanPkb = 0
				nlDendapkb = 0
				clBulanswd = 0
				nlDendaSwd = 0 
				proPkb	   = 0 && pkb selisih per bulan 
				llDendaPkb = .f.
				llDendaSwd = .f.

				proPK      = .t.
				PROSW      = .t.
			
			ENDIF 
								
		
		CASE lcMohon = '51' && rubah bentuk
								
			dlubh_btk  = IIF(!ISNULL(cubh_btk),cubh_btk,dltgl_dft)
			dlubh_btk  = IIF(dltgl_dft < cubh_btk, dltgl_dft,cubh_btk)
			
			nBulan     = cek_tgl(dlubh_btk,dltgl_dft,'M')
			nTahun     = cek_tgl(dlubh_btk,dltgl_dft,'Y')
			nBulan     = (nTahun * 12) + nBulan
			nBulan 	   = IIF(nBulan >= 24, 24,nBulan)
			nlDendabbn = IIF(nBulan < 1, 0 ,nBulan)
			llDendaBbn = Iif(dlubh_btk + 30 < dltgl_dft,.T.,.F.) && 30 hari dari tgl kuitansi
			
			IF dltgl_notice_sd = dltgl_notice
			
				nBulan    = cek_tgl(dltgl_notice_sd,dltgl_dft,'M')
				nTahun51  = cek_tgl(dltgl_notice_sd,dltgl_dft,'Y')
				
				nBulan    = ( nTahun51 * 12 ) + nBulan
				
				IF lnPkb > lnPkb_asal
					proPkb     = ((lnPkb -lnPkb_asal)/12)*nBulan
					clBulanPkb = nBulan
					nlDendapkb = nBulan
					proPk      = .t.
				ENDIF 
				
				IF laSwd(1) < laSwd(2)  &&laSwd2= harga jr terbaru
					clBulanswd = nBulan
					nlDendaSwd = clBulanswd  
				ELSE
					clBulanswd = 0
					nlDendaSwd = 0
				ENDIF 
				
				prosw = .t.
				
			ENDIF 
			
			beda_nama = .t.
								
		ENDCASE 

		*\ hitung pajak biasa
		
		csql = 'Select * FROM Ajpajak WHERE j_pajak=?lcMohon'
		asg  = SQLExec(gnconnhandle,csql,'rst_pajak')

		IF asg < 0
			Messagebox('error get APajak',48,'Error')
			cek_error()
		ELSE 
		
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
					
				ENDCASE 

			ENDFOR 

		ENDIF 

		

		*\ hitung pajak biasa

		For i = 1 To 10

			If !Empty(laArray(i,1))
						
						
				DO  CASE 
					
				CASE  laArray(i,2) = '11' Or laArray(i,2) = '12' 	    && Hitung Pokok BBNKB I & II
					
				
					DO CASE 
						
						CASE  lcDumb   	&& dumb
							lnPajak = clnilai_jual * ndumb
						CASE rbh_btk    && rubah bentuk
							lnPajak = njkb_lamp2 * 0.1 
						CASE lcPlat = 'KUNING' OR lcPlat = 'MERAH' 	&& Umum
							* jenis ken : f dan g itu mobil beban
							lnPajak =  lnNilai * Iif(laArray(i,2)='11', 0.13, 0.01 ) &&Iif(clJenisKend= 'F' Or clJenisKend ='G', 0.8, 0.6) *
						OTHERWISE && plat merah & hitam
							lnPajak = lnNilai * Iif(laArray(i,2)='11', 0.13, 0.01)
					
					ENDCASE 
					
					laArray(i,3) = Iif(beda_nama,pembulatan(lnPajak),0)  
				
				
				CASE  laArray(i,2) = '21' .Or. laArray(i,2) = '22' 		&& Hitung Denda BBNKB I & II
					
					
					IF llDendaBbn
						
						
						DO CASE 
						
							
							CASE  lcDumb  && dumb
								
								&&lnPajak = clnilai_jual * ndumb * (nlDendabbn*0.02) && 2%
								lnPajak = clnilai_jual * ndumb * 0.25 && 2%
							
							
							CASE rbh_btk  && rubah bentuk
							
								&&lnPajak = njkb_lamp2 * 0.1 * (nlDendabbn*0.02) && 2%
								lnPajak = njkb_lamp2 * 0.15 * 0.25 && 2%
							
							
							CASE lcPlat = 'KUNING' && Umum
									
								&&lnPajak = lnNilai * Iif( laArray(i,2) = '21', 0.15, 0.01 ) * Iif(clJenisKend= 'F' Or clJenisKend ='G', 0.8,0.6) * ;
									      &&Iif( pnTunggak > 2, 0.73,  ( 0.25 + (nlDendabbn*0.02) ))
									      
								lnPajak  = lnNilai * Iif( laArray(i,2) = '21', 0.15, 0.01 ) * Iif(clJenisKend= 'F' Or clJenisKend ='G', 0.8,0.6) * 0.25 		      	
									
							OTHERWISE && plat merah & hitam 
						
								&&lnPajak   = ( lnNilai * Iif( laArray(i,2)='21', 0.15, 0.01 ) ) * Iif( pnTunggak > 2, 0.48, ( 0.25 + (nlDendabbn*0.02) ) ) && 2%
								lnPajak  = ( lnNilai * Iif( laArray(i,2)='21', 0.15, 0.01 ) ) * 0.25 
										
						ENDCASE 
					
						
						* pembulatan denda BBN KB
						IF beda_nama
							laArray(i,4) = pembulatan(lnPajak) 		&&Iif((dltgl_dft+90 > dltgl_notice) ,pembulatan(lnPajak),0)
						ELSE 
							laArray(i,4) = 0
						ENDIF 

					ENDIF 
					

				
				Case laArray(i,2) = '13'  && Hitung Pokok PKB
				
							
						*!*					IF propk AND clBulanPkb # 12 
						*!*						lnPajak = IIF(clBulanPkb > 12,lnPkb + proPkb,proPkb)
						*!*					ELSE
						*!*						lnPajak = lnPkb
						*!*					ENDIF 
						
								
						DO CASE 
							CASE propk AND clBulanPkb # 12
								lnPajak = IIF(clBulanPkb > 12,lnPkb + proPkb,proPkb)
							CASE propk AND clBulanPkb = 12
								lnPajak = proPkb
							OTHERWISE 
								lnPajak = lnPkb
						ENDCASE 						
								
						laArray(i,3) =  Iif( ( YEAR(dltgl_notice_sd) > YEAR(dltgl_notice) ) or ( propk AND clBulanPkb # 12 ) or ( propk AND clBulanPkb = 12 ) , ;
						                       pembulatan(lnPajak),0)

				CASE laArray(i,2) = '23'  && Hitung Denda PKB

					
					*!*				DO CASE 
					*!*				
					*!*					CASE lcPlat <> 'MERAH'
					*!*						IF (llDendaPkb AND !propk) OR (llDendaPkb And propk AND clBulanPkb > 12) OR (llDendaPkb AND lcDumb)
					*!*							lnPajak      = lnPkb * ( IIF(pnTunggak >= 1,0,0.25) + IIF( pnTunggak >= 2,0,(nlDendapkb * 0.02))) && 2%
					*!*							laArray(i,4) = IIF((YEAR(dltgl_notice_sd) > YEAR(dltgl_notice)) ,pembulatan(lnPajak),0)
					*!*						ENDIF
					*!*					CASE lcPlat = 'MERAH' 	
					*!*						laArray(i,4) = IIF((YEAR(dltgl_notice_sd) > YEAR(dltgl_notice)),0,0)
					*!*						
					*!*				ENDCASE 
					
					
					IF (llDendaPkb AND !propk) OR (llDendaPkb And propk AND clBulanPkb > 12) OR (llDendaPkb AND lcDumb)
						lnPajak      = lnPkb * ( IIF(pnTunggak >= 1,0,0.25) + IIF( pnTunggak >= 2,0,(nlDendapkb * 0.02))) && 2%
						laArray(i,4) = IIF((YEAR(dltgl_notice_sd) > YEAR(dltgl_notice)) ,pembulatan(lnPajak),0)
					ENDIF
								
				
				Case laArray(i,2) = '14'  && hitung pokok swdkllj
					
					nlDendaswd = IIF(nlDendaswd >= 12,12,nlDendaswd)
					lnPro      = 'lnProrata'+Allt(Str(nlDendaswd))
					lnSWDKLLJ  = lnSwd_pk + lnSwd_lg
					
					IF nlDendaswd >= 12
						lnProrata12 = 0
					ENDIF 
					
					IF nlDendaswd = 0
						lnProrata0 = 0
					ENDIF 
						
						If !prosw OR clBulanswd = 12 &&btidak prorata
								
								&&laArray(i,3) = Iif((YEAR(dltgl_notice_sd) > YEAR(dltgl_notice)) ,lnSWDKLLJ,0)
						
								IF YEAR(dltgl_notice_sd) = YEAR(dltgl_notice) AND cldaftar1='71'
									laArray(i,3) = lnswd_lg
								ELSE 
									laArray(i,3) = Iif((YEAR(dltgl_notice_sd) > YEAR(dltgl_notice)) ,lnSWDKLLJ,0)
								ENDIF 
						
						
						ELSE
							IF clBulanswd > 12 &&lebih dari 12 bulan
								laArray(i,3) = lnSWDKLLJ + &lnPro
							ELSE
								laArray(i,3) = Iif(clBulanswd # 0,&lnPro,0)
							ENDIF 
						ENDIF

				Case laArray(i,2) = '24' && denda swd
								
					If (llDendaSwd And !prosw) OR (llDendaSwd And prosw AND clBulanswd > 12)
							laArray(i,4) = Iif((YEAR(dltgl_notice_sd) > YEAR(dltgl_notice)) , Iif(lnSwd_pk>100000,100000,lnSwd_pk) ,0)
					ENDIF
								
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
				
							
					DO CASE 
					
						CASE clDaftar1 = '01'

							IF clJenisKend ='R' && Jenis SEPEDA MOTOR, SPM R3, SEPEDA MOTOR R4
								laArray(i,3) = Iif(!Isnull(konfig.pendapatan_2),konfig.pendapatan_2,0)
							ELSE 
								DO  Case  
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
							ENDIF
							
						CASE clDaftar1 = '33' OR clDaftar1 = '34'
				
							IF  clJenisKend ='R' && Jenis SEPEDA MOTOR, SPM R3, SEPEDA MOTOR R4
								laArray(i,3) = Iif(!Isnull(konfig.akdpr2),konfig.akdpr2,0)
							ELSE 
								laArray(i,3) = Iif(!Isnull(konfig.akdpr4),konfig.akdpr4,0)
							ENDIF

					ENDCASE 
			
				ENDCASE 

			Else
				laArray(i,1) = ''
				laArray(i,3) = 0
				laArray(i,4) = 0
			Endif
		Endfor

		
		*\ update data array ke array simpan
				
		For i = 1 To 10
			laSave(i,1) = Space(3)
			laSave(i,2) = Space(2)
			laSave(i,3) = 0
			laSave(i,4) = 0
		ENDFOR
		
		
		k = 1
		lnJumlah = 0
		For i = 1 To 10
			If laArray(i,3) > 0 Or laArray(i,4) > 0
				laSave(k,1) = laArray(i,1)
				laSave(k,2) = laArray(i,2)
				laSave(k,3) = laArray(i,3)
				laSave(k,4) = laArray(i,4)

				k = k+1
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
		ENDFOR



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
						Replace pokok_b WITH pokok_b + npk, kd_as1 With cjns
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

		ENDIF
		
		
		IF rbh_btk AND lcmohon = '51'
			rbh_btk = .F.
		ENDIF 	

	ENDIF 

ENDFOR 

*** Proses Kalo perhitungan di pindahkan ke penetapan
*** Proses Simpan ke PKB_Biasa Yang LAma

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
