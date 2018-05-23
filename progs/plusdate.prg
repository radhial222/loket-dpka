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

*!*	Function plusdate()
*!*	Lparameter xdTgl, xnPlus
*!*	Set Date To british

*!*	Local ldTgl

*!*	If Month(xdTgl) = 2 And Day(xdTgl) = 29
*!*	* tahun kabisat
*!*		ldTgl = Ctod('28/02/'+Str(Year(xdTgl)+xnPlus,4))
*!*	Else
*!*		ldTgl = Ctod(Str(Day(xdTgl),2)+'/'+;
*!*			STR(Month(xdTgl),2)+'/'+;
*!*			STR(Year(xdTgl)+xnPlus,4))
*!*	Endif
*!*	Set Date To YMD
*!*	Return ldTgl