oSoap = CREATE('wwSoap')
oSoap.cServerUrl = 'http://192.168.0.202/wsfox/server.soap'  && Any SOAP url

oSoap.AddParameter('nopol','DE1114AE')

*** Create SOAP request XML
lcRequest = oSoap.CreateSoapRequestXML('getDataNopol')

MESSAGEBOX(osoap.cRequestXML)  && lcRequest

*** Call the server with Soap Request
lcResponse = oSoap.CallSoapServer()
IF oSoap.lError
   MESSAGEBOX(oSoap.cResponseXML,48,'ERror')
   RETURN
ENDIF   
   
MESSAGEBOX(lcResponse)  && oSoap.cResponseXML

lvResult = oSoap.ParseSoapResponse(lcResponse)
? lvResult
? VARTYPE(lvResult)

*** Retrieve multiple IN/OUT parameters if any
FOR x=2 to  oSoap.nReturnValueCount
  ? oSoap.aReturnValues[x,2]
ENDFOR
