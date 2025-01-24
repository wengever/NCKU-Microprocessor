List p=18f4520 ;???PIC18F4520
    ;???PIC18F
    #include<p18f4520.inc>
        CONFIG OSC = INTIO67
        CONFIG WDT = OFF
        org 0x00 ; ???0x00???????
	
	intial:
	CLRF 0x00
	CLRF 0x01
	MOVLW 0x00 
	MOVWF 0x10 ;num1 high
	MOVLW 0x00
	MOVWF 0x11 ;num1 low
	MOVLW 0x00
	MOVWF 0x12 ; num2 high
	MOVLW 0X01
	MOVWF 0x13 ; num2 low
	
	MOVLW 0x03 ; count down 
	MOVWF 0x20
	
	MOVLW 0x01
	CPFSGT 0x20 ; 0x20 > 0x01,skip
	GOTO stop
	rcall fib
	GOTO quit
	
	stop:
	    MOVLW 0x00
	    CPFSGT 0x20
	    GOTO quit
	    MOVLW 0x01
	    MOVWF 0x01
	    GOTO quit
	fib:
	    ; add to answer
	    MOVFF 0x13,WREG 
	    ADDWF 0x01
	    BTFSC STATUS, C
	    INCF 0x00 ; overflow,[0x00]++
	    MOVFF 0x12,WREG
	    ADDWF 0x00
	    
	    ;add n1 to n2
	    MOVFF 0x11,WREG
	    ADDWF 0x13
	    BTFSC STATUS, C
	    INCF 0x12
	    MOVFF 0x10,WREG
	    ADDWF 0x12
	    
	    ;swap
	    MOVFF 0x11,WREG
	    MOVFF 0x13,0x11
	    MOVFF WREG,0x13
	    
	    MOVFF 0x10,WREG
	    MOVFF 0x12,0x10
	    MOVFF WREG,0x12	    
	    
	    ;check 
	    DECFSZ 0x20
	    GOTO fib
	    RETURN
	quit:
	    end
	


