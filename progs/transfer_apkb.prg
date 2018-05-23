ctbl = Getfile("dbf")
IF USED('tbl_apkb')
	SELECT tbl_apkb
	USE 
ENDIF 
	
USE &ctbl ALIAS "tbl_apkb" SHARED AGAIN 

cgol_bs = INPUTBOX("Input Jenis Kendaraan Jasaraharja Pribadi")
cgol_um = INPUTBOX("Input Jenis Kendaraan Jasaraharja Umum")

STORE 0 TO i

SELECT tbl_apkb
GO TOP 
DO WHILE !EOF()
	cjenis = LEFT(kode,3)
	ckd_merk = SUBSTR(kode,4,3)
	cket_merk = ket_merk
	ctipe = kode
	cth_buat = th_buat
	cket = ket_tipe
	nbobot = bobot
	njual = njkb
	dpkb = dasar
	npkb_bs = pkb_bs
	npkb_um = pkb_um

	
	TEXT TO csql1 noshow
		insert into apkb (jenis,kd_merk,tipe,th_buat,ket,bobot,nilai_jual,dasar_pkb,gol_bs,gol_um,pkb_um,pkb_bs)
		values (?cjenis,?ckd_merk,?ctipe,?cth_buat,?cket,?nbobot,?njual,?dpkb,?cgol_bs,?cgol_um,?npkb_um,?npkb_bs)
	ENDTEXT 
	
	TEXT TO csql2 noshow
		DELETE from apkb WHERE tipe = ?ctipe AND th_buat = ?cth_buat
	ENDTEXT 
	
*!*			UPDATE apkb SET nilai_jual = ?njual,pkb_um = ?npkb_um,pkb_bs = ?npkb_bs, dasar_pkb=?dpkb, gol_bs=?cgol_bs,gol_um=?cgol_um WHERE tipe = ?ctipe AND th_buat = ?cth_buat
	
	
	st1 = SQLEXEC(gnConnhandle,'Select * from msmerk where kd_merk = ?ckd_merk','ms_merk')
	IF st1 > 0
		SELECT ms_merk
		jm1 = RECCOUNT()
		IF jm1 = 0 
			asg = SQLEXEC(gnconnhandle,'Insert into msmerk(kd_merk,ket) values(?ckd_merk,?cket_merk)')
		ENDIF 
	ENDIF 
	
	
	st = SQLEXEC(gnconnhandle,"select * from apkb where tipe = ?ctipe and th_buat = ?cth_buat",'ada')
	IF st > 0
		SELECT ada
		jm = RECCOUNT()
		IF jm > 0
*!*				SQLEXEC(gnconnhandle,"delete from apkb where tipe = ?ctipe and th_buat = ?cth_buat")
			asg = SQLEXEC(gnconnhandle,csql2)
			asg = SQLEXEC(gnconnhandle,csql1)
		ELSE 
			asg = SQLEXEC(gnconnhandle,csql1)
		ENDIF 
	ENDIF 
	
	i = i + 1
	SELECT tbl_apkb
	Wait Window ('proses data ke '+Allt(Str(i))) Nowait
	
	SKIP 
ENDDO 