List p=18f4520 ;???PIC18F4520
    ;???PIC18F
    #include<p18f4520.inc>
        CONFIG OSC = INTIO67
        CONFIG WDT = OFF
        org 0x00 ; ???0x00???????
	
	LFSR 0, 0x100 ; FSR0 point to 0x100
	LFSR 1, 0x116 ; FSR1 point to 0x116
	
	MOVLW 0x01
	MOVWF INDF0 ; [0x100] = 0x00
	MOVLW 0x00
	MOVWF INDF1 ; [0x116] = 0x01
	
	MOVLW 0x06 ; execute 6 times
	MOVWF 0x000
	
	LOOP:
	    MOVF POSTINC0,W ; w = [0x100], FSR0 point to 0x101
	    ADDWF INDF1, W ; w = [0x116]+[0x100]
	    MOVWF INDF0 ; [0x101] = w

	    MOVF POSTDEC1,W ; w = [0x116], FSR1 point to 0x115
	    ADDWF INDF0,W ; w = [0x101]+[0x116]
	    MOVWF INDF1 ; [0x115] = w
	    
	    DECFSZ 0x000
	    GOTO LOOP
		
	end


