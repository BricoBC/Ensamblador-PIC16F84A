#include <xc.inc>

PROCESSOR 16F84A
    
CONFIG FOSC = XT
CONFIG WDTE = OFF
CONFIG PWRTE = OFF
CONFIG CP = OFF
    
PSECT Programa, class = CODE, delta = 2, abs
ORG 00h
Programa:
    GOTO PRINCIPAL

;Port configuration area
;We configure all the portB and  as output
;portA
PRINCIPAL:
    bsf STATUS, 5
    clrf TRISA
    movlw 10111B
    bcf STATUS, 5
    
    p1_live equ 0CH
    p2_live equ 0DH
    button1 equ 1CH
    button2 equ 1DH
 
 
PLAY:;-------------------FUNCIÓN PLAY
    movlw 1B
    movf PORTB
    
    END Programa