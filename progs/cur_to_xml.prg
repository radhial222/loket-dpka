

**** Update data Remote ke server
**** persiapan Update data Remote ke server

Function pre_update1()
Lparameters _upt,_no_dft,_tgl,_cnopol
Local chead,cbiasa,ctunggak,lsend

csql = 'Select kode_upt From akend_r Where nopol = ?_cnopol '
asg = SQLExec(gnconnhandle,csql,'temp')
If asg<0
	Messagebox('ERROR get aken_r')
Else

	Select temp
	cupt_asal = Alltrim(kode_upt)
	cupt_byr = _upt
	cno_dft = _no_dft
	dtgl = _tgl
	cnopol = Alltrim(_cnopol)

	csql = " select * FROM pkb_header WHERE no_dft=?_no_dft and tgl_dft = ?_tgl "
	asg = SQLExec(gnconnhandle,csql,'temp_header')
	If asg<0
		Messagebox('error get header')
	Endif


	csql = " select * FROM pkb_biasa WHERE no_dft=?_no_dft and tgl_dft = ?_tgl "
	asg = SQLExec(gnconnhandle,csql,'temp_biasa')
	If asg<0
		Messagebox('error get biasa')
	Endif


	csql = " select * FROM pkb_tunggak WHERE no_dft=?_no_dft and tgl_dft = ?_tgl "
	asg = SQLExec(gnconnhandle,csql,'temp_tunggak')
	If asg<0
		Messagebox('error get tunggak')
	Endif

	csql = " select * FROM AKEND_R   "
	asg = SQLExec(gnconnhandle,csql,'akend_r')
	If asg<0
		Messagebox('error Akend_r')
	Endif

	Select a.nopol,a.nopol_eks,a.kohir,a.ktp,a.tgl_notice,a.sd_notice,a.tgl_swd,;
		a.nama,a.kerja,a.alamat,a.kd_pos,a.jenis,a.kd_merk,a.tipe,a.thn_buat,a.kd_bbm, a.cyl,a.rangka,a.mesin,;
		a.no_bpkb,a.kd_milik,a.kd_guna,a.ke,a.warna,a.warna_plat ,a.no_stnkb ,a.tgl_stnk,a.sd_stnk, a.tg_ctk_st, a.dft_stnk,;
		a.tgl_kwt,a.tgl_fiskal ,a.ubh_btk, a.ubh_msn , a.skum,;
		a.sd_swd,a.tgl_dft,a.tgl_ttp,a.tgl_trm,b.kode_upt From temp_header a INNER Join akend_r b On  a.nopol = b.nopol  Into Cursor temp_akend

	chead = cur_to_text('temp_header')

	cbiasa =cur_to_text('temp_biasa')

	ctunggak=cur_to_text('temp_tunggak')

	CAKEND = cur_to_text('temp_akend')


	lsend=update1('','',cnopol,cno_dft,dtgl,chead,cbiasa,ctunggak,CAKEND)
Endif
Return lsend


****Update Data Local Ke server

Function pre_update1_local()
****persiapan kirim data transaksi lokal perrecord
Lparameters _upt,_no_dft,_tgl,_cnopol
Local chead,cbiasa,ctunggak,lsend

*!*	csql = 'SELECT kode_upt FROM akend_r WHERE nopol = ?_cnopol '
*!*	asg = SQLExec(gnconnhandle,csql,'temp')
*!*	If asg<0
*!*		Messagebox('error get akend_r')
*!*	Else
*!*		Select temp

*!*		cupt_asal = Alltrim(kode_upt)

cupt_byr = _upt
cno_dft = _no_dft
dtgl = _tgl
cnopol = Alltrim(_cnopol)
csql = " select * FROM pkb_header WHERE no_dft=?_no_dft and tgl_dft = ?_tgl "
asg = SQLExec(gnconnhandle,csql,'temp_header')
If asg<0
	Messagebox('error get header')
Endif

csql = " select * FROM pkb_biasa WHERE no_dft=?_no_dft and tgl_dft = ?_tgl "
asg = SQLExec(gnconnhandle,csql,'temp_biasa')
If asg<0
	Messagebox('error get biasa')
Endif


csql = " select * FROM pkb_tunggak WHERE no_dft=?_no_dft and tgl_dft = ?_tgl "
asg = SQLExec(gnconnhandle,csql,'temp_tunggak')
If asg<0
	Messagebox('error get tunggak')
Endif


csql = " select * FROM akend WHERE nopol=?_cnopol"
asg = SQLExec(gnconnhandle,csql,'temp_akend')
If asg<0
	Messagebox('error get akend')
Else

****bila tidak ada di akend ambil data di pkb_header
	If Reccount('temp_akend')=0
		csql1 ="	SELECT a.nopol,a.nopol_eks,a.kohir,a.ktp,a.tgl_notice,a.sd_notice,a.tgl_swd,;
		 a.nama,a.kerja,a.alamat,a.kd_pos,a.jenis,a.kd_merk,a.tipe,a.thn_buat,a.kd_bbm, a.cyl,a.rangka,a.mesin, "
		csql2 ="a.no_bpkb,a.kd_milik,a.kd_guna,a.ke,a.warna,a.warna_plat ,a.no_stnkb ,a.tgl_stnk,a.sd_stnk, a.tg_ctk_st, a.dft_stnk,;
		 a.tgl_kwt,a.tgl_fiskal ,a.ubh_btk, a.ubh_msn , a.skum,a.sd_swd,a.tgl_dft,a.tgl_ttp,a.tgl_trm ,a.kd_lokasi as kode_upt "
		csql3 ="  from pkb_header a WHERE a.nopol =?cnopol"

		csql = csql1+csql2+csql3
		asg = SQLExec(gnconnhandle,csql,'temp_akend')
		If asg<0
			Messagebox('error get akend')
		Endif

	Endif


	chead = cur_to_text('temp_header')

	cbiasa =cur_to_text('temp_biasa')

	ctunggak=cur_to_text('temp_tunggak')

	CAKEND = cur_to_text('temp_akend')


	lsend=update1('','',cnopol,cno_dft,dtgl,chead,cbiasa,ctunggak,CAKEND)

	Return lsend
Endif



*****UPDATE DATA CLIENT KE SERVER PER HARI

Function pre_update_hari()
Lparameters ckd_upt,ctgl

Local chead,cbiasa,ctunggak
Store '' To chead,cbiasa,ctunggak,CAKEND
cupt_asal = Alltrim(ckd_upt)
dtgl = ctgl


csql = 'SELECT * FROM pkb_header WHERE data_r=0 AND tgl_dft = ?dtgl AND tgl_trm=1'




Select a.* From pkb_biasa a INNER Join temp_header b On    ;
	a.no_dft = b.no_dft And a.tgl_dft= b.tgl_dft Into Cursor temp_biasa


Select a.* From pkb_tunggak a INNER Join temp_header b On    ;
	a.no_dft = b.no_dft And a.tgl_dft= b.tgl_dft Into Cursor temp_tunggak

Select nopol,nopol_eks,kohir,ktp,tgl_notice,sd_notice,tgl_swd,;
	nama,kerja,alamat,kd_pos,jenis,kd_merk,tipe,thn_buat,kd_bbm, cyl,rangka,mesin,;
	no_bpkb,kd_milik,kd_guna,ke,warna,warna_plat ,  no_stnkb ,tgl_stnk, sd_stnk, tg_ctk_st, dft_stnk,;
	tgl_kwt,tgl_fiskal ,ubh_btk, ubh_msn , skum,upt_bayar As kode_upt,;
	sd_swd,tgl_dft From temp_header Into Cursor temp_akend


Select temp_header
Go Top
Do While !Eof()
	cTxHead =cur_to_text('temp_header')
	If Empty(chead)
		chead = chead+cTxHead
	Else
		chead = chead+'|||'+cTxHead
	Endif
	Skip
Enddo


Select temp_biasa
Go Top
Do While !Eof()
	cTxHead =cur_to_text('temp_biasa')
	If Empty(cbiasa)
		cbiasa = cbiasa+cTxHead
	Else
		cbiasa = cbiasa+'|||'+cTxHead
	Endif
	Skip
Enddo


Select temp_tunggak
Go Top
Do While !Eof()
	cTxHead =cur_to_text('temp_tunggak')
	If Empty(ctunggak)
		ctunggak = ctunggak+cTxHead
	Else
		ctunggak = ctunggak+'|||'+cTxHead
	Endif
	Skip
Enddo

Select temp_akend
Go Top
Do While !Eof()
	cTxHead =cur_to_text('temp_akend')
	If Empty(CAKEND)
		CAKEND = CAKEND+cTxHead
	Else
		CAKEND = CAKEND+'|||'+cTxHead
	Endif
	Skip
Enddo



update_hari(ckd_upt,dtgl,chead,cbiasa,ctunggak,CAKEND)
Endfunc


****Mengambil Data kendaraan dari Server
Function Get_nopol()
Lparameters lcnopol

Local lret
lret = .T.
If Empty(lcnopol)
	lcnopol = " "
Endif

*** Load wwSOAP dependencies

Do wwSOAP
oSOAP = Createobject("wwSOAP")
oSOAP.cserverUrl = pcServerUrl
oSOAP.AddParameter("nopol",lcnopol)
lcakend = oSOAP.CallMethod("getDataNopol")



If oSOAP.lError
	lret = .F.


Else

	chasil = oSOAP.cResponseXML

	If Len(lcakend)>100
		text_to_cur(lcakend)
		update_akend_r()
		lret = .T.
	Else

		lret = .F.
	Endif
Endif

Return lret
*!*	RETURN CHASIL


****Mengambil Data kendaraan dari Server


Function update1()
****mengupdate 1 data transaksi remote dari  UPT
Lparameter cupt_asal,cupt_byr,cnopol,cno_dft,dtgl,cheader,cbiasa,ctunggak,CAKEND
Do wwSOAP
oSOAP = Createobject("wwSOAP")
** oSOAP.cServerUrl = "http://219.83.122.66/wsfox/server.soap"
*!*	oSOAP.cServerUrl = "http://192.168.1.109/wsfox/server.soap"
oSOAP.cserverUrl = pcServerUrl
oSOAP.AddParameter("nopol",cnopol)
oSOAP.AddParameter("no_dft",cno_dft)
oSOAP.AddParameter("tgl_dft",dtgl)
oSOAP.AddParameter("t_header",cheader)
oSOAP.AddParameter("t_biasa",cbiasa)
oSOAP.AddParameter("t_tunggak",ctunggak)
oSOAP.AddParameter("t_akend",CAKEND)

lcakend = oSOAP.CallMethod("daftarUlang")

If oSOAP.lError
*!*		Messagebox('Pengiriman Data ke Server  Gagal')
	lret = .F.
Else
*!*		Messagebox('Pengiriman Data ke Server  Berhasil')

	lret = .T.
Endif

Return lret

Function update_hari()
****mengupdate  data transaksi lokal perhari dari  UPT

Lparameter lckd_upt,tgl,c_header,c_biasa,c_tunggak,c_akend
Do wwSOAP
oSOAP = Createobject("wwSOAP")
** oSOAP.cServerUrl = "http://219.83.122.66/wsfox/server.soap"
**oSOAP.cServerUrl = "http://192.168.1.109/wsfox/server.soap"
*!*	oSOAP.cServerUrl =" http://219.83.122.66/wsfox/server.soap"
oSOAP.cserverUrl = pcServerUrl
oSOAP.AddParameter("upt_asal",lckd_upt)
oSOAP.AddParameter("tgl_sinkron",tgl)
oSOAP.AddParameter("t_header",c_header)
oSOAP.AddParameter("t_biasa",c_biasa)
oSOAP.AddParameter("t_tunggak",c_tunggak)
oSOAP.AddParameter("t_akend",c_akend)

lcakend = oSOAP.CallMethod("sendDataToServer")


If oSOAP.lError

	lret = .F.
Else

	lret = .T.
Endif

Return lret

Function request_data_update()
***meminta data perunbahan di server
Lparameter dtgl_awal,dtgl_akhir,ckd_upt
Do wwSOAP
oSOAP = Createobject("wwSOAP")
oSOAP.cserverUrl = pcServerUrl
oSOAP.AddParameter("tgl_awal",dtgl_awal)
oSOAP.AddParameter("tgl_akhir",dtgl_akhir)
oSOAP.AddParameter("kode_upt",ckd_upt)

lcdata = oSOAP.CallMethod("bayarTempatLain")

If oSOAP.lError
	lret = .F.
	Messagebox('Koneksi ke Server tidak Berhasil')
Else

	lret = .T.
	If Len(Alltrim(lcdata))<50
		lret = .F.
	Else
		text_to_cur2(lcdata)
	Endif
Endif

Return lret

****ADD/Update Data Blokir***

Function SendBlokir()
***menambah data Pemblokiran
Lparameter cnopol,dtgl,cket,cket1,lpolisi,lnew
Do wwSOAP
oSOAP = Createobject("wwSOAP")

oSOAP.cserverUrl = pcServerUrl

oSOAP.AddParameter("nopol",cnopol)
oSOAP.AddParameter("tgl_blokir",dtgl)
oSOAP.AddParameter("ket",cket)
oSOAP.AddParameter("ket1",cket1)
oSOAP.AddParameter("ispolisi",lpolisi)
oSOAP.AddParameter("isupdate",lnew)
lcdata = oSOAP.CallMethod("addblok")



If oSOAP.lError
	Messagebox('Koneksi ke Server tidak Berhasil')
	lret = .F.
Else


	lret = .T.
Endif

Return lret

****menghapus Data Blokir***
Function remove_Blokir()
****menghapus data blokir
Lparameter cnopol,lpolisi
Do wwSOAP
oSOAP = Createobject("wwSOAP")


oSOAP.cserverUrl = pcServerUrl
oSOAP.AddParameter("nopol",cnopol)
oSOAP.AddParameter("ispolisi",lpolisi)


lcdata = oSOAP.CallMethod("hapusBlokNopol")

*!*	MESSAGEBOX(osoap.cRequestXML)



If oSOAP.lError
	Messagebox('Koneksi ke Server tidak Berhasil')
	lret = .F.
Else
	lret = .T.
Endif

Return lret


Function List_bayar()
****Mengambil Data yang harus dibayar kendaraan dari Server
Lparameters lcnopol

Local lret
lret = .T.
If Empty(lcnopol)
	lcnopol = " "
Endif

*** Load wwSOAP dependencies

Do wwSOAP
oSOAP = Createobject("wwSOAP")
oSOAP.cserverUrl = pcServerUrl
oSOAP.AddParameter("nopol",lcnopol)
lcakend = oSOAP.CallMethod("listingPembayaran")



If oSOAP.lError
	lret = .F.
	Messagebox('Koneksi ke Server tidak Berhasil')

Else

	chasil = oSOAP.cResponseXML
	lret = .T.
Endif

Return lret



Function send_update_nopol()
Lparameters cnopol
csql = " select * FROM akend where nopol =?cnopol"
asg = SQLExec(gnconnhandle,csql,'temp_akend')
If asg<0
	Messagebox('error get akend')
	Return .F.
Endif
****bila tidak ada di akend ambil data di pkb_header
If Reccount('temp_akend')=0
	csql1 ="	SELECT a.nopol,a.nopol_eks,a.kohir,a.ktp,a.tgl_notice,a.sd_notice,a.tgl_swd,;
		 a.nama,a.kerja,a.alamat,a.kd_pos,a.jenis,a.kd_merk,a.tipe,a.thn_buat,a.kd_bbm, a.cyl,a.rangka,a.mesin, "
	csql2 ="a.no_bpkb,a.kd_milik,a.kd_guna,a.ke,a.warna,a.warna_plat ,a.no_stnkb ,a.tgl_stnk,a.sd_stnk, a.tg_ctk_st, a.dft_stnk,;
		 a.tgl_kwt,a.tgl_fiskal ,a.ubh_btk, a.ubh_msn , a.skum,a.sd_swd,a.tgl_dft,a.tgl_ttp,a.tgl_trm ,a.kd_lokasi as kode_upt "
	csql3 ="  from pkb_header a WHERE a.nopol =?cnopol"

	csql = csql1+csql2+csql3
	asg = SQLExec(gnconnhandle,csql,'temp_akend')
	If asg<0
		Messagebox('error get akend')
		Return .F.
	Endif
ENDIF 

	CAKEND = cur_to_text('temp_akend')
	update_nopol(cnopol,CAKEND)

Endfunc

Function update_nopol()

Lparameters lcnopol,CAKEND

Local lret
lret = .T.
If Empty(lcnopol)
	lcnopol = " "
Endif

*** Load wwSOAP dependencies

Do wwSOAP
oSOAP = Createobject("wwSOAP")
oSOAP.cserverUrl = pcServerUrl
oSOAP.AddParameter("nopol",lcnopol)
oSOAP.AddParameter("data",CAKEND)
lcakend = oSOAP.CallMethod("updateNopol")



If oSOAP.lError
	lret = .F.

	Messagebox('Gagal Update Ke Server')
Else

*!*		Messagebox(' Update Ke server Berhasil')
	lret = .T.

Endif
Release oSOAP
Return lret


Function Update_master()
Lparameters cnmtabel,npage,nlimit
Do wwSOAP
oSOAP = Createobject("wwSOAP")
oSOAP.cserverUrl = pcServerUrl
oSOAP.AddParameter("tabel",cnmtabel)
oSOAP.AddParameter("page",npage)
oSOAP.AddParameter("limit",nlimit)
cdata = oSOAP.CallMethod("masterTabel")


If oSOAP.lError
	lret = .F.
	Messagebox('Gagal Download Data '+Alltrim(cnmtabel)+' dari Server')
Else
	chasil = oSOAP.cResponseXML



	lret = .T.

Endif
Return cdata

Release oSOAP
Endfunc


****Mengambil Data Total tabel
Function Ask_Total_data()
Lparameters lctabel

Local lntot

lret = .T.
If Empty(lctabel)
	lctabel = " "
Endif



Do wwSOAP
oSOAP = Createobject("wwSOAP")
oSOAP.cserverUrl = pcServerUrl
oSOAP.AddParameter("tabel",lctabel)
lntot = oSOAP.CallMethod("totalDataTabel")



If oSOAP.lError
	lret = .F.

Else


Endif

Return lntot


Function Update_master_II()
Lparameters cnmtabel,npage,nlimit
Do wwSOAP
oSOAP = Createobject("wwSOAP")
oSOAP.cserverUrl = pcServerUrl
oSOAP.AddParameter("tabel",cnmtabel)
oSOAP.AddParameter("page",npage)
oSOAP.AddParameter("limit",nlimit)
cdata = oSOAP.CallMethod("masterTabel")


If oSOAP.lError
	lret = .F.
	Messagebox('Gagal Download Data '+Alltrim(cnmtabel)+' dari Server')
	cdata = ''
Else
	chasil = oSOAP.cResponseXML
	lret = .T.

Endif
Return cdata
Release oSOAP
Endfunc


Function send_querry()
Lparameters csql,ctabel,cadr
Do wwSOAP
oSOAP = Createobject("wwSOAP")
oSOAP.cserverUrl = cadr
oSOAP.AddParameter("select",csql)
cdata = oSOAP.CallMethod("tampil")


If oSOAP.lError
	lret = .F.
	cdata = ''
Else
	lret = .T.

Endif

If lret
	cstru = desc_stat(csql)
	cdata = env_res(ctabel,cstru,cdata)
	get_result(cdata,ctabel)
Endif

Return lret
Release oSOAP
Endfunc


*update untuk form lsend
*============================
Function send_update_nopol_ol()
Lparameters cnopol

SET STEP ON 

csql = " select * FROM akend where nopol =?cnopol"
asg = SQLExec(gnconnhandle,csql,'temp_akend')
If asg<0
	Messagebox('error get akend')
Endif

CAKEND = cur_to_text('temp_akend')


update_nopol_ol(cnopol,CAKEND)

Endfunc

Function update_nopol_ol()

Lparameters lcnopol,CAKEND

Local lret
lret = .T.
If Empty(lcnopol)
	lcnopol = " "
Endif

*** Load wwSOAP dependencies

Do wwSOAP
oSOAP = Createobject("wwSOAP")
oSOAP.cserverUrl = pcServerUrl
oSOAP.AddParameter("nopol",lcnopol)
oSOAP.AddParameter("data",CAKEND)
lcakend = oSOAP.CallMethod("updateNopol")



*!*	If oSOAP.lError
*!*		lret = .F.

*!*		Messagebox('Gagal Update Ke Server')
*!*	Else

*!*		Messagebox(' Update Ke server Berhasil')
*!*		lret = .T.

*!*	Endif
Release oSOAP
Return lret

Function update_status_ol()
Lparameters ldtanggal,lcnomor,lstatus
If lstatus
	lps = 1
Else
	lps = 0
Endif

csql = 'select COUNT(*) from send_status where no_dft =?lcnomor and tgl_dft=?ldtanggal'
asg = SQLExec(gnconnhandle,csql,'count_send')
If asg<0
	Messagebox('error count send_status')
Else
	Select count_send
	cfield = Field(1)
	njum = Val(&cfield)
	If njum>0
		csql = ' update send_status set lsend = ?lps where no_dft =?lcnomor and tgl_dft=?ldtanggal'

	Else
		csql = 	' insert into send_status(no_dft,tgl_dft,lsend)values(?lcnomor,?ldtanggal,?lps)'
	Endif


	asg = SQLExec(gnconnhandle,csql)
	If asg<0
		Messagebox('error update status pengiriman')
	Endif
Endif


*=======================
