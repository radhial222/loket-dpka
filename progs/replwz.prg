*fungsi untuk menambahkan angka 0 didepan
lpar angka,jum
local i, hasil, temp
  temp = alltrim(str(angka,jum,0))
  do while len(temp) < jum
    temp = '0'+ temp
  enddo    
return temp
