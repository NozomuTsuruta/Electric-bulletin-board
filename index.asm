 ;プロセッサとコンフィグレーションビットの指定
 list p=pic16f84a
  #include "p16f84a.inc"
  __CONFIG _HS_OSC & _WDT_OFF & _PWRTE_ON & _CP_OFF

;定数の設定
numcnt equ h'f6' ;タイマ0のカウンタに設定する値(タイマ０割り込み間隔Ti=(256-numcnt)×0.1024[ms])
numint equ h'01' ;タイマ０割り込み回数(LED１列の表示間隔Tl=Ti×numint[ms])
numcol equ h'08' ;LEDの列数(ダイナミック点灯間隔Td=Tl×numcol[ms])
num250 equ h'fa' ;割り込みカウンタ(250回)
numadd equ h'13' ;adrptnに加算する最大値
 
;表示パターン設定
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
 
;変数のアドレス設定
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

;プログラムの開始
  org 0 ;リセットベクタ
  goto main ;ラベルmainへジャンプ

  org 4 ;割り込みベクタ
  goto tmr ;ラベルtmrへジャンプ

main
  ;入出力ポートとタイマ0の設定
  bsf STATUS,RP0 ;STATUSレジスタのPR0ビットの設定(バンク0からバンク１への切り替え)
  movlw h'87' ;OPTIONレジスタをh'87'に設定
  movwf OPTION_REG ;タイマ0の１カウント=0.4×256[μs]=0.1024[ms]
  clrf TRISA ;TRISAレジスタのクリア
  clrf TRISB ;TRISBレジスタのクリア
  bcf STATUS,RP0 ;STATUSレジスタのPR0ビットの設定

  ;出力の初期化
  clrf PORTA ;PORTAレジスタのクリア
  clrf PORTB ;PORTBレジスタのクリア

loop0
  movlw ptn1 ;表示パターン1をWレジスタへ格納
  movwf adr1 ;Wレジスタの値を変数adr1へ格納
  movlw ptn2 ;表示パターン2をWレジスタへ格納
  movwf adr2 ;Wレジスタの値を変数adr2へ格納
  movlw ptn3 ;表示パターン3をWレジスタへ格納
  movwf adr3 ;Wレジスタの値を変数adr3へ格納
  movlw ptn4 ;表示パターン4をWレジスタへ格納
  movwf adr4 ;Wレジスタの値を変数adr4へ格納
  movlw ptn5 ;表示パターン5をWレジスタへ格納
  movwf adr5 ;Wレジスタの値を変数adr5へ格納
  movlw ptn6 ;表示パターン6をWレジスタへ格納
  movwf adr6 ;Wレジスタの値を変数adr6へ格納
  movlw ptn7 ;表示パターン7をWレジスタへ格納
  movwf adr7 ;Wレジスタの値を変数adr7へ格納
  movlw ptn8 ;表示パターン8をWレジスタへ格納
  movwf adr8 ;Wレジスタの値を変数adr8へ格納
  movlw ptn9 ;表示パターン9をWレジスタへ格納
  movwf adr9 ;Wレジスタの値を変数adr9へ格納
  movlw ptn10 ;表示パターン10をWレジスタへ格納
  movwf adr10 ;Wレジスタの値を変数adr10へ格納
  movlw ptn11 ;表示パターン11をWレジスタへ格納
  movwf adr11 ;Wレジスタの値を変数adr11へ格納
  movlw ptn12 ;表示パターン12をWレジスタへ格納
  movwf adr12 ;Wレジスタの値を変数adr12へ格納
  movlw ptn13 ;表示パターン13をWレジスタへ格納
  movwf adr13 ;Wレジスタの値を変数adr13へ格納
  movlw ptn14 ;表示パターン14をWレジスタへ格納
  movwf adr14 ;Wレジスタの値を変数adr14へ格納
  movlw ptn15 ;表示パターン15をWレジスタへ格納
  movwf adr15 ;Wレジスタの値を変数adr15へ格納
  movlw ptn16 ;表示パターン16をWレジスタへ格納
  movwf adr16 ;Wレジスタの値を変数adr16へ格納
  movlw ptn17 ;表示パターン17をWレジスタへ格納
  movwf adr17 ;Wレジスタの値を変数adr17へ格納
  movlw ptn18 ;表示パターン18をWレジスタへ格納
  movwf adr18 ;Wレジスタの値を変数adr18へ格納
  movlw ptn19 ;表示パターン19をWレジスタへ格納
  movwf adr19 ;Wレジスタの値を変数adr19へ格納
  movlw ptn20 ;表示パターン20をWレジスタへ格納
  movwf adr20 ;Wレジスタの値を変数adr20へ格納
  movlw ptn21 ;表示パターン21をWレジスタへ格納
  movwf adr21 ;Wレジスタの値を変数adr21へ格納
  movlw ptn22 ;表示パターン22をWレジスタへ格納
  movwf adr22 ;Wレジスタの値を変数adr22へ格納
  movlw ptn23 ;表示パターン23をWレジスタへ格納
  movwf adr23 ;Wレジスタの値を変数adr23へ格納
  movlw ptn24 ;表示パターン24をWレジスタへ格納
  movwf adr24 ;Wレジスタの値を変数adr24へ格納
  movlw ptn25 ;表示パターン25をWレジスタへ格納
  movwf adr25 ;Wレジスタの値を変数adr25へ格納

  ;割り込み回数用カウンタの初期化
  movlw numint ;割り込み回数をWレジスタへ格納
  movwf cntint ;Wレジスタの値を変数cntintへ格納

  movlw numcol ;LEDの列数をWレジスタへ格納
  movwf cntcol ;Wレジスタの値を変数adrptnへ格納
  
  movlw num250 ;タイマ０割り込みを繰り返す回数をWレジスタへ格納
  movwf cnt250 ;Wレジスタの値を変数cnt250に格納
  movlw numadd ;adrptnに加算する最大値をWレジスタへ格納
  movwf cntadd ;Wレジスタの値を変数cntaddへ格納
  
  clrf adrcol ;変数adrcolのクリア
  clrf n ;nのクリア
  clrf m ;mのクリア

  ;表示パターンのアドレスの初期化
  movlw adr1 ;表示パターンの先頭アドレスをWレジスタへ格納
  movwf adrptn ;Wレジスタの値をadrptnへ格納
  
  ;タイマ０カウンタの初期化
  movlw numcnt ;タイマ0のカウンタに設定する値をWレジスタへ格納
  movwf TMR0 ;Wレジスタの値をTMR0レジスタへ格納
  
  ;割り込み許可の設定
  bsf INTCON,T0IE ;INTCONレジスタのTOIEビットの設定(タイマ０割り込みの許可)
  bsf INTCON,GIE ;INTCONレジスタのGIEビットの設定(全割り込みの許可)

  ;LEDの設定
  call setled ;サブルーチンsetledの呼び出し

loop
  ;割り込み待ちループ
  goto loop ;ラベルloopへジャンプ

tmr
  ;割り込みの設定
  bcf INTCON,T0IF ;INTCONレジスタのTOIFビットの設定(タイマ０割り込みフラグのクリア)

  ;タイマ0のカウンタの初期化
  movlw numcnt ;タイマ0のカウンタに設定する値をWレジスタへ格納
  movwf TMR0 ;Wレジスタの値をTMR0レジスタへ格納

  decfsz cntint,F ;変数cntintの値から1減算して変数cntintへ格納
  goto tmr_ret ;変数cntintの値が0でなければラベルtmr_retへジャンプ

  movlw numint ;割り込み回数をWレジスタへ格納
  movwf cntint ;Wレジスタの値を変数cntintへ格納
  
  call setled ;サブルーチンsetledの呼び出し

  decfsz cnt250,F ;変数cnt250の値から1減算して変数cnt250へ格納
  goto tmr_ret ;変数cntintの値が0出なければラベルtmr_retへジャンプ
  call add_n ;サブルーチンadd_nの呼び出し

tmr_ret
  retfie ;割り込みからの復帰

;サブルーチンsetled(LED設定サブルーチン)
setled
  ;LEDの初期化
  clrf PORTB ;PORTBレジスタのクリア

  ;ポートAの出力の設定
  movf adrcol,W ;変数adrcolをWレジスタへ格納
  movwf PORTA ;Wレジスタの値をPORTAレジスタへ格納

  ;間接アドレッシングによるデータの読み込み
  movf adrptn,W ;変数adrptnをWレジスタへ格納
  movwf FSR ;Wレジスタの値をFSRレジスタへ格納(間接アドレッシング用アドレスの設定)
  movf INDF,W ;INDFレジスタの値をWレジスタへ格納(FSRレジスタが指すアドレスの内容の読み込み)

  movwf PORTB ;Wレジスタの値をPORTBレジスタへ格納

  decfsz cntcol,F ;変数cntcolの値から1減算して変数cntcolへ格納
  goto setled_adr ;変数cntcolの値が0でなければラベルsetled_adrへジャンプ

  ;列数用カウンタの初期化
  movlw numcol ;LEDの列数をWレジスタへ格納
  movwf cntcol ;Wレジスタの値を変数cntcolへ格納

  clrf adrcol ;変数adrcolのクリア

  ;adrptnの初期化
  movlw adr1 ;表示パターンの先頭アドレスをWレジスタへ格納
  movwf adrptn ;Wレジスタの値を変数adrptnへ格納

  ;nの値をmにコピー
  movf n,W ;変数nをWレジスタへ格納
  movwf m ;Wレジスタの値を変数mに格納

  ;adrptnにnを加算
  call addloop ;サブルーチンaddloopの呼び出し

setled_ret
  return ;サブルーチンからの復帰

setled_adr
  ;表示するLEDの列のアドレスの更新
  incf adrcol,F ;変数adrcolの値を1加算して変数adrcolへ格納

  ;表示パターンのアドレスの更新
  incf adrptn,F ;変数adrptnの値を1加算して変数adrptnへ格納
  goto setled_ret ;ラベルsetled_retへジャンプ

add_n
  ;割り込みが250回繰り返されるたびにnに1加算
  incf n,F ;変数nの値を1加算して変数nへ格納
  decfsz cntadd,F ;変数cntaddの値を1減算して変数cntaddへ格納
  return ;変数cntaddの値が0でなければサブルーチンからの復帰

  ;割り込みカウンタ、adrptn加算に関する値を初期化
  movlw num250 ;割り込みカウンタ(250回)をWレジスタに格納
  movwf cnt250 ;Wレジスタの値を変数cnt250に格納
  movlw numadd ;adrptnに加算する最大値をWレジスタに格納
  movwf cntadd ;Wレジスタの値を変数cntaddに格納
  clrf n ;nのクリア
  return ;サブルーチンからの復帰
  
loop_add
  ;n回addを繰り返す
  decfsz m,F ;変数mの値を1減算して変数mへ格納
  goto add ;ラベルaddへジャンプ
  return ;サブルーチンからの復帰
  
;adrptnにn加算(n回1加算)
add
  incf adrptn,F ;変数adrptnの値を1加算して変数adrcolへ格納
  goto loop_add ;ラベルloop_addへジャンプ

  end ;プログラムの終了