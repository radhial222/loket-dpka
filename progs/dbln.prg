lpar bln
  #define tbl_bulan 'Januari  Februari Maret    April    Mei      Juni     '+;
              'Juli     Agustus  SeptemberOktober  November Desember '
return alltrim(substr(tbl_bulan,9*bln-8,9)) 
