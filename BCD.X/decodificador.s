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
    clrf TRISA
    bcf STATUS, 5
    i equ 0CH
    j equ 0DH
    k equ 0EH
 
    count equ 1CH
 
MAIN:
    movlw 0
    movwf count
    
Preguntar:
    addwf PCL, 1
    
    goto Cero
    goto Uno
    goto Dos
    goto Tres
    goto Cuatro
    goto Cinco
    goto Seis
    goto Siete
    goto Ocho
    goto Nueve
    
Sumar:
    incf count
    movf count, w
    goto Preguntar
 
Cero: 
    clrf PORTA
    call Delay
    goto Sumar
    
Uno:
    movlw 0001B
    movwf PORTA
    call Delay
    goto Sumar
Dos:
    movlw 0010B
    movwf PORTA
    call Delay
    goto Sumar
Tres:
    movlw 0011B
    movwf PORTA
    call Delay
    goto Sumar
Cuatro:
    movlw 0100B
    movwf PORTA
    call Delay
    goto Sumar
Cinco:
    movlw 0101B
    movwf PORTA
    call Delay
    goto Sumar
Seis:
    movlw 0110B
    movwf PORTA
    call Delay
    goto Sumar
Siete:
    movlw 0111B
    movwf PORTA
    call Delay
    goto Sumar
Ocho:
    movlw 1000B
    movwf PORTA
    call Delay
    goto Sumar
Nueve:
    movlw 1001B
    movwf PORTA
    call Delay
    
    clrf count
    movf count, w
    goto Preguntar
    
Delay:
    movlw 00000010B
    movwf k
    
    Dec03:
    movlw 11111111B
    movwf j
    
    Dec02:
    movlw 11111111B
    movwf i
    
    Dec01:
    decfsz i, 1
    goto Dec01
    
    decfsz j, 1
    goto Dec02
    
    decfsz k, 1
    goto Dec03
    
    return
    
    