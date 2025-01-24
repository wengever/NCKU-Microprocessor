List p=18f4520 ;???PIC18F4520
    ;???PIC18F
    #include<p18f4520.inc>
        CONFIG OSC = INTIO67
        CONFIG WDT = OFF
        org 0x00 ; ???0x00???????

	Sub_Mul macro xh, xl, yh, yl
	    MOVLW xh
	    MOVWF 0x20
	    MOVLW xl
	    MOVWF 0x21
	    MOVLW yh
	    MOVWF 0x22
	    MOVLW yl
	    MOVWF 0x23
	    
	    MOVFF 0x23,WREG
	    SUBWF 0x21
	    MOVFF 0x21,0x01
	    
	    MOVFF 0x20,WREG
	    SUBFWB 0x22,WREG
	    MOVFF WREG,0x00
	    
	    multiplication:
		MOVFF 0x00,WREG
		MULWF 0x01
		CLRF 0x10
		CLRF 0x11
		MOVFF PRODH,WREG
		ADDWF 0x10,f ; [0x10] = [0x10] + PRODH
		MOVFF PRODL,WREG
		ADDWF 0x11,f ; [0x11] = [0x11] + PRODL
	    endm
	
	Sub_Mul 0xff, 0x07, 0x0a, 0x05
	
	quit:
	    end


