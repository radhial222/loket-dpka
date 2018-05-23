*\ clear environment
clear all         	&& clear memory
close all			&& close data files
release windows		&& clear all orphaned windows
on key				&& clear ON KEY LABELs
clear				&& clear main window


public lcoldtalk
public lMenu, pdTgl_Trans, plTrans,ccompany, c_user, katakunci,plOnline,pckdupt,pcServerUrl,pcServer ,pcdbname, usernya,princi_bayar
PUBLIC Pckd_area, login_ulang,pndp 
login_ulang=.f.
lcoldtalk=set("talk")
lMenu = .T.


set talk off
set status bar off
set debug off
set safety off
set exact on
set delete on
set century on
set date british
set optimize on
set point to ','
set sepa to  '.'
SET ANSI ON
SET SEPARATOR TO '.'
*\ multi user environment
set exclusive off
set multilock on
set reprocess to -1

set sysmenu to

setpath()
set procedure to progs\util.prg
SET CLASSLIB TO libs\con_mysql


Toolbar_Foxpro(.F.)

		oApp = Createobject("con_mysql")
		If Type('oApp') = "O"
			PNEWCONN = .F.
			lfirst = .t.
			oApp.Do_info()
		Endif

Toolbar_Foxpro(.T.)

set sysmenu to defa

FUNCTION SetPath()
  LOCAL lcSys16, ;
        lcProgram

  lcSys16 = SYS(16)
  lcProgram = SUBSTR(lcSys16, AT(":", lcSys16) - 1)

  CD LEFT(lcProgram, RAT("\", lcProgram))
  IF RIGHT(lcProgram, 3) = "FXP"
    CD ..
  ENDIF
  SET PATH TO PROGS, FORMS, LIBS, ;
        MENUS, DATA, DATA\HIST, ;
        REPORTS,  HELP, ;
        PICTURE, GRAPHICS, TEXT,classes
    SET CLASSLIB TO con_mysql    
ENDFUNC