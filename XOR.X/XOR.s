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
    variable equ 0Ch
 
    Program:
	GOTO Start
;Port configuration area
;We configure all the portB as output and the portA as input
    Start:
	bsf STATUS, 5
	clrf TRISB
	movlw 11111111
	movf TRISA
	bcf STATUS, 5
;Section of the program to execute continuously (loop)
    Main:
	movf PORTA, w; set value of PORTA to WORK
	movwf variable ;set value of WORK to VARIABLE
	rrf variable, w ;first bit set to WORK to do the operation.
	rrf variable 
	clrf variable
	rlf variable ;second bit set to VARIABLE to do the operation
	xorwf variable, 0 ;operation XORF with VARIABLE and WORK, the result is send to WORK
	movwf PORTB;the result is send to PORTB
	GOTO Main
	END Program