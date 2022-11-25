#include <xc.inc>      
    PROCESSOR 16F84A 
    CONFIG FOSC=XT 
    CONFIG WDTE=OFF 
    CONFIG PWRTE=OFF 
    CONFIG CP=OFF 
   
    PSECT Programa,class=CODE,delta=2,abs 
    ORG 00h
    
Programa: 
    GOTO INICIO 
INICIO: 

    bsf STATUS,5 
    MOVLW 11111111B
    MOVWF TRISA 
    clrf TRISB  
    bcf STATUS,5 
    
    count equ 0CH 
    i equ 0DH
    mover equ 0EH
    
    vida_indio equ 1CH
    vida_vaquero equ 1DH
 
 
PLAY:;-------------------FUNCIÓN PLAY
    MOVLW 4
    MOVWF count ;Count = 4
    
WHILE_PLAY:
    BTFSS STATUS, 2 ;if Z=1
    GOTO PLAY ;SECUENCIA_INICIO
    MOVLW 00001001B
    MOVWF PORTB
    MOVLW 00000110B
    MOVWF PORTB
    
    DECF count, 1
    GOTO WHILE_PLAY
    
