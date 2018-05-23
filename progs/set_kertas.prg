function BuatUkuranKertas(vNamaKertas,lebar,panjang,NamaPrinter)
Local        ;
    vDir,;
    lAda,;
    vFile,;
    cString,;
    nLength,;
    nOccurs,;
    nSizeX ,;
    nSizeY ,;
    nStart ,;
    cPaper ,;
    cSize  ,;
    cPrinterName,;
    cPaperNameWithSize

Decl Integer SetPaperName In Printer.Dll String,String
Decl String  GetPaperList In Printer.Dll String

**Ambil Nama Printer Default
cPrinterName=Set("Printer",2)                                   

** Ambil Nama Form yang sudah ada di Printer Properties
cString                      = GetPaperList(cPrinterName)+':'
nOccurs                      = Occurs(':',cString)

Dime aPaperSize(1,3)
aPaperSize(1,1)              =''
aPaperSize(1,2)              = 0
aPaperSize(1,3)              = 0
nStart                       = 0
lAda=.F.

For i = 2 To nOccurs Step 2
    nStart                       = nStart + 1
    nLength                      = At(':',cString,i) - nStart
    cPaperNameWithSize           = Subs(cString,nStart,nLength)
    cPaper                       = 
Subs(cPaperNameWithSize,1,At(':',cPaperNameWithSize)-1)
    cSize                        = Subs(cPaperNameWithSize,  
At(':',cPaperNameWithSize)+1)
    nSizeX                       = 
Roun(Val(Subs(cSize,1,At(',',cSize)-1))/10,0)
    nSizeY                       = Roun(Val(Subs(cSize,  
At(',',cSize)+1))/10,0)
    nStart                       = At(':',cString,i)
    Dime aPaperSize(i/2,3)
    aPaperSize(i/2,1)            = cPaper && paper name
    aPaperSize(i/2,2)            = nSizeX && width
    aPaperSize(i/2,3)            = nSizeY && height
    If Upper(cPaper)==Upper(vNamaKertas) && Cek Nama Form yang akan kita 
bikin ada belum
        vNamaKertas=cPaper
        lAda=.T.
    Endif
Endf
lReturn=.t.
If !lAda
    _screen.AddObject('ObjPrint','AddPrinterForm')
    If Isnull(NamaPrinter) Or Type('NAMAPRINTER')<>"C" Or 
Len(Alltrim(NamaPrinter))=0
        _Screen.ObjPrint.DeleteForm(vNamaKertas)
        lReturn=_Screen.ObjPrint.AddForm(vNamaKertas,lebar,panjang)
    Else
        _Screen.ObjPrint.DeleteForm(vNamaKertas)
       
 lReturn=_screen..ObjPrint.AddForm(vNamaKertas,lebar,panjang,NamaPrinter)
    Endif
    _Screen..RemoveObject('OBjPrint')
Endif
if lReturn
  SetPaperName(cPrinterName,vNamaKertas)
  Set Printer To Default
  Set Printer To Name (cPrinterName)
endif
Return lReturn