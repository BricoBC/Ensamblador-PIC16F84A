#include <xc.inc> 
    PROCESSOR 16F84A 
     
    CONFIG FOSC=XT 
    CONFIG WDTE=OFF 
    CONFIG PWRTE=OFF 
    CONFIG CP=OFF 
     
    player1 EQU 0Ch    ;Puntos totales del jugador 1 
    player2 EQU 0Dh    ;Puntos totales del jugador 2 
    golpe EQU 0Eh      ;Auxiliar 
    VidaPlayer1 EQU 0Fh         
    VidaPlayer2 EQU 10h          
    winner EQU 11h 
    i EQU 12h 
    j EQU 13h 
    contadorP1 EQU 14h 
    contadorP2 EQU 15h 
    aux EQU 16h 
     
  
    PSECT Programa, class=CODE,delta=2, abs 
    ORG 00h 
     
    Programa: 
    GOTO INICIO 
 
    INICIO:  ;Entradas_Salidas 
    bsf STATUS,5 
    movlw 11101B 
    movwf TRISA 
    clrf TRISB 
    bcf STATUS,5 
 
  
PRINCIPAL: 
    movlw 00000011B ;Vidas de cada jugador 
    movwf VidaPlayer1 
    movlw 00000011B 
     movwf VidaPlayer2 
   
     InicioJuego: 
     btfss PORTA,2 ;boton inicio 
     goto NoIniciado 
     goto EvaluacionVidas 
;_______________________________________________________________ 
 NoIniciado:  
     goto InicioJuego 
  
     EvaluacionVidas: 
         btfss VidaPlayer1,1 
         goto op1 
         goto InicioPlayer1 
  op1: 
         btfss VidaPlayer1,0 
         goto InicioPlayer2 
         goto InicioPlayer1 
  
;_________________________________________________________________ 
  
 InicioPlayer1: 
     movlw 00000001B 
     movwf PORTB 
     call LedIzquierdaDerecha 
      
 InicioPlayer2: 
     btfss VidaPlayer2,0 
     goto aun1 
     goto seguir 
      
     aun1: 
  btfss VidaPlayer2,1 
  goto winnerG 
  goto seguir 
      
 seguir: 
     movlw 10000000B 
     movwf PORTB 
     call LedDerechaIzquierda 
      
;_________________________________________________________________           
      
 winnerG:           
     movf contadorP1,0 
     subwf contadorP2,0 
      
     btfss STATUS,2 
     goto unGanador 
     goto empate 
      
     empate: 
  movlw 00111100B 
  movwf PORTB 
  call delay 
  goto PRINCIPAL 
      
     unGanador: 
  btfss STATUS,0 
  goto ganoPlayer1 
  goto ganoPlayer2 
      
     ganoPlayer1: 
  movlw 00001111B 
  movwf PORTB 
  call delay 
  goto PRINCIPAL 
   
     ganoPlayer2: 
  movlw 11110000B 
  movwf PORTB 
  call delay 
  goto PRINCIPAL 
     
;_________________________________________________________________      
      
 LedDerechaIzquierda: 
     btfss PORTB,7 
     goto noo 
     goto sii 
      
     noo: 
  call delay 
  rlf PORTB,1 
  goto LedDerechaIzquierda 
     sii: 
  call delay 
  btfss PORTA,4 
  goto No2 
  goto Si2
            Si2: 
  movlw 00010B 
  movwf PORTA 
  call delay 
  call LedIzquierdaDerecha 
     No2: 
  clrf PORTB 
  decf VidaPlayer2,1 
  incf contadorP1,1 
  goto InicioJuego 
;_________________________________________________________________  
   
 LedIzquierdaDerecha: 
     btfss PORTB,0 
     goto nooo 
     goto siii 
      
     nooo: 
  call delay 
  rrf PORTB,1 
  goto LedIzquierdaDerecha 
     siii: 
  call delay 
  btfss PORTA,0 
  goto No3 
  goto Si3 
  
     Si3: 
  movlw 00010B 
  movwf PORTA 
  call delay 
  call LedDerechaIzquierda 
     No3: 
  clrf PORTB 
  decf VidaPlayer1,1 
  incf contadorP2,1 
  goto InicioJuego 
     
;_________________________________________________________________      
 delay: 
     bcf STATUS,2 
     movlw 165 
     movwf j 
 bucle1: 
     btfss STATUS,2 
     goto no 
     goto si 
 no: 
     movlw 200 
     movwf i 
 bucle2: 
     btfss STATUS,2 
     goto no1 
     goto si1 
 no1: 
     decf i 
     goto bucle2 
 si1: 
     bcf STATUS,2 
     decf j 
     goto bucle1 
 si: 
     return 
      
    END Programa