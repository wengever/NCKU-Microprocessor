List p=18f4520 ;???PIC18F4520
    ;???PIC18F
    #include<p18f4520.inc>
        CONFIG OSC = INTIO67
        CONFIG WDT = OFF
        org 0x00 ; ???0x00???????
	
	MOVLW 0x1F ; a_value
	MOVWF 0x000	
	MOVLW 0x01 ; b_value	
	MOVWF 0x001
	
	MOVF 0x000,W ; put a_value in wr
	ADDWF 0x001,W ; add b_value to wr
	MOVWF 0x002 ; put wr in 0x002
	
	MOVLW 0x7F ; c_value
	MOVWF 0x010
	MOVLW 0x6F ; d_value
	MOVWF 0x011
	
	MOVF 0x011, W  ; put d_value in wr
	SUBWF 0x010, W ; c_value - d_value
	MOVWF 0x012
	
	MOVF 0x012, W ; A2
	CPFSEQ 0x002 ; if A1 == A2
	GOTO not_equal

	MOVLW 0xBB  
	MOVWF 0x020
	GOTO quit

	not_equal:
	    CPFSGT 0x002 ; if A1 > A2
	    GOTO less
	    MOVLW 0xAA ; A1 == A2
	    MOVWF 0x020
	    GOTO quit

	less:
	    MOVLW 0xCC ; A1 < A2
	    MOVWF 0x020

	quit:
	    end
	


