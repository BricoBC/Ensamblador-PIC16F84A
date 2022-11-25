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
    bcf STATUS, 5
    
    ;Function of microcontroller
Principal:
    movlw 1
    movwf   PORTB ; set 1 to PORTB
    
    i equ 0CH 
    j equ 0DH
    k equ 0EH
    
    
DerechaIzquierda: ;subrutine Derecha - Izquierda
    btfss PORTB, 7
    goto no ;Condition if is false
    goto IzquierdaDerecha ;Condition if is true
    
no:
    rlf PORTB
    call Delay
    goto DerechaIzquierda      
    
IzquierdaDerecha:
    btfss PORTB, 0
    goto NOU; Confition if is false
    goto DerechaIzquierda ;Condition if is true
    
NOU:
    rrf PORTB
    call Delay
    goto IzquierdaDerecha
    
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
    
    END Programa
    