
scr40	equ %00111110	;screen 40b

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


.struct zp
	regA	.byte
	regX	.byte
	regY	.byte
.ends

	.extrn	cloc, zpage, hfntCon, hpmgCon, hpmg		.byte

	.extrn	color_nr, emulator, scrCon			.word
	.extrn	SAVE_COLOR, FADE_IN, FADE_OUT, sid_stop		.word
	.extrn	__l_tcol, __h_tcol, __t_satur, __t_color	.word

	.extrn	WAIT		.proc (.byte x) .reg
	.extrn	SID_RESTART	.proc (.byte a) .reg

	.public	congrat_main


	.reloc


ant
 dta $70,$70,$F0
 dta $44,a(scrCon),$84,$04,$04,$04,$04,$84,$84
 dta $70,$F0,$04,$04,$04,$04,$04,$84,$F0,$F0
 dta $04,$04,$04,$84,$70
 dta $41,a(ant) 


;scr	ins 'grat_OK.scr'


congrat_main

 mva #hpmgCon $d407		; missiles and players data address

; jsr save_color		;then save all colors and set value 0 for all colors

 mva #0  $d400

 sta msx_stop+1

 ldy #$0b
 sta $d000,y-
 rpl

 mva __color_nr  color_nr	; BYTE

 mwa #l_tcol   __l_tcol
 mwa #h_tcol   __h_tcol
 mwa #t_satur  __t_satur
 mwa #t_color  __t_color


skip lda #0
 sne
 jsr save_color

 mva #$ff  skip+1

 lda <nmi
 sta $fffa
 sta $fffe
 lda >nmi
 sta $fffb
 sta $ffff

 SID_RESTART #1

 mwa #dli1  dliv+1

 mva #$c0 $d40e		;switch on NMI+DLI again

 jsr fade_in		;fade in colors


loop
 lda $d01f
 and #1
 beq quit

 lda $d010
 beq quit

 jmp loop

quit

 jsr fade_out		;fade out colors

 mva #$ff  msx_stop+1
 jsr sid_stop

 SID_RESTART #5

 WAIT #1

 mva #$40  $d40e
 sta $d400

 mva #hpmg $d407

 rts			; EXIT


;-- DLI PROGRAM

dli1
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
 lda #hfntCon+4
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
 lda #hfntCon
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
 lda #hfntCon+4
 sta $d40a                   ;line=104
 sta chbase
 DLINEW dli4

dli4
 lda #hfntCon
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
 lda #hfntCon+4
 sta $d40a                   ;line=168
 sta chbase
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

 mwa #ant   $d402		;ANTIC address program
 mva #scr40 $d400	;set new screen's width

;-- first line of screen initialization

 lda #hfntCon
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

 mwa #dli1 dliv+1	;set the first address of DLI interrupt

msx_stop lda #$ff
 sne
 jsr emulator		; gra SID PLAYER

nmiQ
 lda zpage+zp.regA
 ldx zpage+zp.regX
 ldy zpage+zp.regY
 rti


 ?ile = h_tcol-l_tcol

__color_nr	dta b(?ile)

l_tcol
 dta l(c0,c1,c2,c3,c4,c5,c6,c7,c8,c9)
 dta l(c10,c11,c12,c13,c14,c15,c16,c17,c18,c19)
 dta l(c20,c21,c22,c23,c24,c25,c26,c27,c28,c29)
 dta l(c30,c31,c32,c33,c34,c35)

h_tcol
 dta h(c0,c1,c2,c3,c4,c5,c6,c7,c8,c9)
 dta h(c10,c11,c12,c13,c14,c15,c16,c17,c18,c19)
 dta h(c20,c21,c22,c23,c24,c25,c26,c27,c28,c29)
 dta h(c30,c31,c32,c33,c34,c35)

t_satur	:?ile brk
t_color	:?ile brk


 blk update address
 blk upadet external
 blk update public

*---

 opt l-

.macro DLINEW
 mwa #:1 dliv+1
 jmp nmiQ
.endm

.macro ALIGN
 ift (*/:1)*:1<>*
  org (*/:1)*:1+:1
 eif
.endm
