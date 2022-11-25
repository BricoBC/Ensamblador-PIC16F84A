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
    cont1 equ 0Ch
    cont2 equ 0Dh
 
Program:
    GOTO Start
;Port configuration area
;We configure all the portB as output and the portA as input
Start:
    bsf STATUS, 5
    clrf TRISA
    bcf STATUS, 5
;Section of the program to execute continuously (loop)
Main:
    movlw 1
    movwf PORTA
    btfsc PORTA, 0
    Goto tiempo ;detalle del goto que acaba la instrucción de la subrutine y no regresa en donde se quedó.
    
    decf PORTA ;PORTA has value 0
    btfss PORTA, 0
    Goto tiempo
    Goto Main
    
tiempo: 
    movlw 11B
    movwf cont2
    ;The first formula is 2+(3*N)
firstTime:
    movlw 11B ; Example 3 times
    movwf cont1 ;The variable cont1 has the value 11 binary
SecNo:
    decfsz cont1, 1
    goto SecNo ;finish the first formula
    
    decfsz cont2,1
    goto firstTime
    
