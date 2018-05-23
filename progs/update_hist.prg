Function hist_ablokir_p
Lparameters lctindakan,cnopol
cwaktu = Datetime()
hist_sql = 'insert into  h_ablokir_P select *,?cuser,?cwaktu,?lctindakan from ablokir_p where nopol =?cnopol'
asg = SQLExec(gnconnhandle, hist_sql)
If asg<0
	Messagebox('error update histori Blokir Polisi')

Endif
Endfunc

Function hist_ablokir_d
Lparameters lctindakan,cnopol
cwaktu = Datetime()
hist_sql = 'insert into  h_ablokir_d select *,?cuser,?cwaktu,?lctindakan from ablokir_d where nopol =?cnopol'
asg = SQLExec(gnconnhandle, hist_sql)
If asg<0
	Messagebox('error update histori blokir Dispenda')

Endif
Endfunc

Function hist_afiskal
Lparameters lctindakan,cnomor
cwaktu = Datetime()
hist_sql = 'insert into  h_afiskal select *,?cuser,?cwaktu,?lctindakan from afiskal where nomor =?cnomor'
asg = SQLExec(gnconnhandle, hist_sql)
If asg<0
	Messagebox('error update histori fiskal')

Endif
Endfunc

Function hist_ajenis
Lparameters lctindakan,cjenis
cwaktu = Datetime()
hist_sql = 'insert into  h_ajenis select *,?cuser,?cwaktu,?lctindakan from ajenis where jenis =?cjenis'
asg = SQLExec(gnconnhandle, hist_sql)
If asg<0
	Messagebox('error update histori fiskal')

Endif
Endfunc

Function hist_apkb
Lparameters lctindakan,cjenis,cmerk,ctahun,ctipe
cwaktu = Datetime()
hist_sql1 = 'insert into  h_apkb select *,?cuser,?cwaktu,?lctindakan from apkb where jenis =?cjenis'
hist_sql2 = ' and kd_merk =?cmerk and th_buat =?ctahun and tipe =?ctipe'
hist_sql = hist_sql1+hist_sql2

asg = SQLExec(gnconnhandle, hist_sql)
If asg<0
	Messagebox('error update histori apkb')

Endif
Endfunc

Function hist_login
Lparameters lctindakan,cuser_id
cwaktu = Datetime()
hist_sql = 'insert into  h_login select *,?cuser,?cwaktu,?lctindakan from login where userid = ?cuser_id'
asg = SQLExec(gnconnhandle, hist_sql)
If asg<0
	Messagebox('error update histori login')

Endif
Endfunc

Function hist_otori
Lparameters lctindakan,cotori
cwaktu = Datetime()
hist_sql = 'insert into  h_otori select *,?cuser,?cwaktu,?lctindakan from otori where otorisasi =?cotori'
asg = SQLExec(gnconnhandle, hist_sql)
If asg<0
	Messagebox('error update histori otori')

Endif
Endfunc

FUNCTION hist_ajsetor
LPARAMETERS lctindakan,cjsetor
cwaktu = DATETIME()
hist_sql = 'insert into h_ajsetor select *,?cuser,?cwaktu,?ctindakan from ajsetor where jsetor = ?cjsetor'
asg = SQLExec(gnconnhandle, hist_sql)
If asg<0
	Messagebox('error update histori ajsetor')

Endif
Endfunc

FUNCTION hist_ajpajak
LPARAMETERS lctindakan,cj_pajak
cwaktu = DATETIME()
hist_sql = 'insert into h_ajpajak select *,?cuser,?cwaktu,?ctindakan from ajpajak where j_pajak = ?cj_pajak'
asg = SQLExec(gnconnhandle, hist_sql)
If asg<0
	Messagebox('error update histori ajpajak')

Endif
Endfunc

Function hist_akend
Lparameters lctindakan,cnopol
cwaktu = Datetime()
hist_sql = 'insert into  h_akend select *,?cuser,?cwaktu,?lctindakan from akend where nopol =?cnopol'
asg = SQLExec(gnconnhandle, hist_sql)
If asg<0
	Messagebox('error update histori akend')

Endif
Endfunc



Function hist_pkb_header
Lparameters lctindakan,cnomor,dtanggal
cip = ambil_ip()
cwaktu = Datetime()
*!*	hist_sql = 'insert into  h_pkb_header select *,?cuser,?cwaktu,?lctindakan from pkb_header where no_dft =?cnomor and tgl_dft =?dtanggal'
hist_sql = 'insert into  h_pkb_header select *,?cuser,?cwaktu,?lctindakan,?cip from pkb_header where no_dft =?cnomor and tgl_dft =?dtanggal'
asg = SQLExec(gnconnhandle, hist_sql)
If asg<0
	Messagebox('error update histori Pkb_header')
	cek_error()
Endif
Endfunc

Function hist_pkb_biasa
Lparameters lctindakan,cnomor,dtanggal
cwaktu = Datetime()
hist_sql = 'insert into  h_pkb_biasa select *,?cuser,?cwaktu,?lctindakan from pkb_biasa where no_dft =?cnomor and tgl_dft =?dtanggal'
asg = SQLExec(gnconnhandle, hist_sql)
*!*	If asg<0
*!*		Messagebox('error update histori Pkb_biasa')
*!*	Endif
Endfunc
*!*	SET STEP ON
Function hist_pkb_tunggak
Lparameters lctindakan,cnomor,dtanggal
cwaktu = Datetime()
*!*	x1=cuser
*!*	x2=lctindakan
*!*	x3=cnomor
*!*	x4=dtanggal
hist_sql = 'insert into  h_pkb_tunggak select *,?cuser,?cwaktu,?lctindakan from pkb_tunggak where no_dft =?cnomor and tgl_dft =?dtanggal'
asg = SQLExec(gnconnhandle, hist_sql)
If asg<0
	Messagebox('error update histori Pkb_tunggak')
Endif
ENDFUNC

Function hist_h_stnk
Lparameters lctindakan,cnomor,dtanggal
cwaktu = Datetime()
hist_sql = 'insert into  h_stnk select *,?cuser,?cwaktu,?lctindakan from stnk where no_dft =?cnomor and tgl_dft =?dtanggal'
asg = SQLExec(gnconnhandle, hist_sql)
If asg<0
	Messagebox('error update histori h_stnk')

Endif
ENDFUNC

FUNCTION hist_mspos
LPARAMETERS lctindakan,ckd_pos,clokasi
cwaktu = DATETIME()
hist_sql = 'insert into h_mspos select *,?cuser,?cwaktu,?lctindakan from mspos where kd_pos = ?ckd_pos and kd_lokasi = ?clokasi'
asg = SQLEXEC(gnconnhandle, hist_sql)
If asg<0
	Messagebox('error update histori mspos')

Endif
ENDFUNC

*!*	FUNCTION hist_aconfig()
*!*	LPARAMETERS lctindakan
*!*	cwaktu = DATETIME()
*!*	hist_sql = ' insert into h_aconfig select *,?cuser,?cwaktu,?lctindakan from aconfig'
*!*	asg = SQLEXEC(gnconnhandle, hist_sql)
*!*	If asg<0
*!*		Messagebox('error update histori aconfig')
*!*	Endif
*!*	ENDFUNC
FUNCTION hist_aconfig()
LPARAMETERS lctindakan
cwaktu = DATETIME()
hist_sql = ' insert into h_aconfig select ?cuser,?cwaktu,?lctindakan from aconfig'
asg = SQLEXEC(gnconnhandle, hist_sql)
If asg<0
	Messagebox('error update histori aconfig')
Endif
ENDFUNC

FUNCTION hist_swdkllj
lPARAMETERS lctindakan,cgol
cwaktu = DATETIME()
hist_sql = 'insert into h_swdkllj select *,?cuser,?cwaktu,?lctindakan from swdkllj where gol = ?cgol'
asg = SQLEXEC(gnconnhandle, hist_sql)
If asg<0
	Messagebox('error update histori swdkllj')
Endif
ENDFUNC

FUNCTION hist_mbank
LPARAMETERS lctindakan,ckd_bank
cwaktu = DATETIME()
hist_sql = 'insert into h_mbank select *,?cuser,?cwaktu,?lctindakan from mbank where kd_bank = ?ckd_bank'
asg = SQLEXEC(gnconnhandle, hist_sql)
If asg<0
	Messagebox('error update histori mbank')

Endif
ENDFUNC

FUNCTION hist_maccount
LPARAMETERS lctindakan,ckode_rek
cwaktu =  DATETIME()
hist_sql = 'insert into h_maccount select *,?cuser,?cwaktu,?lctindakan from maccount where kode_rek = ?ckode_rek'
asg = SQLEXEC(gnconnhandle, hist_sql)
If asg<0
	Messagebox('error update histori maccount')

Endif
ENDFUNC

FUNCTION hist_alokasi
LPARAMETERS lctindakan,ckd_lokasi
cwaktu = DATETIME()
hist_sql = 'insert into h_alokasi select *,?cuser,?cwaktu,?lctindakan from alokasi where kd_lokasi = ?ckd_lokasi'
asg = SQLEXEC(gnconnhandle, hist_sql)
If asg<0
	Messagebox('error update histori alokasi')

Endif
ENDFUNC

FUNCTION hist_ttd
LPARAMETERS lctindakan,cnip
cwaktu = DATETIME()
hist_sql = 'insert into h_ttd select *,?cuser,?cwaktu,?lctindakan from ttd where nip = ?cnip'
asg = SQLEXEC(gnconnhandle, hist_sql)
If asg<0
	Messagebox('error update histori ttd')

Endif
ENDFUNC

FUNCTION hist_mjenis_bayar
LPARAMETERS lctindakan,ckode_jnsbyr
cwaktu =  DATETIME()
hist_sql = 'insert into h_mjenis_bayar select *,?cuser,?cwaktu,?lctindakan from mjenis_bayar where kode_jnsbyr = ?ckode_jnsbyr'
asg = SQLEXEC(gnconnhandle, hist_sql)
If asg<0
	Messagebox('error update histori mjenis_bayar')

Endif
ENDFUNC

FUNCTION hist_mbayar
LPARAMETERS lctindakan,cno_dft,ctgl_dft
cwaktu = DATETIME()
hist_sql = 'insert into h_mbayar select *,?cuser,?cwaktu,?lctindakan from mbayar where no_dft = ?cno_dft and tgl_dft = ?ctgl_dft'
asg = SQLEXEC(gnconnhandle, hist_sql)
If asg<0
	Messagebox('error update histori mbayar')

Endif
ENDFUNC
