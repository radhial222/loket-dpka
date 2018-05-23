close databases
clear all
set safety off
set dele on


*\ append data dari struktur data lama
* buka table data baru
use \samtng\data\ablokir_d alias ablokir_d in 0 
use \samtng\data\ablokir_p alias ablokir_p in 0 
use \samtng\data\aconfig alias aconfig in 0 
use \samtng\data\afiskal alias afiskal in 0 
use \samtng\data\ajenis alias ajenis in 0 
use \samtng\data\ajsetor alias ajsetor in 0 
use \samtng\data\alokasi alias alokasi in 0 
use \samtng\data\apkb alias apkb in 0 
use \samtng\data\hr_trm alias hr_trm in 0 
use \samtng\data\hr_ttp alias hr_ttp in 0 
use \samtng\data\login alias login in 0 
use \samtng\data\msbb alias msbb in 0 
use \samtng\data\msguna alias msguna in 0 
use \samtng\data\mslibur alias mslibur in 0 
use \samtng\data\msmerk alias msmerk in 0 
use \samtng\data\msmilik alias msmilik in 0 
use \samtng\data\mspos alias mspos in 0 
use \samtng\data\pkb_biasa alias pkb_biasa in 0 
use \samtng\data\pkb_tunggak alias pkb_tunggak in 0 
use \samtng\data\stnk alias stnk in 0 
use \samtng\data\swdkllj alias swdkllj in 0 


* hapus dan append data baru dari data lama
sele ablokir_d
zap
append from \samtng\data_old\ablokir_d

sele ablokir_p
zap
append from \samtng\data_old\ablokir_p

sele aconfig
zap
append from \samtng\data_old\aconfig

sele afiskal
zap
append from \samtng\data_old\afiskal

sele ajenis
zap
append from \samtng\data_old\ajenis

sele ajsetor
zap
append from \samtng\data_old\ajsetor

sele alokasi
zap
append from \samtng\data_old\alokasi

sele apkb
zap
append from \samtng\data_old\apkb

sele hr_trm
zap
append from \samtng\data_old\hr_trm

sele hr_ttp
zap
append from \samtng\data_old\hr_ttp

sele login
zap
append from \samtng\data_old\login

sele msbb
zap
append from \samtng\data_old\msbb

sele msguna
zap
append from \samtng\data_old\msguna

sele mslibur
zap
append from \samtng\data_old\mslibur

sele msmerk
zap
append from \samtng\data_old\msmerk

sele msmilik
zap
append from \samtng\data_old\msmilik

sele mspos
zap
append from \samtng\data_old\mspos

sele pkb_biasa
zap
append from \samtng\data_old\pkb_biasa

sele pkb_tunggak
zap
append from \samtng\data_old\pkb_tunggak

sele stnk
zap
append from \samtng\data_old\stnk

sele swdkllj
zap
append from \samtng\data_old\swdkllj



* buka table data histori
use \samtng\data\hist\h_ablokir_d alias h_ablokir_d in 0 
use \samtng\data\hist\h_ablokir_p alias h_ablokir_p in 0 
use \samtng\data\hist\h_aconfig alias h_aconfig in 0 
use \samtng\data\hist\h_afiskal alias h_afiskal in 0 
use \samtng\data\hist\h_ajenis alias h_ajenis in 0 
use \samtng\data\hist\h_ajpajak alias h_ajpajak in 0 
use \samtng\data\hist\h_ajsetor alias h_ajsetor in 0 
use \samtng\data\hist\h_alokasi alias h_alokasi in 0 
use \samtng\data\hist\h_apkb alias h_apkb in 0 
use \samtng\data\hist\h_login alias h_login in 0 
use \samtng\data\hist\h_msbb alias h_msbb in 0 
use \samtng\data\hist\h_msguna alias h_msguna in 0 
use \samtng\data\hist\h_mslibur alias h_mslibur in 0 
use \samtng\data\hist\h_msmerk alias h_msmerk in 0 
use \samtng\data\hist\h_msmilik alias h_msmilik in 0 
use \samtng\data\hist\h_mspos alias h_mspos in 0 
use \samtng\data\hist\h_otori alias h_otori in 0 
use \samtng\data\hist\h_pkb_biasa alias h_pkb_biasa in 0 
use \samtng\data\hist\h_pkb_tunggak alias h_pkb_tunggak in 0 
use \samtng\data\hist\h_stnk alias h_stnk in 0 
use \samtng\data\hist\h_swdkllj alias h_swdkllj in 0 


* hapus dan append data baru dari data lama
sele h_ablokir_d
zap
append from \samtng\data_old\hist\h_ablokir_d

sele h_ablokir_p
zap
append from \samtng\data_old\hist\h_ablokir_p

sele h_aconfig
zap
append from \samtng\data_old\hist\h_aconfig

sele h_afiskal
zap
append from \samtng\data_old\hist\h_afiskal

sele h_ajenis
zap
append from \samtng\data_old\hist\h_ajenis

sele h_ajpajak
zap
append from \samtng\data_old\hist\h_ajpajak

sele h_ajsetor
zap
append from \samtng\data_old\hist\h_ajsetor

sele h_alokasi
zap
append from \samtng\data_old\hist\h_alokasi

sele h_apkb
zap
append from \samtng\data_old\hist\h_apkb

sele h_login
zap
append from \samtng\data_old\hist\h_login

sele h_msbb
zap
append from \samtng\data_old\hist\h_msbb

sele h_msguna
zap
append from \samtng\data_old\hist\h_msguna

sele h_mslibur
zap
append from \samtng\data_old\hist\h_mslibur

sele h_msmerk
zap
append from \samtng\data_old\hist\h_msmerk

sele h_msmilik
zap
append from \samtng\data_old\hist\h_msmilik

sele h_mspos
zap
append from \samtng\data_old\hist\h_mspos

sele h_otori
zap
append from \samtng\data_old\hist\h_otori

sele h_pkb_biasa
zap
append from \samtng\data_old\hist\h_pkb_biasa

sele h_pkb_tunggak
zap
append from \samtng\data_old\hist\h_pkb_tunggak

sele h_stnk
zap
append from \samtng\data_old\hist\h_stnk

sele h_swdkllj
zap
append from \samtng\data_old\hist\h_swdkllj




* proses transfer data
* buka table data baru
use \samtng\data\pkb_header alias pkb_header in 0 
use \samtng\data\akend alias akend in 0 
use \samtng\data\kb_pasif alias kb_pasif in 0 
use \samtng\data\hist\h_pkb_header alias h_pkb_header in 0 
use \samtng\data\hist\h_akend alias h_akend in 0 
use \samtng\data\hist\h_kb_pasif alias h_kb_pasif in 0 

sele pkb_header
zap
sele akend
zap
sele kb_pasif
zap
sele h_pkb_header
zap
sele h_akend
zap
sele h_kb_pasif
zap


* buka table data lama
use \samtng\data_old\pkb_header alias pkb_header_old in 0 
use \samtng\data_old\akend alias akend_old in 0 
use \samtng\data_old\kb_pasif alias kb_pasif_old in 0 
use \samtng\data_old\hist\h_pkb_header alias h_pkb_header_old in 0 
use \samtng\data_old\hist\h_akend alias h_akend_old in 0 
use \samtng\data_old\hist\h_kb_pasif alias h_kb_pasif_old in 0 



* transfer table akend
sele akend_old
go top
scan
	lcNopol = nopol
	lcNopol_Eks = nopol_eks
	lcKohir = kohir
	lcKtp = ktp
	lcNama = nama
	lcKerja = kerja
	lcAlamat = alamat
	lcKd_Pos = kd_pos
	lcJenis = jenis
	lcKd_Merk = kd_merk
	lcTipe = tipe
	lcThn_Buat = thn_buat
	lcKd_Bbm = kd_bbm
	lcCyl = cyl
	lcRangka = rangka
	lcMesin = mesin
	lcNo_Bpkb = no_bpkb
	lcKd_Milik = kd_milik
	lcKd_Guna = kd_guna
	lnKe = ke
	lcWarna = warna
	lcWarna_Plat = warna_plat
	ldTgl_Stnk = tgl_stnk
	ldSd_Stnk = CTOD(STR(DAY(tgl_stnk),2)+'/'+STR(MONTH(tgl_stnk),2)+'/'+STR(YEAR(tgl_stnk)+5,4))
	ldtgl_Notice = CTOD(STR(DAY(tgl_notice),2)+'/'+STR(MONTH(tgl_notice),2)+'/'+STR(YEAR(tgl_notice)-1,4))
	ldSd_Notice = tgl_notice
	ldTgl_Faktur = tgl_faktur
	lcKd_Lokasi = kd_lokasi

	
	select akend
	append blank
	replace nopol with lcNopol, nopol_eks with lcNopol_Eks, kohir with lcKohir, ktp with lcKtp, nama with lcNama, ;
		kerja with lcKerja, alamat with lcAlamat, kd_pos with lcKd_Pos, jenis with lcJenis, ;
		kd_merk with lcKd_Merk, tipe with lcTipe, thn_buat with lcThn_Buat, kd_bbm with lcKd_Bbm, ;
		cyl with lcCyl, rangka with lcRangka, mesin with lcMesin, no_bpkb with lcNo_Bpkb, ;
		kd_milik with lcKd_Milik, kd_guna with lcKd_Guna, ke with lnKe, warna with lcWarna, ;
		warna_plat with lcWarna_Plat, tgl_stnk with ldTgl_Stnk, sd_stnk with ldSd_Stnk, tgl_notice with ldTgl_Notice, ;
		sd_notice with ldSd_Notice, tgl_faktur with ldTgl_Faktur, kd_lokasi with lcKd_Lokasi
	
	select akend_old
endscan


* transfer table kb_pasif
sele kb_pasif_old
go top
scan
	lcNopol = nopol
	lcNopol_Eks = nopol_eks
	lcKohir = kohir
	lcKtp = ktp
	lcNama = nama
	lcKerja = kerja
	lcAlamat = alamat
	lcKd_Pos = kd_pos
	lcJenis = jenis
	lcKd_Merk = kd_merk
	lcTipe = tipe
	lcThn_Buat = thn_buat
	lcKd_Bbm = kd_bbm
	lcCyl = cyl
	lcRangka = rangka
	lcMesin = mesin
	lcNo_Bpkb = no_bpkb
	lcKd_Milik = kd_milik
	lcKd_Guna = kd_guna
	lnKe = ke
	lcWarna = warna
	lcWarna_Plat = warna_plat
	ldTgl_Stnk = tgl_stnk
	ldSd_Stnk = CTOD(STR(DAY(tgl_stnk),2)+'/'+STR(MONTH(tgl_stnk),2)+'/'+STR(YEAR(tgl_stnk)+5,4))
	ldtgl_Notice = CTOD(STR(DAY(tgl_notice),2)+'/'+STR(MONTH(tgl_notice),2)+'/'+STR(YEAR(tgl_notice)-1,4))
	ldSd_Notice = tgl_notice
	ldTgl_Faktur = tgl_faktur
	lcKd_Lokasi = kd_lokasi

	
	select kb_pasif
	append blank
	replace nopol with lcNopol, nopol_eks with lcNopol_Eks, kohir with lcKohir, ktp with lcKtp, nama with lcNama, ;
		kerja with lcKerja, alamat with lcAlamat, kd_pos with lcKd_Pos, jenis with lcJenis, ;
		kd_merk with lcKd_Merk, tipe with lcTipe, thn_buat with lcThn_Buat, kd_bbm with lcKd_Bbm, ;
		cyl with lcCyl, rangka with lcRangka, mesin with lcMesin, no_bpkb with lcNo_Bpkb, ;
		kd_milik with lcKd_Milik, kd_guna with lcKd_Guna, ke with lnKe, warna with lcWarna, ;
		warna_plat with lcWarna_Plat, tgl_stnk with ldTgl_Stnk, sd_stnk with ldSd_Stnk, tgl_notice with ldTgl_Notice, ;
		sd_notice with ldSd_Notice, tgl_faktur with ldTgl_Faktur, kd_lokasi with lcKd_Lokasi
		
	select kb_pasif_old
endscan


* transfer table pkb_header
sele pkb_header_old
go top
scan
	lcNo_Dft = no_dft
	ldTgl_Dft = tgl_dft
	lcJns_Dft = jns_dft
	ldMLaku = mlaku
	ldTgl_Ttp = tgl_ttp
	ldTgl_Trm = tgl_trm
	lcNo_Ttp = no_ttp
	lcNo_Trm = no_trm
	lcNo_Ttp_Tgk = no_ttp_tgk
	lcNo_Trm_Tgk = no_trm_tgk
	llCtk_Dft = ctk_dft
	llCtk_Ttp = ctk_ttp
	llCtk_Trm = ctk_trm
	llCtk_Dft_Tg = ctk_dft_tg
	llCtk_Ttp_Tg = ctk_ttp_tg
	llCtk_Trm_Tg = ctk_trm_tg
	llCtk_Stnk = ctk_stnk
	llVld_Stnk = vld_stnk
	lcNopol = nopol
	lcNopol_Eks = nopol_eks
	lcKohir = kohir
	lcKtp = ktp
	lcNama = nama
	lcKerja = kerja
	lcAlamat = alamat
	lcKd_Pos = kd_pos
	lcJenis = jenis
	lcKd_Merk = kd_merk
	lcTipe = tipe
	lcThn_Buat = thn_buat
	lcKd_Bbm = kd_bbm
	lcCyl = cyl
	lcRangka = rangka
	lcMesin = mesin
	lcNo_Bpkb = no_bpkb
	lcKd_Milik = kd_milik
	lcKd_Guna = kd_guna
	lnKe = ke
	lcWarna = warna
	lcWarna_Plat = warna_plat
	ldTgl_Stnk = tgl_stnk
	ldSd_Stnk = CTOD(STR(DAY(tgl_stnk),2)+'/'+STR(MONTH(tgl_stnk),2)+'/'+STR(YEAR(tgl_stnk)+5,4))
	ldtgl_Notice = CTOD(STR(DAY(tgl_notice),2)+'/'+STR(MONTH(tgl_notice),2)+'/'+STR(YEAR(tgl_notice)-1,4))
	ldSd_Notice = tgl_notice
	ldTgl_Faktur = tgl_faktur
	lcKd_Lokasi = kd_lokasi
	
	
	* konversi jns_dft dan gol_dft
	do case
		case lcJns_Dft = '01'
			lcGol_Dft = 'B'
			lcjns_Dft1 = '01'
		case lcJns_Dft = '02'
			lcGol_Dft = 'U'
			lcjns_Dft1 = '02'
		case lcJns_Dft = '03'
			lcGol_Dft = 'D'
			lcjns_Dft1 = '73'
		case lcJns_Dft = '05'
			lcGol_Dft = 'M'
			lcjns_Dft1 = '31'
		case lcJns_Dft = '06'
			lcGol_Dft = 'K'
			lcjns_Dft1 = '33'
		case lcJns_Dft = '07'
			lcGol_Dft = 'D'
			lcjns_Dft1 = '41'
		case lcJns_Dft = '08'
			lcGol_Dft = 'D'
			lcjns_Dft1 = '51'
		case lcJns_Dft = '09'
			lcGol_Dft = 'D'
			lcjns_Dft1 = '52'
		case lcJns_Dft = '10'
			lcGol_Dft = 'D'
			lcjns_Dft1 = '53'
		case lcJns_Dft = '11'
			lcGol_Dft = 'D'
			lcjns_Dft1 = '06'
		case lcJns_Dft = '12'
			lcGol_Dft = 'D'
			lcjns_Dft1 = '71'
		case lcJns_Dft = '13'
			lcGol_Dft = 'D'
			lcjns_Dft1 = '74'
		case lcJns_Dft = '14'
			lcGol_Dft = 'D'
			lcjns_Dft1 = '42'
		case lcJns_Dft = '15'
			lcGol_Dft = 'U'
			lcjns_Dft1 = '02'
		case lcJns_Dft = '16'
			lcGol_Dft = 'D'
			lcjns_Dft1 = '16'	
		case lcJns_Dft = '17'
			lcGol_Dft = 'B'
			lcjns_Dft1 = '43'	
		case lcJns_Dft = '18'
			lcGol_Dft = 'B'
			lcjns_Dft1 = '44'	 
		case lcJns_Dft = '19'
			lcGol_Dft = 'B'
			lcjns_Dft1 = '45'	
		case lcJns_Dft = '20'
			lcGol_Dft = 'B'
			lcjns_Dft1 = '46'	
		case lcJns_Dft = '21'
			lcGol_Dft = 'D'
			lcjns_Dft1 = '47'	
	endcase

	select pkb_header
	append blank
	replace no_dft with lcNo_Dft, tgl_dft with ldTgl_Dft, gol_dft with lcGol_Dft, jns_dft1 with lcJns_Dft1, ;
		mlaku with ldMLaku, tgl_ttp with ldTgl_Ttp, tgl_trm with ldTgl_Trm, no_ttp with lcNo_Ttp, ;
		no_trm with lcNo_Trm, no_ttp_tgk with lcNo_Ttp_Tgk, no_trm_tgk with lcNo_Trm_Tgk, ctk_dft with llCtk_Dft, ;
		ctk_ttp with llCtk_Ttp, ctk_trm with llCtk_Trm, ctk_dft_tg with llCtk_Dft_Tg, ctk_ttp_tg with llCtk_Ttp_Tg, ;
		ctk_trm_tg with llCtk_Trm_Tg, ctk_stnk with llCtk_Stnk, vld_stnk with llVld_Stnk, nopol with lcNopol, ;
		nopol_eks with lcNopol_Eks, kohir with lcKohir, ktp with lcKtp, nama with lcNama, ;
		kerja with lcKerja, alamat with lcAlamat, kd_pos with lcKd_Pos, jenis with lcJenis, ;
		kd_merk with lcKd_Merk, tipe with lcTipe, thn_buat with lcThn_Buat, kd_bbm with lcKd_Bbm, ;
		cyl with lcCyl, rangka with lcRangka, mesin with lcMesin, no_bpkb with lcNo_Bpkb, ;
		kd_milik with lcKd_Milik, kd_guna with lcKd_Guna, ke with lnKe, warna with lcWarna, ;
		warna_plat with lcWarna_Plat, tgl_stnk with ldTgl_Stnk, sd_stnk with ldSd_Stnk, tgl_notice with ldTgl_Notice, ;
		sd_notice with ldSd_Notice, tgl_faktur with ldTgl_Faktur, kd_lokasi with lcKd_Lokasi
	
	sele akend
	go top
	locate for nopol = lcNopol
	if found()
		replace tgl_dft with ldTgl_Dft, tgl_ttp with ldTgl_Ttp, tgl_trm with ldTgl_Trm
	endif
	
	sele kb_pasif
	go top
	locate for nopol = lcNopol
	if found()
		replace tgl_dft with ldTgl_Dft, tgl_ttp with ldTgl_Ttp, tgl_trm with ldTgl_Trm
	endif
endscan


* update tgl_dft pada table akend
sele akend
go top
scan 
	ldTgl = tgl_notice
	
	if empty(tgl_dft)
		replace tgl_dft with ldTgl
	endif

	if empty(tgl_ttp)
		replace tgl_ttp with ldTgl
	endif
	
	if empty(tgl_trm)
		replace tgl_trm with ldTgl
	endif
endscan


* update tgl_dft pada table kb_pasif
sele kb_pasif
go top
scan 
	ldTgl = tgl_notice
	
	if empty(tgl_dft)
		replace tgl_dft with ldTgl
	endif

	if empty(tgl_ttp)
		replace tgl_ttp with ldTgl
	endif
	
	if empty(tgl_trm)
		replace tgl_trm with ldTgl
	endif
endscan




*\ transfer data histori
* transfer table akend
sele h_akend_old
go top
scan
	lcNopol = nopol
	lcNopol_Eks = nopol_eks
	lcKohir = kohir
	lcKtp = ktp
	lcNama = nama
	lcKerja = kerja
	lcAlamat = alamat
	lcKd_Pos = kd_pos
	lcJenis = jenis
	lcKd_Merk = kd_merk
	lcTipe = tipe
	lcThn_Buat = thn_buat
	lcKd_Bbm = kd_bbm
	lcCyl = cyl
	lcRangka = rangka
	lcMesin = mesin
	lcNo_Bpkb = no_bpkb
	lcKd_Milik = kd_milik
	lcKd_Guna = kd_guna
	lnKe = ke
	lcWarna = warna
	lcWarna_Plat = warna_plat
	ldTgl_Stnk = tgl_stnk
	ldSd_Stnk = CTOD(STR(DAY(tgl_stnk),2)+'/'+STR(MONTH(tgl_stnk),2)+'/'+STR(YEAR(tgl_stnk)+5,4))
	ldtgl_Notice = CTOD(STR(DAY(tgl_notice),2)+'/'+STR(MONTH(tgl_notice),2)+'/'+STR(YEAR(tgl_notice)-1,4))
	ldSd_Notice = tgl_notice
	ldTgl_Faktur = tgl_faktur
	lcKd_Lokasi = kd_lokasi

	
	select h_akend
	append blank
	replace nopol with lcNopol, nopol_eks with lcNopol_Eks, kohir with lcKohir, ktp with lcKtp, nama with lcNama, ;
		kerja with lcKerja, alamat with lcAlamat, kd_pos with lcKd_Pos, jenis with lcJenis, ;
		kd_merk with lcKd_Merk, tipe with lcTipe, thn_buat with lcThn_Buat, kd_bbm with lcKd_Bbm, ;
		cyl with lcCyl, rangka with lcRangka, mesin with lcMesin, no_bpkb with lcNo_Bpkb, ;
		kd_milik with lcKd_Milik, kd_guna with lcKd_Guna, ke with lnKe, warna with lcWarna, ;
		warna_plat with lcWarna_Plat, tgl_stnk with ldTgl_Stnk, sd_stnk with ldSd_Stnk, tgl_notice with ldTgl_Notice, ;
		sd_notice with ldSd_Notice, tgl_faktur with ldTgl_Faktur, kd_lokasi with lcKd_Lokasi
	
	select h_akend_old
endscan


* transfer table kb_pasif
sele h_kb_pasif_old
go top
scan
	lcNopol = nopol
	lcNopol_Eks = nopol_eks
	lcKohir = kohir
	lcKtp = ktp
	lcNama = nama
	lcKerja = kerja
	lcAlamat = alamat
	lcKd_Pos = kd_pos
	lcJenis = jenis
	lcKd_Merk = kd_merk
	lcTipe = tipe
	lcThn_Buat = thn_buat
	lcKd_Bbm = kd_bbm
	lcCyl = cyl
	lcRangka = rangka
	lcMesin = mesin
	lcNo_Bpkb = no_bpkb
	lcKd_Milik = kd_milik
	lcKd_Guna = kd_guna
	lnKe = ke
	lcWarna = warna
	lcWarna_Plat = warna_plat
	ldTgl_Stnk = tgl_stnk
	ldSd_Stnk = CTOD(STR(DAY(tgl_stnk),2)+'/'+STR(MONTH(tgl_stnk),2)+'/'+STR(YEAR(tgl_stnk)+5,4))
	ldtgl_Notice = CTOD(STR(DAY(tgl_notice),2)+'/'+STR(MONTH(tgl_notice),2)+'/'+STR(YEAR(tgl_notice)-1,4))
	ldSd_Notice = tgl_notice
	ldTgl_Faktur = tgl_faktur
	lcKd_Lokasi = kd_lokasi

	
	select h_kb_pasif
	append blank
	replace nopol with lcNopol, nopol_eks with lcNopol_Eks, kohir with lcKohir, ktp with lcKtp, nama with lcNama, ;
		kerja with lcKerja, alamat with lcAlamat, kd_pos with lcKd_Pos, jenis with lcJenis, ;
		kd_merk with lcKd_Merk, tipe with lcTipe, thn_buat with lcThn_Buat, kd_bbm with lcKd_Bbm, ;
		cyl with lcCyl, rangka with lcRangka, mesin with lcMesin, no_bpkb with lcNo_Bpkb, ;
		kd_milik with lcKd_Milik, kd_guna with lcKd_Guna, ke with lnKe, warna with lcWarna, ;
		warna_plat with lcWarna_Plat, tgl_stnk with ldTgl_Stnk, sd_stnk with ldSd_Stnk, tgl_notice with ldTgl_Notice, ;
		sd_notice with ldSd_Notice, tgl_faktur with ldTgl_Faktur, kd_lokasi with lcKd_Lokasi
		
	select h_kb_pasif_old
endscan


* transfer table pkb_header
sele h_pkb_header_old
go top
scan
	lcNo_Dft = no_dft
	ldTgl_Dft = tgl_dft
	lcJns_Dft = jns_dft
	ldMLaku = mlaku
	ldTgl_Ttp = tgl_ttp
	ldTgl_Trm = tgl_trm
	lcNo_Ttp = no_ttp
	lcNo_Trm = no_trm
	lcNo_Ttp_Tgk = no_ttp_tgk
	lcNo_Trm_Tgk = no_trm_tgk
	llCtk_Dft = ctk_dft
	llCtk_Ttp = ctk_ttp
	llCtk_Trm = ctk_trm
	llCtk_Dft_Tg = ctk_dft_tg
	llCtk_Ttp_Tg = ctk_ttp_tg
	llCtk_Trm_Tg = ctk_trm_tg
	llCtk_Stnk = ctk_stnk
	llVld_Stnk = vld_stnk
	lcNopol = nopol
	lcNopol_Eks = nopol_eks
	lcKohir = kohir
	lcKtp = ktp
	lcNama = nama
	lcKerja = kerja
	lcAlamat = alamat
	lcKd_Pos = kd_pos
	lcJenis = jenis
	lcKd_Merk = kd_merk
	lcTipe = tipe
	lcThn_Buat = thn_buat
	lcKd_Bbm = kd_bbm
	lcCyl = cyl
	lcRangka = rangka
	lcMesin = mesin
	lcNo_Bpkb = no_bpkb
	lcKd_Milik = kd_milik
	lcKd_Guna = kd_guna
	lnKe = ke
	lcWarna = warna
	lcWarna_Plat = warna_plat
	ldTgl_Stnk = tgl_stnk
	ldSd_Stnk = CTOD(STR(DAY(tgl_stnk),2)+'/'+STR(MONTH(tgl_stnk),2)+'/'+STR(YEAR(tgl_stnk)+5,4))
	ldtgl_Notice = CTOD(STR(DAY(tgl_notice),2)+'/'+STR(MONTH(tgl_notice),2)+'/'+STR(YEAR(tgl_notice)-1,4))
	ldSd_Notice = tgl_notice
	ldTgl_Faktur = tgl_faktur
	lcKd_Lokasi = kd_lokasi
	
	
	* konversi jns_dft dan gol_dft
	do case
		case lcJns_Dft = '01'
			lcGol_Dft = 'B'
			lcjns_Dft1 = '01'
		case lcJns_Dft = '02'
			lcGol_Dft = 'U'
			lcjns_Dft1 = '02'
		case lcJns_Dft = '03'
			lcGol_Dft = 'D'
			lcjns_Dft1 = '73'
		case lcJns_Dft = '05'
			lcGol_Dft = 'M'
			lcjns_Dft1 = '31'
		case lcJns_Dft = '06'
			lcGol_Dft = 'K'
			lcjns_Dft1 = '33'
		case lcJns_Dft = '07'
			lcGol_Dft = 'D'
			lcjns_Dft1 = '41'
		case lcJns_Dft = '08'
			lcGol_Dft = 'D'
			lcjns_Dft1 = '51'
		case lcJns_Dft = '09'
			lcGol_Dft = 'D'
			lcjns_Dft1 = '52'
		case lcJns_Dft = '10'
			lcGol_Dft = 'D'
			lcjns_Dft1 = '53'
		case lcJns_Dft = '11'
			lcGol_Dft = 'D'
			lcjns_Dft1 = '06'
		case lcJns_Dft = '12'
			lcGol_Dft = 'D'
			lcjns_Dft1 = '71'
		case lcJns_Dft = '13'
			lcGol_Dft = 'D'
			lcjns_Dft1 = '74'
		case lcJns_Dft = '14'
			lcGol_Dft = 'D'
			lcjns_Dft1 = '42'
		case lcJns_Dft = '15'
			lcGol_Dft = 'U'
			lcjns_Dft1 = '02'
		case lcJns_Dft = '16'
			lcGol_Dft = 'D'
			lcjns_Dft1 = '16'	
		case lcJns_Dft = '17'
			lcGol_Dft = 'B'
			lcjns_Dft1 = '43'	
		case lcJns_Dft = '18'
			lcGol_Dft = 'B'
			lcjns_Dft1 = '44'	 
		case lcJns_Dft = '19'
			lcGol_Dft = 'B'
			lcjns_Dft1 = '45'	
		case lcJns_Dft = '20'
			lcGol_Dft = 'B'
			lcjns_Dft1 = '46'	
		case lcJns_Dft = '21'
			lcGol_Dft = 'D'
			lcjns_Dft1 = '47'	
	endcase

	select h_pkb_header
	append blank
	replace no_dft with lcNo_Dft, tgl_dft with ldTgl_Dft, gol_dft with lcGol_Dft, jns_dft1 with lcJns_Dft1, ;
		mlaku with ldMLaku, tgl_ttp with ldTgl_Ttp, tgl_trm with ldTgl_Trm, no_ttp with lcNo_Ttp, ;
		no_trm with lcNo_Trm, no_ttp_tgk with lcNo_Ttp_Tgk, no_trm_tgk with lcNo_Trm_Tgk, ctk_dft with llCtk_Dft, ;
		ctk_ttp with llCtk_Ttp, ctk_trm with llCtk_Trm, ctk_dft_tg with llCtk_Dft_Tg, ctk_ttp_tg with llCtk_Ttp_Tg, ;
		ctk_trm_tg with llCtk_Trm_Tg, ctk_stnk with llCtk_Stnk, vld_stnk with llVld_Stnk, nopol with lcNopol, ;
		nopol_eks with lcNopol_Eks, kohir with lcKohir, ktp with lcKtp, nama with lcNama, ;
		kerja with lcKerja, alamat with lcAlamat, kd_pos with lcKd_Pos, jenis with lcJenis, ;
		kd_merk with lcKd_Merk, tipe with lcTipe, thn_buat with lcThn_Buat, kd_bbm with lcKd_Bbm, ;
		cyl with lcCyl, rangka with lcRangka, mesin with lcMesin, no_bpkb with lcNo_Bpkb, ;
		kd_milik with lcKd_Milik, kd_guna with lcKd_Guna, ke with lnKe, warna with lcWarna, ;
		warna_plat with lcWarna_Plat, tgl_stnk with ldTgl_Stnk, sd_stnk with ldSd_Stnk, tgl_notice with ldTgl_Notice, ;
		sd_notice with ldSd_Notice, tgl_faktur with ldTgl_Faktur, kd_lokasi with lcKd_Lokasi
	
	sele h_akend
	go top
	locate for nopol = lcNopol
	if found()
		replace tgl_dft with ldTgl_Dft, tgl_ttp with ldTgl_Ttp, tgl_trm with ldTgl_Trm
	endif
	
	sele h_kb_pasif
	go top
	locate for nopol = lcNopol
	if found()
		replace tgl_dft with ldTgl_Dft, tgl_ttp with ldTgl_Ttp, tgl_trm with ldTgl_Trm
	endif
endscan


* update tgl_dft pada table akend
sele h_akend
go top
scan 
	ldTgl = tgl_notice
	
	if empty(tgl_dft)
		replace tgl_dft with ldTgl
	endif

	if empty(tgl_ttp)
		replace tgl_ttp with ldTgl
	endif
	
	if empty(tgl_trm)
		replace tgl_trm with ldTgl
	endif
endscan


* update tgl_dft pada table kb_pasif
sele h_kb_pasif
go top
scan 
	ldTgl = tgl_notice
	
	if empty(tgl_dft)
		replace tgl_dft with ldTgl
	endif

	if empty(tgl_ttp)
		replace tgl_ttp with ldTgl
	endif
	
	if empty(tgl_trm)
		replace tgl_trm with ldTgl
	endif
endscan


close databases
wait wind "Transfer Completed ..."
