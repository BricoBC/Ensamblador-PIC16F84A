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
    i equ 0Ch
    support equ 0Dh
 
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
    btfss  PORTA, 4
    goto pass_date
    btfss PORTA, 3
    goto complement
    goto pass_date

pass_date:
    movf PORTA, w
    movwf PORTB
    goto Main
    
complement:
    movlw 0001B
    movwf support
    movlw 0
    movwf i
while:
    btfss PORTA, i
    goto no
    goto si
      
no:
    incf i
    rlf support
    goto while
 
si: 
    movf PORTA, w
    addlw support
    addlw support
    movwf PORTB
    goto Main
    

    