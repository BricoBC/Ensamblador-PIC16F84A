;El programa consiste en la suma de dos números que tiene dos bits cada uno e indica si el resultado es positivo, negativo o neutro.
;Considerando que la resta es n1-n2
    #include <xc.inc> 
    PROCESSOR 16F84A 
     
    CONFIG FOSC=XT 
    CONFIG WDTE=OFF 
    CONFIG PWRTE=OFF 
    CONFIG CP=OFF 
     
    n1 EQU 0Ch    ;number one
    n2 EQU 0Dh    ;number two
    r EQU 0Eh    ;resultado
    k EQU 11h
    j EQU 12h
    i EQU 13h
   
    PSECT Programa, class=CODE,delta=2, abs 
    ORG 00h 
     
    Programa: 
    GOTO INICIO 
 
    INICIO:  ;Entradas_Salidas 
    bsf STATUS,5 
    movlw 11111B 
    movwf TRISA 
    clrf TRISB 
    bcf STATUS,5 
    
    MAIN:
    clrf PORTB
    clrf n1
    clrf n2
    clrf r
    call numberOne
    call numberTwo
    subwf r, 1
    btfss STATUS, 2
    goto nose
    goto Empate
    
    numberOne:
    movf PORTA, W
    movwf n1
    bcf n1, 2
    bcf n1, 3
    bcf n1, 4 
    movf n1, w
    movwf r
    return
    
    numberTwo:
    movf PORTA, W
    movwf n2
    bcf n2, 0
    bcf n2, 1
    bcf n2, 4  
    rrf n2
    rrf n2
    movf n2, w
    return
    
    nose:
    btfss STATUS, 0
    goto Negativo
    goto Positivo
    
    
    
    Empate:
    clrf PORTB
    call Delay
    goto Programa
    
    Negativo:
    clrf PORTB
    bsf PORTB, 0
    bsf PORTB, 1
    bsf PORTB, 2
    bsf PORTB, 3
    call Delay
    goto Programa
    
    Positivo:
    clrf PORTB
    bsf PORTB, 4
    bsf PORTB, 5
    bsf PORTB, 6
    bsf PORTB, 7
    call Delay
    goto Programa
    
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
    
