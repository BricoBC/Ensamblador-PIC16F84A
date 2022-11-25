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
    VARIABLE equ H'0C'
 
    Programa:
	GOTO Inicio
;Port configuration area
;We configure all the portB as output and the portB as input
    Inicio:
	bsf STATUS, 5
	clrf TRISB
	movlw 11111111
	movf TRISA
	bcf STATUS, 5
;Section of the program to execute continuously (loop)
    Principal:
	movf PORTA, w
	movwf variable
	rrf variable, w
	rrf variable, variable
	clrf variable
	rlf variable
	xorwf variable, PORTB
	GOTO principal
	
	END Programa