  P   !                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                              Courier New                    =  '  winspool Epson LQ-1170 ESC/P 2 LPT1:                                                    �Epson LQ-1170 ESC/P 2            � 0C�  �
od   �   �   Letter                                                        ����                DINU"   0  "��H                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      �DRIVER=winspool
DEVICE=Epson LQ-1170 ESC/P 2
OUTPUT=LPT1:
ORIENTATION=1
PAPERSIZE=8
ASCII=8
COPIES=1
DEFAULTSOURCE=15
PRINTQUALITY=180
COLOR=1
YRESOLUTION=180
TTOPTION=2
COLLATE=1
                                    Arial Narrow                   8"LAPORAN  : MUTASI MASUK OBYEK PAJAK KENDARAAN BERMOTOR"        Arial Narrow                   "U P T"                        Arial Narrow                   "TAHUN ANGGARAN"               Arial Narrow                   "JENIS KENDARAAN :"            Arial Narrow                   "KODE FORM "                   Arial Narrow                   "BULAN "                       Arial Narrow                   "No."                          Courier New                    "1"                            Courier New                    "2"                            Arial Narrow                   "Hal :"                        _pageno                                                       Arial Narrow                   no                                                            Arial                          Arial Narrow                   ":"                            Arial Narrow                   "LC. 02"                       Arial Narrow                   ":"                            Arial Narrow                   ":"                            Arial Narrow                   ":"                            konfig.lokasi                  Arial Narrow                   roda                                                          Arial Narrow                   anggaran                                                      Arial Narrow                   Arial Narrow                   "Nama / AlamatPemilik Baru"                                    Arial Narrow                   "Identitas Kendaraan"          Arial Narrow                   "Merk /Type"                  "@I"                           Arial Narrow                   "CC/Th."                       Arial Narrow                   "No. Rangka /No. Mesin"       Arial Narrow                   "Kode Identitas"               Arial Narrow                   "Plat"                         Arial Narrow                   "Nopol"                        "@I"                           Arial Narrow                   "Tgl.Pembelian"               "@I"                           Arial Narrow                   "Tgl.Pendaftaran"             "@I"                           Arial Narrow                   "Tgl.Jth. Tempo"              "@I"                           Arial Narrow                   "Tgl.Pembayaran"              Arial Narrow                   "Penetapan Pajak"              "@I"                           Arial Narrow                   "Nilai Jual /"                 "@I"                           Arial Narrow                   "Dasar Pengenaan PKB /"        "@I"                           Arial Narrow                   "Denda Pajak"                  "@I"                           Arial Narrow                   "JumlahPembayaran"            Arial Narrow                   "Ket."                         Courier New                    "3"                            Courier New                    "4"                            Courier New                    "5"                            Courier New                    "6"                            Courier New                    "7"                            Courier New                    "8"                            Courier New                    "9"                            Courier New                    "10"                           Courier New                    "11"                           Courier New                    "12"                           Courier New                    "13"                           Courier New                    "14"                           Courier New                    "15"                           Courier New                    "17"                           Courier New                    "16"                           master.nama                    Arial                          master.alamat                  Arial                          master.merk                    Arial                          master.model                   Arial                          	master.cc                      Arial                          master.th_buat                 Arial                          master.rangka                  Arial                          master.mesin                   Arial                          kelompok.name                  Arial                          master.nopol                                                  Arial                          master.tgl_faktur                                             Arial                          master.tgl_daftar                                             Arial                          master.tgl_bayar                                              Arial                          &bulan()+' '+alltrim(str(year(Date())))                                                         Arial Narrow                   master.tgl_notice                                             Arial                          dp.nilaijual                                                  Arial                          "999,999,999,999"              Arial Narrow                   "Bobot"                        Arial Narrow                   "Pokok Pajak"                  dp.nilaipkb                                                   Arial                          "999,999,999,999"              master.pk_pkb                                                 Arial                          "999,999,999,999"              master.dn_pkb                                                 Arial                          "999,999,999,999"              dp.bobot                                                      Arial                          "999,999,999,999"              master.pk_pkb+ master.dn_pkb                                                                   Arial                          "999,999,999,999"              Arial Narrow                   "Nama / AlamatPemilik Lama"                                    master.namalama                                               Arial                          master.almlama                                                Arial                          "@I"                           Times New Roman                "MENGETAHUI :"                 "@I"                           Times New Roman                "BENDAHARAWAN KHUSUS PENERIMA"                                  &alltrim(konfig.lokasi)+', '+sekarang()                                                         Times New Roman                OTORIT.PB22                                                   Times New Roman                'NIP  '+OTORIT.PB21                                           Times New Roman                otorit.ATSDIS2                                                Times New Roman                 'NIP  '+ alltrim(otorit.ATSDIS1)                                                               Times New Roman                4alltrim(otorit.ATSDIS4)+'  DINAS PENDAPATAN DAERAH '                                           Times New Roman                alltrim(konfig.lokasi)                                        Times New Roman                no                             1                              0                              Courier New                    Arial Narrow                   Arial Narrow                   Arial Narrow                   Arial Narrow                   Arial                          Times New Roman                Times New Roman                dataenvironment                JLeft = 52
Top = 61
Width = 722
Height = 451
Name = "Dataenvironment"
                       cursor                         eLeft = 10
Top = 20
Width = 90
Height = 90
Alias = "dp"
CursorSource = dp.dbf
Name = "Cursor1"
                             cursor                         nLeft = 150
Top = 20
Width = 90
Height = 90
Alias = "master"
CursorSource = master.dbf
Name = "Cursor2"
                    cursor                         sLeft = 245
Top = 194
Width = 95
Height = 90
Alias = "kelompok"
CursorSource = kelompok.dbf
Name = "Cursor3"
               cursor                         nLeft = 430
Top = 20
Width = 95
Height = 90
Alias = "tabjen"
CursorSource = tabjen.dbf
Name = "Cursor4"
                    cursor                         nLeft = 570
Top = 20
Width = 95
Height = 90
Alias = "konfig"
CursorSource = konfig.dbf
Name = "Cursor5"
                    relation                       oParentAlias = "dp"
RelationalExpr = "nopol"
ChildAlias = "master"
ChildOrder = "nopol"
Name = "Relation1"
                   relation                       sParentAlias = "master"
RelationalExpr = "kd_jen"
ChildAlias = "tabjen"
ChildOrder = "code"
Name = "Relation2"
               relation                       sParentAlias = "master"
RelationalExpr = "plat"
ChildAlias = "kelompok"
ChildOrder = "code"
Name = "Relation3"
               cursor                         nLeft = 10
Top = 140
Width = 90
Height = 90
Alias = "otorit"
CursorSource = otorit.dbf
Name = "Cursor6"
                     