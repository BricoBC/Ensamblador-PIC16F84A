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
;We configure all the portB as INPUT and portA as OUTPUT
    
PRINCIPAL:
    bsf STATUS, 5
    movlw 11111111B
    movf TRISB
    clrf TRISA
    bcf STATUS, 5
    
    compuerta equ 0CH
    value equ 0DH
 
MAIN:
    movf PORTB, w
    movwf value
    
    call LIMPIAR_BITS
    movf value, w
    movwf compuerta ;compuerta tendrá los primeros 4 bits para hacer la operación
    
    movf PORTB, w
    movwf value
    swapf value, 1
    call LIMPIAR_BITS
    movf value, w ;w tendrá los ultimos 4 bits para hacer la operación
    
    iorwf compuerta, w
    movwf PORTA
    NOP
    goto MAIN
    
LIMPIAR_BITS:
    BCF value, 4
    BCF value, 5
    BCF value, 6
    BCF value, 7
    
    return
    