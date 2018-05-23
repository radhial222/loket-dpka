lMenu = .F.

Sele otori
nrec = Recno()
*!*	close tables all
Close Tables All
Set Exclusive On

On Error Do pesan()


lcfile = 'data\ablokir_d'
Use 'ablokir_d'
If Isexclusive()
	Wait Window Nowait"Indexing Data Blokir (Dispenda) ...."
	Index On nopol Tag nopol Of &lcfile
Endif
Use
Wait Wind 'Data Blokir (Dispenda) Reindexed ....' Timeout 1

lcfile = 'data\pkb_sanksi'
Use 'pkb_sanksi'
If Isexclusive()
	Wait Window Nowait"Indexing Data PKB Sangsi ...."
	Index On Dtos(tgl_dft)+no_dft Tag daftar Of &lcfile
Endif
Use
Wait Wind 'Data PKB Sangsi Reindexed ....' Timeout 1

lcfile = 'data\ablokir_p'
Use 'ablokir_p'
If Isexclusive()
	Wait Window Nowait"Indexing Data Blokir (Polisi) ...."
	Index On nopol Tag nopol Of &lcfile
Endif
Use
Wait Wind 'Data Blokir (Polisi) Reindexed ....' Timeout 1

lcfile = 'data\afiskal'
Use 'afiskal'
If Isexclusive()
	Wait Window Nowait"Indexing Data Fiskal Antar Daerah ...."
	Index On nomor Tag nomor Of &lcfile
Endif
Use
Wait Wind 'Data Fiskal Antar Daerah Reindexed ....' Timeout 1

lcfile = 'data\ajenis'
Use 'ajenis'
If Isexclusive()
	Wait Window Nowait"Indexing Data Jenis Kendaraan ...."
	Index On jenis Tag jenis Of &lcfile
Endif
Use
Wait Wind 'Data Jenis Kendaraan Reindexed ....' Timeout 1

lcfile = 'data\ajpajak'
Use 'ajpajak'
If Isexclusive()
	Wait Window Nowait"Indexing Data Jenis Pajak ...."
	Index On j_pajak Tag j_pajak Of &lcfile
Endif
Use
Wait Wind 'Data Jenis Pajak Reindexed ....' Timeout 1

lcfile = 'data\ajsetor'
Use 'ajsetor'
If Isexclusive()
	Wait Window Nowait"Indexing Data Jenis Setor ...."
	Index On jsetor Tag jsetor Of &lcfile
	Index On ayat Tag ayat Of &lcfile
Endif
Use
Wait Wind 'Data Jenis Setor Reindexed ....' Timeout 1

lcfile = 'data\akend'
Use 'akend'
If Isexclusive()
	Wait Window Nowait"Indexing Data Kendaraan ...."
	Index On nopol Tag nopol Of &lcfile
	Index On kohir Tag kohir Of &lcfile
	Index On rangka Tag rangka Of &lcfile
	Index On mesin Tag mesin Of &lcfile
Endif
Use
Wait Wind 'Data Kendaraan Reindexed ....' Timeout 1

lcfile = 'data\alokasi'
Use 'alokasi'
If Isexclusive()
	Wait Window Nowait"Indexing Data Lokasi/Daerah ...."
	Index On kd_lokasi Tag kd_lokasi Of &lcfile
Endif
Use
Wait Wind 'Data Lokasi/Daerah Reindexed ....' Timeout 1

lcfile = 'data\msbb'
Use 'msbb'
If Isexclusive()
	Wait Window Nowait"Indexing Data Bahan Bakar ...."
	Index On kd_bbm Tag kd_bbm Of &lcfile
Endif
Use
Wait Wind 'Data Bahan Bakar Reindexed ....' Timeout 1

lcfile = 'data\msguna'
Use 'msguna'
If Isexclusive()
	Wait Window Nowait"Indexing Data Penggunaan ...."
	Index On kd_guna Tag kd_guna Of &lcfile
Endif
Use
Wait Wind 'Data Penggunaan Reindexed ....' Timeout 1

lcfile = 'data\mslibur'
Use 'mslibur'
If Isexclusive()
	Wait Window Nowait"Indexing Data Hari Libur Nasional ...."
	Index On tgl Tag tgl Of &lcfile
Endif
Use
Wait Wind 'Data Hari Libur Nasional Reindexed ....' Timeout 1

lcfile = 'data\msmerk'
Use 'msmerk'
If Isexclusive()
	Wait Window Nowait"Indexing Data Merek Kendaran ...."
	Index On kd_merk Tag kd_merk Of &lcfile
Endif
Use
Wait Wind 'Data Merek Kendaran Reindexed ....' Timeout 1

lcfile = 'data\msmilik'
Use 'msmilik'
If Isexclusive()
	Wait Wind 'Indexing Data Kepemilikan ....' Nowait
	Index On kd_milik Tag kd_milik Of &lcfile
Endif
Use
Wait Wind 'Data Kepemilikan Reindexed ....' Timeout 1

lcfile = 'data\mspos'
Use 'mspos'
If Isexclusive()
	Wait Wind 'Indexing Data kode pos ....' Nowait
	Index On kd_pos Tag kd_pos Of &lcfile
Endif
Use
Wait Wind 'Data Kode Pos Reindexed ....' Timeout 1

lcfile = 'data\pkb_header'
Use 'pkb_header'
If Isexclusive()
	Wait Wind 'Indexing Data Pajak PKB Header ....' Nowait
	Index On nopol Tag nopol Of &lcfile
	Index On Dtos(tgl_dft)+no_dft Tag daftar Of &lcfile
	Index On no_ttp Tag no_ttp Of &lcfile
	Index On no_ttp_tgk Tag no_ttp_tgk Of &lcfile
	Index On no_trm Tag no_trm Of &lcfile
	Index On no_trm_tgk Tag no_trm_tgk Of &lcfile
	Index On kohir_gab Tag kohir_gab Of &lcfile
Endif
Use
Wait Wind 'Data Pajak PKB Header Reindexed ....' Timeout 1

lcfile = 'data\apkb'
Use 'apkb'
If Isexclusive()
	Wait Wind 'Indexing Data APKB ....' Nowait
	Index On jenis+kd_merk+tipe Tag pkb Of &lcfile
	Index On jenis+tipe+th_buat Tag pkb1 Of &lcfile
	Index On jenis+kd_merk+tipe+th_buat Tag NJKB Of &lcfile
Endif
Use
Wait Wind 'Data APKB Reindexed ...' Timeout 1

lcfile = 'data\pkb_biasa'
Use 'pkb_biasa'
If Isexclusive()
	Wait Wind 'Indexing Data Pajak PKB Biasa ....' Nowait
	Index On Dtos(tgl_dft)+no_dft Tag daftar Of &lcfile
Endif
Use
Wait Wind 'Data Pajak PKB Biasa Reindexed ....' Timeout 1

lcfile = 'data\pkb_TUNGGAK'
Use 'pkb_tunggak'
If Isexclusive()
	Wait Wind 'Indexing Data Pajak PKB Tunggakan ....' Nowait
	Index On Dtos(tgl_dft)+no_dft Tag daftar Of &lcfile
Endif
Use
Wait Wind 'Data Pajak PKB Tunggakan Reindexed ....' Timeout 1

lcfile = 'data\stnk'
Use 'stnk'
If Isexclusive()
	Wait Wind 'Indexing Data Pencetakan STNK ....' Nowait
	Index On Dtos(tgl_dft)+no_dft Tag daftar Of &lcfile
	Index On no_seri Tag no_seri Of &lcfile
	Index On nopol Tag nopol Of &lcfile
Endif
Use
Wait Wind 'Data Pencetakan STNK Reindexed ....' Timeout 1

lcfile = 'data\swdkllj'
Use 'swdkllj'
If Isexclusive()
	Wait Wind 'Indexing Data SWDKLLJ ....' Nowait
	Index On GOL Tag GOL Of &lcfile
Endif
Use
Wait Wind 'Data SWDKLLJ Reindexed ....' Timeout 1

*!*	lcfile = 'data\hist\h_akend'
*!*	Use 'h_akend'
*!*	If Isexclusive()
*!*		Wait Window 'Indexing Data Histori Kendaraan ....' Nowait
*!*		Index On nopol Tag nopol Of &lcfile
*!*	Endif
*!*	Use
*!*	Wait Window 'Data Histori Kendaraan Reindexed ....' Timeout 1

*!*	lcfile = 'data\hist\h_pkb_header'
*!*	Use 'h_pkb_header'
*!*	If Isexclusive()
*!*		Wait Window 'Indexing Data Histori PKB Header ....' Nowait
*!*		Index On nopol Tag nopol Of &lcfile
*!*	Endif
*!*	Use
*!*	Wait Window 'Data Histori PKB HEADER Reindexed ....' Timeout 1

lcfile = 'data\mspos'
use 'mspos'
if isexclusive()
	wait window 'Indexing Data Kode Pos...'Nowait
	index on kd_pos tag kd_pos of &lcfile
endif
use
wait window 'Data Kode Pos Reindexed...' Timeout 1

lcfile = 'data\ket_bebas'
use 'ket_bebas'
if isexclusive()
	wait window 'Indexing Data Surat Keterangan Bebas Pajak...'nowait
	index on nomor tag nomor of &lcfile
endif
use
wait window 'Data Surat Keterangan Bebas Pajak Reindexed...' Timeout 1

=Messagebox('Reindex Completed',64,'Information')
Use otori In 0 Order Tag otorisasi
Go nrec
lMenu = .T.
Return


Procedure pesan()
Wait Wind "File sedang digunakan"
Exit
Return
Endproc
