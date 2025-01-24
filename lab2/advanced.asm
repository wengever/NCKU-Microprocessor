List p=18f4520 ;???PIC18F4520
    ;???PIC18F
    #include<p18f4520.inc>
        CONFIG OSC = INTIO67
        CONFIG WDT = OFF
        org 0x00 ; ???0x00???????

	LFSR 0, 0x100 ; FSR0 point to 0x100
	LFSR 1, 0x100
	LFSR 2, 0x101
	
	MOVLW 0xFF
	MOVWF POSTINC0
	MOVLW 0xFE
	MOVWF POSTINC0
	MOVLW 0xFD
	MOVWF POSTINC0
	MOVLW 0xFC
	MOVWF POSTINC0
	MOVLW 0xFB
	MOVWF POSTINC0
	MOVLW 0xFA
	MOVWF POSTINC0
	MOVLW 0xF9
	MOVWF POSTINC0
	
	MOVLW 0x07 ; count loop_i
	MOVWF 0x000
	
	loop_i:
	    LFSR 1, 0x100
	    LFSR 2, 0x101 
	    MOVLW 0x06 ; count loop_j
	    MOVWF 0x001
	    DECFSZ 0x000
	    GOTO loop_j	    
	    GOTO quit
	    
	    loop_j:
		MOVF INDF1,W ; w = [0x100]
		CPFSGT INDF2 ; if [0x101] > [0x100], skip swap
		GOTO swap
		
		MOVFF POSTINC1, 0x003 ; [INDF1++]
		CLRF 0x003
		MOVFF POSTINC2, 0x003 ; [INDF2++]
		CLRF 0x003
		
		DECFSZ 0x001
		GOTO loop_j
		GOTO loop_i
	
	swap:
	    MOVFF INDF2,INDF1
	    MOVWF POSTINC2
	    MOVFF POSTINC1, 0x003 ; [INDF1++]
	    CLRF 0x003
	    DECFSZ 0x001
	    GOTO loop_j
	    GOTO loop_i
	
	quit:
	    end
	

;List p=18f4520
;    #include<p18f4520.inc>
;        CONFIG OSC = INTIO67
;        CONFIG WDT = OFF
;        org 0x00
;
;    MOVLW 0x08
;    MOVFF WREG, 0x100
;    MOVLW 0x7C
;    MOVFF WREG, 0x101
;    MOVLW 0x78
;    MOVFF WREG, 0x102
;    MOVLW 0xFE
;    MOVFF WREG, 0x103
;    MOVLW 0x34
;    MOVFF WREG, 0x104
;    MOVLW 0x7A
;    MOVFF WREG, 0x105
;    MOVLW 0x0D
;    MOVFF WREG, 0x106
;
;    MOVLW 0x06  ;do 6 times
;        MOVWF 0x00  ;[0x00] store index i
;
;    Loop0:
;        MOVFF 0x00, 0x01  ;[0x01] store index j
;        LFSR 0, 0x100 ; FSR0 point to [0x100]
;        LFSR 1, 0x101 ; FSR1 point to [0x101]
;
;        Loop1:
;        MOVFF INDF1, WREG  ;put the second pointer into W
;        CPFSLT INDF0  ;if FSR0 < FSR1(W) skip
;        GOTO Change  ;>=
;        GOTO Loop1End  ;<
;
;        Change:
;            MOVFF INDF0, INDF1
;            MOVFF WREG, INDF0
;
;        Loop1End:
;            MOVLW 0x00
;            ADDWF POSTINC0  ;FSR0 + W and pointer++
;            ADDWF POSTINC1  ;FSR1 + W and pointer++
;
;                    ;This method can also be used
;                    ;MOVLW 0x01
;            ;ADDWF FSR0L, F ;FSR0 + W
;            ;ADDWF FSR1L, F ;FSR1 + W
;
;
;            DECFSZ 0x01  ;j--
;            GOTO Loop1 
;
;        DECFSZ 0x00  ;i--
;        GOTO Loop0
;
;
;    end
