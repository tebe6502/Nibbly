* NIBBLY TITLE SCREEN v1.1 (14.05.2006) by Tebe/Madteam

 icl '..\nibbly.hea'

cloc	= $0014		;(1)

ftmp	= $80		;(2)
regA	= ftmp+2	;(1)
regX	= regA+1	;(1)
regY	= regX+1	;(1)
hlp	= regY+1	;(1)
hlp2	= hlp+1		;(2)

;-- MAIN PROGRAM
 org $2000

logo1	ins 'logomax1.dat'
logo2	ins 'logomax2.dat'

 org $3000
fntTit	ins 'title_OK_2.fnt',0,124*8

 org $3400

ant1
 pantic logo1 , ant2

ant2
 pantic logo2 , ant1


?flen = 640

 .get 'title_OK_2.scr',0,?flen

 :?flen-5*32	.put[.r] := .get[.r]&$7f


scrTit
 .sav [0] ?flen

buf
 .sav [0] ?flen


main
;-- init PMG
 mva >pmg $d407		;missiles and players data address
 mva #3 $d01d		;enable players and missiles

 jsr save_color		;save all colors and set value 0 for all colors

 ldy #8
 lda #0
 sta 704,y-
 rpl

 WAIT #1		;wait 1 frame

 sei			;stop interrups
 mva #0 $d40e		;stop all interrupts
 sta $d400
 sta 559
 mva #$fe $d301		;switch off ROM to get 16k more ram

 ldy #$0b
 lda #0
 sta $d000,y-
 rpl

?ofs=192

 ldy #39
_cp
 mva _pmg0,y pmg+$300+?ofs,y
 mva _pmg1,y pmg+$400+?ofs,y
 mva _pmg2,y pmg+$500+?ofs,y
 mva _pmg3,y pmg+$600+?ofs,y
 mva _pmg4,y pmg+$700+?ofs,y
 dey
 bpl _cp

 mwa #nmi $fffa		;new NMI handler

 mva #$c0 $d40e		;switch on NMI+DLI again


 mwa #ant2   $d402		;ANTIC address program

 jsr fade_in		;fade in colors


*---- MIGOTANIE

h = [?flen-4*32]/32

loop
 mwa #scrTit hlp2

 ldy #30

_cop

 :h	mva buf+#*32,y  scrTit+#*32,y

 dey
 bpl _cop


 ldx #1
_lp
 ldy px,x

 lda (hlp2),y
 eor #$80
 sta (hlp2),y
 iny
 lda (hlp2),y
 eor #$80
 sta (hlp2),y
 iny
 lda (hlp2),y
 eor #$80
 sta (hlp2),y

 tya
 add #32-2
 tay

 lda (hlp2),y
 eor #$80
 sta (hlp2),y
 iny
 lda (hlp2),y
 eor #$80
 sta (hlp2),y
 iny
 lda (hlp2),y
 eor #$80
 sta (hlp2),y

 lda hlp2
 add #64
 sta hlp2
 scc
 inc hlp2+1

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

 inx
 cpx #h/2
 bne _lp

 WAIT #3

 inc tim+1
tim lda #0
 and #$7f
 bne _sk

 ldy #h-1
cp
 mva po,y px,y
 lda #1
 sta ad,y
 dey
 bpl cp

 lda _eor
 eor #[{adc #}^{nop}]
 sta _eor

 lda _eor+1
 eor #[1^{nop}]
 sta _eor+1

_sk
 jmp loop


 jsr fade_out		;fade out colors

 jmp *


 brk
po dta b(sin(3,h,32,0,h))
px dta b(sin(3,h,32,0,h))
ad :h dta 1

msk 
:6 brk
:22 dta 1
 brk


;-- DLI PROGRAM

 ?old_dli = *

dli1

 mva #24 hlp

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

 dec hlp
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
c7 lda #$14
c8 ldx #$28
c9 ldy #$1A
 sta $d40a                   ;line=85
 sta color0
 stx color1
 sty color2
 DLINEW dli5

dli5
 sta $d40a                   ;line=96
c10 lda #$B4
c11 ldx #$C8
c12 ldy #$CA
 sta $d40a                   ;line=97
 sta color0
 stx color1
 sty color2
 DLINEW dli6

dli6
 sta $d40a                   ;line=112
 sta $d40a                   ;line=113
 sta $d40a                   ;line=114
 sta $d40a                   ;line=115
 sta $d40a                   ;line=116
c13 lda #$04
c14 ldx #$08
c15 ldy #$0A
 sta $d40a                   ;line=117
 sta color0
 stx color1
 sty color2
 DLINEW dli7

dli7
 sta $d40a                   ;line=128
 sta $d40a                   ;line=129
 sta $d40a                   ;line=130
 sta $d40a                   ;line=131
 sta $d40a                   ;line=132
c16 lda #$44
c17 ldx #$38
c18 ldy #$2A
 sta $d40a                   ;line=13
 sta color0
 stx color1
 sty color2
 DLINEW dli8

dli8
 sta $d40a                   ;line=144
 sta $d40a                   ;line=145
c19 lda #$04
c20 ldx #$08
c21 ldy #$0A
 sta $d40a                   ;line=146
 sta color0
 stx color1
 sty color2
 DLINEW dli9

dli9
 sta $d40a                   ;line=160
 sta $d40a                   ;line=161
c22 lda #$74
c23 ldx #$78
c24 ldy #$6A
 sta $d40a                   ;line=162
 sta color0
 stx color1
 sty color2
 DLINEW dli10

dli10
c25 lda #$84
c26 ldx #$88
c27 ldy #$8A
 sta $d40a                   ;line=192
 sta color0
 stx color1
 sty color2
c28 lda #$0A
 sta color3
 DLINEW dli11

dli11
 sta $d40a                   ;line=208
 sta $d40a                   ;line=209
 sta $d40a                   ;line=210
 sta $d40a                   ;line=211
 sta $d40a                   ;line=212
c29 lda #$F4
c30 ldx #$F8
c31 ldy #$FA
 sta $d40a                   ;line=213
 sta color0
 stx color1
 sty color2
 sta $d40a                   ;line=214
 lda #$62
 ldx #$6C
 sta $d40a                   ;line=215
 sta hposp1
 stx hposm0
 sta $d40a                   ;line=216
 sta $d40a                   ;line=217
 lda #$59
 sta $d40a                   ;line=218
 sta hposp0
 sta hposp2
 lda #$6A
 ldx #$6C
 sta $d40a                   ;line=219
 sta hposm0
 stx hposm2
 lda #$6A
 sta $d40a                   ;line=220
 sta hposm2
 sta $d40a                   ;line=221
 lda #$58
c32 ldx #$08
 sta $d40a                   ;line=222
 sta hposm1
 stx colpm1
 lda #$6F
c33 ldx #$04
 sta $d40a                   ;line=223
 sta hposm1
 stx colpm1
 jmp nmiQ

;--
nmi
 sta regA
 stx regX
 sty regY

 bit $d40f
 bpl vbl

dliv jmp dli1

vbl			;VBL routine
 sta $d40f		;reset NMI flag

 inc cloc		;little timer

 mva #scr40 $d400	;set new screen's width

;-- first line of screen initialization

 lda >fntTit
 sta chbase
c0 lda #$00
 sta colbak

 lda #$04
 sta gtictl
 lda #$00
 sta sizep0
 sta sizep1
 sta sizep2
 sta sizep3
 sta sizem
 lda #$58
 sta hposp0
 lda #$61
 sta hposp1
 lda #$58
 sta hposp2
 lda #$62
 sta hposp3
 lda #$6A
 sta hposm0
 lda #$6F
 sta hposm1
 lda #$6B
 sta hposm2
 lda #$70
 sta hposm3

_idx lda #0
 eor #3
 sta _idx+1
 tay

 lda pal,y
 sta k1_+1
 lda pal+1,y
 sta k2_+1
 lda pal+2,y
 sta k3_+1

 lda pal+3,y
 sta k1+1
 lda pal+4,y
 sta k2+1
 lda pal+5,y
 sta k3+1

 mwa #dli1 dliv+1	;set the first address of DLI interrupt

;this area is for yours routines

nmiQ
 lda regA
 ldx regX
 ldy regY
 rti

;--
 .link 'title_fade.obx'

__l_tcol	dta a(l_tcol)
__h_tcol	dta a(h_tcol)
__t_satur	dta a(t_satur)
__t_color	dta a(t_color)


l_tcol
 dta l(c0,c1,c2,c3,c4,c5,c6,c7,c8,c9)
 dta l(c10,c11,c12,c13,c14,c15,c16,c17)
 dta l(c18,c19,c20,c21,c22,c23,c24,c25)
 dta l(c26,c27,c28,c28,c30,c31,c32,c33)
 dta l(pal-1,pal,pal+1)
 dta l(pal+2,pal+3,pal+4)
 dta l(pal+5,pal+6,pal+7)

h_tcol
 dta h(c0,c1,c2,c3,c4,c5,c6,c7,c8,c9)
 dta h(c10,c11,c12,c13,c14,c15,c16,c17)
 dta h(c18,c19,c20,c21,c22,c23,c24,c25)
 dta h(c26,c27,c28,c28,c30,c31,c32,c33)
 dta h(pal-1,pal,pal+1)
 dta h(pal+2,pal+3,pal+4)
 dta h(pal+5,pal+6,pal+7)

?ile = h_tcol-l_tcol
color_nr	dta ?ile


t_satur .ds ?ile
t_color .ds ?ile

pal
 dta $24,$a6,$2a
 dta $74,$b6,$98
 dta $24,$a6,$2a


_pmg0
 dta $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$04,$80
 dta $00,$80,$58,$01,$20,$00,$A0,$45,$00,$00,$00,$00,$00,$00,$04,$80
 dta $00,$80,$69,$12,$20,$00,$A8,$54
_pmg1
 dta $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$01,$0A,$01
 dta $00,$06,$01,$00,$00,$00,$02,$09,$00,$00,$00,$00,$00,$10,$A0,$10
 dta $00,$60,$21,$08,$04,$00,$40,$29
_pmg2
 dta $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$40,$00
 dta $00,$00,$81,$08,$00,$00,$00,$49,$00,$00,$00,$00,$00,$00,$40,$00
 dta $00,$00,$02,$10,$08,$00,$00,$92
_pmg3
 dta $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$04,$01,$08
 dta $00,$08,$04,$01,$00,$00,$08,$04,$00,$00,$00,$00,$00,$40,$10,$80
 dta $00,$80,$84,$21,$0A,$00,$09,$84
_pmg4
 dta $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$80
 dta $00,$80,$48,$02,$10,$00,$90,$49,$00,$00,$00,$00,$00,$00,$00,$80
 dta $00,$80,$08,$02,$14,$00,$92,$48


 run main

*---

 opt l-

.macro DLINEW
 ift .hi(?old_dli)==.hi(:1)
  mva <:1 dliv+1
 els
  mwa #:1 dliv+1
 eif

 jmp nmiQ

 ?old_dli = *
.endm

.macro pantic
 dta $70+$80
 dta $4e,a(:1)
 :+47 dta $0e
 dta $70+$80
 dta $44,a(scrTit),$84,$04,$84,$04,$84,$04,$84,$04,$84,$04,$84,$04,$04,$04,$F0,$04,$84,$04,$04,$04
 dta $41,a(:2)
.endm
