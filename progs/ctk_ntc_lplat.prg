LPARAMETERS ntc
LOCAL ctk
nlen = LEN(ALLTRIM(ntc))
DO CASE 
	
	CASE nlen = 5
		ctk = ntc
	CASE nlen = 10
		ctk = LEFT(ntc,5)+','+SUBSTR(ntc,6,5)
	CASE nlen = 15
		ctk = LEFT(ntc,5)+','+SUBSTR(ntc,6,5)+','+SUBSTR(ntc,11,5)
	CASE nlen = 20
		ctk = LEFT(ntc,5)+','+SUBSTR(ntc,6,5)+','+SUBSTR(ntc,11,5)+','+SUBSTR(ntc,16,5)
	CASE nlen = 25
		ctk = LEFT(ntc,5)+','+SUBSTR(ntc,6,5)+','+SUBSTR(ntc,11,5)+','+SUBSTR(ntc,16,5)+','+SUBSTR(ntc,21,5)
	CASE nlen = 30
		ctk = LEFT(ntc,5)+','+SUBSTR(ntc,6,5)+','+SUBSTR(ntc,11,5)+','+SUBSTR(ntc,16,5)+','+SUBSTR(ntc,21,5)+','+SUBSTR(ntc,26,5)
	OTHERWISE
		ctk = ntc
ENDCASE 
RETURN ctk
	
	