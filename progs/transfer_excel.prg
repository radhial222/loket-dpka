
SET PROCEDURE TO c:\samsat_02032010\progs\pembulatan.prg
Set Decimals To 1
Local ckode,cmerek,ctype

cF_excel=Getfile("xls")
cTable = Strtran(cF_excel,'.XLS','.DBF')
CPath = Left(cF_excel,At('\',cF_excel,Occurs('\',cF_excel)))
cFtable = Alltrim(CPath)+Alltrim(cTable)
If File(cFtable)
	Delete File &cFtable
Endif


Cd &CPath

If Empty(cF_excel)
	Clear All
	Close All
	Clear
	Return
Endif
CtABLE= STREXTRACT(UPPER(cf_excel),'\','.XLS',OCCURS('\',CF_EXCEL))
Create Table &cTable(kode c(12),ket_merk c(50),ket_tipe c(150),th_buat c(4),njkb N(17),bobot N(3,2),dasar N(17),pkb_bs n(17),pkb_um n(17))
loExcel = Createobject("Excel.Application")
loExcel.workbooks.Open(cF_excel,,,,"")
loExcel.Visible=.T.

For lnCount = 1 To loExcel.workbooks(1).Sheets.Count
	sheet_name= loExcel.workbooks(1).Sheets(lnCount).Name
	ntanya = Messagebox('Proses Sheet '+Alltrim(sheet_name) +'?',4+32)
	If ntanya = 6
		loExcel.workbooks(1).Sheets(lnCount).Select
		loExcel.workbooks(1).Sheets(lnCount).Activate
		xlSheet = loExcel.activesheet
		N=Inputbox('Mulai Dari Baris ?','Pilih Row Pertama Data Excel','8')
		N=Val(N)
		awal =N-1
		Do While .T.
			If Isnull(loExcel.activesheet.cells(N,1).Value)
				If N < 10
					If loExcel.activesheet.cells(N,1).Value <> 1
						=Messagebox('Salah Memilih Baris Pertama ',0+16)
						Exit
					Endif
				Else
					=Messagebox('Transfer Data Selesai ',0+64)
					Exit
				Endif
			Endif

			Wait Window ('proses data ke '+Allt(Str(N-awal))) Nowait
			If !Isnull(loExcel.activesheet.cells(N,2).Value) And !Empty(loExcel.activesheet.cells(N,2).Value)
				ckode = Alltrim(Transform(loExcel.activesheet.cells(N,2).Value,'@'))
				cmerk = Alltrim(Transform(loExcel.activesheet.cells(N,3).Value,'@'))
				ctipe =Alltrim(Transform(loExcel.activesheet.cells(N,4).Value,'@'))
			Endif
			c_tahun = Alltrim(Transform(loExcel.activesheet.cells(N,5).Value,'@'))
			n_njkb=Val(Alltrim(Transform(loExcel.activesheet.cells(N,6).Value,'@')))
			n_bobot=Val(Alltrim(Transform(loExcel.activesheet.cells(N,7).Value,'9.9')))
			n_dasar = Val(Alltrim(Transform(loExcel.activesheet.cells(N,8).Value,'@')))
			n_biasa =  pembulatan(n_dasar * 0.015)
			n_um =  pembulatan(n_dasar * 0.6 * 0.01)

			Select &cTable
			Append Blank
			Replace kode With ckode,;
				ket_merk With cmerk,;
				ket_tipe With ctipe ,;
				th_buat With c_tahun,;
				njkb With n_njkb,;
				bobot With n_bobot,;
				dasar With n_dasar,;
				pkb_bs WITH n_biasa,;
				pkb_um WITH n_um

			N=N+1
			Loop
		Enddo
	Endif
Next
loExcel.DisplayAlerts = .F.

loExcel.workbooks.Close
loExcel.Quit
Release oExcel





