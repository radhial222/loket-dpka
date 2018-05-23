Function text_to_cur2()
Lparameters cstring
Local chead,cbiasa,ctunggak,nlen_t,nmaxL,lpas
lpas= .F.

nmaxL = Len(cstring)

chead =  Strextract(cstring,'t_header[]','[]')
cbiasa =  Strextract(cstring,'t_biasa[]','[]')
nlen_t=Len(chead)+Len(cbiasa)+Len('t_header[][]')+Len('t_biasa[][]')+Len('t_tunggak[]')+1
ctunggak = Substr(cstring,nlen_t,nmaxL-nlen_t)

nrec = jum_Record(chead)
extract_header(chead,nrec)
extract_biasa(cbiasa,nrec)
extract_tunggak(ctunggak)
Endfunc



Function extract_header()
Lparameters cstr,nrec

If Occurs('|||',cstr) = 0
	nf =Occurs('||',cstr)+1
Else
	nf =Occurs('||',Strextract(cstr,'','|||',1))+1
Endif
Local Array laresp(nf,nrec)
FOR b = 1 TO nrec
	FOR a = 1 TO nf 
			laresp(a,b)=' '
	NEXT
next	
Local Array laFIELD(nf,2)
nfield=1
nfnum=1
lval = .F.
cval=''
cfield =''
njrec=1
nwidth_f=0
llfield = .F.
For hed = 1 To Len(Alltrim(cstr))
	If !lval
		If Substr(cstr,hed,1)=':'
			If Substr(cstr,hed+1,1)=':'
				If nfnum >nf
					llfield = .T.
				Endif
				If !llfield
					laFIELD(nfnum,1)=cfield
					laFIELD(nfnum,2)=nwidth_f
				Endif
				hed = hed+1
				lval=.T.
				nfnum=nfnum+1
				cfield=''
				nwidth_f=0
			Else
				cfield=cfield+Substr(cstr,hed,1)
				nwidth_f=nwidth_f+1
			Endif
		Else
			cfield=cfield+Substr(cstr,hed,1)
			nwidth_f=nwidth_f+1
		Endif
	Else
		If Substr(cstr,hed,1)='|'
			If Substr(cstr,hed+1,1)='|'
				lval = .F.
				laresp(nfield,njrec)=cval
				nfield = nfield+1
				cval =''
				If Substr(cstr,hed+2,1)='|'
					njrec=njrec+1
					hed=hed+2
					nfield = 1
					nfnum=1

*!*						exit
				Else
					hed=hed+1
				Endif
			Else
				cval=cval+Substr(cstr,hed,1)
			Endif
		Else
			cval=cval+Substr(cstr,hed,1)
		Endif
		If hed = Len(Alltrim(cstr))+1
			laresp(nfield,njrec)=cval
		Endif
	Endif
Next

cwidth = 200
ccrea= 'create cursor res_header('
For F = 1 To nf
	ccrea = ccrea+ laFIELD(F,1)+' c(200) '
	If F<nf
		ccrea = ccrea+','
	Endif
Next

ccrea = ccrea+')'
&ccrea
Select res_header
For v = 1 To nrec
	Append Blank
	For F = 1 To nf
		IF UPPER(laFIELD(F,1))<> 'KET_HPS_BYR'
		crep = 'REPLACE '+laFIELD(F,1) +' with "'+laresp(F,v)+'"'
		&crep
		ENDIF 
	Next
Next
Endfunc


Function extract_biasa()
Lparameters cstr,nrec
Local Array laresp(33,nrec)
Local Array laFIELD(33,2)
nfield=1
nfnum=1
lval = .F.
cval=''
cfield =''
njrec=1
nwidth_f=0
llfield = .F.
For hed = 1 To Len(Alltrim(cstr))
	If !lval
		If Substr(cstr,hed,1)=':'
			If Substr(cstr,hed+1,1)=':'
				If nfnum >33
					llfield = .T.
				Endif
				If !llfield
					laFIELD(nfnum,1)=cfield
					laFIELD(nfnum,2)=nwidth_f
				Endif
				hed = hed+1
				lval=.T.
				nfnum=nfnum+1
				cfield=''
				nwidth_f=0
			Else
				cfield=cfield+Substr(cstr,hed,1)
				nwidth_f=nwidth_f+1
			Endif
		Else
			cfield=cfield+Substr(cstr,hed,1)
			nwidth_f=nwidth_f+1
		Endif
	Else
		If Substr(cstr,hed,1)='|'
			If Substr(cstr,hed+1,1)='|'
				lval = .F.
				laresp(nfield,njrec)=cval
				nfield = nfield+1
				cval =''
				If Substr(cstr,hed+2,1)='|'
					njrec=njrec+1
					hed=hed+2
					nfield = 1
					nfnum=1
				Else
					hed=hed+1
				Endif
			Else
				cval=cval+Substr(cstr,hed,1)
			Endif
		Else
			cval=cval+Substr(cstr,hed,1)
		Endif
		If hed = Len(Alltrim(cstr))
			laresp(nfield,njrec)=cval
		Endif
	Endif
Next

cwidth = 30
ccrea= 'create cursor res_biasa('
For F = 1 To 33
	ccrea = ccrea+ laFIELD(F,1)+' c(30) '
	If F<33
		ccrea = ccrea+','
	Endif
Next

ccrea = ccrea+')'
&ccrea
Select res_biasa
For v = 1 To nrec
	Append Blank
	For F = 1 To 33
		crep = 'REPLACE '+laFIELD(F,1) +' with "'+laresp(F,v)+'"'
		&crep
	Next
Next
Endfunc


Function extract_tunggak()
Lparameters cstr
If Len(Alltrim(cstr))>45
	njmlrec = jum_Record(cstr)
	jmfield = jum_field(cstr)
	Local Array laresp(jmfield,njmlrec)
	Local Array laFIELD(jmfield,2)
	nfield=1
	nfnum=1
	lval = .F.
	cval=''
	cfield =''
	njrec=1
	nwidth_f=0
	llfield = .F.
	For hed = 1 To Len(Alltrim(cstr))
		If !lval
			If Substr(cstr,hed,1)=':'
				If Substr(cstr,hed+1,1)=':'
					If nfnum >jmfield
						llfield = .T.
					Endif
					If !llfield
						laFIELD(nfnum,1)=cfield
						laFIELD(nfnum,2)=nwidth_f
					Endif
					hed = hed+1
					lval=.T.
					nfnum=nfnum+1
					cfield=''
					nwidth_f=0
				Else
					cfield=cfield+Substr(cstr,hed,1)
					nwidth_f=nwidth_f+1
				Endif
			Else
				cfield=cfield+Substr(cstr,hed,1)
				nwidth_f=nwidth_f+1
			Endif
		Else
			If Substr(cstr,hed,1)='|'
				If Substr(cstr,hed+1,1)='|'
					lval = .F.
					laresp(nfield,njrec)=cval
					nfield = nfield+1
					cval =''
					If Substr(cstr,hed+2,1)='|'
						njrec=njrec+1
						hed=hed+2
						nfield = 1
						nfnum=1
					Else
						hed=hed+1
					Endif
				Else
					cval=cval+Substr(cstr,hed,1)
				Endif
			Else
				cval=cval+Substr(cstr,hed,1)
			Endif
			If hed = Len(Alltrim(cstr))
				laresp(nfield,njrec)=cval
			Endif
		Endif
	Next

	cwidth = 30
	ccrea= 'create cursor res_tunggak('
	For F = 1 To jmfield
		ccrea = ccrea+ laFIELD(F,1)+' c(30) '
		If F<jmfield
			ccrea = ccrea+','
		Endif
	Next

	ccrea = ccrea+')'
	&ccrea
	Select res_tunggak
	For v = 1 To njmlrec
		Append Blank
		For F = 1 To jmfield
			crep = 'REPLACE '+laFIELD(F,1) +' with "'+laresp(F,v)+'"'
			&crep
		Next
	Next
Endif
Endfunc





Function jum_Record()
Lparameters crec_str
Local njm_rec
njm_rec=1
For rec = 1 To Len(Alltrim(crec_str))
	If Substr(crec_str,rec,3)='|||'
		njm_rec = njm_rec+1
	Endif
Next

Return njm_rec

Function jum_field()
Lparameters cstr
Local njum
njum=1
nx=0
For x = 1 To Len(Alltrim(cstr))
	If Substr(cstr,x,3)='|||'
		Exit
	Else
		If Substr(cstr,x,2)='||'
			njum=njum+1
		Endif
	Endif
Next
Return njum



Function text_to_cur()
Lparameters cstr
**** start debugging
nfield =jum_field(cstr)
If nfield>1
	Local Array laFIELD(nfield,3)
	Local nCount
	nCount=1
	nWidth_field=0
	nStart_field=1

	nStart_Val=1
	nWidth_Val=0
	llVa = .F.

	For k = 1 To Len(Alltrim(cstr))
		If !llVa
			If Substr(cstr,k,1)=':'
				If Substr(cstr,k+1,1)=':'
					laFIELD(nCount,1)=Substr(cstr,nStart_field,nWidth_field)
					nStart_Val= k+2
					nWidth_field=0
					llVa=.T.
				Endif
			Else
				If Substr(cstr,k,1)#'|'
					nWidth_field=nWidth_field+1
				Endif
			Endif
		Else
			If Substr(cstr,k,1)='|'
				If Substr(cstr,k+1,1)='|'
					laFIELD(nCount,2)=Substr(cstr,nStart_Val,nWidth_Val)
					laFIELD(nCount,3)=(nWidth_Val)
					nStart_field=k+2
					nWidth_Val=0
					llVa=.F.
					nCount=nCount+1
				Endif
			Else
				If Substr(cstr,k,1)#':'
					nWidth_Val=nWidth_Val+1
				Endif
			Endif
		Endif
		If k = Len(Alltrim(cstr))
			laFIELD(nCount,2)=Substr(cstr,nStart_Val,nWidth_Val)
			laFIELD(nCount,3)=(nWidth_Val)

		Endif
	Next

	ccur = 'CREATE cursor respond('
	For N = 1 To nfield
		cfcur = laFIELD(N,1)+' c('+Iif(laFIELD(N,3)>0,Alltrim(Str(laFIELD(N,3))),'1')+'),'
		ccur = ccur+cfcur
	Next
	ccrea =Substr(ccur,1,Len(Alltrim(ccur))-1)+')'
	&ccrea
	Select respond
	Append Blank
	For F = 1 To nfield
		cnmfield =Field(F)
		Replace &cnmfield With laFIELD(F,2)
	Next

Endif
Endfunc

Function Sync_type()
Lparameters xtype,cdata
Local cret
Do Case
Case Type('xtype')= 'C' Or Type('xtype')= 'M'
	cret = Alltrim(cdata)
Case Type('xtype')= 'D'
	cret = Ctod(cdata)
Case Type('xtype')= 'N'
	cret = Val(cdata)
Case Type('xtype')= 'L'
	cret = Iif(Alltrim(cdata)='1',.T.,.F.)
Endcase
Return cret





Function update_akend_r()
Select respond
*!*	SET STEP ON 

vNopol 	= respond.nopol
vNopol_eks	=respond.nopol_eks
vKtp 	= respond.ktp
vNama	= respond.nama
vKerja 	= respond.kerja
vAlamat	= respond.alamat
vkd_pos = respond.kd_pos
vjenis  = respond.jenis
vkd_merk= respond.kd_merk
vtipe 	=respond.tipe
vthn_buat = respond.thn_buat
vkd_bbm = respond.kd_bbm

*!*	vcyl 	= lcObject.pageframe1.page2.txtCyl.value &&des
vcyl 	=cyl
vrangka = respond.rangka
vmesin  = respond.mesin
vno_bpkb= respond.no_bpkb
vkd_milik = respond.kd_milik
vkd_guna = respond.kd_guna
vno_hp = respond.no_hp
vke 	= IIF(ISNULL(respond.ke) or EMPTY(respond.ke),1,respond.ke)

vwarna 	= respond.warna
vwarna_plat = respond.warna_plat

vtgl_stnk = Alltrim(respond.tgl_stnk)
dtgl_stnk = Alltrim(respond.tgl_stnk)


dsd_stnk =  Alltrim(respond.sd_stnk)
dsd_notice =  Alltrim(respond.sd_notice)

*!*	vsd_swd   = lcObject.pageframe1.page2.txtTgl_Notice.value
dsd_swd =  Alltrim(respond.sd_swd)

dtgl_faktur = Iif(!Empty(respond.tgl_faktur),Alltrim(respond.tgl_faktur),Null)
dtgl_notice = Iif(!Empty(respond.tgl_notice),Alltrim(respond.tgl_notice),Null)
ckode_upt = Alltrim(respond.kode_upt)

csql = 'SELECT nopol from akend_r where nopol =?vnopol'
asg =SQLExec(gnconnhandle,csql,'rskend')
If asg<0
	Messagebox('ERROR get akend_r')
Else
	If Reccount('rskend')>0
		csql = 'delete from  akend_r where nopol =?vnopol'
		asg =SQLExec(gnconnhandle,csql)
		If asg<0
			Messagebox('ERROR Reset akend_r')
		Endif
	Endif



	cSql1 = "insert into akend_r (nopol, nopol_eks, ktp, nama, kerja, alamat, kd_pos, jenis, kd_merk, tipe, ;
		thn_buat, kd_bbm, cyl, rangka, mesin, no_bpkb, kd_milik, kd_guna, ke, warna, warna_plat, tgl_stnk, "

	csql1a = "sd_stnk, tgl_notice, sd_notice, sd_swd, tgl_faktur,kode_upt,no_hp) values ("

*!*		cSql2 = "'" + vNopol + "','" + vNopol_eks + "','" + vKtp + "','" + vNama + "','" + vKerja + "','" + vAlamat	+ ;
*!*			"','" + vkd_pos + "','" + vjenis + "','" + vkd_merk + "','" + vtipe + "','" + vthn_buat + "','" + vkd_bbm +;
*!*			"'," + vcyl + ",'" + vrangka + "','" + vmesin + "','" + vno_bpkb + "','" + vkd_milik + "',"

*!*		cSql3 = "'" + vkd_guna + "'," + vke + ",'" + vwarna + "','" + vwarna_plat + "','" + dtgl_stnk + ;
*!*			"','" + dsd_stnk + "','" + dtgl_notice + "','" + dsd_notice + "','" + dsd_swd + "','" + dtgl_faktur+ "','" + ckode_upt + "')"

	cSql2 =  "?vNopol,?vNopol_eks,?vKtp,?vNama,?vKerja,?vAlamat, ;
				?vkd_pos,?vjenis,?vkd_merk,?vtipe,?vthn_buat,?vkd_bbm,;
		     ?vcyl,?vrangka,?vmesin,?vno_bpkb,?vkd_milik,"

	cSql3 =  " ?vkd_guna,?vke,?vwarna ,?vwarna_plat,?dtgl_stnk  , ;
 		    ?dsd_stnk,?dtgl_notice,?dsd_notice,?dsd_swd,?dtgl_faktur,?ckode_upt,?vno_hp)"




	cstr = cSql1+csql1a+cSql2+cSql3
*!*		STRTOFILE(cstr,'c:\test.txt')
	asg =SQLExec(gnconnhandle,cstr)
	If asg<0
cek_error()

		Messagebox('ERROR get akend_r')
	Else
		Select respond
		Use
	Endif

Endif
Endfunc





Function buka_akend_r()
If Used('akend_r')
	Select akend_r
	Use
Endif

Use Data\akend_r Alias akend_r In 0 Shared
Endfunc

*!*	Function cur_to_text()
*!*	Lparameters cTable

*!*	Local ctresp
*!*	ctresp =''
*!*	nfield =Fcount('&cTable')
*!*	Select &cTable
*!*	For i = 1 To nfield
*!*		cfield = Lower(Field(i))
*!*		cisi = convert_type(&cfield)
*!*		ctresp = ctresp+cfield+'::'+Iif(!Isnull(cisi),cisi,'')
*!*		If i < nfield
*!*			ctresp = ctresp+'||'
*!*		Endif
*!*	Next
*!*	Return ctresp

Function cur_to_text()
Lparameters cTable
nrec=Reccount('&ctable')

Local ctresp,nCount
ctresp =''
nCount=0
nfield =Fcount('&cTable')
Select &cTable
Go Top
Do While !Eof()
	nCount=nCount+1
	For i = 1 To nfield
		cfield = Lower(Field(i))
		cisi = convert_type(&cfield)
		ctresp = ctresp+cfield+'::'+Iif(!Isnull(cisi),cisi,'')
		If i < nfield
			ctresp = ctresp+'||'
		Endif
	Next
	If nCount<nrec
		ctresp = ctresp+'|||||'
	Endif
	Skip
Enddo

Return ctresp





Function convert_type()
Lparameters cdata
ctype = Type('cdata')
cret =''
Do Case
Case ctype = 'C'
	cret = Alltrim(cdata)
Case ctype = 'D'
	If cdata < Ctod('01/01/1900')
		cret =''
	Else
		csdate = Set('date')

		Set Date To ymd
		cret = rubah_tanggal(Dtoc(cdata))
		Set Date To &csdate
	Endif
Case ctype = 'N'
	cret = Alltrim(Str(cdata))
Case ctype = 'L'
	If cdata = .T.
		cret = '1'
	Else
		cret = '0'
	Endif
Case ctype = 'Y'
	cret = Alltrim(Str(cdata))
Endcase
Return 	cret

Function conv_tanggal()
Lparameters _dtgl
csdate = Set('date')
Set Date To ymd
cret = rubah_tanggal(Dtoc(_dtgl))


Set Date To &csdate

Return cret


Function rubah_tanggal()
Lparameters ctgl
cftgl=''
If !Isnull(ctgl)
	npjg =Len(Allt(ctgl))
	cloop = 0
	cyear=''
	cbln=''
	cday=''
	For k = 1 To npjg
		If !Inlist(Substr(ctgl,k,1),'/','-')
			Do Case
			Case cloop = 0
				cyear = cyear+ Substr(ctgl,k,1)
			Case cloop = 1
				cbln = cbln+ Substr(ctgl,k,1)
			Case cloop = 2
				cday = cday+ Substr(ctgl,k,1)
			Endcase
		Else
			cloop = cloop+1

		Endif
	Next
	cftgl= cyear+'-'+cbln+'-'+cday
Else
	cftgl=''
Endif
Return cftgl


Function open_tabel()
Lparameters ctabel,calias,ckond,corder
Local csql,lsucces

csql = 'select * from '+ctabel
If !Empty(ckond)
	csql = csql +ckond
Endif
If !Empty(corder)
	csql = csql +corder
Endif

asq = SQLExec(gnconnhandle,csql,'&calias')
If asq <0
	Messagebox('error get tabel'+ctabel)

Else

Endif
Endfunc

&& FORMAT CETAK STNK
Function F_CTK_NOPOL
Lparameters cnopol

cret = format_nopol(cnopol,1)+' '+format_nopol(cnopol,2)+' '+format_nopol(cnopol,3)

Return Alltrim(cret)

Function format_nopol()
Lparameters cnopol,nbag
Local cnpl

cnpl = ''
If !Empty(cnopol)
	If !Isnull(cnopol)
		Do Case
		Case nbag = 1
			For p = 1 To Len(cnopol)
				If  !Inlist(Substr(cnopol,p,1),'1','2','3','4','5','6','7','8','9','0')
					cnpl = cnpl+ Substr(cnopol,p,1)
				Else
					Exit
				Endif
			Next

		Case nbag = 2
			For k = 2 To Len(cnopol)
				If  Inlist(Substr(cnopol,k,1),'1','2','3','4','5','6','7','8','9','0')
					cnpl=cnpl+Substr(cnopol,k,1)
				Endif
			Next
		Case nbag = 3
			For k = 3 To Len(cnopol)
				If  !Inlist(Substr(cnopol,k,1),'1','2','3','4','5','6','7','8','9','0',' ')
					cnpl=cnpl+Substr(cnopol,k,1)
				Endif
			Next
		Endcase
	Endif
Endif

Return cnpl

Function close_tabel()

Aused(lawork)
*!*	SET STEP ON 
_nwork = Alen(lawork,1)
For T =1 To _nwork-1
	_ctabel = Lower(lawork(T,1))
	If !Inlist(_ctabel,'otori')
		Select &_ctabel
		Use
	Endif
Next

Release lawork
Endfunc

Function update_status()
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


Function rem_spasi()
Lparameters _ctext
nmlop = Len(Alltrim(_ctext))
creturn = ''
For c = 1 To nmlop
	If Substr(_ctext,c,1)# Space(1)
		creturn = creturn +Substr(_ctext,c,1)
	Endif
Next
Return creturn


Function save_respond()

Local csql
nmaxF = Fcount('res_header')
Local Array larespon(nmaxF,2)

csql = ''
cSql2 = ''
Select res_header

Go Top
Do While !Eof()
	Wait Wind('update data pkb_header ')Nowait
	For k = 1 To nmaxF
		cfield = Field(k)
		lcvar = cfield
		larespon(k,1)=cfield
		larespon(k,2)=&cfield
	Next

	cno_dft = Alltrim(larespon(1,2))
	ctgl_dft =Alltrim(larespon(2,2))
	csql_cari = 'select * from pkb_header where ;
			 no_dft = ?cno_dft and tgl_dft =?ctgl_dft'
	asg = SQLExec(gnconnhandle,csql_cari,'rs_h')
	If asg<0
		=Messagebox('error count data')
	Else
		If Reccount('rs_h')>0
			ctindak = 'EDIT'
			csql = 'update pkb_header set '
			cSql2 =''
			cSql3 = 'where no_dft = '+cno_dft+' and tgl_dft ='+ctgl_dft
			For lop = 3 To nmaxF
				cSql2=cSql2+larespon(lop,1)+"="+Iif(!Empty(larespon(lop,2)),"'"+Alltrim(larespon(lop,2))+"'",'null  ')
				If lop<nmaxF
					cSql2=cSql2+','
				Endif
			Next
		Else
			ctindak = 'Append'
			csql = 'insert into pkb_header ( '
			cSql2 =''
			cSql3 = 'values('
			For lop = 1 To nmaxF
				cSql2 = cSql2+larespon(lop,1)
				cSql3 = cSql3+Iif(!Empty(larespon(lop,2)),"'"+Alltrim(larespon(lop,2))+"'",'null  ')
				If lop<nmaxF
					cSql2=cSql2+','
					cSql3=cSql3+','
				Else
					cSql2=cSql2+')'
					cSql3=cSql3+')'
				Endif
			Next

		Endif

		csqlstr = csql+cSql2+cSql3
		Strtofile(csqlstr,'c:\has_sql.txt')
		asg = SQLExec(gnconnhandle,csqlstr)
		If asg<0
			=Messagebox('error update PKB_header')
			Return
*!*			Else
*!*				hist_pkb_header(ctindak,cno_dft,ctgl_dft)
		Endif


	Endif
	Select res_header
	Skip
Enddo


***** Update ke Pkb_biasa
Select res_biasa
Wait Wind('update data pkb_Biasa ')Nowait
nmaxF = Fcount('res_biasa')
Local Array larespon(nmaxF,2)
Go Top
Do While !Eof()
	For k = 1 To nmaxF
		cfield = Field(k)
		lcvar = cfield
		larespon(k,1)=cfield
		larespon(k,2)=&cfield
	Next

	cno_dft = Alltrim(larespon(1,2))
	ctgl_dft =Alltrim(larespon(2,2))
	csql_cari = 'select * from pkb_biasa where ;
			 no_dft = ?cno_dft and tgl_dft =?ctgl_dft'
	asg = SQLExec(gnconnhandle,csql_cari,'rs_h')
	If asg<0
		=Messagebox('error count data')
	Else
		If Reccount('rs_h')>0
			csql = 'update pkb_biasa set '
			cSql2 =''
			cSql3 = 'where no_dft = '+cno_dft+' and tgl_dft ='+ctgl_dft
			For lop = 3 To nmaxF
				cSql2=cSql2+larespon(lop,1)+"="+Iif(!Empty(larespon(lop,2)),"'"+Alltrim(larespon(lop,2))+"'",'null  ')
				If lop<nmaxF
					cSql2=cSql2+','
				Endif
			Next
		Else
			csql = 'insert into pkb_biasa ( '
			cSql2 =''
			cSql3 = 'values('
			For lop = 1 To nmaxF
				cSql2 = cSql2+larespon(lop,1)
				cSql3 = cSql3+Iif(!Empty(larespon(lop,2)),"'"+Alltrim(larespon(lop,2))+"'",'null  ')
				If lop<nmaxF
					cSql2=cSql2+','
					cSql3=cSql3+','
				Else
					cSql2=cSql2+')'
					cSql3=cSql3+')'
				Endif
			Next

		Endif

		csqlstr = csql+cSql2+cSql3
		Strtofile(csqlstr,'c:\has_sql.txt')
		asg = SQLExec(gnconnhandle,csqlstr)
		If asg<0
			=Messagebox('error update PKB_biasa')
			Return
		Else
			hist_pkb_BIASA(ctindak,cno_dft,ctgl_dft)
		Endif


	Endif
	Select res_biasa
	Skip
Enddo


****PKB_tunggak
llada= .F.
Aused(lawork)
_nwork = Alen(lawork,1)
For T =1 To _nwork-1
	_ctabel = lawork(T,1)
	If Inlist(_ctabel,'res_tunggak')
		llada=.T.
	Endif
Next

Release lawork

If llada
	Select res_tunggak

	Wait Wind('update data pkb_tunggak ')Nowait
	nmaxF = Fcount('res_tunggak')
	Local Array larespon(nmaxF,2)
	If Reccount('res_tunggak')>0
		Select res_tunggak
		Go Top
		Do While !Eof()
			For k = 1 To nmaxF
				cfield = Field(k)
				lcvar = cfield
				larespon(k,1)=cfield
				larespon(k,2)=&cfield
			Next

			cno_dft = Alltrim(larespon(1,2))
			ctgl_dft =Alltrim(larespon(2,2))
			csql_cari = 'select * from pkb_tunggak where ;
			 no_dft = ?cno_dft and tgl_dft =?ctgl_dft'
			asg = SQLExec(gnconnhandle,csql_cari,'rs_h')
			If asg<0
				=Messagebox('error count data')
			Else
				If Reccount('rs_h')>0
					csql = 'update pkb_tunggak set '
					cSql2 =''
					cSql3 = 'where no_dft = '+cno_dft+' and tgl_dft ='+ctgl_dft
					For lop = 3 To nmaxF
						cSql2=cSql2+larespon(lop,1)+"="+Iif(!Empty(larespon(lop,2)),"'"+Alltrim(larespon(lop,2))+"'",'null  ')
						If lop<nmaxF
							cSql2=cSql2+','
						Endif
					Next
				Else
					csql = 'insert into pkb_tunggak ( '
					cSql2 =''
					cSql3 = 'values('
					For lop = 1 To nmaxF
						cSql2 = cSql2+larespon(lop,1)
						cSql3 = cSql3+Iif(!Empty(larespon(lop,2)),"'"+Alltrim(larespon(lop,2))+"'",'null  ')
						If lop<nmaxF
							cSql2=cSql2+','
							cSql3=cSql3+','
						Else
							cSql2=cSql2+')'
							cSql3=cSql3+')'
						Endif
					Next

				Endif

				csqlstr = csql+cSql2+cSql3
				Strtofile(csqlstr,'c:\has_sql.txt')
				asg = SQLExec(gnconnhandle,csqlstr)
				If asg<0
					=Messagebox('error update PKB_tunggak')
					Return
				Else
					hist_pkb_TUNGGAK(ctindak,cno_dft,ctgl_dft)
				Endif


			Endif
			Select res_tunggak
			Skip
		Enddo

	Endif
Endif
***Update Akend
Select nopol,nopol_eks,kohir,ktp,tgl_notice,sd_notice,tgl_swd,;
	nama,kerja,alamat,kd_pos,jenis,kd_merk,tipe,thn_buat,kd_bbm, cyl,rangka,mesin,;
	no_bpkb,kd_milik,kd_guna,ke,warna,warna_plat ,  no_stnkb ,tgl_stnk, sd_stnk, tg_ctk_st, dft_stnk,;
	tgl_kwt,tgl_fiskal ,ubh_btk, ubh_msn , skum,upt_bayar As kode_upt,;
	sd_swd,tgl_dft From res_header Into Cursor  res_akend

Select res_akend
Wait Wind('update data akend ')Nowait
nmaxF = Fcount('res_akend')
Local Array larespon(nmaxF,2)
If Reccount('res_akend')>0
	Select res_akend
	Go Top
	Do While !Eof()
		For k = 1 To nmaxF
			cfield = Field(k)
			lcvar = cfield
			larespon(k,1)=cfield
			larespon(k,2)=&cfield
		Next

		cnopol  = Alltrim(larespon(1,2))
		csql_cari = 'select * from akend where ;
			 nopol = ?cnopol'
		asg = SQLExec(gnconnhandle,csql_cari,'rs_h')
		If asg<0
			=Messagebox('error count data')
		Else
			If Reccount('rs_h')>0
				ctindak ='EDIT'
				csql = "update akend set "
				cSql2 =""
				cSql3 = "  where nopol ='"+cnopol+ "'"
				For lop = 3 To nmaxF
					If !Empty(larespon(lop,2))
						If Upper(Alltrim(larespon(lop,1)))='KODE_UPT'
							cSql2=cSql2+larespon(lop,1)+"='"+Alltrim(pckdupt)+"'"
						Else
							cSql2=cSql2+larespon(lop,1)+"="+Iif(!Empty(larespon(lop,2)),"'"+Alltrim(larespon(lop,2))+"'","''")
						Endif
						If lop<nmaxF
							cSql2=cSql2+','
						Endif
					Endif
				Next
			Else
				ctindak ='Append'
				csql = 'insert into akend( '
				cSql2 =''
				cSql3 = 'values('
				For lop = 1 To nmaxF
					cSql2 = cSql2+ Iif(!Empty(larespon(lop,2)),larespon(lop,1),'')
					If Upper(Alltrim(larespon(lop,1)))='KODE_UPT'
						cSql3 = cSql3+"'"+Alltrim(pckdupt)+"'"
					Else
						If !Empty(larespon(lop,2))
							cSql3 = cSql3+Iif(!Empty(larespon(lop,2)),"'"+Alltrim(larespon(lop,2))+"'","''")
						Endif
					Endif
					If lop<nmaxF
						If !Empty(larespon(lop,2))
						cSql2=cSql2+','
						cSql3=cSql3+','
						ENDIF 
					Else
						cSql2=cSql2+')'
						cSql3=cSql3+')'
					Endif
				Next

			Endif


			csqlstr = csql+cSql2+cSql3

			asg = SQLExec(gnconnhandle,csqlstr)
			If asg<0
				=Messagebox('error update Akend')
				cek_error() 
				Return
			Else
				hist_akend(ctindak,cnopol)
			Endif


		Endif
		Select res_akend
		Skip
	Enddo
Endif

Endfunc

***dari prosedur master Tabel

Function extract_master()
*    tabel, struktur, data
*    pemisah data untuk tabel master
*	  1 = :::
*     2 = |||
*     3 = []
*     4 = |
*    Format :
*      tabel:::nama_tabel|||struktur:::nama_field1|nama_field2|nama_field3|||data:::data1_row1|data2_row1|data3_row1[]data1_row1|data2_row1|data3_row1
***************************************************

Lparameters ctext
Local _ccur,Lnot_valid

N= Occurs('tabel',ctext)
If N<0
	Lnot_valid = .T.
Endif

N= Occurs('struktur',ctext)
If N<0
	Lnot_valid = .T.
Endif

N= Occurs('data:::',ctext)
If N<0
	Lnot_valid = .T.
Endif

If Lnot_valid
	Messagebox('String yang di passing tidak sesuai, Hubungi konsultan',0+16,'Error Converting')
Else

	_ctabel = Strextract(ctext,'tabel:::','|||')
	_cstruk = Strextract(ctext,'struktur:::','|||')
	_nloop = Occurs(ctext,'[]')

***get stuktur tabel tuju

	csql = 'select * from '+Alltrim(_ctabel)+' limit 0,1'
	asg = SQLExec(gnconnhandle,csql,'rs_temp')
	If asg<0
		Messagebox('error get struktur tabel '+Alltrim(_ctabel))
	Else

***Buat Cursor penampung

		Afields(lastruk,'rs_temp')
		_njumf= Fcount('rs_temp')

		cscursor = 'create cursor temp_cur('
		For F = 1 To _njumf
			cscursor= cscursor+lastruk(F,1)+Space(1)+lastruk(F,2)+Space(1)+'('+Alltrim(Str(lastruk(F,3)))+')'

			If F<_njumf
				cscursor=cscursor+','
			Endif
		Next
		cscursor=cscursor+')'

		&cscursor


****baca data dari Xml...
		cdata = Strextract(ctext,'data:::','')
		_nloop = Occurs('[]',cdata)

***data row pertama
		cisi = Strextract(cdata,'','[]',1)

***Prosedur menyimpan ke cursor sementara
		If update_temp_cur(cisi)

***	data ke 2 sampai n-1
			For d = 1 To _nloop -1
				cisi = Strextract(cdata,'[]','[]',d)
				If !update_temp_cur(cisi)
					Exit
				Endif
			Next

***data row terakhir
			cisi = Strextract(cdata,'[]','',_nloop)
			If update_temp_cur(cisi)
				Wait Wind('Proses simpan ke cursor selesai ')
			Else
				Wait Wind('Proses simpan ke cursor gagal ')
			Endif
		Endif

	Endif

Endif



Endfunc

Function update_temp_cur()
Lparameters ccont

If !Used('temp_cur')
	Messagebox('cursor sementara belum dibuat')
	Return .F.
Else
	njumF= Fcount('temp_cur')
	nlong = Occurs('|',ccont)
*make new row blank
	Select temp_cur
	Append Blank


*isi row pertama
	cval = Strextract(ccont,'','|',1)
	Select temp_cur
	ctype = Type(Field(1))
	cfield = Field(1)
***convert ke type data cursor
	cval=convert_to_type(cval,ctype)
***apend ke cursor
	Replace &cfield With cval


***	data ke 2 sampai n-1
	For nf = 1 To nlong -1
		cval = Strextract(ccont,'|','|',nf)
		ctype = Type(Field(nf+1))
		cval=convert_to_type(cval,ctype)
		cfield = Field(nf+1)
		Replace &cfield With cval
	Next

***data row terakhir
	cval = Strextract(cdata,'|','',nlong)
	cval = Strextract(ccont,'|','|',nf)
	ctype = Type(Field(nlong))
	cval=convert_to_type(cval,ctype)
	cfield = Field(nlong)
	Replace &cfield With cval

	Return .T.
Endif
Endfunc








Function convert_to_type()
Lparameters cdata,ctype
Do Case
Case ctype = 'C'
	cret = Alltrim(cdata)
Case ctype = 'D'
	csdate = Set('date')

	Set Date To ymd
	cret = Ctod(cdata)
	Set Date To &csdate

*!*	Case ctype = 'N'
*!*			cret =val(cdata)
Case ctype = 'L'
	If cdata = .T.
		cret = 1
	Else
		cret = 0
	Endif
Case ctype = 'Y'Or ctype = 'N'
	cdec = Set('Point')
	Set Point To '.'
	cret = Val(cdata)
	Set Point   To &cdec

Endcase
Return 	cret
Endfunc


Function update_local_master()
Lparameters ctext
Local _ccur,Lnot_valid

N= Occurs('tabel',ctext)
If N<0
	Lnot_valid = .T.
Endif

N= Occurs('struktur',ctext)
If N<0
	Lnot_valid = .T.
Endif

N= Occurs('data:::',ctext)
If N<0
	Lnot_valid = .T.
Endif

If Lnot_valid
	Messagebox('String yang di passing tidak sesuai, Hubungi konsultan',0+16,'Error Converting')
Else

	_ctabel = Strextract(ctext,'tabel:::','|||')
	_cstruk = Strextract(ctext,'struktur:::','|||')
	_nloop = Occurs(ctext,'[]')

***get stuktur tabel tuju
	clstru = Strtran(_cstruk,'|',',')

***reset data tabel tujuan
	csql = ' delete from ' +_ctabel
	asg = SQLExec(gnconnhandle,csql)
	If asg<0
		Messagebox('error reset tabel' +cnmtabel)
	Else

***** Step on

		cSql1 = 'insert into '+_ctabel+' ('+clstru+')'
		cSql2 = ' values '

****baca data dari Xml...
		cdata = Strextract(ctext,'data:::','')

		_nloop = Occurs('[]',cdata)

		If _nloop>0
***data row pertama
			cisi = Strextract(cdata,'','[]',1)
			cSql3 =Strtran(cisi,'|','","')
			cSql3 ='("'+cSql3+'")'

***Prosedur update ke  tabel
			csql = cSql1+cSql2+cSql3
			asg = SQLExec(gnconnhandle,csql)
			If asg<0
				Messagebox('error Update tabel '+_ctabel)
				Return
			Endif


***	data ke 2 sampai n-1
			For d = 1 To _nloop -1
				cisi = Strextract(cdata,'[]','[]',d)

***data row
				cSql3 =Strtran(cisi,'|','","')
				cSql3 ='("'+cSql3+'")'

***Prosedur update ke  tabel
				csql = cSql1+cSql2+cSql3
				asg = SQLExec(gnconnhandle,csql)
				If asg<0
					Messagebox('error Update tabel '+_ctabel)
					Return
				Endif
			Next


***data row terakhir
			cisi = Strextract(cdata,'[]','',_nloop)
			cSql3 =Strtran(cisi,'|','","')
			cSql3 ='("'+cSql3+'")'

***Prosedur update ke  tabel
			csql = cSql1+cSql2+cSql3
			asg = SQLExec(gnconnhandle,csql)
			If asg<0
				Messagebox('error Update tabel '+_ctabel)
				Return
			Else
				Wait Wind('Proses simpan ke cursor selesai ')

			Endif

		Else
			Messagebox('Tidak Ada Data dari Server simpan ke cursor selesai ',0+64)
		Endif


	Endif

Endif
Endfunc


Function update_local_masterII()
Lparameters ctext
Local _ccur,Lnot_valid,lret

N= Occurs('tabel',ctext)
If N<0
	Lnot_valid = .T.
Endif

N= Occurs('struktur',ctext)
If N<0
	Lnot_valid = .T.
Endif

N= Occurs('data:::',ctext)
If N<0
	Lnot_valid = .T.
Endif

If Lnot_valid
	Messagebox('String yang di passing tidak sesuai, Hubungi konsultan',0+16,'Error Converting')
Else

	_ctabel = Strextract(ctext,'tabel:::','|||')
	_cstruk = Strextract(ctext,'struktur:::','|||')
	_nloop = Occurs(ctext,'[]')

***get stuktur tabel tuju
	clstru = Strtran(_cstruk,'|',',')



***** Step on

	cSql1 = 'insert into '+_ctabel+' ('+clstru+')'
	cSql2 = ' values '

****baca data dari Xml...
	cdata = Strextract(ctext,'data:::','')

	_nloop = Occurs('[]',cdata)

	If _nloop>0
***data row pertama
		cisi = Strextract(cdata,'','[]',1)
		cSql3 =Strtran(cisi,'|','","')
		cSql3 ='("'+cSql3+'")'

***Prosedur update ke  tabel
		csql = cSql1+cSql2+cSql3
		asg = SQLExec(gnconnhandle,csql)
		If asg<0
			Messagebox('error Update tabel '+_ctabel)
			Return
		Endif


***	data ke 2 sampai n-1
		For d = 1 To _nloop -1
			cisi = Strextract(cdata,'[]','[]',d)

***data row
			cSql3 =Strtran(cisi,'|','","')
			cSql3 ='("'+cSql3+'")'

***Prosedur update ke  tabel
			csql = cSql1+cSql2+cSql3
			asg = SQLExec(gnconnhandle,csql)
			If asg<0
				Messagebox('error Update tabel '+_ctabel)
				Return
			Endif
		Next


***data row terakhir
		cisi = Strextract(cdata,'[]','',_nloop)
		cSql3 =Strtran(cisi,'|','","')
		cSql3 ='("'+cSql3+'")'

***Prosedur update ke  tabel
		csql = cSql1+cSql2+cSql3
		asg = SQLExec(gnconnhandle,csql)
		If asg<0
			Messagebox('error Update tabel '+_ctabel)
			lret = .F.
			Return
		Else
			lret = .T.
		Endif

	Else
		If !Empty(cdata)
			cSql3 =Strtran(cdata,'|','","')
			cSql3 ='("'+cSql3+'")'
			csql = cSql1+cSql2+cSql3

			asg = SQLExec(gnconnhandle,csql)
			If asg<0
				Messagebox('error Update tabel '+_ctabel)
			Else
				lret = .T.
			Endif

		Else

			Messagebox('Tidak Ada Data dari Server simpan ke cursor selesai ',0+64)
			lret =.F.
		Endif

	Endif




Endif
Return lret
Endfunc



***mengupdate data rekap

Function update_rekap_1()
Lparameters no,tgl

Local i, j, Y, m, N, cHuruf, cPlat
Local  pkb_pk1[9,2],pkb_dd1[9,2],bbn1_pk1[9,2],bbn1_dd1[9,2],bbn2_pk1[9,2],bbn2_dd1[9,2] && Array Plat Merah
Local  pkb_pk2[9,2],pkb_dd2[9,2],bbn1_pk2[9,2],bbn1_dd2[9,2],bbn2_pk2[9,2],bbn2_dd2[9,2] && Array Plat kuning
Local  pkb_pk3[9,2],pkb_dd3[9,2],bbn1_pk3[9,2],bbn1_dd3[9,2],bbn2_pk3[9,2],bbn2_dd3[9,2] && Array Plat Hitam
Local  jum_kend[9,4]

*!*	local  bs_pk2[9,2],bs_dd2[9,2],tg_pk2[9,2],tg_dd2[9,2] && Array Plat Kuning
*!*	local  bs_pk3[9,2],bs_dd3[9,2],tg_pk3[9,2],tg_dd3[9,2] && Array Plat Hitam

Dimension  pkb_pk1[9,2],pkb_dd1[9,2],bbn1_pk1[9,2],bbn1_dd1[9,2],bbn2_pk1[9,2],bbn2_dd1[9,2] && Array Plat Merah
Dimension pkb_pk2[9,2],pkb_dd2[9,2],bbn1_pk2[9,2],bbn1_dd2[9,2],bbn2_pk2[9,2],bbn2_dd2[9,2] && Array Plat Kuning
Dimension pkb_pk3[9,2],pkb_dd3[9,2],bbn1_pk3[9,2],bbn1_dd3[9,2],bbn2_pk3[9,2],bbn2_dd3[9,2] && Array Plat Hitam
**Array Jumlah Kendaraan
Dimension jum_kend[9,4]

cHuruf = 'ABCDEFGHR' && Variable untuk menentukan jenis kendaraan
cPlat  = 'MKHP'       && Variable untuk menentukan warna plat





** i Menerangkan Jenis
** j Menerangkan warna plat / obyek1,obyek2,non obyek
** y Menerangkan Rupiah / jml kendaraan
For i = 1 To 9
	For j = 1 To 4
* Plat Merah
		If j < 3
			Store 0 To pkb_pk1[i,j]
			Store 0 To pkb_dd1[i,j]
			Store 0 To bbn1_pk1[i,j]
			Store 0 To bbn1_dd1[i,j]
			Store 0 To bbn2_pk1[i,j]
			Store 0 To bbn2_dd1[i,j]


* Plat Kuning
			Store 0 To pkb_pk2[i,j]
			Store 0 To pkb_dd2[i,j]
			Store 0 To bbn1_pk2[i,j]
			Store 0 To bbn1_dd2[i,j]
			Store 0 To bbn2_pk2[i,j]
			Store 0 To bbn2_dd2[i,j]

* Plat Hitam
			Store 0 To pkb_pk3[i,j]
			Store 0 To pkb_dd3[i,j]
			Store 0 To bbn1_pk3[i,j]
			Store 0 To bbn1_dd3[i,j]
			Store 0 To bbn2_pk3[i,j]
			Store 0 To bbn2_dd3[i,j]

			Store 0 To jum_kend[i,j]
		Else
			Store 0 To jum_kend[i,j]
		Endif

	Next
Next

cSql1 = 'select pkb_header.tgl_dft, pkb_header.no_dft,pkb_header.jenis,pkb_header.warna_plat, ajenis.kend ;
			from pkb_header,ajenis '
cSql2 = ' where pkb_header.no_dft = ?no AND pkb_header.jenis = ajenis.jenis and  pkb_header.tgl_dft = ?tgl '
csql = cSql1+cSql2
asg =SQLExec(gnconnhandle,csql,'pkb_temp')
If asg<0
	=Messagebox('error get pkb_header')
Else

	Sele pkb_temp

* m menunjukan jenis kendaraan berdasarkan variable cHuruf
	m = At(Left(pkb_temp.warna_plat,1),cPlat)
* n menunjukan jenis kendaraan berdasarkan variable cHuruf
	N = At(pkb_temp.kend,cHuruf)
	If m<4
*** Ambil data pkb Biasa
		dTgl_dft = tgl_dft
		cno_dft = no_dft
		csql =' select * from  pkb_biasa where tgl_dft = ?dtgl_dft and no_dft = ?cno_dft'
		asg =SQLExec(gnconnhandle,csql,'list_biasa')
		If asg<0
			=Messagebox('error get pkb_biasa')
		Else
			If !Eof()
				cArray_kend = 'jum_kend('+Alltrim(Str(N))+','+Alltrim(Str(m))+')'
				&cArray_kend = &cArray_kend+1
				For i = 1 To 10
					temp1 = 'jenis'+Alltrim(Str(i))
					temp2 = &temp1

					Do Case
					Case temp2 = '01' && Pokok PKB
						tempA   = 'pokok'+Alltrim(Str(i))
						tempB   = &tempA
						cArray1A = 'pkb_pk'+Alltrim(Str(m))+'[n,1]'
						cArray2A = 'pkb_pk'+Alltrim(Str(m))+'[n,2]'

						&cArray1A = &cArray1A + tempB
						&cArray2A = &cArray2A + 1
					Case  temp2 = '06A' && Pokok PKB
						tempA = 'denda'+Alltrim(Str(i))
						tempB = &tempA
						cArray1A = 'pkb_dd'+Alltrim(Str(m))+'[n,1]'
						cArray2A = 'pkb_dd'+Alltrim(Str(m))+'[n,2]'

						&cArray1A = &cArray1A + tempB
						&cArray2A = &cArray2A + 1

					Case temp2 = '02A'	&&Pokok BBN1
						tempA = 'pokok'+Alltrim(Str(i))
						tempB = &tempA
						cArray1A = 'bbn1_pk'+Alltrim(Str(m))+'[n,1]'
						cArray2A = 'bbn1_pk'+Alltrim(Str(m))+'[n,2]'

						&cArray1A = &cArray1A + tempB
						&cArray2A = &cArray2A + 1

					Case  temp2 = '06B' &&Denda BBN1
						tempA = 'denda'+Alltrim(Str(i))
						tempB = &tempA
						cArray1A = 'bbn1_dd'+Alltrim(Str(m))+'[n,1]'
						cArray2A = 'bbn1_dd'+Alltrim(Str(m))+'[n,2]'

						&cArray1A = &cArray1A + tempB
						&cArray2A = &cArray2A + 1

					Case temp2 = '02B'	&&Pokok BBN2
						tempA = 'pokok'+Alltrim(Str(i))
						tempB = &tempA
						cArray1A = 'bbn2_pk'+Alltrim(Str(m))+'[n,1]'
						cArray2A = 'bbn2_pk'+Alltrim(Str(m))+'[n,2]'

						&cArray1A = &cArray1A + tempB
						&cArray2A = &cArray2A + 1

					Case  temp2 = '06C' &&Denda BBN2
						tempA = 'denda'+Alltrim(Str(i))
						tempB = &tempA
						cArray1A = 'bbn2_dd'+Alltrim(Str(m))+'[n,1]'
						cArray2A = 'bbn2_dd'+Alltrim(Str(m))+'[n,2]'

						&cArray1A = &cArray1A + tempB
						&cArray2A = &cArray2A + 1

					Endcase
				Next
			Endif
		Endif
*** Simpan data berdasarkan ldtgl
*** Jika tanggal bukan 1 Januari ( Th. Baru ) simpan data

		csql = 'select * from	tr_hari_biasa where tgl =?tgl'
		asg =SQLExec(gnconnhandle,csql,'cek_pkbtr')
		If asg<0
			=Messagebox('error get pkbtr')
		Else
			Store '' To cSql1,cSql2,cSql3,csql4,csql5,csql6,csql7

			If Reccount('cek_pkbtr')>0
				lbaru = .F.

			Else

				lbaru = .T.
			Endif



			If lbaru
				cSql1 = 'insert into tr_hari_biasa(tgl,kode_upt) '
				cSql2=	'values(?tgl,?pckdupt)'
				csql=cSql1+cSql2
				asg =SQLExec(gnconnhandle,csql)
				If asg<0
					=Messagebox('error update')
				Endif
			Endif
		Endif

		csql = 'select * from	tr_hari_biasa where tgl =?tgl'
		asg =SQLExec(gnconnhandle,csql,'tr_ini')
		If asg<0
			=Messagebox('error get pkbtr')
		Endif




		For i  = 1 To 9
			Store '' To str_sql1,str_sql2,str_sql3,str_sql4

*********** JML PAJAK (RP)
** Pajak,bbn1 dan BBn2 biasa yang pokok (RUPIAH) plat Hitam
			cbs1A = 'pkb_bs_h'+Alltrim(Str(i))
			nfield = 'tr_ini.'+cbs1A
			cbs1A_L = Iif(!Isnull(&nfield),'?tr_ini.pkb_bs_h'+Alltrim(Str(i)) ,'0')
			cbs2A = 'bbn1_bs_h'+Alltrim(Str(i))
			nfield = 'tr_ini.'+cbs2A
			cbs2A_L= Iif(!Isnull(&nfield),'?tr_ini.bbn1_bs_h'+Alltrim(Str(i)) ,'0')
			cbs3A = 'bbn2_bs_h'+Alltrim(Str(i))
			nfield = 'tr_ini.'+cbs3A
			cbs3A_L=Iif(!Isnull(&nfield),'?tr_ini.bbn2_bs_h'+Alltrim(Str(i)) ,'0')

** Pajak,bbn1 dan BBn2 biasa yang pokok (RUPIAH) **Plat Kuning
			cbs1B = 'pkb_bs_k'+Alltrim(Str(i))
			nfield = 'tr_ini.'+cbs1B
			cbs1B_L = Iif(!Isnull(&nfield),'?tr_ini.pkb_bs_k'+Alltrim(Str(i)) ,'0')
			cbs2B = 'bbn1_bs_k'+Alltrim(Str(i))
			nfield = 'tr_ini.'+cbs2B
			cbs2B_L =  Iif(!Isnull(&nfield),'?tr_ini.bbn1_bs_k'+Alltrim(Str(i)) ,'0')
			cbs3B = 'bbn2_bs_k'+Alltrim(Str(i))
			nfield = 'tr_ini.'+cbs3B
			cbs3B_L =Iif(!Isnull(&nfield),'?tr_ini.bbn2_bs_k'+Alltrim(Str(i)) ,'0')
** Pajak bbn1 dan BBn2 yang denda (RUPIAH) plat Hitam
			cbs1C = 'dpkb_bs_h'+Alltrim(Str(i))
			nfield = 'tr_ini.'+cbs1C
			cbs1C_L =Iif(!Isnull(&nfield),'?tr_ini.dpkb_bs_h'+Alltrim(Str(i)) ,'0')
			cbs2C = 'dbbn1_bs_h'+Alltrim(Str(i))
			nfield = 'tr_ini.'+cbs2C
			cbs2C_L =  Iif(!Isnull(&nfield),'?tr_ini.dbbn1_bs_h'+Alltrim(Str(i)) ,'0')
			cbs3C = 'dbbn2_bs_h'+Alltrim(Str(i))
			nfield = 'tr_ini.'+cbs3C
			cbs3C_L = Iif(!Isnull(&nfield),'?tr_ini.dbbn2_bs_h'+Alltrim(Str(i)) ,'0')

** Pajak bbn1 dan BBn2 yang denda (RUPIAH) plat Kuning
			cbs1D = 'dpkb_bs_k'+Alltrim(Str(i))
			nfield = 'tr_ini.'+cbs1D
			cbs1D_L = Iif(!Isnull(&nfield),'?tr_ini.dpkb_bs_k'+Alltrim(Str(i)) ,'0')
			cbs2D = 'dbbn1_bs_k'+Alltrim(Str(i))
			nfield = 'tr_ini.'+cbs2D
			cbs2D_L =  Iif(!Isnull(&nfield),'?tr_ini.dbbn1_bs_k'+Alltrim(Str(i)) ,'0')
			cbs3D = 'dbbn2_bs_k'+Alltrim(Str(i))
			nfield = 'tr_ini.'+cbs3D
			cbs3D_L = Iif(!Isnull(&nfield),'?tr_ini.dbbn2_bs_k'+Alltrim(Str(i)) ,'0')

			str_sql1 = str_sql1+cbs1A+'=?pkb_pk3['+Allt(Str(i))+',1]+'+cbs1A_L+','+cbs2A+'=?bbn1_pk3['+Allt(Str(i))+',1]+'+cbs2A_L+','+cbs3A+'=?bbn2_pk3['+Allt(Str(i))+',1]+'+cbs3A_L+','
			str_sql2 = str_sql2+cbs1B+'=?pkb_pk2['+Allt(Str(i))+',1]+'+cbs1B_L+','+cbs2B+'=?bbn1_pk2['+Allt(Str(i))+',1]+'+cbs2B_L+','+cbs3B+'=?bbn2_pk2['+Allt(Str(i))+',1]+'+cbs3C_L+','
			str_sql3 = str_sql3+cbs1C+'=?pkb_dd3['+Allt(Str(i))+',1]+'+cbs1C_L+','+cbs2C+'=?bbn1_dd3['+Allt(Str(i))+',1]+'+cbs2C_L+','+cbs2C+'=?bbn2_dd3['+Allt(Str(i))+',1]+'+cbs3C_L+','
			str_sql4 = str_sql4+cbs1D+'=?pkb_dd2['+Allt(Str(i))+',1]+'+cbs1D_L+','+cbs2D+'=?bbn1_dd2['+Allt(Str(i))+',1]+'+cbs2D_L+','+cbs3D+'=?bbn2_dd2['+Allt(Str(i))+',1]+'+cbs3D_L+','

*!*					Repl ctg1A With tg_pk1[i,1],&ctg2A With tg_pk2[i,1],&ctg3A With tg_pk3[i,1];
*!*						&ctg1C With tg_dd1[i,1],&ctg2C With tg_dd2[i,1],&ctg3C With tg_dd3[i,1]

*********** JML KEND (WP)
			cjmlH = 'jkb_h'+Alltrim(Str(i))
			nfield = 'tr_ini.'+cjmlH
			cjmlH_L = Iif(!Isnull(&nfield),'?tr_ini.'+cjmlH,'0')

			cjmlk = 'jkb_k'+Alltrim(Str(i))
			nfield = 'tr_ini.'+cjmlk
			cjmlk_L = Iif(!Isnull(&nfield),'?tr_ini.'+cjmlk,'0')

			cjmlm = 'jkb_m'+Alltrim(Str(i))
			nfield = 'tr_ini.'+cjmlm
			cjmlm_l = Iif(!Isnull(&nfield),'?tr_ini.'+cjmlm,'0')

			str_sql4 = str_sql4+cjmlH+'=?jum_kend['+Allt(Str(i))+',3]+'+cjmlH_L+','+cjmlk+'=?jum_kend['+Allt(Str(i))+',2]+'+cjmlk_L+','+cjmlm+'=?jum_kend['+Allt(Str(i))+',1]+'+cjmlm_l



*******
** Pajak tunggakan yang pokok (WP)



			cSql1 = 'update pkbtr set '
			cSql2 = str_sql1+str_sql2
			cSql3 = ' where tgl =?tgl'

			csql=cSql1+cSql2+cSql3+csql4
			asg =SQLExec(gnconnhandle,csql)
			If asg<0
				=Messagebox('error Update pkbtr Post_PKb_tp')
				Exit
			Endif

		Next





	Endif

Endif




Function getNo_record()
Aused(lawork)
_nwork = Alen(lawork,1)
For T =1 To _nwork
	_ctabel = lawork(T,1)
	?_ctabel+'  '+Alltrim(Str(Reccount('&_ctabel')))
Next

Procedure  get_result()
Lparameters cresult,ctabel
cnama_tabel = Allt(ctabel)
cstruktur = Strextract(cresult,'struktur:::','||')
nrecno = Occurs('[]',cresult)+1
cdata = Substr(cresult,At('data:::',cresult)+7,Len(cresult))


**mulai isi data
***sempurnakan statement untuk kemudahan extracr
cdata ='|'+cdata
If Right(Allt(cdata),2)<>'[]'
	cdata=cdata+'[]'
Endif

*!*	SELECT &cnama_tabel




cstruktur ='|'+cstruktur
If Right(Allt(cstruktur),1)<>'|'
	cstruktur=cstruktur+'|'
Endif

njfield = Occurs('|',cstruktur) -1
If njfield= 0
	njfield = 1
Endif
nmax = njfield
Local Array astru(nmax,2)
For F = 1 To njfield
	astru(F,1)=Strextract(cstruktur,'|','|',F)
	astru(F,2)=1
Next


Local Array atabel(nrecno,nmax)
For r = 1 To nrecno

	If r =1
		crow = Left(cdata,At('[]',cdata,1)-1)
	Else
		If r = nrecno
			crow = Substr(cdata,At('[]',cdata,r-1 )+2,Len(cdata)-(At('[]',cdata,r-1 )+3))
		Else
			crow = Strextract(cdata,'[]','[]',r-1)
		Endif
	Endif


	If Left(crow,1)<>'|'
		crow ='|'+crow
	Endif
	If Right(crow,1)<>'|'
		crow =crow+'|'
	Endif

*!*		nloop = OCCURS('|',crow)-1


	For i = 1 To nmax
		cisi = Strextract(crow,'|','|',i)
		atabel(r,i)=cisi
		pji= Len(cisi)
		If astru(i,2)<pji
			astru(i,2) = pji
		Endif
	Next
Next


**create temporary cursor
ccursor = 'create cursor '+cnama_tabel+' ( '
For F = 1 To nmax
	If astru(F,2) > 254
		ccursor=ccursor+astru(F,1)+' m(4)'
	Else
		ccursor=ccursor+astru(F,1)+' c('+Allt(Str(astru(F,2)))+')'
	Endif
	If F<nmax
		ccursor = ccursor +','
	Endif
Next
ccursor = ccursor +')'
&ccursor

**masukan data
For r = 1 To nrecno
	Select &cnama_tabel
	Append Blank
	For i = 1 To nmax
		cfield = Field(i)

		Replace &cfield With atabel(r,i)


	Next
Next





Endproc

Function desc_stat()
Lparameters cstat
Local cret
cret=''
*cut bagian field yang diambil
clstat = Alltrim(Lower(cstat))
N=At('from',clstat)
cqst = Alltrim(Substr(Alltrim(clstat),7,N-7))

*define berapa field yang diambil
cnfield = Occurs(',',cqst)
nlast_post = 1
If cnfield =0 &&hanya satu field yang diambil
	cret = get_nfield(Allt(cqst))
Else
	For p = 1 To cnfield
		npc = At(',',cqst,p )
		csub_st = Alltrim(Substr(cqst,nlast_post,npc-nlast_post))
		nlast_post = npc+1
		cnmfield = get_nfield(Allt(csub_st))
		cret=cret +cnmfield+','
	Next
**field terakhir
	csub_st = Substr(cqst,nlast_post,Len(cqst)-(nlast_post-1))
	cnmfield = get_nfield(Allt(csub_st))
	cret=cret +cnmfield
*!*		cret = repl_chr(cret,',','|')
Endif
Return cret

Function env_res()
Lparameters cTable,cstruktur,cdata
Local cenv
cenv = 'tabel:::'+Allt(Upper(cTable))+'|||struktur:::'+Allt(Upper(cstruktur))+'|||data:::'+Allt(cdata)
Return cenv


Function get_nfield()
Lparameters cstr

npst = Len(Alltrim(cstr))
***define apakah nama fileld pake alias 'as'
ns_as = Occurs(' as ',cstr)
If ns_as >0
	nSpos = At(' as ',cstr)
	nApos = nSpos+4
	nJchr = npst-nSpos
Else
***define bila memakai nama tabel
	If Substr(cstr,2,1)='.'
		nApos = 3
		nJchr = npst-2

	Else
		nApos =1
		nJchr = npst

	Endif
Endif
cret_c = Substr(cstr,nApos,nJchr)
Return cret_c
