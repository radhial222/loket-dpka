close databases
clear all
set safety off
set dele on


* buka table data baru

use \sampapua\data\akend alias akend in 0

* buka table data irian
use \sampapua\data\transfer\trnkb alias trnkb in 0 
use \sampapua\data\transfer\mstkb alias mstkb in 0


* hapus data baru






*\ proses transfer data
* transfer table blokir dispenda

* transfer table akend
sele trnkb
go top
scan
	lcNopol = nopol
	
	lcJenis = KD_JENIS
			

	select akend
	locate for nopol = lcnopol
	if found()
		IF JENIS =''
		DO CASE
		case lcjenis = '101'
			replace jenis with 'A01'
		CASE LCJENIS = '103'
			REPLACE JENIS WITH 'A02'
		CASE LCJENIS = '211'
			REPLACE JENIS WITH 'A04'
		CASE LCJENIS = '212'
			REPLACE JENIS WITH 'A05'
		CASE LCJENIS = '311'
			REPLACE JENIS WITH 'B02'
		CASE LCJENIS = '312'
			REPLACE JENIS WITH 'B01'
*!*			CASE LCJENIS = '325'
*!*				REPLACE JENIS WITH 'A03'
		CASE LCJENIS = '411'
			REPLACE JENIS WITH 'C02'
		CASE LCJENIS = '414'
			REPLACE JENIS WITH 'C16'
		CASE LCJENIS ='435'
			REPLACE JENIS WITH 'C05'
		CASE LCJENIS = '412'
			REPLACE JENIS WITH 'C11'
		CASE LCJENIS = '415'
			REPLACE JENIS WITH 'C17'
		CASE LCJENIS = '431'
			REPLACE JENIS WITH 'C09'
		CASE LCJENIS = '432'
			REPLACE JENIS WITH 'C18'
		CASE LCJENIS = '451'
			REPLACE JENIS WITH 'C01'
		CASE LCJENIS ='452'
			REPLACE JENIS WITH 'C10'							 			 					
		CASE LCJENIS = '326'	
			REPLACE JENIS WITH 'C03'
		CASE LCJENIS = '511'
			REPLACE JENIS WITH 'E01'
		CASE LCJENIS = '512'
			REPLACE JENIS WITH 'E15'
		CASE LCJENIS = '601'
			REPLACE JENIS WITH 'D01'	
		CASE LCJENIS = '325'
			REPLACE JENIS WITH 'A03'
		ENDCASE
		ENDIF
			
	endif
	select trnkb
endscan


sele MSTKB
go top
scan
	lcNopol = nopol
	
	lcJenis = KD_JENIS
		

	select akend
	locate for nopol = lcnopol
	if found()
				IF JENIS =''
		DO CASE
		case lcjenis = '101'
			replace jenis with 'A01'
		CASE LCJENIS = '103'
			REPLACE JENIS WITH 'A02'
		CASE LCJENIS = '211'
			REPLACE JENIS WITH 'A04'
		CASE LCJENIS = '212'
			REPLACE JENIS WITH 'A05'
		CASE LCJENIS = '311'
			REPLACE JENIS WITH 'B02'
		CASE LCJENIS = '312'
			REPLACE JENIS WITH 'B01'
*!*			CASE LCJENIS = '325'
*!*				REPLACE JENIS WITH 'A03'
		CASE LCJENIS = '411'
			REPLACE JENIS WITH 'C02'
		CASE LCJENIS = '414'
			REPLACE JENIS WITH 'C16'
		CASE LCJENIS ='435'
			REPLACE JENIS WITH 'C05'
		CASE LCJENIS = '412'
			REPLACE JENIS WITH 'C11'
		CASE LCJENIS = '415'
			REPLACE JENIS WITH 'C17'
		CASE LCJENIS = '431'
			REPLACE JENIS WITH 'C09'
		CASE LCJENIS = '432'
			REPLACE JENIS WITH 'C18'
		CASE LCJENIS = '451'
			REPLACE JENIS WITH 'C01'
		CASE LCJENIS ='452'
			REPLACE JENIS WITH 'C10'							 			 					
		CASE LCJENIS = '326'	
			REPLACE JENIS WITH 'C03'
		CASE LCJENIS = '511'
			REPLACE JENIS WITH 'E01'
		CASE LCJENIS = '512'
			REPLACE JENIS WITH 'E15'
		CASE LCJENIS = '601'
			REPLACE JENIS WITH 'D01'	
		CASE LCJENIS = '325'
			REPLACE JENIS WITH 'A03'
		ENDCASE

		ENDIF
			
	endif
	select MSTKB
endscan

close databases
wait wind "Transfer Completed ..."
