lparam ddate

cdate = ''

if type('ddate') = 'D'

	do case
		case dow(ddate) = 1
			cdate = 'Minggu'
		case dow(ddate) = 2
			cdate = 'Senin'
		case dow(ddate) = 3
			cdate = 'Selasa'
		case dow(ddate) = 4
			cdate = 'Rabu'
		case dow(ddate) = 5
			cdate = 'Kamis'
		case dow(ddate) = 6
			cdate = 'Jumat'
		case dow(ddate) = 7
			cdate = 'Sabtu'
		OTHERWISE 
			cdate = ''
	endcase

ENDIF 

return cdate