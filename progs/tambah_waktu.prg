Function tambah_waktu()
Lparameters cur
cwaktu = cur
*waktu 1 menit
extd = 60
ctext = substr(Alltrim(cwaktu),12,8)
nhour = Val(Left(ctext,2))
NMENIT = Val(Substr(ctext,4,2))
ndetik =Val(Right(ctext,2))

njam = 0
ntmenit = 0
ntdetik = 0
nsisa = extd


cm = Int((extd)/60)
nsdetik = Mod(extd,60)
If nsdetik + ndetik >=60
	cm = cm + 1
	ndetik  = (nsdetik + ndetik) - 60
Else
	ndetik = ndetik + nsdetik
Endif

nm = NMENIT + cm
nj = Int(cm/60)
cnmenit = Mod(cm,60)

If cnmenit + NMENIT >=60
	nj = nj + 1
	NMENIT = (cnmenit + NMENIT )- 60
Else
	NMENIT = cnmenit + NMENIT
Endif


nhour = nhour + nj

nret = Alltrim(Str(nhour))+':'+Alltrim(Str(NMENIT))+':'+Alltrim(Str(ndetik))

Return nret

