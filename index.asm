 list p=pic16f84a
  #include "p16f84a.inc"
  __CONFIG _HS_OSC & _WDT_OFF & _PWRTE_ON & _CP_OFF

numcnt equ h'f6'
numint equ h'01'
numcol equ h'08'
num250 equ h'fa'
numadd equ h'13'
 
ptn1	equ b'00000000'
ptn2	equ b'00001000'
ptn3	equ b'01001010'
ptn4	equ b'01001010' 
ptn5	equ b'00101010'
ptn6	equ b'00011000'
ptn7	equ b'00000000'
ptn8	equ b'00001000'
ptn9	equ b'00001000'
ptn10	equ b'00001000'
ptn11	equ b'00001000'
ptn12	equ b'00000000'
ptn13	equ b'01000000'
ptn14	equ b'00100100'
ptn15	equ b'00011000'
ptn16	equ b'00011000'
ptn17	equ b'00100100'
ptn18	equ b'00000010'
ptn19	equ b'00000000'
ptn20	equ b'01000100'
ptn21	equ b'01000100'
ptn22	equ b'01000100'
ptn23	equ b'00100000'
ptn24	equ b'00011100'
ptn25	equ b'00000000'
 
cntint equ h'20'
cntcol equ h'21'
cnt250 equ h'22'
cntadd equ h'23'
adrcol equ h'24'
adrptn equ h'25'
n equ h'26'
m equ h'27'

adr1 equ h'30'
adr2 equ h'31'
adr3 equ h'32'
adr4 equ h'33'
adr5 equ h'34'
adr6 equ h'35'
adr7 equ h'36'
adr8 equ h'37'
adr9 equ h'38'
adr10 equ h'39'
adr11 equ h'3a'
adr12 equ h'3b'
adr13 equ h'3c'
adr14 equ h'3d'
adr15 equ h'3e'
adr16 equ h'3f'
adr17 equ h'40'
adr18 equ h'41'
adr19 equ h'42'
adr20 equ h'43'
adr21 equ h'44'
adr22 equ h'45'
adr23 equ h'46'
adr24 equ h'47'
adr25 equ h'48'

  org 0
  goto main

  org 4
  goto tmr

main
  bsf STATUS,RP0
  movlw h'87'
  movwf OPTION_REG
  clrf TRISA
  clrf TRISB
  bcf STATUS,RP0

  clrf PORTA
  clrf PORTB

loop0
  movlw ptn1
  movwf adr1
  movlw ptn2
  movwf adr2
  movlw ptn3
  movwf adr3
  movlw ptn4
  movwf adr4
  movlw ptn5
  movwf adr5
  movlw ptn6
  movwf adr6
  movlw ptn7
  movwf adr7
  movlw ptn8
  movwf adr8
  movlw ptn9
  movwf adr9
  movlw ptn10
  movwf adr10
  movlw ptn11
  movwf adr11
  movlw ptn12
  movwf adr12
  movlw ptn13
  movwf adr13
  movlw ptn14
  movwf adr14
  movlw ptn15
  movwf adr15
  movlw ptn16
  movwf adr16
  movlw ptn17
  movwf adr17
  movlw ptn18
  movwf adr18
  movlw ptn19
  movwf adr19
  movlw ptn20
  movwf adr20
  movlw ptn21
  movwf adr21
  movlw ptn22
  movwf adr22
  movlw ptn23
  movwf adr23
  movlw ptn24
  movwf adr24
  movlw ptn25
  movwf adr25

  movlw numint
  movwf cntint

  movlw numcol
  movwf cntcol
  
  movlw num250
  movwf cnt250
  movlw numadd
  movwf cntadd
  
  clrf adrcol
  clrf n
  clrf m

  movlw adr1
  movwf adrptn
  
  movlw numcnt
  movwf TMR0
  
  bsf INTCON,T0IE
  bsf INTCON,GIE

  call setled

loop
  goto loop

tmr
  bcf INTCON,T0IF

  movlw numcnt
  movwf TMR0

  decfsz cntint,F
  goto tmr_ret

  movlw numint
  movwf cntint
  
  call setled
  decfsz cnt250,F
  goto tmr_ret
  call add_n

tmr_ret
  retfie

setled
  clrf PORTB

  movf adrcol,W
  movwf PORTA

  movf adrptn,W
  movwf FSR
  movf INDF,W

  movwf PORTB

  decfsz cntcol,F
  goto setled_adr

  movlw numcol
  movwf cntcol

  clrf adrcol

  movlw adr1
  movwf adrptn
  movf n,W
  movwf m
  call addloop

setled_ret
  return

setled_adr
  incf adrcol,F
  incf adrptn,F
  goto setled_ret

add_n
  incf n,F
  decfsz cntadd,F
  return
  movlw num250
  movwf cnt250
  movlw numadd
  movwf cntadd
  clrf n
  return
  
loop_add
  decfsz m,F
  goto add
  return
  
add
  incf adrptn,F
  goto loop_add

  end