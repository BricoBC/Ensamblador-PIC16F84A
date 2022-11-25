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
    movlw 11111111B
    movf TRISA
    clrf TRISB
    bcf STATUS, 5
    
    count equ 0CH 
    i equ 0DH
    mover equ 0EH
    
    vida_indio equ 1CH
    vida_vaquero equ 1DH
 
 
PLAY:;-------------------FUNCIÓN PLAY
    MOVLW 0
    MOVWF PORTB
    BCF STATUS, 2;Limpia el registro status bit 2
    
    MOVLW 4
    MOVWF count ;Count = 4
    
WHILE_PLAY:
    BTFSC STATUS, 2 ;if Z=0
    GOTO SECUENCIA_INICIO ;SECUENCIA_INICIO Condition if is FALSE
    CLRF PORTB
    BSF PORTB, 4
    BSF PORTB, 7
    BSF PORTB, 5
    BSF PORTB, 6
    
    DECF count, 1
    GOTO WHILE_PLAY
    
SECUENCIA_INICIO:;---------------------------------------------función secuencia de inicio
    BCF STATUS, 2;Limpia el registro status bit 2
    MOVLW 3
    MOVWF count ;Count = 3
    
WHILE_SEQ:
    BTFSC STATUS, 2
    GOTO BOTON
    BSF PORTB, 0
    BSF PORTB, 3
    BCF PORTB, 0
    BCF PORTB, 3
    
    BSF PORTB, 1
    BSF PORTB, 2
    BCF PORTB, 1
    BCF PORTB, 2
    
    DECF count, 1
    GOTO WHILE_SEQ
    
BOTON:
    BCF STATUS, 2
    
    BTFSC PORTA, 0
    GOTO PLAY
    BTFSC PORTA, 1
    GOTO BOTON_DISPARO_V
    
    BTFSC PORTA, 2
    GOTO BOTON_DISPARO_I
    
     GOTO PLAY
    
BOTON_DISPARO_V:;---------------------------------------------función disparo de vaquero
    MOVLW 2
    MOVWF vida_vaquero ; vida_vaquero = 2
    
    BSF PORTB, 3
    BSF PORTB, 2
    BSF PORTB, 1
    BSF PORTB, 0
    
    MOVLW 5
    MOVWF count ;Count = 5

ULTIMA_BALA_V:
    
    BTFSC STATUS, 2
    GOTO I_SIN_VIDA
    DECF count, 1
    BCF PORTB, 0
    BSF PORTB, 0
    GOTO ULTIMA_BALA_V
    
V_SIN_VIDA:
    DECF vida_vaquero, 1
    
    BTFSS vida_vaquero, 0
    BCF PORTB, 5
    BCF PORTB, 4
    GOTO SECUENCIA_INICIO
    
BOTON_DISPARO_I:;---------------------------------------------función disparo de indio
    MOVLW 2
    MOVWF vida_indio ; vida_vaquero = 2
    
    BSF PORTB, 0
    BSF PORTB, 1
    BSF PORTB, 2
    BSF PORTB, 3
    
    MOVLW 5
    MOVWF count ;Count = 5

ULTIMA_BALA_I:
    
    BTFSC STATUS, 2
    GOTO V_SIN_VIDA
    DECF count, 1
    BCF PORTB, 3
    BSF PORTB, 3
    GOTO ULTIMA_BALA_I
    
I_SIN_VIDA:
    DECF vida_indio, 1
    
    BTFSS vida_indio, 0
    BCF PORTB, 7
    BCF PORTB, 6
    GOTO SECUENCIA_INICIO
