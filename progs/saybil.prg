lparam mAngka
  SET TALK OFF
   
  PRIVATE mhasil,x,x1,x2,a_satuan,a_angka,a_puluhan

  DIME a_satuan[5], a_angka[20], a_puluhan[10]
  a_satuan[1] = ""
  a_satuan[2] = "ribu "
  a_satuan[3] = "juta "
  a_satuan[4] = "milyar "
  a_satuan[5] = "triliun "

  a_angka[ 1] = ""
  a_angka[ 2] = "satu "
  a_angka[ 3] = "dua "
  a_angka[ 4] = "tiga "
  a_angka[ 5] = "empat "
  a_angka[ 6] = "lima "
  a_angka[ 7] = "enam "
  a_angka[ 8] = "tujuh "
  a_angka[ 9] = "delapan "
  a_angka[10] = "sembilan "
  a_angka[11] = "sepuluh "
  a_angka[12] = "sebelas "
  a_angka[13] = "dua belas "
  a_angka[14] = "tiga belas "
  a_angka[15] = "empat belas "
  a_angka[16] = "lima belas "
  a_angka[17] = "enam belas "
  a_angka[18] = "tujuh belas "
  a_angka[19] = "delapan belas "
  a_angka[20] = "sembilan belas "

  a_puluhan[ 1] = ""
  a_puluhan[ 2] = "puluh "
  a_puluhan[ 3] = "dua puluh "
  a_puluhan[ 4] = "tiga puluh "
  a_puluhan[ 5] = "empat puluh "
  a_puluhan[ 6] = "lima puluh "
  a_puluhan[ 7] = "enam puluh "
  a_puluhan[ 8] = "tujuh puluh "
  a_puluhan[ 9] = "delapan puluh "
  a_puluhan[10] = "sembilan puluh "

  x1 = 5
  x2 = 1
  mhasil = ""
  DO WHILE x1 >= 1
     *555444333222111
     *999999999999999.99
     mhasil = mhasil + FCAMTP(substr( str(mangka,18,2) ,x2,3) ,x1)
     x1 = x1 - 1
     x2 = x2 + 3
  ENDDO
  x = VAL( RIGHT( str(mangka,18,2),2 ) )
  IF x # 0
     mhasil = mhasil + ltrim(str(x,2)) + "/100 "
  ENDIF
  mhasil = UPPER(LEFT(mhasil,1))+SUBSTR(mhasil,2)
  RETURN trim(mhasil)
  
FUNCTION FCAMTP
  PARAMETER mstr_amt,mpangkat
  
  PRIVATE mhasil,x
  
  mhasil = ""
  IF mstr_amt = space(3) .or. mstr_amt = "000"
     RETURN ""
  ENDIF

  IF val(mstr_amt)=1 .and. mpangkat=2
     mhasil = 'se'
  ELSE
     x = val(left(mstr_amt,1))
     IF x # 0
        IF x=1
           mhasil = "seratus "
        ELSE
           mhasil = a_angka[1+ x ] + "ratus "
        ENDIF
     ENDIF
     x = val(right(mstr_amt,2))
     IF x <= 19
        mhasil = mhasil + a_angka[1+ x ]
     ELSE
        mhasil = mhasil + a_puluhan[1+ val(substr(mstr_amt,2,1)) ] + a_angka[1+ val(substr(mstr_amt,3,1)) ]
     ENDIF
  ENDIF
  RETURN mhasil + a_satuan[ mpangkat ]
ENDFUNC



*!*	param angka

*!*	local temp, hasil, panjang
*!*	local sat, ribuan, jutaan, milyaran
*!*	  temp = alltrim(str(angka,12))
*!*	  panjang=len(temp)
*!*	  sat = right(temp,3)  
*!*	  hasil = bil(val(sat),.F.)
*!*	  if len(temp) > 3
*!*	    temp = left(temp,len(temp)-3)
*!*	    ribuan = right(temp,3)
*!*	    if val(ribuan) <> 0 
*!*	      hasil = bil(val(ribuan),.T.)+'ribu ' + hasil
*!*	    endif
*!*	  endif
*!*	  if len(temp) > 3
*!*	    temp = left(temp,len(temp)-3)
*!*	    jutaan = right(temp,3)
*!*	    if val(jutaan) <> 0
*!*	      hasil = bil(val(jutaan),.F.)+ 'juta '+ hasil
*!*	    endif
*!*	  endif
*!*	  if len(temp) > 3
*!*	    temp = left(temp,len(temp)-3)
*!*	    milyaran = right(temp,3)
*!*	    if val(milyaran) <> 0
*!*	      hasil = bil(val(milyaran),.F.)+ 'milyar '+ hasil
*!*	    endif
*!*	  endif
*!*	  if panjang =1 and temp = '0'
*!*	    hasil = 'nol '
*!*	  endif
*!*	  hasil = hasil + 'rupiah'
*!*	return hasil


*!*	function bil(angka, tipe)
*!*	local temp, terbilang, panjang
*!*	  terbilang = ''
*!*	  temp = alltrim(str(int(angka)))
*!*	  panjang = len(temp)
*!*	  dime satuan[9] 
*!*	  satuan[1] = 'se'
*!*	  satuan[2] = 'dua '
*!*	  satuan[3] = 'tiga '
*!*	  satuan[4] = 'empat '
*!*	  satuan[5] = 'lima '
*!*	  satuan[6] = 'enam '
*!*	  satuan[7] = 'tujuh '
*!*	  satuan[8] = 'delapan '
*!*	  satuan[9] = 'sembilan '
*!*	  
*!*	  if len(temp) == 3
*!*	    terbilang = satuan[val(left(temp,1))]+'ratus '
*!*	    if mod(val(temp),100) = 0
*!*	      temp = ''
*!*	    else
*!*	      if mod(val(temp),100) < 10
*!*	        temp = right(temp,1)
*!*	      else
*!*	        temp = right(temp,2)
*!*	      endif
*!*	    endif
*!*	  endif
*!*	  if len(temp) == 2 and val(temp) <> 0
*!*	    if val(temp) > 10 and val(temp) < 20
*!*	      terbilang = terbilang + satuan[val(right(temp,1))] + 'belas '
*!*	      temp = ''
*!*	    else
*!*	      terbilang = terbilang + satuan[val(left(temp,1))]+'puluh ' 
*!*	      if mod(val(temp),10) = 0
*!*	        temp = ''
*!*	      else
*!*	        temp = right(temp,1)
*!*	      endif
*!*	    endif
*!*	  endif
*!*	  if len(temp) == 1 and val(temp) <> 0
*!*	    if temp = '1' 
*!*	      if panjang = 1 and tipe = .T. 
*!*	        terbilang = terbilang + 'se'
*!*	      else
*!*	        terbilang = terbilang + 'satu ' 
*!*	      endif
*!*	    else
*!*	      terbilang = terbilang + satuan[val(temp)]
*!*	    endif
*!*	  endif
*!*	  return terbilang
*!*	endfunc