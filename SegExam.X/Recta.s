;El programa simula la formula de mx+b en donde M es 8 y b 5, la entrada será el valor de x
    #include <xc.inc> 
    PROCESSOR 16F84A 
     
    CONFIG FOSC=XT 
    CONFIG WDTE=OFF 
    CONFIG PWRTE=OFF 
    CONFIG CP=OFF 
     
    m EQU 0Ch    
    x EQU 0Dh 
    be EQU 0Eh 
    y EQU 0Fh 
   
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
    movlw 0
    movwf y
    movf PORTA, w
    movwf x
    
    call Multiplicar
    call Cinco
    movf y, w
    movwf PORTB
    
    goto MAIN
    
    Multiplicar:
    btfsc STATUS, 2
    return
    call Ocho
    decf x,1
    goto Multiplicar
    
    Ocho:
    incf y, 1
    incf y, 1
    incf y, 1
    incf y, 1
    incf y, 1
    incf y, 1
    incf y, 1
    incf y, 1
    return
    
    NoZero:
    incf y, 1
    decf m
    goto Ocho
    
    Cinco:
    incf y, 1
    incf y, 1
    incf y, 1
    incf y, 1
    incf y, 1
    return
    
    
 