List p=18f4520 ;???PIC18F4520
    ;???PIC18F
    #include<p18f4520.inc>
        CONFIG OSC = INTIO67
        CONFIG WDT = OFF
        org 0x00 ; ???0x00???????
	
	MOVLW 0x01
	MOVWF 0x00 ;a1
	MOVLW 0x03
	MOVWF 0x01 ;a2
	MOVLW 0x06
	MOVWF 0x02 ;a3
	MOVLW 0x02
	MOVWF 0x10 ;b1
	MOVLW 0x03
	MOVWF 0x11 ;b2
	MOVLW 0x05
	MOVWF 0x12 ;b3
	rcall cross
	GOTO quit
	
	cross:
	    MOVFF 0x01,WREG
	    MULWF 0x12 ; a2*b3
	    MOVFF PRODL,0x20 
	    MOVFF 0x02,WREG
	    MULWF 0x11 ; a3*b2
	    MOVFF PRODL,WREG 
	    SUBWF 0x20 
	    
	    MOVFF 0x02,WREG
	    MULWF 0x10 ; a3*b1
	    MOVFF PRODL,0x21
	    MOVFF 0x00,WREG
	    MULWF 0x12 ; a1*b3
	    MOVFF PRODL,WREG
	    SUBWF 0x21
	    
	    MOVFF 0x00,WREG
	    MULWF 0x11 ; a1*b2
	    MOVFF PRODL,0x22
	    MOVFF 0x01,WREG
	    MULWF 0x10 ; a2*b1
	    MOVFF PRODL,WREG
	    SUBWF 0x22
	    
	    RETURN
	    
	    
	quit:
	    end




