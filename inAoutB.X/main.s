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
    GOTO PRINCIPAL

;Port configuration area
;We configure all the portB as output
PRINCIPAL:
    bsf STATUS, 5
    movlw 11111111B
    movf TRISA
    clrf TRISB
    bcf STATUS, 5
  
Main:
    movf PORTA, w
    movwf PORTB
    goto Main