List p=18f4520 ;???PIC18F4520
    ;???PIC18F
    #include<p18f4520.inc>
        CONFIG OSC = INTIO67
        CONFIG WDT = OFF
        org 0x00 ; ???0x00???????
	
	MOVLW 0Xcc ; a_value
	MOVWF 0x000	
	MOVLW 0x01 ; b_value	
	MOVWF 0x010
	
	initial:
	    MOVLW 0xcc ; keep original a_value
	    MOVWF 0x001
	    
	loop:
	    MOVFF 0x001,0x011 ; 
	    BTFSS 0x000, 0 ; the 0 bit is 1 or not
	    GOTO check4
	    DECF 0x010
	    RRNCF 0x000
	    MOVF 0x000, w
	    XORWF 0X011,f
	    TSTFSZ 0x0011
	    GOTO loop	
	GOTO quit
	    
	check4:
	    BTFSS 0x000, 1 ; the 1 bit is 1 or not
	    INCF 0x010
	    INCF 0x010
	    RRNCF 0x000
	    MOVF 0x000, w
	    XORWF 0X011,f
	    TSTFSZ 0x0011
	    GOTO loop
	quit:
	    CLRF 0x001
	    CLRF 0x011
	    end
	
    
	    
	    
	    




