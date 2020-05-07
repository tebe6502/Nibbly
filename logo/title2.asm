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
 jmp NmiQuit
dli_start


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

 lda >fnt
 sta chbase
c0 lda #$00
 sta colbak
c1 lda #$0A
 sta color0
c2 lda #$78
 sta color1
c3 lda #$64
 sta color2
c4 lda #$34
 sta color3
 lda #$04
 sta gtictl
 lda #$01
 sta sizep2
 sta sizep3
 lda #$00
 sta sizem
 lda #$68
 sta hposp2
 lda #$58
 sta hposp3
 lda #$5C
 sta hposm3
c5 lda #$38
 sta colpm2
 sta colpm3

 mwa #dli_start dliv+1	;set the first address of DLI interrupt

;this area is for yours routines

NmiQuit
 lda regA
 ldx regX
 ldy regY
 rti

;--
 icl 'title2.fad'

 run main

*---

 opt l-

.macro SPRITES
 dta $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
 dta $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
 dta $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
 dta $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
 dta $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
 dta $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
 dta $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
 dta $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
 dta $00,$00,$80,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
 dta $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
 dta $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
 dta $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
 dta $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
 dta $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
 dta $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
 dta $00,$00,$00,$00,$00,$00,$00,$00,$3F,$3F,$3F,$3F,$3F,$3F,$3F,$3F

 .ds $100
 .ds $100
 dta $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
 dta $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
 dta $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
 dta $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
 dta $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
 dta $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
 dta $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
 dta $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
 dta $98,$00,$98,$A8,$A8,$A8,$28,$28,$A8,$08,$30,$00,$00,$00,$00,$00
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
 dta $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
 dta $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
 dta $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
 dta $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
 dta $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
 dta $59,$00,$51,$AA,$8A,$AA,$8B,$AA,$AA,$00,$80,$00,$00,$00,$00,$00
 dta $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
 dta $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
 dta $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
 dta $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
 dta $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
 dta $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
 dta $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00

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
 dta $70,$70,$70,$70,$70,$70,$70,$70,$70,$70,$70,$70,$44,a(:1),$04,$04,$04,$04,$70,$70,$04,$04,$70,$70,$70,$70,$70,$70,$70,$70,$70
 dta $41,a(:2)
.endm

.macro SCREEN_DATA
 ins 'title2.scr'
.endm

.macro FONTS
 ins 'title2.fnt'
.endm
