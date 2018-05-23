Procedure transfer_data()
Lparameters no_tabel,_nama_tabel
Local _nmax,_nfield,nloop
nloop = 1
ctext = ''

nCount = 0
dTanggal = " / / "

Select &_nama_tabel
nmaxLOOP=Reccount('&_nama_tabel')
Go Top
Do While !Eof()
	Do Case
	Case no_tabel ='01' &&& Transfer PKB_Header

*cNo_dft = IIF(!EMPTY(no_dft), ALLTRIM(no_dft), null)
*dTgl_dft= Iif(!Empty(daftar), rubah_tanggal(Dtoc(daftar)), Null)
*dTgl_dft= Iif(!Empty(daftar), ALLTRIM(STR(YEAR(daftar)))+"-"+ALLTRIM(STR(MONTH(daftar)))+"-"+ALLTRIM(STR(DAY(daftar))), Null)

		dTgl_dft= conv_tanggal(daftar)
		dmlaku 	= Iif(!Empty(mlaku), rubah_tanggal(mlaku), Null)
		dTtgl_ttp = Iif(!Empty(tetap), conv_tanggal(tetap), Null)
		dTgl_trm= Iif(!Empty(lunas), conv_tanggal(lunas), Null)
		cNo_ttp = Iif(!Empty(no_nota), Alltrim(no_nota), Null)
		cNo_trm = Iif(!Empty(no_lns), Alltrim(no_lns), Null)

		cnopol 	= Iif(!Empty(nopol), Alltrim(nopol), Null)

		lctk_dft = '0'
		lctk_ttp = '0'
		lctk_trm = '0'
		lctk_stnk = '0'

		If dTanggal # dTgl_dft
			nCount = 1
			dTanggal = dTgl_dft
		Else
			nCount = nCount+1
		Endif

		cNo_dft = replwz(nCount,4)

		Do Case
		Case cetak = 1
			lctk_dft = '1'
		Case cetak = 2
			lctk_ttp = '1'
		Case cetak = 3
			lctk_trm = '1'
		Case cetak = 4
			lctk_stnk = '1'
		Endcase

		csql1 = 'insert into pkb_header (no_dft, tgl_dft, mlaku, tgl_ttp, tgl_trm, no_ttp, no_trm, ;
			ctk_dft, ctk_ttp, ctk_trm, ctk_stnk, nopol) '

		csql2 = ' values(?cNo_dft, ?dTgl_dft, ?dmLaku, ?dTtgl_ttp, ?dTgl_trm, ?cNo_ttp, ?cNo_trm, ;
			?lctk_dft, ?lctk_ttp, ?lctk_trm, ?lctk_stnk, ?cNopol)'

		cs = csql1+csql2

		asg = SQLExec(gnconnhandle, cs)
		If asg < 0
			Messagebox('error transfer PKB_Header')
			Return
		Endif
		Wait Wind('transfer data ke '+Alltrim(Str(nloop)) +' dari '+Alltrim(Str(nmaxLOOP))) Nowait

	Case no_tabel ='02' &&Akend
		If !Empty(nama) && NAMA GA BOLEH KOSONG

&& Data Nopol ga boleh Kosong \ Tidak sesuai dengan kode daerah
			If Upper(Left(Alltrim(nopol),2))='DD'

				cnopol =  IIF(!Empty(Alltrim(nopol)),ALLTRIM(nopol),null)
				If Len(cnopol)<=10
					cnama=Iif(!Empty(Alltrim(nama)),Alltrim(nama),Null)
					ckerja=Iif(!Empty(Alltrim(kerja)),Alltrim(kerja),Null)
					calamat =	Iif(!Empty(Alltrim(almt)),Alltrim(almt),Null)
					cktp= Iif(!Empty(Alltrim(ktp)),Alltrim(ktp),Null)
					cjenis=Iif(!Empty(Alltrim(jenis)),Alltrim(jenis),Null)
					cmerk = find_merk(Iif(!Empty(Alltrim(merek)),merek,Null),_nama_tabel)
					cthn = Iif(Empty(Alltrim(thn_buat)),Null,Alltrim(thn_buat))
					ncyl=Alltrim(Str(cyl))
					cwarna=Iif(!Empty(Alltrim(warna)),Alltrim(warna),Null)
					crangka = Iif(!Empty(Alltrim(rangka)),Alltrim(rangka),Null)
					cmesin =Iif(!Empty(Alltrim(mesin)),Alltrim(mesin),Null)
					nke= Alltrim(Str(ke))
					ckdmilik = Iif(!Empty(Alltrim(milik)),Alltrim(replwz(Val(milik),2)),Null)
					cguna = Iif(!Empty(Alltrim(GUna)),Alltrim(GUna),Null)
					If Alltrim(Upper(nopol_eks))='TETAP'
						cnopol_eks=rem_spasi_2(cnopol)
					Else
						cnopol_eks=Iif(!Empty(Alltrim(nopol_eks)),Alltrim(rem_spasi_2(nopol_eks)),Null)
					Endif
					cwarna_plat=Iif(!Empty(Alltrim(WARNA_PLAT)),Alltrim(WARNA_PLAT),Null)
					dmlaku  = BERLAKU
					ctype =  format_tipe(Alltrim(tipe))
					cno_bPkb = Iif(!Empty(Alltrim(NO_BPKB)),Alltrim(NO_BPKB),Null)
					cB_bakar =	Iif(!Empty(Alltrim(B_BAKAR)),Alltrim(B_BAKAR),Null)
					ckd_lks =	Iif(!Empty(Alltrim(KODE_LKS)),Alltrim(KODE_LKS),Null)
					ckd_upt =	Alltrim(pckdupt)
					dNONAKTIF	= Iif(nonaktif,1,0)

					cdasar		= Iif(!Empty(Alltrim(DASAR)),Alltrim(DASAR),Null)

					lcodate		= Set("Date")


					dTGL_LUNAS	= Iif(!Empty(tgl_lunas),conv_tanggal(tgl_lunas),Null)
					dtgl_faktur = Iif(!Empty(TGL_FAKTUR),conv_tanggal(TGL_FAKTUR),Null)
					dtgl_stnk	= Iif(!Empty(TGL_STNK),conv_tanggal(TGL_STNK),Null)

					If !Empty(TGL_STNK)
						If TGL_STNK<Ctod('1999/01/01')
							dsd_stnk = Null
						Else
							dsd_stnk= conv_tanggal(plusdate(TGL_STNK,5))
						Endif
					Else
						dsd_stnk = Null
					Endif



					Set Date To &lcodate
					csql = 'delete from akend where nopol = ?cnopol'
					asg = SQLExec(gnconnhandle,csql)
					If asg < 0
						Messagebox('error reset AKEND')
						Return
					Else


						csql1 = 'insert into akend(nopol,nama,ktp,jenis,kd_merk,kerja,thn_buat,alamat,tipe,kd_bbm,cyl,'
						csql2= 'rangka,mesin,no_bpkb,kd_milik,kd_guna,ke,warna,warna_plat,tgl_stnk,sd_stnk,tgl_faktur,non_aktif,kode_upt)'
						csql3 =' values(?cnopol,?cnama,?cktp,?cjenis,?cmerk,?ckerja,?cthn,?calamat,?ctype,?cb_bakar,?ncyl,'
						csql4 ='?crangka,?cmesin,?cno_bPkb,?ckdmilik,?cguna,?nke,?cwarna,?cwarna_plat,?dtgl_stnk,?dsd_stnk,?dtgl_faktur,?dnonaktif,?ckd_upt)'


						cstr = csql1+csql2+csql3+csql4

						asg = SQLExec(gnconnhandle,cstr)
						If asg < 0
							Messagebox('error transfer AKEND')
							Return
						Endif
						Wait Wind('transfer data ke '+Alltrim(Str(nloop)) +' dari '+Alltrim(Str(nmaxLOOP)))Nowait
					Endif
				Endif
			Endif
		Endif

	Case no_tabel ='03'
**tabel ajenis*
		cjenis =Alltrim(jenis)
		cket =Alltrim(ket)
		ctype = Alltrim(Type)
		cgeneral=Alltrim(General)

		Do Case
		Case Alltrim(kend)='1' Or Alltrim(kend)='2'
			ckend ='R'
		Case Alltrim(kend)='3'
			Do Case
			Case Left(cjenis,2)='A1'
				ckend= 'A'
			Case Left(cjenis,2)='A2'
				ckend= 'B'
			Case Left(cjenis,2)='B1'
				ckend= 'E'
			Case Left(cjenis,2)='C1'
				ckend= 'F'
			Case Left(cjenis,2)='A4' Or Left(cjenis,2)='B2'
				ckend= 'D'
			Otherwise
				ckend= 'C'
			Endcase

		Case Alltrim(kend)='4'
			If Left(cjenis,2)='C7' Or Left(cjenis,2)='C9'
				ckend = 'H'
			Else
				If Left(cjenis,2)='A1'
					ckend = 'A'
				Else
					ckend = 'G'
				Endif
			Endif

		Case Alltrim(kend)='5'
			If Left(cjenis,2)='C8'
				ckend = 'G'
			Else
				ckend = 'H'
			Endif
		Endcase

		csql1 = 'insert into ajenis(jenis,ket,type,general,kend) '
		csql2 = 'values(?cjenis,?cket,?ctype,?cgeneral,?ckend)'

		asg = SQLExec(gnconnhandle,csql1+csql2)
		If asg < 0
			Messagebox('error transfer ajenis')
			Return
		Endif
		Wait Wind('transfer data ke '+Alltrim(Str(nloop)) +' dari '+Alltrim(Str(nmaxLOOP)))Nowait


	Case no_tabel ='04' &&& Transfer PKB_Biasa

		dTgl_dft= Iif(!Empty(daftar), conv_tanggal(daftar), Null)

		If dTanggal # dTgl_dft
			nCount = 1
			dTanggal = dTgl_dft
		Else
			nCount = nCount+1
		Endif

		cNo_dft = replwz(nCount,4)

		cJenis1 = Iif(!Empty(Jenis1), Alltrim(Jenis1), Null)
		cJenis2 = Iif(!Empty(Jenis2), Alltrim(Jenis2), Null)
		cJenis3 = Iif(!Empty(Jenis3), Alltrim(Jenis3), Null)
		cJenis4 = Iif(!Empty(Jenis4), Alltrim(Jenis4), Null)
		cJenis5 = Iif(!Empty(Jenis5), Alltrim(Jenis5), Null)
		cJenis6 = Iif(!Empty(Jenis6), Alltrim(Jenis6), Null)
		cJenis7 = Iif(!Empty(Jenis7), Alltrim(Jenis7), Null)
		cJenis8 = Iif(!Empty(Jenis8), Alltrim(Jenis8), Null)
		cJenis9 = Iif(!Empty(Jenis9), Alltrim(Jenis9), Null)
		cJenis10= Iif(!Empty(Jenis10), Alltrim(Jenis10), Null)

		nPokok1 = Transform(pokok1)
		nPokok2 = Transform(pokok2)
		nPokok3 = Transform(pokok3)
		nPokok4 = Transform(pokok4)
		nPokok5 = Transform(pokok5)
		nPokok6 = Transform(pokok6)
		nPokok7 = Transform(pokok7)
		nPokok8 = Transform(pokok8)
		nPokok9 = Transform(pokok9)
		nPokok10= Transform(pokok10)

		nDenda1 = Transform(Denda1)
		nDenda2 = Transform(Denda2)
		nDenda3 = Transform(Denda3)
		nDenda4 = Transform(Denda4)
		nDenda5 = Transform(Denda5)
		nDenda6 = Transform(Denda6)
		nDenda7 = Transform(Denda7)
		nDenda8 = Transform(Denda8)
		nDenda9 = Transform(Denda9)
		nDenda10= Transform(Denda10)

		nJumlah = Transform(Jumlah)

		csql1 = "insert into pkb_biasa (no_dft, tgl_dft, "
		csql2 = "Jenis1, Jenis2, Jenis3, Jenis4, Jenis5, Jenis6, Jenis7, Jenis8, Jenis9, Jenis10, ;
				Pokok1, Pokok2, Pokok3, Pokok4, Pokok5, Pokok6, Pokok7, Pokok8, Pokok9, Pokok10, "

		csql3 = " Denda1, Denda2, Denda3, Denda4, Denda5, Denda6, Denda7, Denda8, Denda9, Denda10, jumlah) "

		csql4 = " values (?cNo_dft, ?dTgl_dft, ;
				?cJenis1, ?cJenis2, ?cJenis3, ?cJenis4, ?cJenis5, ?cJenis6, ?cJenis7, ?cJenis8, ?cJenis9, ?cJenis10, "
		csql5 = "?nPokok1, ?nPokok2, ?nPokok3, ?nPokok4, ?nPokok5, ?nPokok6, ?nPokok7, ?nPokok8, ?nPokok9, ?nPokok10, ;
				?nDenda1, ?nDenda2, ?nDenda3, ?nDenda4, ?nDenda5, ?nDenda6, ?nDenda7, ?nDenda8, ?nDenda9, ?nDenda10, ?nJumlah)"

		cs = csql1+csql2+csql3+csql4+csql5

		asg = SQLExec(gnconnhandle, cs)

		If asg < 0
			Messagebox('error transfer PKB_Biasa')

			Return
		Endif
		Wait Wind('transfer data ke '+Alltrim(Str(nloop)) +' dari '+Alltrim(Str(nmaxLOOP))) Nowait

&& End of PKB_Biasa


	Case no_tabel ='05'
****AJsetor
		cjsetor = Alltrim(jsetor)
		cket = Alltrim(ket)
		cs_H = Alltrim(S_H)
		cheader = Alltrim(Header)
		cayat = Alltrim(ayat)
		cjenis = Alltrim(jenis)
		cpilih =Alltrim(pilih)

		csql1 = 'insert into ajsetor(jsetor,ket,S_H,header,ayat,jenis,pilih) '
		csql2 = 'values(?cjsetor,?cket,?cs_H,?cheader,?cayat,?cjenis,?cpilih)'

		asg = SQLExec(gnconnhandle,csql1+csql2)
		If asg < 0
			Messagebox('error transfer ajsetor')
			Return
		Endif
		Wait Wind('transfer data ke '+Alltrim(Str(nloop)) +' dari '+Alltrim(Str(nmaxLOOP)))Nowait

	Case no_tabel ='08'
*** A blokir_D
		cnopol = Alltrim(rem_spasi_2(nopol))
		dtgl_blok=tgl_blokir
		cket = Alltrim(ket)
		csql1 = 'insert into ablokir_d(nopol,tgl_blokir,ket) '
		csql2 = 'values(?cnopol,?dtgl_blok,?cket)'

		asg = SQLExec(gnconnhandle,csql1+csql2)
		If asg < 0
			Messagebox('error transfer ablokir_D')
			Return
		Endif
		Wait Wind('transfer data ke '+Alltrim(Str(nloop)) +' dari '+Alltrim(Str(nmaxLOOP)))Nowait

	Case no_tabel ='13'
*** A blokir_P
		cnopol = Alltrim(rem_spasi_2(nopol))
		dtgl_blok=tgl_blokir
		cket = Alltrim(ket)
		csql1 = 'insert into ablokir_P(nopol,tgl_blokir,ket) '
		csql2 = 'values(?cnopol,?dtgl_blok,?cket)'

		asg = SQLExec(gnconnhandle,csql1+csql2)
		If asg < 0
			Messagebox('error transfer ablokir_D')
			Return
		Endif
		Wait Wind('transfer data ke '+Alltrim(Str(nloop)) +' dari '+Alltrim(Str(nmaxLOOP)))Nowait

	Case no_tabel ='11'
***** A P K B

		cjenis = Alltrim(jenis)
		ckdmerk =find_merk(Alltrim(merk),_nama_tabel)
		_nlt =Len(Alltrim(tipe))
		ctipe = format_tipe(Alltrim(tipe))
		cthn= Alltrim(th_buat)
		cket = Alltrim(ket)
		nbobot=bobot
		nnilai_jual = nilai_jual
		ndasar = dasar_pkb
		nkdbbm= bbm
		ncyl = cc
***bila rumus berubah silahkan ganti
		npkb_um = pembulatan((dasar_pkb-(dasar_pkb*0.4))*0.01)
		npkb_bs = pembulatan((dasar_pkb*0.015))

*****Gol SWDKLLJ
		Do Case
		Case Left(cjenis,1)='A'
			cgol_bs= 'DP'
			cGol_um='DU'
		Case Left(cjenis,1)='B'
			cgol_bs= 'EP'
			cGol_um='EU'
		Case Left(cjenis,1)='C'
			If  Left(cjenis,2)='C1' Or Left(cjenis,2)='C2'
				cgol_bs= 'DP'
				cGol_um='DU'
			Else
				cgol_bs= 'F'
				cGol_um='F'
			Endif
		Case Left(cjenis,1)='D'
			Do Case
			Case   Left(cjenis,2)='D1' Or Left(cjenis,2)='D2'
				cgol_bs= 'A'
				cGol_um='A'
			Case   Left(cjenis,2)='D4'
				cgol_bs= 'C1'
				cGol_um='C1'

			Otherwise
				cgol_bs= 'C2'
				cGol_um='C2'
			Endcase
		Endcase

		csql1 = 'insert into aPKB(jenis,kd_merk,tipe,th_buat,ket,bobot,nilai_jual,dasar_pkb,kd_bbm,cyl,'
		csql12 = 'gol_bs,gol_um,pkb_um,pkb_bs)'
		csql2 = 'values(?cjenis,?ckdmerk,?ctipe,?cthn,?cket,?nbobot,?nnilai_jual,'
		csql22 = '?ndasar,?nkdbbm,?ncyl,?cgol_bs,?cgol_um,?npkb_um,?npkb_bs)'

		cstr = csql1+csql12+csql2+csql22
		asg = SQLExec(gnconnhandle,cstr)
		If asg < 0
			Messagebox('error transfer aPKB')
			Return
		Endif
		Wait Wind('transfer data ke '+Alltrim(Str(nloop)) +' dari '+Alltrim(Str(nmaxLOOP)))Nowait

	Endcase

	Select &_nama_tabel
	nloop = nloop+1
	Skip
Enddo
Endproc








*!*	FUNCTION valid_nopol
*!*	LPARAMETERS _cnopol
*!*			h


Function find_merk()
Lparameters cmerek,tbl
csql =' select kd_merk,ket from msmerk where LTRIM(ket)=?cmerek'
Local ckode
asg = SQLExec(gnconnhandle,csql,'cs_merk')
If asg>0
	If Reccount('cs_merk')>0
		ckode = Alltrim(kd_merk)
	ELSE
		ckode =''
*!*			csql =' select kd_merk from msmerk'
*!*			asg = SQLExec(gnconnhandle,csql,'cs_merk2')
*!*			Select cs_merk2
*!*			Go Bottom
*!*			_clast	= Val(kd_merk)
*!*			ckode  = Alltrim(Str(_clast+1))
*!*			csql =' insert into msmerk(kd_merk,ket) values(?ckode,?cmerek) '
*!*			asg = SQLExec(gnconnhandle,csql,'cs_merk2')
*!*			Select cs_merk2
*!*			Use
	Endif

Else
	ckode =''
Endif
Select cs_merk
Use
Select &tbl
Return ckode


*!*	Function plusdate()
*!*	Lparameter xdTgl, xnPlus
*!*	Set Date To british

*!*	Local ldTgl


*!*	If Month(xdTgl) = 2 And Day(xdTgl) = 29
*!*	* tahun kabisat
*!*		ldTgl = Ctod('28/02/'+Str(Year(xdTgl)+xnPlus,4))
*!*	Else
*!*		ldTgl = Ctod(Str(Day(xdTgl),2)+'/'+;
*!*			STR(Month(xdTgl),2)+'/'+;
*!*			STR(Year(xdTgl)+xnPlus,4))
*!*	Endif
*!*	Set Date To YMD
*!*	Return ldTgl






Function format_tipe()
Lparameters lctipe
Local ctip
npjg=Len(Alltrim(lctipe))
cdel = .F.
ckode_T =''
For k= 1 To npjg
	If Substr(lctipe,k,1)#'-'
		If cdel = .T.
			ckode_T=ckode_T+Substr(lctipe,k,1)
		Endif
	Else
		cdel =.T.
	Endif
Next
Return ckode_T


Function rem_spasi_2()
Lparameters _nopol
nmax = Len(_nopol)
Local ret_nopol
ret_nopol = ''
For p=1 To nmax
	If Alltrim(Substr(_nopol,p,1))# '-'
		If  Alltrim(Substr(_nopol,p,1))#'.'
			If  Alltrim(Substr(_nopol,p,1))#' '
				ret_nopol = ret_nopol+Alltrim(Substr(_nopol,p,1))
			Endif
		Endif
	Endif
Next
ret_nopol = Alltrim(_nopol)
Return ret_nopol

*!*	FUNCTION format_nopol()
*!*	LPARAMETERS cnopol
*!*	cdep = LEFT(cnopol,2)
*!*	cnpl = cdep
*!*	x=4
*!*	FOR k = 3 TO LEN(cnopol)
*!*		IF  INLIST(SUBSTR(cnopol,k,1),'1','2','3','4','5','6','7','8','9','0')
*!*			cnpl=cnpl+SUBSTR(cnopol,k,1)
*!*			x=x-1
*!*		ELSE
*!*			IF LEN(cnpl)>6
*!*				cnpl=cnpl+SUBSTR(cnopol,k,1)
*!*			ELSE
*!*				cnpl=cnpl+SPACE(x)+SUBSTR(cnopol,k,1)
*!*			ENDIF
*!*		ENDIF
*!*	NEXT
*!*	return cnpl
*!*



