FUNCTION pembulatan()

	Lparameters nilai_awal
	Local nilai_akhir
	lnBulat = Mod(nilai_awal,100)
	Do Case
	Case lnBulat > 0 And lnBulat <= 1
		nilai_akhir = nilai_awal-lnBulat
	Case lnBulat > 1 And lnBulat <= 100
		nilai_akhir = nilai_awal-lnBulat+100
	Other
		nilai_akhir = nilai_awal
	Endcase
	Return nilai_akhir

ENDFUNC


FUNCTION pembulatanBBN()

	Lparameters nilai_awal
	Local nilai_akhir
	lnBulat     = Mod(nilai_awal,1000)
	nilai_akhir = IIF(lnbulat<500,nilai_awal-lnbulat,nilai_awal-lnbulat+1000)
	Return nilai_akhir

ENDFUNC






*!*	Lparameters nilai_awal
*!*	Local nilai_akhir
*!*	lnBulat = Mod(nilai_awal,100)
*!*	Do Case
*!*	Case lnBulat > 0 And lnBulat <= 1
*!*		nilai_akhir = nilai_awal-lnBulat
*!*	Case lnBulat > 1 And lnBulat <= 100
*!*		nilai_akhir = nilai_awal-lnBulat+100
*!*	Other
*!*		nilai_akhir = nilai_awal
*!*	Endcase
*!*	Return nilai_akhir



