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
    
    bsf STATUS,5
    clrf TRISB
    movlw 11111111B
    movwf TRISA
    bcf STATUS,5
    
    value EQU 0Ch    

    MAIN:
	movf PORTA,0
	movwf value
	btfss value,4
	goto DATOS
	goto COMPLEMENTO

    DATOS:
	movf value,0
	movwf PORTB
	goto MAIN

    COMPLEMENTO:
	bcf value,4
	comf value,1

	bcf value,5
	bcf value,6
	bcf value,7

	INCF value,1
	movf value,0
	movwf PORTB
	goto MAIN
    END Programa