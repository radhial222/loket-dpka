lMenu = .F.

sele otori
nrec = recno()
close tables all

on error do pesan()
set exclusive on

use 'data\ablokir_d' 
if isexclusive()
	wait wind 'Packing Data Blokir (Dispenda) ....' nowait
	pack
endif
wait wind 'Data Blokir (Dispenda) Packed ....' timeout 1

use 'data\ablokir_p' 
if isexclusive()
	wait wind 'Packing Data Blokir (Polisi) ....' nowait
	pack
endif
wait wind 'Data Blokir (Polisi) Packed ....' timeout 1

use 'data\afiskal' 
if isexclusive()
	wait wind 'Packing Data Fiskal Antar Daerah ....' nowait
	pack
endif
wait wind 'Data Fiskal Antar Daerah Packed ....' timeout 1

use 'data\ajenis' 
if isexclusive()
	wait wind 'Packing Data Jenis Kendaraan ....' nowait
	pack
endif
wait wind 'Data Jenis Kendaraan Packed ....' timeout 1

use 'data\ajpajak' 
if isexclusive()
	wait wind 'Packing Data Jenis Pajak ....' nowait
	pack
endif
wait wind 'Data Jenis Pajak Packed ....' timeout 1

use 'data\ajsetor' 
if isexclusive()
	wait wind 'Packing Data Jenis Setor ....' nowait
	pack
endif
wait wind 'Data Jenis Setor Packed ....' timeout 1

use 'data\akend'
if isexclusive()
	wait wind 'Packing Data Kendaraan ....' nowait
	pack
endif
wait wind 'Data Kendaraan Packed ....' timeout 1

use 'data\alokasi' 
if isexclusive()
	wait wind 'Packing Data Lokasi/Daerah ....' nowait
	pack
endif
wait wind 'Data Lokasi/Daerah Packed ....' timeout 1

use 'data\apkb' 
if isexclusive()
	wait wind 'Packing Data Dasar Pengenaan Pajak (DPP PKB) ....' nowait
	pack
endif
wait wind 'Data Dasar Pengenaan Pajak (DPP PKB) Packed ....' timeout 1

use 'data\msbb' 
if isexclusive()
	wait wind 'Packing Data Bahan Bakar ....' nowait
	pack
endif
wait wind 'Data Bahan Bakar Packed ....' timeout 1

use 'data\msguna' 
if isexclusive()
	wait wind 'Packing Data Penggunaan ....' nowait
	pack
endif
wait wind 'Data Penggunaan Packed ....' timeout 1

use 'data\mslibur' 
if isexclusive()
	wait wind 'Packing Data Hari Libur Nasional ....' nowait
	pack
endif
wait wind 'Data Hari Libur Nasional Packed ....' timeout 1

use 'data\msmerk' 
if isexclusive()
	wait wind 'Packing Data Merek Kendaran ....' nowait
	pack
endif
wait wind 'Data Merek Kendaran Packed ....' timeout 1

use 'data\msmilik' 
if isexclusive()
	wait wind 'Packing Data Kepemilikan ....' nowait
	pack
endif
wait wind 'Data Kepemilikan Packed ....' timeout 1

use 'data\mspos' 
if isexclusive()
	wait wind 'Packing Data Kode Pos ....' nowait
	pack
endif
wait wind 'Data Kode Pos Packed ....' timeout 1

use 'data\pkb_header' 
if isexclusive()
	wait wind 'Packing Data Pajak PKB Header ....' nowait
	pack
endif
wait wind 'Data Pajak PKB Header Packed ....' timeout 1

use 'data\pkb_biasa' 
if isexclusive()
	wait wind 'Packing Data Pajak PKB Biasa ....' nowait
	pack
endif
wait wind 'Data Pajak PKB Biasa Packed ....' timeout 1

use 'data\pkb_tunggak' 
if isexclusive()
	wait wind 'Packing Data Pajak PKB Tunggakan ....' nowait
	pack
endif
wait wind 'Data Pajak PKB Tunggakan Packed ....' timeout 1

use 'data\stnk' 
if isexclusive()
	wait wind 'Packing Data Pencetakan STNK ....' nowait
	pack
endif
wait wind 'Data Pencetakan STNK Packed ....' timeout 1

use 'data\swdkllj' 
if isexclusive()
	wait wind 'Packing Data SWDKLLJ ....' nowait
	pack
endif
use
wait wind 'Data SWDKLLJ Packed ....' timeout 1

use 'data\ket_bebas'
if isexclusive()
	wait window 'Packing Data Surat Keterangan Bebas Pajak...' nowait
	pack
endif
use
wait window 'Data Surat Keterangan Bebas Pajak Packed...' timeout 1

=messagebox('Packing Completed',64,'Information')
set exclusive off

use otori in 0 order tag otorisasi
go nrec
lMenu = .T.
return

procedure pesan()
	wait wind "File sedang digunakan !!"
	exit
return
endproc
