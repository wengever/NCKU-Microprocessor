List p=18f4520 ;???PIC18F4520
    ;???PIC18F
    #include<p18f4520.inc>
        CONFIG OSC = INTIO67
        CONFIG WDT = OFF
        org 0x00 ; ???0x00???????
	
	MOVLW 0xFF
	MOVWF 0x00
	MOVLW 0xF1
	MOVWF 0x01 ; input
	
	MOVLW 0x0F ; 15 times count down
	MOVWF 0x03
	
	MOVLW 0x07 ; 7 times
	
	
	loopi:
	    BTFSC 0x00,7 ; check the left bit is 0 or not, skip if yes
	    GOTO check1
	    RLNCF 0x00
	    BCF 0x00,0
	    DECF 0x03
	    CPFSEQ 0x03 
	    GOTO loopi
	    
	loopj:
	    BTFSC 0x01,7
	    GOTO check2
	    RLNCF 0x01
	    BCF 0x01,0
	    DECF 0x03
	    GOTO loopj
	    GOTO check2
	
	check1:
	    BCF 0x01,7 ; check 0x00 and 0x01
	    MOVLW 0x00
	    MOVFF 0x03,0x02 ; ans
	    CPFSEQ 0x00 ; check if 0
	    GOTO plus
	    CPFSEQ 0x01 ; check if 0
	    GOTO plus
	    GOTO quit
	    
	check2:
	    BCF 0x01,7 ; check 0x01
	    MOVLW 0x00
	    MOVFF 0x03,0x02
	    CPFSGT 0x01
	    GOTO quit
	    GOTO plus
	plus:
	    INCF 0x02 
	quit:
	    end
	    
	    
	    
	


