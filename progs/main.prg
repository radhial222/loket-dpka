*\ clear environment

clear all         	&& clear memory
close all			&& close data files
release windows		&& clear all orphaned windows
on key				&& clear ON KEY LABELs
clear				&& clear main window


public lcoldtalk,njkb_hitung,status25,bulan_denda,njkb_denda
public lMenu, pdTgl_Trans, plTrans,ccompany, c_user, katakunci,plOnline,pckdupt,pcServerUrl,pcServer ,pcdbname,pcServer_ol ,pcdbname_ol, usernya,princi_bayar
PUBLIC Pckd_area, login_ulang,pndp 
PUBLIC pc_Server,pc_Uid,pc_Pwd,pc_Db, pc_Server_ol,pc_Uid_ol,pc_Pwd_ol,pc_Db_ol,PCHOME, pcketlogin,pcketlogin1,pcketlogin2

STORE '' TO pc_Server,pc_Uid,pc_Pwd,pc_Db, pc_Server_ol,pc_Uid_ol,pc_Pwd_ol,pc_Db_ol,PCHOME

PUBLIC tkoding, tjenis, tmerk, ttipe, trangka, tmesin, ttahun, tcc, tstruk, ttnama, ttalamat, ttkecamatan, ttmilik, ttguna, ttfaktur, ttwarna, ;
       ttbbm, ttwarnaplat, ttbpkb, tttglnotice, ttkode_kec, PDtgl_ttp, pdtgl_ttp_2, pdtgl_trm_2, ldbatas_tgk, sts_tunggak_merah    

PUBLIC bln_denda_biasa_for_tunggak,bln_denda_tunggak_for_tunggak       


STORE 1 TO tstruk

STORE '' to tkoding, tjenis, tmerk, ttipe, trangka, tmesin, ttahun, tcc, ttnama, ttalamat, ttkecamatan, ttmilik, ttguna, ttfaktur, ttwarna, ;
            ttbbm, ttwarnaplat, ttbpkb, tttglnotice, ttkode_kec, PDtgl_ttp, pdtgl_trm_2    


bulan_denda  = 0
status25     = 0
njkb_hitung  = ''
njkb_denda   = 0
denda_biasa=0
dispensasi=0

login_ulang  = .f.
lcoldtalk    = set("talk")

lMenu        = .T.

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
SET NULLDISPLAY TO SPACE(1)

setpath()
set procedure to progs\util.prg,cur_to_xml,utiltext,update_hist,soap_client,wwapi,wwhttp,wwsoap,tran_mksr,ekspor_data4,ws_sqlcom,plusdate,wwutils,send_rekap
SET CLASSLIB TO libs\samsat.vcx,con_mysql,samsat_neo,soaphelper
*!*	SET CLASSLIB TO classes\wwxml additive


*!*		IF !FILE('konektor.dbf')
*!*			crea table konektor free (Dbname c(100),server c(100),username c(100),pswdb c(100))
*!*			APPEND Blank 
*!*			REPLACE dbname WITH genecp(''),;
*!*					server WITH genecp(''),;
*!*					username WITH genecp(''),;
*!*					pswdb WITH genecp('')
*!*			
*!*	*!*			oCon = CREATEOBJECT('konek')
*!*	*!*			oCon.show
*!*			 		
*!*			
*!*		endif

Toolbar_Foxpro(.F.)

		oApp = Createobject("con_mysql")
		If Type('oApp') = "O"
			PNEWCONN = .F.
			lfirst = .t.
			oApp.Do()
		ENDIF
*!*			oApp = Createobject("con_mysql_ol")
*!*			If Type('oApp') = "O"
*!*				PNEWCONN = .F.
*!*				lfirst = .t.
*!*				oApp.Do()
*!*			Endif

Toolbar_Foxpro(.T.)
Samsat_screen(.F.)

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
  
  pcHome = curdir()
  
  SET PATH TO PROGS, FORMS, LIBS, ;
        MENUS, DATA, DATA\HIST, ;
        REPORTS,  HELP, ;
        PICTURE, GRAPHICS, TEXT,classes
    SET CLASSLIB TO con_mysql
      
ENDFUNC