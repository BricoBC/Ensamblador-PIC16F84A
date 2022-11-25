#include <xc.inc>

;The 8 LED will light up periodically one by one
PROCESSOR 16F84A
    
;General configuration area
    
CONFIG FOSC = XT
CONFIG WDTE = OFF
CONFIG PWRTE = OFF
CONFIG CP = OFF
    
;Code section definition
PSECT Programa, class = CODE, delta = 2, abs
ORG 00h
Programa:
    GOTO Inicio

;Port configuration area
;We configure all the portB as output
Inicio:
    bsf STATUS, 5
    clrf TRISB
    movlw 11111111
    movf TRISA
    bcf STATUS, 5
    
    ;Function of microcontroller
Principal:
    btfss PORTA, 0
    goto SI
    goto NO   
SI:
    bcf PORTB, 0
    goto Principal
NO:
    bsf PORTB, 0
    goto Principal
    

