close databases
clear all
set safety off
set dele on


* buka table data baru
use \sampapua\data\ablokir_d alias ablokir_d exclusive


use \sampapua\data\ablokir_p alias ablokir_p in 0

use \sampapua\data\akend alias akend in 0

* buka table data irian
use \sampapua\data\transfer\mstkb alias mstkb in 0 
use \sampapua\data\transfer\blockir alias blockir in 0


* hapus data baru




sele ablokir_d 
zap



sele ablokir_p 
zap


sele akend
zap



*\ proses transfer data
* transfer table blokir dispenda
sele blockir
go top
scan
	lcNopol = allt(nopol)
	ldTgl = tanggal
	lcKet = allt(catatan)
	lcKode = kd_blokir
	
	if lcKode = 'D'
		* dispenda
		sele ablokir_d
		append blank
		replace nopol with lcNopol, tgl_blokir with ldTgl, ket with lcKet
	else
		*polisi
		if lckode ='P'
		sele ablokir_p
		append blank
		replace nopol with lcNopol, tgl_blokir with ldTgl, ket with lcKet
		endif
	endif
	
	sele blockir
endscan
		

* transfer table akend
sele mstkb
go top
scan
	lcNopol = nopol
	lcNopol_Eks = nopol_lama
	lcKohir = Allt(STR(no_kohir))
	lcKtp = space(25)
	lcNama = nama
	lcKerja = space(40)
	lcAlamat = alamat
	lcKd_Pos = '10000'
	lcJenis = space(3)
	lcKd_Merk = space(2)
	lcTipe = space(6)
	lcThn_Buat = th_buat
	lcKd_Bbm = kd_bbm
	lcCyl = val(cc)
	lcRangka = no_rangka
	lcMesin = no_mesin
	lcNo_Bpkb = no_bpkb
	lcKd_Milik = SPACE(3)
	lcKd_Guna = SPACE(2)
	lnKe = 1
	lcWarna = warna
	lcWarna_Plat = kd_plat
	ldTgl_Stnk = CTOD(STR(DAY(tgl_stnk),2)+'/'+STR(MONTH(tgl_stnk),2)+'/'+STR(YEAR(tgl_stnk)-5,4))
	ldSd_Stnk = tgl_stnk
	ldtgl_Notice = CTOD(STR(DAY(tgl_pajak),2)+'/'+STR(MONTH(tgl_pajak),2)+'/'+STR(YEAR(tgl_pajak)-1,4))
	ldSd_Notice = tgl_pajak
	ldtgl_Swd = CTOD(STR(DAY(tgl_pajak),2)+'/'+STR(MONTH(tgl_pajak),2)+'/'+STR(YEAR(tgl_pajak)-1,4))
	ldSd_Swd = tgl_pajak
	ldTgl_Faktur = tgl_faktur
	ldTgl_Kwt = CTOD('  /  /    ')
	ldTgl_Fiskal = CTOD('  /  /    ')
	ldUbh_Btk = CTOD('  /  /    ')
	ldUbh_Msn = CTOD('  /  /    ')
	ldTgl_Dft = tgl_daftar
	ldTgl_Ttp = tgl_notis
	ldTgl_Trm = tgl_bayar
	lcKd_Lokasi = space(4) 
	llNon_Aktif = .F.
	llSppkb = .F.
	LCNO_STNK = ALLT(STR(NO_STNK))
	LDTGL_CTK = CTOD(STR(DAY(tgl_TERBIT),2)+'/'+STR(MONTH(tgl_TERBIT),2)+'/'+STR(YEAR(tgl_TERBIT),4))
	LCNO_UDAFTSTNK = ALLT(STR(NO_UDFPOL))
	
	* case warna plat
	do case
		case lcWarna_Plat = '1'
			lcWarna_Plat = 'HITAM'
		case lcWarna_Plat = '2'
			lcWarna_Plat = 'KUNING'
		case lcWarna_Plat = '3'
			lcWarna_Plat = 'MERAH'
	endcase	
			

	select akend
	append blank
	Replace nopol with lcNopol, nopol_eks with lcNopol_Eks, kohir with lcKohir, ktp with lcKtp, nama with lcNama, ;
		kerja with lcKerja, alamat with lcAlamat, kd_pos with lcKd_Pos, jenis with lcJenis, ;
		kd_merk with lcKd_Merk, tipe with lcTipe, thn_buat with lcThn_Buat, kd_bbm with lcKd_Bbm, ;
		cyl with lcCyl, rangka with lcRangka, mesin with lcMesin, no_bpkb with lcNo_Bpkb, ;
		kd_milik with lcKd_Milik, kd_guna with lcKd_Guna, ke with lnKe, warna with lcWarna, ;
		warna_plat with lcWarna_Plat, tgl_stnk with ldTgl_Stnk, sd_stnk with ldSd_Stnk, tgl_notice with ldTgl_Notice, ;
		sd_notice with ldSd_Notice, tgl_swd with ldTgl_Swd, sd_swd with ldSd_Swd, tgl_faktur with ldTgl_Faktur, ;
		tgl_kwt with ldTgl_Kwt, tgl_fiskal with ldTgl_Fiskal, ubh_btk with ldUbh_Btk, Ubh_Msn with ldUbh_Msn, ;
		tgl_dft with ldTgl_Dft, tgl_ttp with ldTgl_Ttp, tgl_trm with ldTgl_Trm, kd_lokasi with lcKd_Lokasi, ;
		non_aktif with llNon_Aktif, sppkb with llSppkb, NO_STNKB WITH LCNO_STNK, TG_CTK_ST WITH LDTGL_CTK, DFT_STNK WITH LCNO_UDAFTSTNK
	
	select mstkb
endscan


close databases
wait wind "Transfer Completed ..."
