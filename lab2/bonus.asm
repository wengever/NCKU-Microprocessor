List p=18f4520 ;???PIC18F4520
    ;???PIC18F
    #include<p18f4520.inc>
        CONFIG OSC = INTIO67
        CONFIG WDT = OFF
        org 0x00 ; ???0x00???????
	
	MOVLW 0x15
	MOVWF 0x000
	MOVLW 0x35
	MOVWF 0x001
	MOVLW 0x55
	MOVWF 0x002
	MOVLW 0x75
	MOVWF 0x003
	MOVLW 0x95
	MOVWF 0x004
	MOVLW 0xB5
	MOVWF 0x005
	MOVLW 0xD5
	MOVWF 0x006
	
	MOVLW 0x14 ; target
	MOVWF 0x007
	
	MOVLW 0x00 
	MOVWF 0x020 ; [0x020] store left index
	MOVLW 0x06 
	MOVWF 0x021 ; [0x021] store right index
	
	LFSR 0, 0x000 ; FSR0 point to 0x000
	
	loop:
	    MOVF 0x020,w ; WREG = left_index
	    ADDWF 0x021,w ; WREG = left_index + right_index
	    MOVFF WREG,0x022 ; [0x022] = WREG
	    RRCF 0x022 ; (L + R) / 2 , the rightest will be thrown away
	
	    MOVF 0x022,w ; WREG = mid_index
	    MOVFF PLUSW0, 0x024 ; [0x024] = mid_value
	    	    
	    MOVF 0x020,w
	    CPFSGT 0x021 ; if right > left, skip
	    GOTO not_found_ornot ; right <= left
	    
	    MOVF 0x024,w ; WREG = mid_value
	    CPFSGT 0x007 ; if tartget > mid_value, skip 
	    GOTO not_greater
	    GOTO greater
	
	greater:
	    MOVLW 0x01 ; WREG = 1
	    ADDWF 0x022,w ; mid_index++
	    MOVWF 0x020 ; left_index update
	    GOTO loop
	
	not_greater:
	    CPFSEQ 0x007 ; if target = mid_value, skip
	    GOTO less
	    GOTO equal
	    
	less:
	    MOVLW 0x01 ; WREG = 1
	    SUBWF 0x022,w ; mid_index--
	    MOVWF 0x021 ; right_index update
	    GOTO loop
	    
	equal:
	    MOVLW 0xFF
	    MOVWF 0x011
	    GOTO quit
	
	not_found_ornot:
	    MOVLW 0x00 ; predict not found
	    MOVWF 0x011
	    
	    MOVF 0x07,w
	    CPFSEQ 0x024 ; check not_found_ornot, found goto equal
	    GOTO quit
	    GOTO equal
	    
	quit:	
	    end
	





