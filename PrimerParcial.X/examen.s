#include <xc.inc>

    PROCESSOR 16F84A
    
;Zona de configuración general.
    CONFIG FOSC = XT
    CONFIG WDTE = OFF
    CONFIG PWRTE = OFF
    CONFIG CP = OFF
    
;Variables
    change equ 0Ch
    
;Definición de la sección del código
    PSECT Programa, class = CODE, delta = 2, abs
    ORG 00h
    
    palabra1 equ 0CH
    palabra2 equ 0DH
 
    p1 equ 1CH
    p2 equ 1DH
    
    Programa:
    GOTO INICIO
    
;Zona de configuración de los puertos.
;Configuramos todos el puerto B como salida y el puerto A como entrada
    INICIO:
	bsf STATUS,5
	clrf TRISA	
	movlw 11111111B
	movwf TRISB
	bcf STATUS, 5	
	
;Zona del diagrama de flujo
    Principal:
	movf PORTB, w
	movwf palabra1
	bcf palabra1,7
	bcf palabra1,6
	bcf palabra1,5
	bcf palabra1,4 
	movf palabra1, w
	movwf p1
	;palabra 1 ya tiene los primeros 4 valores
	
	movf PORTB, w
	movwf p2
	movwf palabra2
	swapf palabra2, 1
	bcf palabra2,7
	bcf palabra2,6
	bcf palabra2,5
	bcf palabra2,4
	movf palabra2, w
	movwf p2
	;palabra 2 ya tiene los primeros 4 valores
	
	goto MAYOR
	
    MAYOR:
	decf palabra1, 1 ; palabra 1--
	BTFSC STATUS, 2 ;if z=0
	goto palabraDos; false
	;pregunto si palabra 1 llega a 0, si es asi que se vaya a imprimir esos bits sino que reste uno.
	
	decf palabra2, 1; true
	btfsc STATUS, 2;if z=0
	goto palabraUno;false
	goto MAYOR;true
	;pregunto si palabra 2 llega a 0, si es asi que se vaya a imprimir esos bits sino que reste uno.
    
    palabraDos:
	movf p2, w
	movwf PORTA
	GOTO Principal
	
    palabraUno:
	movf p1, w
	movwf PORTA
	Goto Principal
    
