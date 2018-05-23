
LPARAMETERS ntc
LOCAL ctk
nlen = LEN(ALLTRIM(ntc))
DO CASE 
	CASE nlen = 6 
		ctk = ntc
	CASE nlen = 12
		ctk = LEFT(ntc,6)+','+SUBSTR(ntc,7,6)
	CASE nlen = 18
		ctk = LEFT(ntc,6)+','+SUBSTR(ntc,7,6)+','+SUBSTR(ntc,13,6)
	CASE nlen = 24
		ctk = LEFT(ntc,6)+','+SUBSTR(ntc,7,6)+','+SUBSTR(ntc,13,6)+','+SUBSTR(ntc,19,6)
	CASE NLEN = 30
		CTK = LEFT(ntc,6)+','+SUBSTR(ntc,7,6)+','+SUBSTR(ntc,13,6)+','+SUBSTR(ntc,19,6)+','+SUBSTR(ntc,25,6)
	CASE NLEN = 36
		CTK = LEFT(ntc,6)+','+SUBSTR(ntc,7,6)+','+SUBSTR(ntc,13,6)+','+SUBSTR(ntc,19,6)+','+SUBSTR(ntc,25,6)+','+SUBSTR(ntc,31,6)
	OTHERWISE
		ctk = ntc	
ENDCASE 
RETURN ctk
	
	