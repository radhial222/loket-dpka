Procedure  read_data()
Lparameters cfile
Local cstr
cstr=Filetostr('&cfile')
cfname = kode_kom(cstr,2)+'.txt'
ckdreq = kode_kom(cstr,1)
If check_valid(cstr)
Else
	Do Case
	Case ckdreq='rq1'
		fetch_data(cstr,cfname)
	Case ckdreq='up1'
		Update_data(cstr)
	Case ckdreq ='rc1'
		extrack_data(cstr)
	Otherwise
		gen_error(cstr,cfname)
	Endcase
Endif
Return cstr


Function   cek_jml_param
Lparameter cstr
Local N,Jml_param
N = Len(Alltrim(cstr))
Jml_param = 0

For i = 1 To N
	If Substr(cstr,i,1)=';'
		Jml_param=Jml_param+1
	Endif
Next
Return Jml_param

Function  kode_kom
Lparameter cstr,nurut
Local ckd_kom
ckd_kom =''
N = Len(Alltrim(cstr))
nloop = 1
For i = 1 To N
	If Substr(cstr,i,1)=';'
		If nloop = nurut
			Exit
		Else
			ckd_kom=''
			nloop = nloop+1
		Endif
	Else
		ckd_kom =ckd_kom +Substr(cstr,i,1)
	Endif
Next
Return ckd_kom


Function check_valid()
Lparameters cstr
Local lpass,ckode_kom
lpass = .T.
***check end character
If Right(cstr,1) # '#'
	lpass = .F.
Else
	ckode_kom =kode_kom(cstr,1)
	nparam = cek_jml_param(cstr)
	If Used('ikode')
		Select ikode
		Use
	Endif
	open_tabel('ikode')
	Select ikode
	Set Order To kode
	Seek Alltrim(ckode_kom)
	If Found()
		If Parameter # nparam
			lpass = .F.
			Select ikode
			Use
		Endif
	Else
		lpass = .F.
	Endif
Endif
Return lpass

Function open_tabel
Lparameter ctabel
cotabel = 'data\'+ctabel
If Used('&ctabel')
	Select &ctabel
	Use
Endif
Use &cotabel In 0 Alias &ctabel
Endfunc

Function get_fields
Lparameters ckode_kom
Local xcfields
open_tabel('ikode')
Select ikode
Set Order To kode
Seek Alltrim(ckode_kom)
If Found()
	xcfields = field_look
Endif
Return xcfields


Function fetch_data()
Lparameters cstr,cfname
Local cret,cretfull
cret =''
cnopol =Alltrim(kode_kom(cstr,3))
cfields = get_fields(Alltrim(kode_kom(cstr,1)))
Use Data\dbsamsat.Dbc Again  Shared
If Used('akend')
	Select akend
	Use
Endif
Use akend In 0 Alias akend
Select akend
Set Order To nopol
Seek cnopol
If Found()
	For j = 1 To 27
		cisi = kode_kom(cfields,j)
		If j = 1
			cret = cret+&cisi
		Else
			cadd = cek_type(cisi,&cisi)
			cret = cret+';'+cadd
		Endif
	Next
Endif

cretfull = 'rc1;'+cret+'#'
send_file(cretfull,cfname)
Endfunc

Function con_type
Lparameters ctipe,cdata
Local cstring
Do Case
Case Type(ctipe)='C'
	If cdata #'-'
		cstring = Alltrim(cdata)
	Else
		cstring = ''
	Endif
Case Type(ctipe)='D'
	If cdata #'-'
		cstring = Ctod(cdata)
	Else
		cstring = Ctod(Space(2)+'/'+Space(2)+'/'+Space(4))
	Endif

Case Type(ctipe)='N'
	If cdata #'-'
		cstring = Val(cdata)
	Else
		cstring = 0
	Endif
Case Type(ctipe)='L'
	If Alltrim(cdata) ='.T.'
		cstring = .T.
	Else
		cstring = .F.
	Endif
Endcase
Return cstring

Function cek_type
Lparameters ctipe,cdata
Local cstring
Do Case
Case Type(ctipe)='C'
	cstring = Alltrim(cdata)
Case Type(ctipe)='D'
	cstring = Alltrim(Dtoc(cdata))
Case Type(ctipe)='N'
	cstring = Alltrim(Str(cdata))
Case Type(ctipe)='L'
	If cdata
		cstring = Alltrim('.T.')
	Else
		cstring = Alltrim('.F.')
	Endif
Endcase
Return cstring

Function gen_error()
Lparameters cstr,cfile
=Messagebox('Permintaan Data file '+cfile+' Salah',0+16,'Kesalahan')
cretfull ='error'+ cfile
send_file2('error',cretfull)
Endfunc

Function extrack_data()
Lparameters cstr
For m= 1 To 27
	cvar = 'c'+Alltrim(Str(m))
	&cvar = kode_kom(cstr,m+1)
Next
If Used('akend_r')
	Select akend_r
	Use
Endif

Use Data\akend_r In 0 Alias akend_r
Select akend_r
Locate For Alltrim(nopol)=c1
If !Found()
	Append Blank
Endif
Replace nopol With c1,nama With c2,;
	alamat With c3,jenis With c4,;
	kd_merk With c5,tipe With c6,;
	thn_buat With c7,kd_bbm With c8,;
	rangka With c9,mesin With c10,;
	no_bpkb With c11,kd_milik With c12,;
	kd_guna With c13,warna With c14,;
	no_stnkb With c15,;
	tgl_stnk With Ctod(c16),sd_stnk With Ctod(c17),;
	tgl_notice With Ctod(c18),sd_notice With Ctod(c19),;
	tgl_swd With Ctod(c20),sd_swd With Ctod(c21),;
	tgl_faktur With Ctod(c22),warna_plat With c23,;
	cyl With Val(c24),ke With Val(c25),kd_pos With c26,;
	kode_upt With c27

update_buffer(.F.)
Endfunc

Function Update_data()
Lparameters cstr
njmlf = cek_jml_param(cstr)

Use Data\dbsamsat.Dbc Again  Shared
If Used('PKB_HEADER')
	Use Data\pkb_header Again In 0 Alias PKB
Else
	Use Data\pkb_header  In 0 Alias PKB
Endif

If Used('PKB_Biasa')
	Use Data\pkb_biasa Again In 0 Alias PKB_B
Else
	Use Data\pkb_biasa  In 0 Alias PKB_B
Endif

tgl_daf = Ctod(kode_kom(cstr,5))
Select no_dft From PKB Where  tgl_dft = tgl_daf Into Cursor cten Order By no_dft
Select cten
Go Bottom
cnodaf = nulstr( Val(no_dft)+1, 4 )
Select PKB
nbp = Fcount('PKB')
Append Blank
Replace no_dft With cnodaf,tgl_dft With tgl_daf
For q = 3 To (nbp)

	cfield = Field(q)
	cisi = kode_kom(cstr,q+3)
	cis = con_type(cfield,cisi)
	Replace &cfield With cis
Next

Select PKB_B
Append Blank
Replace no_dft With cnodaf,tgl_dft With tgl_daf

nf = 3
For q = nbp+1 To njmlf
	If kode_kom(cstr,q+3)='#'
		Exit
	Endif
	cfield = Field(nf)
	cisi = kode_kom(cstr,q+3)
	cis = con_type(cfield,cisi)
	Replace &cfield With cis
	nf=nf+1
Next
If Used('akend')
	Use Data\akend Again In 0 Alias akend1
Else
	Use Data\akend  In 0 Alias akend1
Endif

Select akend1
Set Order To nopol
Seek(PKB.nopol)
If Found()
	Replace akend1.nopol With PKB.nopol, akend1.nopol_eks With PKB.nopol_eks, ;
		akend1.ktp With PKB.ktp, ;
		akend1.nama With PKB.nama, akend1.kerja With PKB.kerja, ;
		akend1.alamat With PKB.alamat, akend1.kd_pos With PKB.kd_pos, ;
		akend1.jenis With PKB.jenis, akend1.kd_merk With PKB.kd_merk, ;
		akend1.tipe With PKB.tipe, akend1.thn_buat With PKB.thn_buat, ;
		akend1.kd_bbm With PKB.kd_bbm, akend1.cyl With PKB.cyl, ;
		akend1.rangka With PKB.rangka, akend1.mesin With PKB.mesin, ;
		akend1.no_bpkb With PKB.no_bpkb, akend1.kd_milik With PKB.kd_milik, ;
		akend1.kd_guna With PKB.kd_guna, akend1.ke With PKB.ke, ;
		akend1.warna With PKB.warna, akend1.warna_plat With PKB.warna_plat, ;
		akend1.tgl_stnk With PKB.tgl_stnk, akend1.sd_stnk With PKB.sd_stnk, ;
		akend1.tgl_notice With PKB.tgl_notice, akend1.sd_notice With PKB.sd_notice, ;
		akend1.tgl_swd With PKB.tgl_swd, akend1.sd_swd With PKB.sd_swd, ;
		akend1.tgl_faktur With PKB.tgl_faktur, akend1.tgl_kwt With PKB.tgl_kwt, ;
		akend1.tgl_fiskal With PKB.tgl_fiskal, akend1.ubh_btk With PKB.ubh_btk, ;
		akend1.ubh_msn With PKB.ubh_msn, akend1.tgl_dft With PKB.tgl_dft, ;
		akend1.tgl_ttp With PKB.tgl_ttp, akend1.tgl_trm With PKB.tgl_trm, ;
		akend1.SKUM With Alltrim(PKB.SKUM)+Alltrim(PKB.KET_SKUM),;
		akend1.KOHIR With Alltrim(PKB.KOHIR_BS)+Alltrim(PKB.KET_KOHIR),;
		akend1.sppkb With .F.

* update row buffer
	update_buffer(.F.)
Endif
Select PKB
Use
Select PKB_B
Use
Select akend1
Use
Endfunc
