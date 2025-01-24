#include <xc.h>
#include <pic18f4520.h>
#include <stdio.h>

#pragma config OSC = INTIO67 // Oscillator Selection bits
#pragma config WDT = OFF     // Watchdog Timer Enable bit
#pragma config PWRT = OFF    // Power-up Enable bit
#pragma config BOREN = ON    // Brown-out Reset Enable bit
#pragma config PBADEN = OFF  // Watchdog Timer Enable bit
#pragma config LVP = OFF     // Low Voltage (single -supply) In-Circute Serial Pragramming Enable bit
#pragma config CPD = OFF     // Data EEPROM?Memory Code Protection bit (Data EEPROM code protection off)
#define _XTAL_FREQ 1000000   // clock frequence 1MHZ

const int ID[] = {7, 4, 1, 1, 1, 3, 0, 6};

void __interrupt(high_priority)H_ISR(){
    
    //step4
    int value = (ADRESH << 2) + (ADRESL>>6);
    
    
    //do things
    LATC = ID[value / 128]; // (2^10 / 8) = 128
    
    //clear flag bit
    PIR1bits.ADIF = 0;
    
    
    //step5 & go back step3  
    __delay_us(5);     // delay at least 2tad
    ADCON0bits.GO = 1;
    
    
    return;
}

void main(void) 
{
    //configure OSC and port
    OSCCONbits.IRCF = 0b100; //1MHz
    TRISAbits.RA0 = 1;       // Set RA0 as input port
    
    // Set RB0, RB1, RB2, RB3 as digital output for the LEDs
    TRISC = 0;  // Set PORTB as output
    LATC = 0;   // Clear PORTB data latch
    
    //step1
    ADCON1bits.VCFG0 = 0;     //Vref+ Vdd(5v)
    ADCON1bits.VCFG1 = 0;     //Vref- Vss(0v)
    ADCON1bits.PCFG = 0b1110; //AN0 is analog input,else are digital
    ADCON0bits.CHS = 0b0000;  //choose AN0 as ADC input channel
    ADCON2bits.ADCS = 0b000;  // ADC clock Fosc/2
    ADCON2bits.ACQT = 0b001;  //Tad = 2 us acquisition time ,set 2Tad = 4 > 2.4
    ADCON0bits.ADON = 1;    // activate ADC module
    ADCON2bits.ADFM = 0;    //left justified 
    
    
    //step2
    PIE1bits.ADIE = 1;    // Enable ADC interrupt
    PIR1bits.ADIF = 0;    // Clear ADC interrupt flag
    INTCONbits.PEIE = 1;  // Enable peripheral interrupts
    INTCONbits.GIE = 1;   // Enable global interrupts


    //step3
    ADCON0bits.GO = 1;       // start fisrt ADC conversion
    
    while(1);
    
    return;
}
