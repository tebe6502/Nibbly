/********************************************/
/*   Use MADS http://g2f.atari8.info/mads   */
/*   Mode: GED- (bitmap mode)               */
/********************************************/

scr48	equ %00111111	;screen 48b
scr40	equ %00111110	;screen 40b
scr32	equ %00111101	;screen 32b

cloc	equ $0014	;(1)
byt2	equ $0000	;(1) <$0100
byt3	equ $0100	;(1) >$00FF

ftmp	equ $80		;(2)
regA	equ ftmp+2	;(1)
regX	equ regA+1	;(1)
regY	equ regX+1	;(1)

bajt	equ $e0


hposp0	equ $D000
hposp1	equ $D001
hposp2	equ $D002
hposp3	equ $D003
hposm0	equ $D004
hposm1	equ $D005
hposm2	equ $D006
hposm3	equ $D007
sizep0	equ $D008
sizep1	equ $D009
sizep2	equ $D00A
sizep3	equ $D00B
sizem	equ $D00C

colpm0	equ $D012
colpm1	equ $D013
colpm2	equ $D014
colpm3	equ $D015
color0	equ $D016
color1	equ $D017
color2	equ $D018
color3	equ $D019
colbak	equ $D01A
gtictl	equ $D01B

chbase	equ $D409

;-- BASIC switch OFF
 org $2000
 lda #$ff
 sta $d301
 rts
 ini $2000

;-- MAIN PROGRAM
 org $2000

scr	SCREEN_DATA

 ift .def nil_used
nil :8*40 brk
 eif

	ALIGN $0400
ant	ANTIC_PROGRAM scr,ant

fnt

	ALIGN $1000
	org *+$0300
pmg	SPRITES

main
;-- init PMG
 mva >pmg $d407		;missiles and players data address
 mva #3 $d01d		;enable players and missiles

 lda:cmp:req 20		;wait 1 frame
 
 lda #$cc
 sta bajt

 sei			;stop interrups
 mva #0 $d40e		;stop all interrupts
 mva #$fe $d301		;switch off ROM to get 16k more ram

 mva #scr40 $d400	;set new screen width

;-- RASTER PROGRAM
LOOP lda $d40b		;synchronization for the first change of screen line
 cmp #2
 bne LOOP
 :3 sta $d40a

;-- wait 34 cycle
 jsr _rts
 :2 inc byt2
 mwa #ant $d402

;-- set global ofset
 :2 nop

;-- empty line
 jsr wait54cycle
 inc byt2

; line=0

 jsr wait54cycle
 inc byt2

; line=1

 jsr wait54cycle
 inc byt2

; line=2

 jsr wait54cycle
 inc byt2

; line=3

 jsr wait54cycle
 inc byt2

; line=4

 jsr wait54cycle
 inc byt2

; line=5

 jsr wait54cycle
 inc byt2

; line=6

 jsr wait54cycle
 inc byt2

; line=7

 jsr wait54cycle
 cmp byt2

; line=8

 jsr wait54cycle
 inc byt2

; line=9

 jsr wait54cycle
 inc byt2

; line=10

 jsr wait54cycle
 inc byt2

; line=11

 jsr wait54cycle
 inc byt2

; line=12

 jsr wait54cycle
 inc byt2

; line=13

 jsr wait54cycle
 inc byt2

; line=14

 jsr wait54cycle
 inc byt2

; line=15

 jsr wait54cycle
 cmp byt2

; line=16

 jsr wait54cycle
 inc byt2

; line=17

 jsr wait54cycle
 inc byt2

; line=18

 jsr wait54cycle
 inc byt2

; line=19

 jsr wait54cycle
 inc byt2

; line=20

 jsr wait54cycle
 inc byt2

; line=21

 jsr wait54cycle
 inc byt2

; line=22

 lda #$00
 sta $d01e
 lda #$00
 sta $d01e
 lda #$00
 sta $d01e
 lda #$00
 sta $d01e
 lda #$00
 cmp byt2
 sta colbak
 cmp byt2
 lda #$00
 sta $d01e
 lda #$00
 sta $d01e
 lda #$b4
 inc byt2
 sta $d01e

; line=23

 sta colbak
 lda #$00
 lda #$00
 sta $d01e
 lda #$00
 sta $d01e
 lda #$00
 sta $d01e
 lda #$00
 cmp byt2
 sta colbak
 cmp byt2
 lda #$00
 sta $d01e
 lda #$78
 sta colpm2
 lda #$b4
 cmp byt2
 sta $d01e

; line=24


.macro linia
 lda #$00
 ldx #$00
 ldy #$00
 sta color1
 stx $d01e
 sty $d01e
 lda #$40
 sta $D001
 sta $D000
 lda #$64
 sta $D001
 sta $D000
 lda #$64+52
 sta $D001
 sta $D000
 lda bajt
 sta $D001
 sta $D000
; inc byt2
.endm


 cmp byt2
 sta colbak
 cmp byt2
 lda #$00
 sta color1
 nop
 lda #$40
 sta $D001
 sta $D000
 lda #$64
 sta $D001
 sta $D000
 lda #$64+52
 sta $D001
 sta $D000
 lda bajt
 sta $D001
 sta $D000
; inc byt2


.rept 7 \ linia \ .endr


*- 1
 lda #$78
 ldx #$00
 ldy #$00
 sta color1
 stx colpm2
 sty $d01e
 lda #$00
 sta $d01e
 cmp byt2
 sta colbak
 cmp byt2
 sta $d01e
 lda #$00
 sta $d01e
 sta $d01e
 lda #$b4
 sta $d01e
 inc byt2
 sta colbak

*- 2
 lda #$78
; ldx #$00
; ldy #$00
 sta color1
 stx $d01e
 sty $d01e
 lda #$00
 sta $d01e
 cmp byt2
 sta colbak
 cmp byt2
 sta $d01e
 lda #$00
 sta $d01e
 sta $d01e
 lda #$b4
 sta $d01e
 inc byt2
 sta colbak

*- 3
 lda #$78
; ldx #$00
; ldy #$00
 sta color1
 stx $d01e
 sty $d01e
 lda #$00
 sta $d01e
 cmp byt2
 sta colbak
 cmp byt2
 sta $d01e
 lda #$00
 sta $d01e
 sta $d01e
 lda #$b4
 sta $d01e
 inc byt2
 sta colbak

 :2 sta $d40a

 lda #$00
 sta $d40a
 sta color2

 sta $d40a
 

c0 lda #$b4
 sta colbak
c1 lda #$14
 sta color0
 sta colpm1
 sta colpm3
c2 lda #$78
 sta color1
 sta colpm0
c3 lda #$0C
 sta color2
c4 lda #$3C
 sta color3

 lda #$1
 sta gtictl

 lda #$00
 sta sizep0
 sta sizep1
 sta sizep2
 sta sizep3
 sta colpm2

 lda #48
 sta hposp2
 sta hposp3

 jmp LOOP

;--

wait54cycle
 :2 inc byt2
wait44cycle
 inc byt3
 nop
wait36cycle
 inc byt3
 jsr _rts
wait18cycle
 inc byt3
_rts rts

;--

.macro SCREEN_DATA
 ins 'panel_2.raw'
.endm

.macro ANTIC_PROGRAM
 dta $4e,a(:1+$0000),$f,$f,$f,$f,$f,$f,$f
 dta $4e,a(:1+$0140),$e,$e,$e,$e,$e,$e,$e
 dta $4e,a(:1+$0280),$e,$e,$e,$e,$e,$e,$e
 dta $4f,a(:1+$03C0),$f,$f,$f,$f,$f,$f,$f
 dta $4e,a(:1+$0500),$e,$e,$e,$e,$e,$e,$e

 dta $41,a(:2)
.endm

.macro SPRITES
 org *+$100

 :+32 brk
 dta %00100000,%01000000,%00100000,%00100000,%00100000,%00100000,%01000000,%00100000
 :+13*16+8 brk

 :+32 brk
 dta %10010000,%00100000,%10010000,%10010000,%10010000,%10010000,%00100000,%10010000
 :+13*16+8 brk

 :+31 brk
 dta %00001110
 dta %00100000,%01000000,%00100000,%00100000,%00100000,%00100000,%01000000,%00100000
 :+2 dta %00001111
 :+13*16+6 brk

 :+32 brk
 dta %10010000,%00100000,%10010000,%10010000,%10010000,%10010000,%00100000,%10010000
 :+13*16+8 brk

 org *+$100

.endm
 run main

 opt l-
 icl 'panel_2.mac'
