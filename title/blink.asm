
h	= 17

hlp	equ $80

 org $2000

ant
 :3 dta $70
 dta $42,a(scr)
 :h-1 dta $02
 dta $41,a(ant)


main
 mwa #ant 560
 mwa #%00100001 559

loop
 mwa #scr hlp
 mwa #scr cl+1

 ldx #2
 ldy #0
 tya
 
cl sta scr,y
 iny
 bne cl
 inc cl+2
 dex
 bne cl

 ldx #0
_lp

 ldy px,x
 lda (hlp),y
 eor #$80
 sta (hlp),y
 iny
 lda (hlp),y
 eor #$80
 sta (hlp),y
 iny
 lda (hlp),y
 eor #$80
 sta (hlp),y

 lda hlp
 add #32
 sta hlp
 scc
 inc hlp+1

 lda px,x
 clc
; adc #1
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
 cpx #h
 bne _lp

 lda:cmp:req 20
 lda:cmp:req 20

 jmp loop

scr
 :32*h brk


px dta b(sin(4,h/2,32,0,h))
ad :h dta 1

msk 
:5 brk
:22 dta 1
 brk


 run main