LPARAMETERS cur,extd1
*!*	cwaktu = TTOC(cur)
cwaktu = cur
extd = VAL(SUBSTR(extd1,3,2)) * 60
ctext = right(ALLTRIM(cwaktu),8)
nhour = vAL(LEFT(CTEXT,2))	
NMENIT = VAL(substr(CTEXT,4,2))
ndetik =vAL(right(CTEXT,2))

njam = 0
ntmenit = 0
ntdetik = 0
nsisa = extd
*!*	IF extd >=3600

cm = INT((extd)/60)
nsdetik = MOD(extd,60)
IF nsdetik + ndetik >=60
	cm = cm + 1
	ndetik  = (nsdetik + ndetik) - 60
ELSE
	ndetik = ndetik + nsdetik
ENDIF 

nm = nmenit + cm
nj = INT(cm/60)
cnmenit = MOD(cm,60)

IF cnmenit + nmenit >=60
	nj = nj + 1
	nmenit = (cnmenit + nmenit )- 60
ELSE
	nmenit = cnmenit + nmenit 
ENDIF 


nhour = nhour + nj

nret = REPLWZ(nhour,2)+':'+REPLWZ(nmenit,2)+':'+REPLWZ(ndetik,2)

RETURN nret		
