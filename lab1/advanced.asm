List p=18f4520 ;???PIC18F4520
    ;???PIC18F
    #include<p18f4520.inc>
        CONFIG OSC = INTIO67
        CONFIG WDT = OFF
        org 0x00 ; ???0x00???????

	MOVLW 0XF7 ; a_value
	MOVWF 0x000	
	MOVLW 0X9F ; b_value	
	MOVWF 0x001
	
	MOVF 0x000, W ; store a_value in wr
	ANDLW b'11110000' ; wr and 0xf0
	MOVWF 0x002
	
	MOVF 0x001, W ; store b_value in wr 
	ANDLW b'00001111' ; wr and 0x0f
	IORWF 0x002, F ; combine
	
	initial: 
	    MOVLW 0x08 ; count_down ??8?
	    MOVWF 0x005
	    CLRF 0x003  
	    MOVF 0x002, W ; store combine in wr
	    MOVWF 0x004 ;  store wr in 0x004
	count_down:
	    RRNCF 0x004
	    BTFSS 0X004,0 ; check 0 bit is 1 or not, if 1, skip
	    INCF 0x003
	    DECFSZ 0x005
	    GOTO count_down   
	CLRF 0X004
	end


