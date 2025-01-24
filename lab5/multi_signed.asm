#include "xc.inc"
GLOBAL _multi_signed
PSECT mytext,local,class=CODE,reloc=2

_multi_signed:
    a_initial:
	BTFSC 0x03,7 ; check is negative or not
	GOTO a_reverse
	
    b_initial:
	BTFSC 0x04,7 ; check is negative or not
	GOTO b_reverse
	GOTO before_mul
	
    a_reverse:
	MOVLW 0x01
	MOVWF 0x05 ; [0x05]=1
 	NEGF 0x03
	GOTO b_initial
	
    b_reverse:
	MOVLW 0x01
	MOVWF 0x06 ; [0x06]=1
	NEGF 0x04
	
    before_mul:
	CLRF 0x00
	CLRF 0x01
	MOVLW 0x00
	MOVWF 0x10 ; make multiplicand 16 bits
	MOVLW 0x08
	MOVWF 0x20 ; countdown
    
    multiplex:
	BTFSS 0x04,0 ; test multiplier 0 bit is 1 or not
        GOTO skip
	MOVFF 0x03,WREG
	ADDWF 0x01

	MOVFF 0x10,WREG
	ADDWFC 0x02
    skip:
	RLCF 0x03
	RLCF 0x10
	CLRF STATUS,C
	RRNCF 0x04

	DECFSZ 0x20
	GOTO multiplex
	
    check:
	MOVFF 0x05, WREG
	ADDWF 0x06
	MOVLW 0x01
	CPFSEQ 0x06
	GOTO exit
	
	MOVLW 0xFF ; 2'scomplement
	XORWF 0x01
	XORWF 0x02
	INCF 0x01
	MOVLW 0x00
	ADDWFC 0x02
    exit:
	RETURN
    


