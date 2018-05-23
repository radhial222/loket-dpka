lParameter xdTgl, xnPlus

Local ldTgl

SET date TO british
if month(xdTgl) = 2 and day(xdTgl) = 29
	* tahun kabisat
	ldTgl = CTOD('28/02/'+STR(YEAR(xdTgl)+xnPlus,4))
else
	ldTgl = CTOD(STR(DAY(xdTgl),2)+'/'+;
					STR(MONTH(xdTgl),2)+'/'+;
					STR(YEAR(xdTgl)+xnPlus,4))
endif

return ldTgl

