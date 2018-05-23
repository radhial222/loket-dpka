FUNCTION create_menu() 
Lparameters lcoto

cexec =  ' SET SYSMENU TO ' +Chr(13)
cexec = cexec + ' SET SYSMENU AUTOMATIC ' +Chr(13)

csq = ' SELECT * from otori where otorisasi = ?lcoto '
asg =SQLExec(gnconnhandle,csq,'rs_otori')


csq = ' SELECT * from modul order by kode '
asg =SQLExec(gnconnhandle,csq,'rs_modul')
Select *,0 As akses From  rs_modul Into Cursor rs_modul2 Readwrite


Select rs_modul2
Go Top
Do While ! Eof()
	If nilai <> 1
		ckode = Upper(Alltrim(kode))
		Select rs_otori
		For i = 2 To Fcount('rs_otori')
			cnm = Field(i)
			lada = &cnm
			If cnm =ckode
				If  lada = 1
					Select rs_modul2
					Replace akses With 1
				Endif
				Exit
			Endif
		Next
	Endif
	Select rs_modul2
	Skip
Enddo



ENDFUNC 








*!*	Select rs_otori

*!*	For i = 2 To Fcount('rs_otori')
*!*		cnm = Field(i)
*!*		lada = &cnm
*!*		If lada = 1
*!*			Select * From
*!*			csq = ' SELECT modul,nilai from modul where kode = ?lcoto '
*!*			asg =SQLExec(gnconnhandle,csq,'rs_modul')
*!*			cpad =





