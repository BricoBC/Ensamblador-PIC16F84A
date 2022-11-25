#include <xc.inc>

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
	clrf TRISA
	movlw 11111111
	movf TRISB
	bcf STATUS, 5
;Section of the program to execute continuously (loop)
    Principal:
	movf	PORTA, 0
	movwf	PORTB
	
	END Programa