local npkb, ndpkb, nbbn1, ndbbn1, nbbn2, ndbbn2, nswd, ndswd
local nadm, nplat, ntotal
local tmp1, tmp2, ckode

*\ prepare the variable
store 0 to npkb, ndpkb, nbbn1, ndbbn1, nbbn2, ndbbn2, nswd, ndswd
store 0 to nadm, nplat, ntotal

use pkb_biasa in 0 order tag daftar alias pkb_biasa 
use pkb_tunggak order tag daftar in 0 alias pkb_tunggak
use ajsetor order tag jsetor in 0 alias ajsetor
use harian order tag tgl in 0 alias harian

*\ select the data and fix the relation
dtgl = pdTgl_Trans
select tgl_dft, no_dft, tgl_trm from pkb_header ; 
		where tgl_trm = dTgl; 
		into cursor pkb_h order by no_dft

sele pkb_h
do while !eof()
	*\ biasa begin here
	sele pkb_biasa
	seek dtos(pkb_h.tgl_dft)+pkb_h.no_dft
	if found()
	  ntotal = ntotal + jumlah
	  for i = 1 to 10
		tmp1 = 'pkb_biasa.jenis'+allt(str(i))				
		if !empty(&tmp1)
			ckode = thisform.getjenis(&tmp1)			
			do case 
				case left(ckode,1) = '1'
					tmp2 = 'pkb_biasa.pokok'+allt(str(i)) 
				case left(ckode,1) = '2'
					tmp2 = 'pkb_biasa.denda'+allt(str(i)) 
			endcase
			do case
				case cKode = '13'
					npkb = npkb + &tmp2 
				case cKode = '23'
					ndpkb = ndpkb + &tmp2 
				case cKode = '11'
					nbbn1 = nbbn1 + &tmp2 
				case cKode = '21'
					ndbbn1 = ndbbn1 + &tmp2 
				case cKode = '12'
					nbbn2 = nbbn2 + &tmp2 
				case cKode = '22'
					ndbbn2 = ndbbn2 + &tmp2 
				case cKode = '14'
					nswd = nswd + &tmp2 
				case cKode = '24'
					ndswd = ndswd + &tmp2 
				case cKode = '15'
					nadm = nadm + &tmp2
				case cKode = '16'
					nplat = nplat + &tmp2
			endcase
		endif
	  endfor  
	endif
	
	*\ tunggak begin here
	sele pkb_tunggak
	seek dtos(pkb_h.tgl_dft)+pkb_h.no_dft
	if found()
	  ntotal = ntotal + jumlah
	  for i = 1 to 10
		tmp1 = 'pkb_tunggak.jenis'+allt(str(i))				
		if !empty(&tmp1)
			ckode = thisform.getjenis(&tmp1)			
			do case 
				case left(ckode,1) = '1'
					tmp2 = 'pkb_tunggak.pokok'+allt(str(i)) 
				case left(ckode,1) = '2'
					tmp2 = 'pkb_tunggak.denda'+allt(str(i)) 
			endcase
			do case
				case cKode = '13'
					npkb = npkb + &tmp2 
				case cKode = '23'
					ndpkb = ndpkb + &tmp2 
				case cKode = '11'
					nbbn1 = nbbn1 + &tmp2 
				case cKode = '21'
					ndbbn1 = ndbbn1 + &tmp2 
				case cKode = '12'
					nbbn2 = nbbn2 + &tmp2 
				case cKode = '22'
					ndbbn2 = ndbbn2 + &tmp2 
				case cKode = '14'
					nswd = nswd + &tmp2 
				case cKode = '24'
					ndswd = ndswd + &tmp2 
				case cKode = '15'
					nadm = nadm + &tmp2
				case cKode = '16'
					nplat = nplat + &tmp2
			endcase
		endif	
	  endfor
	endif
	sele pkb_h
	skip
enddo

*\ simpan rekap harian
sele harian
seek dtos(dTgl)
if !found()
	append blank
	repl tgl with dTgl
endif
repl pkb with npkb, dpkb with ndpkb, bbn1 with nbbn1, dbbn1 with ndbbn1
repl bbn2 with nbbn2, dbbn2 with ndbbn2, swd with nswd, dswd with ndswd
repl adm with nadm, plat with nplat, total with ntotal

=messagebox('Rekalkulasi Harian Selesai !',64,'Informasi')

sele pkb_header
use
sele pkb_h
use
sele pkb_biasa 
use
sele pkb_tunggak 
use
sele ajsetor 
use
sele harian
use

*\ the function begin here, so watch out...

function getjenis
param cJsetor
	nsele = select()

	lcJenis = ''
	sele AJSetor
	locate for JSetor = cJSetor
	if found()
		lcJenis = jenis
	endif

	select(nsele)
return lcJenis
endfunc