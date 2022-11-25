;Se recibe como entrada de 5 bits un número, en la salida se despliegan 8 bits en donde los primeros 4 indican el valor de la unidad y los últimos 4 el valor de las decenas
    #include <xc.inc> 
    PROCESSOR 16F84A 
     
    CONFIG FOSC=XT 
    CONFIG WDTE=OFF 
    CONFIG PWRTE=OFF 
    CONFIG CP=OFF 
     
    in EQU 0Ch    ;Entrada del PIC
    decenas EQU 0Dh ;Valor de Decenas  en BCD
    unidades EQU 0Eh ;Valor de Unidades  en BCD
    i EQU 0Fh ; contador del 0 a 9
   
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
 
  
PRINCIPAL: 
    movlw 10
    movwf i
    movf PORTA, w
    movwf in
    incf in, 1
    
    WHILE:
    decf in,1 
    btfss STATUS, 2
    GOTO decIn
    GOTO resultado
    
    decIn:
    decf i, 1
    btfss STATUS, 2
    GOTO noSalta
    GOTO salta
    
    noSalta: 
    incf unidades, 1
    goto WHILE
    
    salta:
    incf decenas, 1
    movlw 0
    movwf unidades
    movlw 10
    movwf i
    goto WHILE
    
    resultado:
    swapf decenas
    movf decenas, w
    xorwf unidades, w
    movwf PORTB 
    goto PRINCIPAL