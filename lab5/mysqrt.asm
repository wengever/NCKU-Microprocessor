#include "xc.inc"
GLOBAL _mysqrt
PSECT mytext,local,class=CODE,reloc=2
    
_mysqrt:
    initial:
	MOVLW 0x01
	MOVWF 0x010
	
    loop:
	MOVFF 0x010,WREG ; n
	MULWF 0x010
	MOVFF PRODL,WREG
	CPFSGT 0x002 ; if a > n*n, skip
	    GOTO solve
	MOVLW 0x10 ; wreg = 16
	CPFSLT 0x010 
	    GOTO solve
	INCF 0x010
	GOTO loop

    solve:
	MOVFF 0x010,WREG
   
    RETURN



    




