

prg	= $1000

pmg	= $d800

chbase	= $D409

scr48	equ %00111111	;screen 48b
scr40	equ %00111110	;screen 40b
scr32	equ %00111101	;screen 32b

*--------------------------------

	.public a1, a2, intro, intro_org


 org prg + $40

intro_org


s1	ins 'logo1.dat'
s2	ins 'logo2.dat'


a1
 dta $30,$70,$70
 dta $4e,a(s1)
 :47 dta $e
 dta $70,$70
 dta $42,a(txt),$02,$70,$02,$02,$70,$02,$02,$70,$02,$02,$70,$70,$02,$02,$02,$02
; dta $70,$f0
; dta $44,a(scr)
; :6 dta 4
 dta $41,a(a2)

a2
 dta $30,$70,$70
 dta $4e,a(s2)
 :47 dta $e
 dta $70,$70
 dta $42,a(txt),$02,$70,$02,$02,$70,$02,$02,$70,$02,$02,$70,$70,$02,$02,$02,$02
; dta $70,$f0
; dta $44,a(scr)
; :6 dta 4
 dta $41,a(a1)


.align $0400

fnt	ins 'logo3.fnt',0,62*8
txt	ins 'logo3.scr'*


intro

 ldy #4
_cut
 lda 708,y
 and #$0f
 sta 708,y
 dey
 bpl _cut

 lda:cmp:req 20


 ldx #15

_lop
 lda:cmp:req 20
 lda:cmp:req 20

 ldy #2
_lp
 lda 708,y
 beq __q

 lda 708,y
 sub #$02
 sta 708,y

__q
 dey
 bpl _lp

 dex
 bne _lop


 lda #0
 ldy #4
 sta 708,y-
 rpl

 mwa #a1 560
 mva >fnt 756


.local
 ldx #4

_lop
 lda:cmp:req 20

 ldy #2
_lp
 lda 708,y
 cmp max,y
 beq __q

 lda 708,y
 add #$02
 sta 708,y

__q
 mva 709 712
 
 dey
 bpl _lp

 dex
 bne _lop
.end


 rts

max dta 4,6,8

 .print 'Program: ',prg,'..',*


 blk update public


; .get [0] 'logo1.dat'
; .get [1920] 'logo2.dat'
; .sav [0] 'logo.dat',2*1920
