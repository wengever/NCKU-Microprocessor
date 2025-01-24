#include "xc.inc"
GLOBAL _gcd
PSECT mytext,local,class=CODE,reloc=2

_gcd:
    initial:
	MOVFF 0x02,WREG
	CPFSEQ 0x04
	GOTO high_solve
	GOTO compare
    high_solve:
	MOVFF 0x02,WREG
	CPFSGT 0x04
	GOTO a_high
	GOTO b_high
    a_high:
	MOVFF 0x03,WREG
	SUBWF 0x01
	MOVFF 0x04,WREG
	SUBWFB 0x02,f
	GOTO initial
    b_high:
	MOVFF 0x01,WREG
	SUBWF 0x03
	MOVFF 0x02,WREG
	SUBWFB 0x04,f
	GOTO initial
	
    low_solve:
	CPFSGT 0x03
	GOTO a_low
	GOTO b_low
    
    a_low:
	MOVFF 0x03,WREG
	SUBWF 0x01
	MOVFF 0x04,WREG
	SUBWFB 0x02,f
	GOTO initial
    b_low:
	MOVFF 0x01,WREG
	SUBWF 0x03
	MOVFF 0x02,WREG
	SUBWFB 0x04,f
	GOTO initial
    
    compare:
	MOVFF 0x01,WREG
	CPFSEQ 0x03
	GOTO low_solve

    RETURN

