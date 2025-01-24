List p=18f4520 ;???PIC18F4520
    ;???PIC18F
    #include<p18f4520.inc>
        CONFIG OSC = INTIO67
        CONFIG WDT = OFF
        org 0x00 ; ???0x00???????
	
	MOVLW 0xC8 ;input
	MOVFF WREG,TRISA
	
	BCF TRISA,7
	RLNCF TRISA ; logic rotate left
	
	BCF TRISA,0 ; arithmetic rotate right
	RRNCF TRISA
	BTFSC TRISA,6 ; check the 6 bit is 0 or not, skip if yes
	BSF TRISA,7

	end





