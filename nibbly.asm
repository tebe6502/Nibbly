
/*
  NIBBLY Engine v1.3 by Tebe/Madteam (05.06.2006)

  21.11.2009  - NTSC msx fix (msx_stop)

  SID2POKEY - $f0..
  INFALTE   - $e0..
  NIBBLY    - $80..

  Zasady:
  - zadaniem jest przejsc 100 poziomow, na kazdym z nich zebrac wszystkie 'kropki' przed uplywem czasu
  - limit casu to 2:00 minuty na kazdy poziom, czasu nie mozna zatrzymac
  - za kazda zebrana 'kropke' dostajemy 5 punktow
  - po zebraniu wszystkich 'kropek' dostajemy 10 punktow za kazda sekunde z czasu ktory nam pozostal
  - po kazdych 10.000 punktach dostajemy dodatkowe zycie (maksymalna liczba zyc to 9) <- USUNIETO TA MOZLIWOSC
  - na koncu kazdego poziomu pokazywany jest 'kod dostepu' do poziomu, kod dostepu wpisujemy przed gra
*/


*--- GLOBAL CONSTANTS

 icl 'nibbly.hea'

 icl 'packed.hea'


 prg		= $3400
 prgTitle	= $1000

 txt_temp	= pmg		; $c000 ...
 l_adr		= pmg+$100
 h_adr		= l_adr+$100


*--- VARIABLES

src	=	$80		;(2)
srcOld	=	src+2		;(2)
dst	=	srcOld+2	;(2)
_tmp	=	dst+2		;(2)
idx	=	_tmp+2		;(1)
len	=	idx+1		;(1)
byt2	=	len+1		;(2)
bajt	=	byt2+1		;(1)	tutaj przechowujemy pozycje X ducha dla panelu
gate	=	bajt+1		;(1)
posX	=	gate+1		;(1)
posY	=	posX+1		;(1)
ftmp	=	posY+1		;(2)

byt3	=	$0100

zpage	=	$e0		; 11 bytes

cloc	=	$14


*--- INTRO

 org intro_org

 .link 'logo\logo3.obx'

 ini intro


*--- INITIALIZE

 org prg

 .link 'init.obx'

depack_move
 icl 'inflate.asm'

 ini prg


*--- MAIN PROGRAM

 org prg

ant
 dta $70,$60,$4e,a(gorny_pasek),$44+$80,a(scr+40)
 dta 4+$80,4
 dta 4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4+$80,4
 dta $4e+$80,a(gorny_pasek),$60
 dta $4e,a(panel+000),$e,$e,$e,$e,$8e,$e,$e
 dta $4f,a(panel+320),$f,$f,$f,$f,$f,$f,$f
 dta $4e,a(panel+640),$e,$e,$e,$e,$e,$e,$e
 dta $41,a(ant)

gorny_pasek	:40 dta $55
;dolny_pasek	:40 dta $55

panel
 ins 'panel\panel_2.raw',640,320*3

panel_lives	= panel+320+2
panel_round	= panel+320+35
panel_clock	= panel+320+20
panel_punkt	= panel+320+6


.local dli
	icl 'dli.asm'
.endl


main

 lda palntsc
 cmp #1 
 beq _skip

 lda #60
 sta _palntsc+1
 sta DEC_CLOCK._palntsc+1

_skip
 jsr setpmcol
 jsr save_color

_pal
 WAIT #1
 
 sei
 mva #0	  $d40e
 sta $d400

 mva #$fe $d301

 mva >pmg $d407		; missiles and players data address
 mva #3 $d01d		; enable players and missiles

; lda #$cc		; stala wartosc dla ostatniej pozycji duchow
; sta bajt

 lda #1
 jsr sid_init

 jsr CRC16.MAKECRCTABLE


* --- EKRAN TYTULOWY

 INFLATE	#nibbly_logo	,	#fntTit		; -> $d800..$ff00

 jsr title_main


* --- GRA

 lda:rne $d40b

 mva #$00  msx_stop+1
 sta _fade+1

 mva __color_nr  color_nr	; BYTE

 mwa #l_tcol2   __l_tcol
 mwa #h_tcol2   __h_tcol
 mwa #t_satur2  __t_satur
 mwa #t_color2  __t_color

 INFLATE	#nibbly_fnt	,	#fnt

 INFLATE	#nibbly_pmg	,	#pmg+$300

 lda <nmi
 sta $fffa
 sta $fffe
 lda >nmi
 sta $fffb
 sta $ffff

 lda #$cc		; stala wartosc dla ostatniej pozycji duchow
 sta bajt

 mwa #dli.dli0 vdli+1

 mva #$c0 $d40e


*---
start
 lda #[3^$75]	;9
 eor #$75
 sta dli.lives			; liczba zyc

 lda #0
 sta dli.punkt_0		; punkty 6x0
 sta dli.punkt_1
 sta dli.punkt_2
 sta dli.punkt_3
 sta dli.punkt_4
 sta dli.punkt_5


restart
 WAIT #1

 lda #def_joy_delay
 sta joy_delay

_palntsc lda #50
 sta second
 sta notime+1

 lda #0
 sta dli.clock_1	; zerujemy zegar 00:00
 sta dli.clock_3
 sta dli.clock_4
 
; lda #0		; usuwamy napis
 sta spr0+1
 sta spr1+1
 sta mis0+1
 sta mis1+1

 sta _old+1

 lda >fnt
 sta dli.f0+1

 ldy #0			; ustawiamy robala na pozycji poczatkowej
 
 sty _SRC_TEST._eat+1	; zerujemy licznik zjedzonych "ziaren"

 lda <@start+10*2
 sta src
 sta srcOLD

 sta l_adr,y+
 rne

 lda >@start+10*2
 sta src+1
 sta srcOLD+1

 sta h_adr,y+
 rne


 lda #1
 sta idx		; pierwszy wolny indeks umozliwiajacy wpis do tablicy RUCH
 lda #1
 sta len		; poczatkowa dlugosc robala
 
 jsr _LEVEL

_fade lda #0
 sne
 jsr fade_in

 mva #$ff  _fade+1


 lda #zpusty		; czyscimy pole pod glowa robala
 ldy #0
 sta (src),y
 iny
 sta (src),y
 ldy #@sw
 sta (src),y
 iny
 sta (src),y 

 lda #2			; startujemy zegar
 sta dli.clock_1
 lda #0
 sta zegar+1


 jsr _CLR_HEAD		; ustawiamy glowe

 lda #$22
 sta dli.nap_gti+1

 lda #0
 sta hsiz+1

 lda #$24
 sta c7+1
 sta dli.nap_col0+1
 lda #$38
 sta c8+1
 sta dli.nap_col1+1

 lda #128
 sta spr0+1
 sta spr1+1
 sta posX

 lda #128+32
 sta posY

 jsr _HEAD_UP			; glowa w gore

 jmp loop_prv


*--- WELL DONE

welldone
 lda #{rts}
 sta text._rts		; nie bedzie czekal na FIRE, wyswietlamy napis WELL DONE 

 SID_RESTART #song2

 jsr CRC16.calc

 TEXT #0

_loop			; dostajemy punkty za pozostaly czas x2
 WAIT #1
 
 lda #1
 sta second
 
 jsr DEC_CLOCK
 jsr INC_PUNKTY
 jsr INC_PUNKTY

 lda notime+1
 bne _loop

 jsr text._rts+1	; usuwamy napis WELL DONE (omijamy rozkaz RTS)

next
 jsr ADD_LEVEL
 
 jsr INC_ROUND

 SID_RESTART #song5

 jmp restart


ADD_LEVEL
 lda _LEVEL.adr		; nastepny level, nastepna runda
 clc
 adc #lsiz
 sta _LEVEL.adr
 scc
 inc _LEVEL.adr+1
 rts


*--- ESCAPE

esc
 jsr _SRC_TEST.ouch		; po tym juz nie wroci


*--- LET'S GO

loop_prv

 lda #def_joy_delay
 sta joy_delay

 lda _LEVEL.ile
 cmp #1
 beq welldone

read_joy


 lda $d20f		; ZWIEKSZENIE LEVELU PO NACISNIECIU KLAWISZA
 and #4			;
 bne ___nxt		;

 lda $d209
 cmp #$1c
 beq esc 
 
; lda #$ff		;
; sta zegar+1		;
; jmp next		;
___nxt			;


 jsr notime

r_d300 ldy #0
 cpy #$0f
 beq read_joy
 
 tya
_old cmp #0
 bne _ok
 
 dec joy_delay
 bne read_joy 

_ok
 tya

 lda l_adr_joy,y
 sta _jmp+1

_jmp jmp _joy_nil


*--- PROCEDURY OBSLUGI JOYA MIESZCZA SIE NA 1 STRONIE
*--- ZACZYNAJA SIE OD POCZATKU STRONY PAMIECI

 .align

.pages

_joy_nil
 lda #1
 sta joy_delay
 
 jmp read_joy


_rg	.local
 lda _old+1
 cmp #@left
 beq _skp
 sta _SRC_TEST._old_restore+1

 tya
 sta _old+1

 _ADD_RUCH
 inw src
 inw src
 jsr _SRC_TEST

_skp
 jmp loop_prv
.endl


_lf	.local
 lda _old+1
 cmp #@right
 beq _skp
 sta _SRC_TEST._old_restore+1

 tya
 sta _old+1

 _ADD_RUCH
 dew src
 dew src
 jsr _SRC_TEST

_skp
 jmp loop_prv
.endl


_up	.local
 lda _old+1
 cmp #@down
 beq _skp
 sta _SRC_TEST._old_restore+1

 tya
 sta _old+1

 _ADD_RUCH
 lda src
 sec
 sbc #@sw*2
 sta src
 scs
 dec src+1
 jsr _SRC_TEST

_skp
 jmp loop_prv
.endl


_dw	.local
 lda _old+1
 cmp #@up
 beq _skp
 sta _SRC_TEST._old_restore+1

 tya
 sta _old+1

 _ADD_RUCH
 lda src
 clc
 adc #@sw*2
 sta src
 scc
 inc src+1
 jsr _SRC_TEST

_skp
 jmp loop_prv
.endl

.endpg


*--- CZYSCIMY PAMIEC PMG DLA GLOWY ROBALA

.proc _CLR_HEAD
 lda #0			; ustawiamy glowe
 ldy #144+1
_clr
 sta pmg+$400+40-1,y
 sta pmg+$500+40-1,y
 dey
 bne _clr
 rts
.endp


*--- PRZESUWAMY GLOWE NA DUCHACH (PM0, PM1)

*--- TUTAJ MAKRA DLA ROZPISANIA PETLI

.macro @@@dw
 lda:cmp:req gate
 inc _fn+1
 inc posY
 inc posY
 :1
.endm

.macro @@@up
 lda:cmp:req gate
 inc _fn+1
 dec posY
 dec posY
 :1
.endm

.macro @@@lf
 lda:cmp:req gate
 inc _fn+1
 dec posX
 lda posX
 sta spr0+1
 sta spr1+1
.endm

.macro @@@rg
 lda:cmp:req gate
 inc _fn+1
 inc posx
 lda posX
 sta spr0+1
 sta spr1+1
.endm


*--- TUTAJ WLASCIWA PROCEDURA

.proc _PUT_HEAD


*--- USTALAMY KIERUNEK I WSTAWIAMY ODPOWIEDNI KLOCEK 0..11

 lda len
 cmp #2
 bcc _ok

 ldx idx
 dex
 dex
 ldy kier,x	; -2
 lda _lsh4,y
 inx
 ora kier,x	; -1
 tay

 lda tst_skip,y
 beq _ok

; ldy idx
; dey
 lda l_adr,x
 sta dst
 lda h_adr,x
 sta dst+1

 lda ofset,y

 ldy #0
 sta (dst),y
 iny
 ora #1
 sta (dst),y
 
 ldy #@sw
 clc
 adc #1
 sta (dst),y
 iny
 ora #1
 sta (dst),y

_ok

*--- _PUT_HEAD

 ldy _old+1

 lda l_adr_head,y
 sta _jmp+1
 lda h_adr_head,y
 sta _jmp+2

_jmp jmp $FFFF
 

_dw
 @@@dw	"jsr _HEAD_DOWN"
 @@@dw	"jsr _HEAD_DOWN"
 @@@dw	"jsr _HEAD_DOWN"
 @@@dw	"jsr _HEAD_DOWN"
 @@@dw	"jsr _HEAD_DOWN"
 @@@dw	"jsr _HEAD_DOWN"
 @@@dw	"jsr _HEAD_DOWN"
 @@@dw	"jmp _HEAD_DOWN"

_up
 @@@up	"jsr _HEAD_UP"
 @@@up	"jsr _HEAD_UP"
 @@@up	"jsr _HEAD_UP"
 @@@up	"jsr _HEAD_UP"
 @@@up	"jsr _HEAD_UP"
 @@@up	"jsr _HEAD_UP"
 @@@up	"jsr _HEAD_UP"
 @@@up	"jmp _HEAD_UP"

_lf
 jsr _HEAD_LEFT
 @@@lf
 @@@lf
 @@@lf
 @@@lf
 @@@lf
 @@@lf
 @@@lf
 @@@lf
 rts

_rg
 jsr _HEAD_RIGHT
 @@@rg
 @@@rg
 @@@rg
 @@@rg
 @@@rg
 @@@rg
 @@@rg
 @@@rg
 rts

.endp


*--- NOWA POZYCJA ROBALA

.proc _PUT_NIBBLY

 lda len
 cmp #2
 bcs _ok

 lda idx	; adres ogona robala
 sec
 sbc len
 tax
 lda l_adr,x
 sta dst
 lda h_adr,x
 sta dst+1

 lda #zpusty
 ldy #0
 sta (dst),y
 sta (src),y
 iny
 sta (dst),y
 sta (src),y
 ldy #@sw
 sta (dst),y
 sta (src),y
 iny
 sta (dst),y
 sta (src),y

 rts

_ok

 ldx idx
 dex
 ldy kier,x	; -1

 lda ofset,y	; nowy klocek robala

 ldy #0
 sta (src),y
 iny
 ora #1
 sta (src),y
 
 ldy #@sw
 clc
 adc #1
 sta (src),y
 iny
 ora #1
 sta (src),y


 lda idx		; adres ogona robala
 sec
 sbc len
 tax
 lda l_adr,x
 sta dst
 lda h_adr,x
 sta dst+1

; lda <@null		; usuwamy adres ogona robala
; sta l_adr,x
; lda >@null
; sta h_adr,x

 inx
 lda l_adr,x
 sta _tmp
 lda h_adr,x
 sta _tmp+1

 lda #zpusty		; kasujemy ogonek
 ldy #0
 sta (dst),y
 iny
 sta (dst),y
 ldy #@sw
 sta (dst),y
 iny
 sta (dst),y

 ldy kier,x
 lda ofset+16,y		; wstawiamy nowy klocek na pozycji przedostatniej ogonka

 ldy #0
 sta (_tmp),y
 iny
 ora #1
 sta (_tmp),y
 ldy #@sw
 clc
 adc #1
 sta (_tmp),y
 iny
 ora #1
 sta (_tmp),y 

_skp
 rts

.endp


*--- ZWIEKSZENIE PUNKTACJI

.proc INC_PUNKTY

 lda dli.punkt_0
 cmp #9
 beq _skp


 ldx #0

 lda dli.punkt_5
 clc
 adc #5
 sta dli.punkt_5

 cmp #10
 bne _skp
 stx dli.punkt_5
 inc dli.punkt_4

 lda dli.punkt_4
 cmp #10
 bne _skp
 stx dli.punkt_4
 inc dli.punkt_3

 lda dli.punkt_3
 cmp #10
 bne _skp
 stx dli.punkt_3
 inc dli.punkt_2

 lda dli.punkt_2
 cmp #10
 bne _skp
 stx dli.punkt_2
 inc dli.punkt_1

; lda dli.lives
; cmp #9
; scs
; inc dli.lives		; dodatkowe zycie za kazde 10.000 punktow (max 9 zyc)

 lda dli.punkt_1
 cmp #10
 bne _skp
 stx dli.punkt_1
 inc dli.punkt_0

_skp

 rts

.endp


*--- ZWIEKSZENIE NUMERU RUNDY

.proc INC_ROUND

 inc lvl_count
 lda lvl_count
 cmp #lvl_max
 bne _sk

 mva #$ff  msx_stop+1
 jsr sid_stop

 jsr setpmcol

 jsr fade_out

 jsr CONGRATULATIONS

 jsr reset

 pla
 pla
 jmp _pal


reset
 mwa #levels  _LEVEL.adr

 ldy #0			; resetujemy numer rundy 001
 sty dli.round_0
 sty dli.round_1

 sty lvl_count		; dodatkowy licznik rund na bajcie

 iny
 sty dli.round_2

; dec dli.lives
 rts


_sk

 ldx #0

 inc dli.round_2

 lda dli.round_2
 cmp #10
 bne _skp
 stx dli.round_2
 inc dli.round_1

 lda dli.round_1
 cmp #10
 bne _skp
 stx dli.round_1
 inc dli.round_0

_skp

 jmp setpmcol

lvl_count	brk

.endp


*--- MODYFIKACJA CZASU

.proc DEC_CLOCK

 lda dli.clock_1
 ora dli.clock_3
 ora dli.clock_4
 sta notime+1
 beq _skp
 
 dec second
 bne _skp

_palntsc lda #50
 sta second

 dec dli.clock_4
 lda dli.clock_4
 bpl _skp
 lda #9
 sta dli.clock_4
 dec dli.clock_3

 lda dli.clock_3
 bpl _skp
 lda #5
 sta dli.clock_3
 dec dli.clock_1

_skp
 rts

.endp


/*******************************************************************************/
/*                           TEST NOWEJ POZYCJI                                */
/*******************************************************************************/

.proc _SRC_TEST

 ldy #0
 lda (src),y
 cmp #murek
 beq _def
 cmp #murek2
 beq _def 
 cmp #ziarno
 beq jedzenie

; cmp #$c4
; beq _ok
; cmp #$c8
; beq _ok
; cmp #$cc
; beq _ok
; cmp #$d0
; beq _ok

 cmp #chr+$80
 bcs ouch

/*
 iny
 lda (src),y
 cmp #murek+1
 beq _def
 cmp #ziarno+1
 beq jedzenie
*/

 jsr _PUT_HEAD
 jmp _PUT_NIBBLY

_def			; przywracamy poprzednia pozycje glowy robala
 mwa  srcOld  src
 dec idx
_old_restore lda #0
 sta _old+1
 rts

jedzenie
_eat lda #0
 clc
 adc #ulamek
 sta _eat+1
 scc
 inc len

 dec _LEVEL.ile

 jsr inc_punkty

 jsr _PUT_HEAD
 jmp _PUT_NIBBLY

ouch			; zmniejszamy liczbe zyc i jesli osiagnie 0 to GAME OVER
 dec dli.lives
 lda dli.lives
 beq gameover

 SID_RESTART #song3

 TEXT #1

 SID_RESTART #song5

 pla
 pla
 jmp restart


gameover
 SID_RESTART #song4

 TEXT #3

 SID_RESTART #song5

 pla
 pla

 mva #$ff  msx_stop+1
 sta black_skip		; omin wpisywanie wartosci 0 do rejestrow kolorow

 jsr sid_stop

 jsr setpmcol
 jsr save_color

 mva #$00 black_skip	; ok, mozesz wpisywac wartosci 0 do rejestrow kolorow

 jsr fade_out
 jmp _pal	;start

.endp


notime lda #0
 bne _skp

 SID_RESTART #song3

 TEXT #2

 WAIT #2

 dec dli.lives
 lda dli.lives
 beq _SRC_TEST.gameover

 SID_RESTART #song5

 pla
 pla
 jmp restart

_skp
 rts


*--- AKTUALIZACJA PANELU

; w regX wartosc cyfry do wyswietlenia

.macro UPDATE_PANEL

; ldy #0
; lda cyfry,x
; sta panel+320+40*0,y
; ldy #40
; lda cyfry+10,x
; sta panel+320+40*1,y

 lda cyfry+20,x
 sta panel+320+40*2,y
 lda cyfry+30,x
 sta panel+320+40*3,y
 lda cyfry+40,x
 sta panel+320+40*4,y
 lda cyfry+50,x
 sta panel+320+40*5,y
 lda cyfry+60,x
 sta panel+320+40*6,y

; lda cyfry+70,x
; sta panel+320+40*7,y

 iny

.endm


/*******************************************************************************/
/*                 WSTAWIENIE NOWEGO KIERUNKU DO TABLICY                       */
/*******************************************************************************/

.macro _ADD_RUCH

 ldx idx

 sta kier,x 

 lda src	; w (scrOLD) zapamietujemy stara wartosc (SRC)
 sta srcOLD
 sta l_adr,x	; RUCH [ IDX ] = KIERUNEK

 lda src+1
 sta srcOLD+1
 sta h_adr,x

 inc idx	; IDX = IDX + 1

.endm


*--- WSTAWIAMY KLOCKI ROBALA NA EKRAN (WSPOLNE ZNAKI DLA WSZYSTKICH ZESTAWOW)

.proc _FIL_ROBAL		; sprawdzamy pole gry 36x18 znakow (18x9 klockow)

 mwa #scr+3*@sw+2	_tmp	; w (_TMP) adres pamieci obrazu, lewy-gorny klocek

 ldx #9

_lop
 ldy #0
_lp
 lda (_tmp),y
 cmp #chr+$80
 bcc _cnt

 sty y+1

 lda #robal
 sta (_tmp),y
 iny
 ora #1
 sta (_tmp),y

 tya
 add #@sw-1
 tay

 lda #robal+2
 sta (_tmp),y
 iny
 ora #1
 sta (_tmp),y

y ldy #0

_cnt
 iny
 iny
 cpy #36
 bne _lp

 lda _tmp
 add #@sw*2
 sta _tmp
 scc
 inc _tmp+1

 dex
 bne _lop

 rts

.endp


/*******************************************************************************/
/*                  WYSWIETLENIE NOWEGO LEVELU                                 */
/*******************************************************************************/

.proc _LEVEL

; mwa #scr  _tmp
 mwa #scr2 dst

; lda #$ff		; dolna czarna kreska na poczatku pola gry
; ldy #@sw-1
; sta gorny_pasek,y-
; rpl

 jsr add_dst
; jsr add_tmp


 lda #murek2		; pierwsze 2 linie murkiem2
 jsr fill_line
 lda #murek2+2
 jsr fill_line


 ldx #10-1		; wypelniamy ekran murkiem
_lp
 lda #murek
 jsr fill_line
 lda #murek+2
 jsr fill_line
 dex
 bne _lp


 lda #murek2		; ostatnie 2 linie innym murkiem2
 jsr fill_line
 lda #murek2+2
 jsr fill_line


 mwa #scr2+@sw*3 dst	; teraz wstawiamy i liczymy "ziarna"

 mwa adr _tmp
 
 ldy #0
 sty ile

_lop
 lda #2
 sta ofs

 lda (_tmp),y
 jsr decode
 iny
 lda (_tmp),y
 jsr decode
 iny
 lda (_tmp),y
 jsr decode

 jsr add_dst
 jsr add_dst 
 
 iny
 cpy #9*3
 bne _lop


; lda #$ff		; gorna czarna kreska na dole pola gry
; ldy #@sw-1
; sta dolny_pasek,y-
; rpl


 lda:cmp:req gate

 mwa #scr2 cp0+1	; przepisujemy bufor ekranu SCR2 na ekran SCR
 mwa #scr  cp1+1

 ldx #11*2+1
lp

 ldy #40-1
___lp
cp0 lda $ffff,y
cp1 sta $ffff,y
 dey
 bpl ___lp

 lda cp0+1
 clc
 adc #@sw
 sta cp0+1
 scc
 inc cp0+2
 
 lda cp1+1
 clc
 adc #@sw
 sta cp1+1
 scc
 inc cp1+2

 dex
 bne lp

 rts


DECODE			; dekoduj ziarna
 sty rY+1
 sta bajt+1

 lda #$80
 sta _bit
 
 ldy #7

bajt lda #0
 and _bit
 bne _skp
 
 lda ofs
 cmp #38
 beq rY
 
 jsr put_ziarno
 
_skp
 lsr _bit
 
 inc ofs
 inc ofs
 
_sk
 dey
 bpl bajt
 
rY ldy #0
 rts


PUT_ZIARNO		; postaw ziarno na ekranie
 sty regY+1
 
 ldy ofs
 lda #ziarno
 sta (dst),y
 iny
 ora #1
 sta (dst),y

 lda ofs
 clc
 adc #@sw
 tay
 lda #ziarno+2
 sta (dst),y
 iny
 ora #1
 sta (dst),y

 inw ile

regY ldy #0
 rts
 

ADD_DST
 lda dst
 clc
 adc #@sw
 sta dst
 scc
 inc dst+1
 rts


FILL_LINE		; wypelniamy linie dwoma znakami
 sta _fil+1

 ldy #0
_fil lda #0
 sta (dst),y
; sta (_tmp),y
 iny
 ora #1
 sta (dst),y
; sta (_tmp),y
 iny
 cpy #@sw
 bne _fil

; jsr add_tmp
 jmp add_dst

adr	dta a(levels)
_bit	brk
ofs	brk
ile	brk

.endp


*--- NMI

nmi
 sta rA+1
 stx rX+1
 sty rY+1

 bit $d40f
 bpl vbl

vdli jmp nmiQ

vbl
 sta $d40f

 inc cloc

 mwa #ant $d402

 mva #scr40 $d400


_fn lda #0
 and #7
 tay
_fnt lda d_fnt,y
 sta dli.f0+1
_fntG :2 nop
 sta dli.f1+1
 sta chbase


c0 lda #$B4
 sta colbak
c1 lda #$00
 sta color0
c2 lda #$0a
 sta color1
c3 lda #$c8
 sta color2
c4 lda #$F8
 sta color3

 lda #$04
 sta gtictl

 lda #$03
 sta sizep2
 sta sizep3

hsiz lda #$03		; szerokosc glowy
 sta sizep0
 sta sizep1

c7 lda #$EA		; kolor glowy
 sta colpm0
c8 lda #$EA
 sta colpm1
 
 lda #$ff
 sta sizem 

spr0 lda #$00		; pozycja glowy
 sta hposp0
spr1 lda #$00
 sta hposp1
mis0 lda #$00
 sta hposm0
mis1 lda #$00
 sta hposm1 

 lda #$30
 sta hposp2
 lda #$50
 sta hposp3

; lda #$50
 sta hposm3

c5 lda #$0A
 sta colpm2
 sta colpm3
 
 lda #$78
 sta hposm2

 mwa #dli.dli0 vdli+1


	jsr msx_stop

 lda $d300
 and #$0f
 sta r_d300+1

zegar lda #$ff
 sne
 jsr dec_clock

nmiQ
rA lda #0
rX ldx #0
rY ldy #0
 rti


*--- USTAWIAMY KOLORY POLA GRY (PM2, PM3)

.proc setpmcol

 lda $d20a
 :4 lsr @
 tay

_lp

 lda l_pal,y
old cmp #$ff
 bne _ok

 iny
 tya
 and #$f
 tay
 jmp _lp

_ok
 lda l_pal,y
 sta old+1
 sta :dst
 lda h_pal,y
 sta :dst+1

 lda #22
 sta max+1

 ldy #0		; kolory pm2, pm3 (podkolorowuja klocki)
 lda (:dst),y
 jsr _setpm

 lda #22+1
 sta max+1
 ldy #1
 lda (:dst),y
 jsr _setpm

 ldy #2		; kolor pola gry
 lda (:dst),y
 sta c0+1
 sta dli._c3+1
 sta dli._c4+1
 sta dli._c5+1
 sta dli._c6+1
 sta dli._c7+1
 iny
 lda (:dst),y
 sta c3+1
 iny
 lda (:dst),y
 sta c4+1

 iny		; kolory panelu
 lda (:dst),y
 sta dli.p0+1
 iny
 lda (:dst),y
 sta dli.p1+1
 sta dli.p2+1
 sta dli.p3+1
 sta dli.p4+1
 sta dli.p5+1

 iny
 lda (:dst),y
 sta TEXT.napCol+1

 rts

_setpm
 ldx l_tcol,y
 stx dst+1
 ldx h_tcol,y
 stx dst+2

 ldx #1
dst sta $ffff,x

 iny
 iny
max cpy #0
 bne _setpm
 rts

.endp


*--- CRC 16
; first initialize (CRC) = $FFFF

.PROC CRC16

MAKECRCTABLE
         LDX #0          ; X counts from 0 to 255
BYTELOOP LDA #0          ; A contains the low 8 bits of the CRC-16
         STX CRC         ; and CRC contains the high 8 bits
         LDY #8          ; Y counts bits in a byte
BITLOOP  ASL @
         ROL CRC         ; Shift CRC left
         BCC NOADD       ; Do nothing if no overflow
         EOR #$21        ; else add CRC-16 polynomial $1021
         PHA             ; Save low byte
         LDA CRC         ; Do high byte
         EOR #$10
         STA CRC
         PLA             ; Restore low byte
NOADD    DEY
         BNE BITLOOP     ; Do next bit
         STA CRCLO,X     ; Save CRC into table, low byte
         LDA CRC         ; then high byte
         STA CRCHI,X
         INX
         BNE BYTELOOP    ; Do next byte
         RTS

calc	
 mwa #$FFFF CRC

 mwa _LEVEL.adr  data+1

 ldy #27
_lp
data lda $FFFF,y
 jsr UPDCRC
 dey
 bpl _lp

 mva CRC	NEWCRC
 mva INC_ROUND.lvl_count	NEWCRC+1
 mva CRC+1	NEWCRC+2

 rts


UPDCRC   EOR CRC+1       ; Quick CRC computation with lookup tables
         TAX
         LDA CRC
         EOR CRCHI,X
         STA CRC+1
         LDA CRCLO,X
         STA CRC
         RTS

.endp

NEWCRC	 .ds 3
CRC      .ds 2
CRCLO    .ds $100
CRCHI    .ds $100



* --- EKRAN "CONGRATULATIONS"

.proc CONGRATULATIONS

 INFLATE	#nibbly_grat	,	#fntCon

 jmp congrat_main

.endp


* --- LEVELS

levels
 ins 'levels\levels.dat'


* --- PROCEDURY I DANE DLA NAPISOW

 .link 'napisy.obx'


msx_stop lda #$ff
 bne skip_emulator

fps	lda #0
	cmp #6
	bne skip_emu

	mva #0 fps+1

	lda _palntsc+1
	cmp #60
	beq skip_emulator	

skip_emu

	jsr emulator		; gra SID PLAYER

skip_emulator

	inc fps+1

	rts


* --- VARIABLES

joy_delay	brk
second		brk

;@null		.ds 80		; bufor na ogon robala

	.align

kier		.ds 256

scr2		.ds $400	; bufor ekranu


.array ofset [256] .byte = robal
 [@right] = phaseidx.@rr+chr+$80
 [@left]  = phaseidx.@ll+chr+$80
 [@up]    = phaseidx.@uu+chr+$80
 [@down]  = phaseidx.@dd+chr+$80

 [@right+16] = phaseidx.@right+chr+$80
 [@left+16]  = phaseidx.@left+chr+$80
 [@up+16]    = phaseidx.@up+chr+$80
 [@down+16]  = phaseidx.@down+chr+$80
 
 [@rr]	= phaseidx.@rr+chr+$80
 [@ll]	= phaseidx.@ll+chr+$80
 [@dl]	= phaseidx.@dl+chr+$80
 [@dr]	= phaseidx.@dr+chr+$80
 [@ul]	= phaseidx.@ul+chr+$80
 [@ur]	= phaseidx.@ur+chr+$80
 [@ld]	= phaseidx.@ld+chr+$80
 [@lu]	= phaseidx.@lu+chr+$80
 [@rd]	= phaseidx.@rd+chr+$80
 [@ru]	= phaseidx.@ru+chr+$80
 [@dd]	= phaseidx.@dd+chr+$80
 [@uu]	= phaseidx.@uu+chr+$80
.enda 


.array tst_skip [256] .byte = $FF
 [@rr]	= 0
 [@ll]	= 0
 [@dd]	= 0
 [@uu]	= 0
.enda


cyfry	:8 ins 'panel\panel_2.raw',0+#*40,10


.array _lsh4 [16] .byte
 [@right] = @right<<4
 [@left ] = @left<<4
 [@up   ] = @up<<4
 [@down ] = @down<<4
.enda


.array l_adr_joy [16] .byte = <_joy_nil
 [@right] = <_rg
 [@left ] = <_lf
 [@up   ] = <_up
 [@down ] = <_dw
.enda


.array l_adr_head [16] .byte
 [@right] = <_PUT_HEAD._rg
 [@left ] = <_PUT_HEAD._lf
 [@up   ] = <_PUT_HEAD._up
 [@down ] = <_PUT_HEAD._dw
.enda


.array h_adr_head [16] .byte
 [@right] = >_PUT_HEAD._rg
 [@left ] = >_PUT_HEAD._lf
 [@up   ] = >_PUT_HEAD._up
 [@down ] = >_PUT_HEAD._dw
.enda



* --- TABLICA ADRESOW KOLOROW DLA POLA GRY

l_tcol
 dta l(c2,dli._c0,c5,dli.c13,dli.c15,dli.c17,dli.c19)				; 22 b
 dta l(dli.c21,dli.c23,dli.c25,dli.c27,dli.c29)
 dta l(dli.c31,dli.c33,dli.c35,dli.c37,dli.c39)
 dta l(dli.c41,dli.c43,dli.c45,dli._c1,dli._c2, txt_temp)

h_tcol
 dta h(c2,dli._c0,c5,dli.c13,dli.c15,dli.c17,dli.c19)				; 22 b
 dta h(dli.c21,dli.c23,dli.c25,dli.c27,dli.c29)
 dta h(dli.c31,dli.c33,dli.c35,dli.c37,dli.c39)
 dta h(dli.c41,dli.c43,dli.c45,dli._c1,dli._c2, txt_temp)


* --- COLOR PALETTE (pm0,pm1, bak,col2,col3, panel_col0,panel_col1, pm0+pm1)

palette0	dta b($0a,$74, $b4,$c8,$f8, $24,$28, $ea)
palette1	dta b($0a,$44, $74,$58,$b8, $14,$78, $dc)
palette2	dta b($0a,$74, $24,$18,$08, $04,$e8, $0a)
palette3	dta b($0a,$04, $44,$68,$f8, $04,$b8, $1a)
palette4	dta b($0a,$04, $14,$d8,$08, $74,$98, $1c)

l_pal :4 dta l(palette0, palette1, palette2, palette3, palette4)
h_pal :4 dta h(palette0, palette1, palette2, palette3, palette4)

black_skip	brk


 .print 'Program: ',prg,'..',*,' (',$9000-*,' bytes free)'

 ift *>$9000
  ert 'Adress > $9000'
 eif


* --- SID2POKEY

 .link 'msx\sid2pokey.obx'


* --- PACKED DATA #1

 org sid_end+1		; obszar pamieci za modulem SID

nibbly_fnt
 ins 'all_fnt.def'

nibbly_pmg
 ins 'pmg.def'


 .link 'title\title_fade.obx'


* --- tworzenie tablic L_TCOL2, H_TCOL2 z etykietami zaczynajacymi sie na C?, DLI.C?, DLI._C?, DLI.P? 

 ?colcnt = 0

 :50 labels <#		; szukamy etykiet wystepujacych w programie


l_tcol2
 .sav [$000] ?colcnt
 
h_tcol2
 .sav [$100] ?colcnt

; .print ' Colors: ',?colcnt

color_nr	dta b(?colcnt)
t_satur2	.ds ?colcnt
t_color2	.ds ?colcnt


__color_nr	dta b(?colcnt)
__l_tcol	dta a(l_tcol2)
__h_tcol	dta a(h_tcol2)
__t_satur	dta a(t_satur2)
__t_color	dta a(t_color2)


 .print '   Free: ',*,'..$BFFF (',$C000-*,' bytes free)'

 ift *>$BFFF
  ert 'Adress > $BFFF'
 eif


* --- TITLE

 org prgTitle

.local
 ldx #4

_lop
 lda:cmp:req 20

 ldy #2
_lp
 lda 708,y
 beq __q

 lda 708,y
 sub #$02
 sta 708,y

__q
 mva 709 712
 
 dey
 bpl _lp

 dex
 bne _lop

 mva #0 $d400
 sta 559
 rts

.end

 ini prgTitle


 org prgTitle

 .link 'title_2\title_2.obx'
 .link 'title_2\input_string.obx'

 .link 'congrat\grat_OK.obx'


nibbly_logo
 ins 'packed_data.def'

nibbly_grat
 ins 'packed_grat.def'


 .print '  Title: ',prgTitle,'..',*,' (',prg-*,' bytes free)'


* --- START

 run main


* --- MACROS
 opt l-


.macro labels ","

 ift .def c%%2
 .put[$000+?colcnt] = <c%%2
 .put[$100+?colcnt] = >c%%2
  .def ?colcnt = ?colcnt + 1
 eif

 ift .def dli.c%%2
 .put[$000+?colcnt] = <dli.c%%2
 .put[$100+?colcnt] = >dli.c%%2
  .def ?colcnt = ?colcnt + 1
 eif

 ift .def dli._c%%2
 .put[$000+?colcnt] = <dli._c%%2
 .put[$100+?colcnt] = >dli._c%%2
  .def ?colcnt = ?colcnt + 1
 eif

 ift .def dli.p%%2
 .put[$000+?colcnt] = <dli.p%%2
 .put[$100+?colcnt] = >dli.p%%2
  .def ?colcnt = ?colcnt + 1
 eif

.endm
