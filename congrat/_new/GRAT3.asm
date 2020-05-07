/***************************************/
/*  Use MADS http://mads.atari8.info/  */
/*  Mode: DLI (char mode)              */
/***************************************/

scr48	= %00111111	;screen 48b
scr40	= %00111110	;screen 40b
scr32	= %00111101	;screen 32b

cloc	= $0014		;(1)
byt2	= $0000		;(1) <$0100
byt3	= $0100		;(1) >$00FF

ftmp	= $80		;(2)
regA	= ftmp+2	;(1)
regX	= regA+1	;(1)
regY	= regX+1	;(1)

hposp0	 = $D000
hposp1	 = $D001
hposp2	 = $D002
hposp3	 = $D003
hposm0	 = $D004
hposm1	 = $D005
hposm2	 = $D006
hposm3	 = $D007
sizep0	 = $D008
sizep1	 = $D009
sizep2	 = $D00A
sizep3	 = $D00B
sizem	 = $D00C

colpm0	 = $D012
colpm1	 = $D013
colpm2	 = $D014
colpm3	 = $D015
color0	 = $D016
color1	 = $D017
color2	 = $D018
color3	 = $D019
colbak	 = $D01A
gtictl	 = $D01B

chbase	 = $D409

;-- BASIC switch OFF
 org $2000
 mva #$ff $d301
 rts
 ini $2000

;-- MAIN PROGRAM
 org $2000

ant	ANTIC_PROGRAM scr,ant

scr	SCREEN_DATA

	ALIGN $0400
fnt	FONTS

	ALIGN $1000
	.ds $0300
pmg	SPRITES

main
;-- init PMG
 mva >pmg $d407		;missiles and players data address
 mva #3 $d01d		;enable players and missiles

 ift .def CHANGES	;if label CHANGES defined
 jsr save_color		;then save all colors and set value 0 for all colors
 eif

 lda:cmp:req 20		;wait 1 frame

 sei			;stop interrups
 mva #0 $d40e		;stop all interrupts
 mva #$fe $d301		;switch off ROM to get 16k more ram

 mwa #nmi $fffa		;new NMI handler

 mva #$c0 $d40e		;switch on NMI+DLI again

 ift .def CHANGES	;if label CHANGES defined
 jsr fade_in		;fade in colors
_lp lda $d20f		;wait to press any key; here you can put any own routine
 and #4
 bne _lp
 jsr fade_out		;fade out colors
 mva #0   $d01d		;PMG disabled
 mva #$ff $d301		;ROM switch on
 mva #$40 $d40e		;only NMI interrupts, DLI disabled
 cli			;IRQ enabled
 jmp ($a)		;jump to DOS
 els
null jmp dli1		;CPU is busy here, so no more routines allowed
 eif

;-- DLI PROGRAM

 ?old_dli = *

dli1
 lda $d40b
 cmp #2
 bne dli1
 :3 sta $d40a
 DLINEW dli9

dli_start
dli9

 sta $d40a                   ;line=24
 sta $d40a                   ;line=25
 sta $d40a                   ;line=26
 sta $d40a                   ;line=27
 sta $d40a                   ;line=28
 sta $d40a                   ;line=29
c9 lda #$E8
 sta $d40a                   ;line=30
 sta color3
 sta $d40a                   ;line=31
 sta $d40a                   ;line=32
c10 lda #$F8
 sta $d40a                   ;line=33
 sta color3
 sta $d40a                   ;line=34
 sta $d40a                   ;line=35
 sta $d40a                   ;line=36
c11 lda #$18
 sta $d40a                   ;line=37
 sta color3
 DLINEW dli10

dli10

 sta $d40a                   ;line=40
c12 lda #$28
 sta $d40a                   ;line=41
 sta color3
 sta $d40a                   ;line=42
 sta $d40a                   ;line=43
c13 lda #$38
 sta $d40a                   ;line=44
 sta color3
 sta $d40a                   ;line=45
 sta $d40a                   ;line=46
c14 lda #$84
 sta $d40a                   ;line=47
 sta colpm3
c15 lda #$48
 ldx #$A1
 ldy #$7A
 sta $d40a                   ;line=48
 sta color3
 stx hposp1
 sty hposp3
c16 lda #$C4
 sta colpm1
 sta $d40a                   ;line=49
 sta $d40a                   ;line=50
 sta $d40a                   ;line=51
c17 lda #$58
 ldx #$84
 sta $d40a                   ;line=52
 sta color3
 stx hposm1
 sta $d40a                   ;line=53
 sta $d40a                   ;line=54
c18 lda #$68
 sta $d40a                   ;line=55
 sta color3
 lda #$C7
 sta $d40a                   ;line=56
 sta hposp2
 sta $d40a                   ;line=57
 sta $d40a                   ;line=58
c19 lda #$78
 ldx #$6B
 sta $d40a                   ;line=59
 sta color3
 stx hposm2
 sta $d40a                   ;line=60
 sta $d40a                   ;line=61
c20 lda #$E4
 sta $d40a                   ;line=62
 sta colpm2
c21 lda #$88
 ldx #$38
 sta $d40a                   ;line=63
 sta color3
 stx hposp0
 lda >fnt+$400*$01
 sta $d40a                   ;line=64
 sta chbase
 sta $d40a                   ;line=65
c22 lda #$98
 sta $d40a                   ;line=66
 sta color3
 sta $d40a                   ;line=67
 sta $d40a                   ;line=68
 lda #$AD
 sta $d40a                   ;line=69
 sta hposm3
c23 lda #$A8
 sta $d40a                   ;line=70
 sta color3
 sta $d40a                   ;line=71
 sta $d40a                   ;line=72
c24 lda #$B8
 ldx #$6E
 ldy #$AE
 sta $d40a                   ;line=73
 sta color3
 stx hposp1
 sty hposm3
 sta $d40a                   ;line=74
 lda #$C4
 sta $d40a                   ;line=75
 sta hposm3
c25 lda #$F8
 sta $d40a                   ;line=76
 sta colpm3
c26 lda #$C8
 sta $d40a                   ;line=77
 sta color3
 DLINEW dli11

dli11

 sta $d40a                   ;line=80
c27 lda #$D8
 sta $d40a                   ;line=81
 sta color3
 sta $d40a                   ;line=82
 sta $d40a                   ;line=83
c28 lda #$E8
 sta $d40a                   ;line=84
 sta color3
 DLINEW dli2


dli2
 lda >fnt+$400*$00
c29 ldx #$F8
 sta $d40a                   ;line=88
 sta chbase
 stx color3
 sta $d40a                   ;line=89
 sta $d40a                   ;line=90
 sta $d40a                   ;line=91
c30 lda #$04
c31 ldx #$F8
c32 ldy #$18
 sta $d40a                   ;line=92
 sta color0
 stx color2
 sty color3
 sta $d40a                   ;line=93
c33 lda #$34
 sta $d40a                   ;line=94
 sta color0
 DLINEW dli3

dli3
 lda >fnt+$400*$01
 sta $d40a                   ;line=104
 sta chbase
 DLINEW dli4

dli4
 lda >fnt+$400*$00
 sta $d40a                   ;line=152
 sta chbase
 DLINEW dli12

dli12

 sta $d40a                   ;line=160
 sta $d40a                   ;line=161
 sta $d40a                   ;line=162
 sta $d40a                   ;line=163
 sta $d40a                   ;line=164
 sta $d40a                   ;line=165
c34 lda #$C4
c35 ldx #$78
 sta $d40a                   ;line=166
 sta color0
 stx color2
 DLINEW dli5

dli5
 lda >fnt+$400*$01
 sta $d40a                   ;line=168
 sta chbase
 DLINEW dli6

dli6
 lda >fnt+$400*$00
 sta $d40a                   ;line=200
 sta chbase
 jmp NmiQuit

;--

CHANGES

nmi
 sta regA
 stx regX
 sty regY

 bit $d40f
 bpl vbl

dliv jmp dli_start

vbl			;VBL routine
 sta $d40f		;reset NMI flag

 inc cloc		;little timer

 mwa #ant   $d402		;ANTIC address program
 mva #scr40 $d400	;set new screen's width

;-- first line of screen initialization

 lda >fnt+$400*$00
 sta chbase
c0 lda #$00
 sta colbak
c1 lda #$0A
 sta color0
c2 lda #$F4
 sta color1
c3 lda #$18
 sta color2
c4 lda #$D8
 sta color3
 lda #$04
 sta gtictl
 lda #$00
 sta sizep0
 sta sizep1
 sta sizep2
 sta sizep3
 lda #$55
 sta sizem
 lda #$52
 sta hposp0
 lda #$9B
 sta hposp1
 lda #$C5
 sta hposp2
 lda #$3A
 sta hposp3
 lda #$BE
 sta hposm0
 lda #$4B
 sta hposm1
 lda #$8F
 sta hposm2
 lda #$AF
 sta hposm3
c5 lda #$48
 sta colpm0
c6 lda #$04
 sta colpm1
c7 lda #$34
 sta colpm2
c8 lda #$24
 sta colpm3

 mwa #dli_start dliv+1	;set the first address of DLI interrupt

;this area is for yours routines

NmiQuit
 lda regA
 ldx regX
 ldy regY
 rti

;--
 icl 'GRAT3.fad'

 run main

*---

 opt l-

.macro SPRITES
 dta $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
 dta $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
 dta $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$10,$30,$30,$30,$20,$00
 dta $00,$00,$40,$40,$88,$CC,$8C,$84,$80,$80,$80,$C0,$00,$40,$20,$00
 dta $01,$01,$03,$01,$00,$01,$00,$00,$00,$00,$00,$00,$30,$F8,$F8,$F8
 dta $DC,$C4,$C0,$40,$C0,$C0,$C0,$C0,$00,$00,$00,$00,$00,$00,$00,$00
 dta $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
 dta $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
 dta $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
 dta $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
 dta $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
 dta $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
 dta $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
 dta $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
 dta $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
 dta $00,$00,$00,$00,$00,$00,$00,$00,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF

 dta $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
 dta $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
 dta $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
 dta $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
 dta $28,$14,$18,$0C,$08,$00,$0A,$00,$00,$00,$02,$3C,$D5,$38,$00,$00
 dta $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
 dta $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
 dta $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
 dta $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
 dta $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
 dta $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
 dta $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
 dta $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
 dta $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
 dta $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
 dta $00,$00,$00,$00,$00,$00,$00,$00,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF

 dta $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
 dta $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
 dta $00,$00,$00,$00,$00,$00,$00,$00,$00,$50,$28,$74,$6A,$34,$00,$00
 dta $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
 dta $00,$00,$00,$00,$00,$00,$00,$20,$50,$38,$18,$94,$58,$74,$28,$50
 dta $E0,$04,$14,$28,$38,$18,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
 dta $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
 dta $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
 dta $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
 dta $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
 dta $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
 dta $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
 dta $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
 dta $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
 dta $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
 dta $00,$00,$00,$00,$00,$00,$00,$00,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF

 dta $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
 dta $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
 dta $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
 dta $00,$00,$00,$00,$00,$00,$80,$40,$28,$40,$28,$74,$3C,$1C,$3C,$3C
 dta $78,$78,$78,$2C,$14,$00,$00,$08,$1C,$1A,$0C,$16,$18,$16,$00,$14
 dta $20,$14,$00,$40,$80,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
 dta $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
 dta $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
 dta $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
 dta $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
 dta $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
 dta $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
 dta $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
 dta $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
 dta $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
 dta $00,$00,$00,$00,$00,$00,$00,$00,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF

 dta $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
 dta $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
 dta $00,$00,$00,$00,$00,$00,$00,$00,$00,$10,$0C,$15,$2B,$1F,$6F,$16
 dta $0E,$04,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$02,$25
 dta $28,$06,$28,$5C,$7C,$70,$78,$D8,$E8,$50,$88,$50,$00,$00,$40,$00
 dta $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
 dta $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
 dta $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
 dta $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
 dta $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
 dta $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
 dta $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
 dta $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
 dta $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
 dta $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
 dta $00,$00,$00,$00,$00,$00,$00,$00,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF

.endm

.macro DLINEW
 ift .hi(?old_dli)==.hi(:1)
  mva <:1 dliv+1
 els
  mwa #:1 dliv+1
 eif

 jmp NmiQuit

 ?old_dli = *
.endm

.macro ALIGN
 ift (*/:1)*:1<>*
  org (*/:1)*:1+:1
 eif
.endm

.macro ANTIC_PROGRAM
 dta $70,$70,$F0,$44,a(:1),$84,$04,$04,$04,$04,$84,$84,$70,$F0,$04,$04,$04,$04,$04,$84,$F0,$F0,$04,$04,$04,$84,$70,$70,$70,$70,$70
 dta $41,a(:2)
.endm

.macro SCREEN_DATA
 ins 'GRAT3.scr'
.endm

.macro FONTS
 ins 'GRAT3.fnt'
.endm
