* NIBBLY TITLE SCREEN v1.1 (29.05.2006) by Tebe/Madteam

// procedury MIGAJ i EMULATOR zajmuja prawie caly czas przerwania VBL
// w najgorszym przypadku VBL bedzie za dlugi i zawartosc rejestru X i innych zacznie "wariowac"

 icl '..\nibbly.hea'

 icl '..\packed.hea'

 litery_width	= 34

.struct zp
	regA	.byte
	regX	.byte
	regY	.byte
	hlp	.byte
	hlp2	.word
.end

	.extrn pusty, ile_znakow, cloc, zpage				.byte

	.extrn INPUT_STRING._1, INPUT_STRING._exit, INPUT_STRING._2	.word
	.extrn INC_ROUND, INC_ROUND._skp, NEWCRC, CRC16.calc		.word
	.extrn ADD_LEVEL, INC_ROUND.reset, INPUT_STRING 		.word
	.extrn levels, emulator, newString, color_nr			.word
	.extrn SAVE_COLOR, FADE_IN, FADE_OUT, sid_stop			.word
	.extrn __l_tcol, __h_tcol, __t_satur, __t_color			.word

	.extrn WAIT		.proc (.byte x) .reg
	.extrn SID_RESTART	.proc (.byte a) .reg

	.public title_main, code_visual


;-- MAIN PROGRAM
 .reloc

;fntTit	ins 'title_OK_3.fnt',0,[128+32]*8

ant1
 pantic logo1 , ant2

ant2
 pantic logo2 , ant1


title_main

 mva #0	$D400
 sta	_idx+1
 sta	msx_stop+1

 mva #$ff  console+1	; ani FIRE, ani START nie zostaly nacisniete

 mva #{jsr $FFFF}	INPUT_STRING._1
 mva #{nop}		INPUT_STRING._exit

 mva __color_nr  color_nr	; BYTE

 mwa #l_tcol   __l_tcol
 mwa #h_tcol   __h_tcol
 mwa #t_satur  __t_satur
 mwa #t_color  __t_color

skip lda #0
 sne
 jsr save_color		;save all colors and set value 0 for all colors

 mva #$ff  skip+1


 mwa #scrTit zpage+zp.hlp2

 ldy #0
 mva scrTit,y  buf,y+
 rne
 mva scrTit+$100,y  buf+$100,y+
 rne


 SID_RESTART #song1	; msx tytulowy

 jsr clrCode

 ldy #$0b
 lda #0
 sta $d000,y-
 rpl

 lda <nmi
 sta $fffa
 sta $fffe
 lda >nmi
 sta $fffb
 sta $ffff

 mva #$c0 $d40e		;switch on NMI+DLI again


 mwa #ant2  $d402	;ANTIC address program

 jsr fade_in		;fade in colors


repeat
 jsr clrCode

 jsr INPUT_STRING	; wpisujemy CODE


console lda #$ff
 beq quit


// wpisany kod scalamy do 3 bajtow, poprzednio formatujac go, czyli usuwamy puste znaki
// oraz znaki wieksze od "P" zamieniajac na wartosc 0, a od pozostalych znakow odejmujemy wartosc "A"

 lda INPUT_STRING._2+1		; trzeba wpisac konkretna liczbe znakow dla CODE
 cmp #ile_znakow
 bne repeat


 ldy #ile_znakow-1

modyfikuj
 lda newString,y
 cmp #pusty+1
 bcc _ok

 lda #"A"
 
_ok
 sub #"A"

_cnt
 sta newCODE,y

_skp
 dey
 bpl modyfikuj


 ldy #0
 ldx #0

scal
 lda newCODE,y
 :4 asl @
 iny
 ora newCODE,y
 iny
 sta _CRC,x

 inx
 cpx #3
 bne scal

// jesli kod jest prawidlowy zaczynamy gre od tego levelu
// jesli nie jest prawidlowy kasujemy kod i kazemy wpisywac ponownie

 ldx _CRC+1
 cpx #100+1	; max to 100 leveli
 bcs repeat

 SET_LEVEL
 
 jsr CRC16.CALC


 ldy #2
_lp2
 lda _CRC,y
 cmp NEWCRC,y
 bne repeat
 dey
 bpl _lp2

 mva _CRC+1  _level_OK

quit

* --- USTAWIAMY LEVEL

 SET_LEVEL	_level_OK


* --- zaczynamy wlasciwa gre

 jsr fade_out		;fade out colors

 mva #$ff  msx_stop+1
 jsr sid_stop

 SID_RESTART #song5

 WAIT #1

 mva #{jmp $FFFF}  INC_ROUND._skp	; odblokowujemy mozliwosco losowania kolorow pola gry

 mva #$00  $d40e
 sta $d400

 rts


_CRC	:3 brk
test    :3 brk

newCODE :6 brk

_level_OK  brk


.proc SET_LEVEL (.byte x) .reg
 stx _rep+1

 jsr INC_ROUND.reset		; koniecznie musimy wyzerowac licznik leveli

 mva #{rts}  INC_ROUND._skp	; blokujemy mozliwosc losowanie kolorow pola gry

_rep ldx #0
 beq _skip

_lp
 jsr INC_ROUND
 jsr ADD_LEVEL
 dec _rep+1
 bne _lp

_skip
 rts

.endp


clrCode
 ldy #ile_znakow-1
 lda #pusty
 sta newString,y-
 rpl 
 
code_visual
 ldy #0

 lda newString
 jsr char
 lda newString+1
 jsr char
 lda newString+2
 jsr char
 lda newString+3
 jsr char
 lda newString+4
 jsr char
 lda newString+5

char
 sub #"A"
 asl @
 tax
 lda litery,x
 sta scrTit+15*32+10,y

 lda litery+litery_width,x
 sta scrTit+15*32+10+32,y

 iny
 lda litery+1,x
 sta scrTit+15*32+10,y

 lda litery+1+litery_width,x
 sta scrTit+15*32+10+32,y

 iny
 rts

/*
litery
 ins 'title_ok_3_litery.scr',0,32
 dta 13, 13				; preparujemy dodatkowy znak '.'

 ins 'title_ok_3_litery.scr',32,32
 dta 30,31
*/

 brk
po dta b(sin(3,h,32,0,h))
px dta b(sin(3,h,32,0,h))

ad :h dta 1

msk 
:6 brk
:22 dta 1
 brk


;-- DLI PROGRAM

dli1

 mva #24 zpage+zp.hlp

k1_ lda #0	; jasn
k2_ ldx #0
k3_ ldy #0
 sta $d40a
 sta $d016
 stx $d017
 sty $d018

k1 lda #0	; kol
k2 ldx #0
k3 ldy #0
 sta $d40a
 sta $d016
 stx $d017
 sty $d018

 dec zpage+zp.hlp
 bne k1_
 DLINEW dli2


dli2
 mva #scr32 $d400

c1 lda #$04
 sta color0
c2 lda #$08
 sta color1
c3 lda #$0A
 sta color2
c4 lda #$0C
 sta color3
c5 lda #$04
 sta colpm0
 sta colpm1
c6 lda #$08
 sta colpm2
 sta colpm3
 DLINEW dli3


dli3
 sta $d40a                   ;line=80
 sta $d40a                   ;line=81
 sta $d40a                   ;line=82
 sta $d40a                   ;line=83
 sta $d40a                   ;line=84
c50 lda #$14
c60 ldx #$28
c70 ldy #$1A
 sta $d40a                   ;line=85
 sta color0
 stx color1
 sty color2
 DLINEW dli7


dli7
 sta $d40a                   ;line=96
c8 lda #$B4
c9 ldx #$C8
c10 ldy #$CA
 sta $d40a                   ;line=97
 sta color0
 stx color1
 sty color2
 DLINEW dli8


dli8
 sta $d40a                   ;line=112
 sta $d40a                   ;line=113
 sta $d40a                   ;line=114
 sta $d40a                   ;line=115
 sta $d40a                   ;line=116
c11 lda #$04
c12 ldx #$08
c13 ldy #$0A
 sta $d40a                   ;line=117
 sta color0
 stx color1
 sty color2
 DLINEW dli9


dli9
 sta $d40a                   ;line=128
 sta $d40a                   ;line=129
 sta $d40a                   ;line=130
 sta $d40a                   ;line=131
 sta $d40a                   ;line=132
c14 lda #$44
c15 ldx #$38
c16 ldy #$2A
 sta $d40a                   ;line=133
 sta color0
 stx color1
 sty color2
 DLINEW dli10


dli10
 sta $d40a                   ;line=144
 sta $d40a                   ;line=145
c17 lda #$04
c18 ldx #$08
c19 ldy #$0A
 sta $d40a                   ;line=146
 sta color0
 stx color1
 sty color2
 DLINEW dli11


dli11
c20 lda #$74
c21 ldx #$6A
 sta $d40a                   ;line=160
 sta color0
 stx color2
c22 lda #$78
; sta $d40a                   ;line=161
 sta color1
 DLINEW dli2_


dli2_
 lda #hfntTit+4		;fntTit+$400*$01
c23 ldx #$E4
c24 ldy #$C8
 sta $d40a                   ;line=184
 sta chbase
 stx color1
 sty color2
 DLINEW dli12


dli12
c25 lda #$B4
c26 ldx #$F8
; sta $d40a                   ;line=192
 sta color0
 stx color3
 jmp nmiQ


;--
nmi
 sta zpage+zp.regA
 stx zpage+zp.regX
 sty zpage+zp.regY

 bit $d40f
 bpl vbl

dliv jmp dli1

vbl			;VBL routine
 sta $d40f		;reset NMI flag

 inc cloc		;little timer

 mva #scr40 $d400	;set new screen's width

;-- first line of screen initialization

 lda #hfntTit
 sta chbase
 lda #$00
 sta colbak

_c1 lda #$04
 sta color0
_c2 lda #$08
 sta color1
_c3 lda #$0A
 sta color2
_c4 lda #$F8
 sta color3
 
 lda #$04
 sta gtictl


_idx lda #0
 eor #3
 sta _idx+1
 tay

 mva pal,y	k1_+1
 mva pal+1,y	k2_+1
 mva pal+2,y	k3_+1

 mva pal+3,y	k1+1
 mva pal+4,y	k2+1
 mva pal+5,y	k3+1

 mwa #dli1	dliv+1	;set the first address of DLI interrupt

msx_stop lda #$ff
 sne
 jsr emulator		; gra SID PLAYER


 :2 jsr migaj


 lda $d01f
 and #1
 beq _con

 lda $d010
 bne nmiQ

_con
 sta console+1

 mva #{rts} INPUT_STRING._1
 sta INPUT_STRING._exit

nmiQ
 lda zpage+zp.regA
 ldx zpage+zp.regX
 ldy zpage+zp.regY
 rti


*---- MIGOTANIE

 h = 16

.proc migaj

 ldy #63
_inv
b0 lda buf,y
 sta (zpage+zp.hlp2),y
 dey
 bpl _inv


idx ldx #h/2-1

_lp
 ldy px,x

 lda (zpage+zp.hlp2),y
 eor #$80
 sta (zpage+zp.hlp2),y
 iny
 lda (zpage+zp.hlp2),y
 eor #$80
 sta (zpage+zp.hlp2),y
 iny
 lda (zpage+zp.hlp2),y
 eor #$80
 sta (zpage+zp.hlp2),y

 tya
 add #32-2
 tay

 lda (zpage+zp.hlp2),y
 eor #$80
 sta (zpage+zp.hlp2),y
 iny
 lda (zpage+zp.hlp2),y
 eor #$80
 sta (zpage+zp.hlp2),y
 iny
 lda (zpage+zp.hlp2),y
 eor #$80
 sta (zpage+zp.hlp2),y

 lda zpage+zp.hlp2
 add #64
 sta zpage+zp.hlp2
 scc
 inc zpage+zp.hlp2+1

 lda b0+1
 add #64
 sta b0+1
 scc
 inc b0+2

 lda px,x
 clc
_eor :2 nop
 adc ad,x
 and #$1f
 sta px,x

 tay
 lda msk,y 
 bne _skp

 lda ad,x
 eor #$fe
 sta ad,x

_skp

 dec idx+1
 bne _sk


 mva #h/2-1	idx+1

 mwa #scrTit	zpage+zp.hlp2

 mwa #buf	b0+1


 inc tim+1
tim lda #0
 and #$7f
 bne _sk

 ldy #h-1
 lda #1
 sta ad,y-
 rpl

 ldy #h-1
 mva po,y  px,y-
 rpl

 lda _eor
 eor #[{adc #}^{nop}]
 sta _eor

 lda _eor+1
 eor #[1^{nop}]
 sta _eor+1

_sk
 rts

.endp


;--
; .link 'title_fade.obx'

l_tcol
 dta l(c50,c60,c70)
 dta l(_c1,_c2,_c3,_c4)
 dta l(c1,c2,c3,c4,c5,c6,c8,c9)
 dta l(c10,c11,c12,c13,c14,c15,c16,c17)
 dta l(c18,c19,c20,c21,c22,c23,c24,c25,c26)
 dta l(pal-1,pal,pal+1)
 dta l(pal+2,pal+3,pal+4)
 dta l(pal+5,pal+6,pal+7)

h_tcol
 dta h(c50,c60,c70)
 dta h(_c1,_c2,_c3,_c4)
 dta h(c1,c2,c3,c4,c5,c6,c8,c9)
 dta h(c10,c11,c12,c13,c14,c15,c16,c17)
 dta h(c18,c19,c20,c21,c22,c23,c24,c25,c26)
 dta h(pal-1,pal,pal+1)
 dta h(pal+2,pal+3,pal+4)
 dta h(pal+5,pal+6,pal+7)

 ?ile = h_tcol-l_tcol
__color_nr	dta b(?ile)


t_satur :?ile brk
t_color :?ile brk


pal
 dta $24,$a6,$2a
 dta $74,$b6,$98
 dta $24,$a6,$2a


;logo1	ins 'logomax1.dat'
;logo2	ins 'logomax2.dat'


 blk update address
 blk update external
 blk update public

*---

 opt l-

.macro DLINEW
 mwa #:1 dliv+1
 jmp nmiQ
.endm


.macro pantic
 dta $70,$70+$80
 dta $4e,a(:1)
 :+47 dta $0e
 dta $70+$80
 dta $44,a(scrTit),$84,$04,$84,$04,$84,$04,$84,$04,$84,$04,$84,$04,$04,$84,$70+$80,$04,$04
 dta $41,a(:2)
.endm
