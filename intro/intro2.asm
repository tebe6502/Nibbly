
 .public	intro

 .reloc

fnt
 ins 'intro2.fnt',0,61*8

ant
 dta $70,$70,$70,$42,a(fre),$42,a(scr)
 dta $02,$42,a(fre),$42,a(scr+40*2),$02,$42,a(fre),$42,a(scr+40*4),$02,$42,a(fre),$42,a(scr+40*6),$02,$42,a(fre)
 dta $42,a(scr+40*8),$02,$42,a(fre),$42,a(fre),$42,a(scr+40*10),$02,$02,$02,2,$42,a(fre),$42,a(fre)
 dta $41,a(ant)

scr
 ins 'intro2.scr'+$80

fre
 :40 brk


intro
 lda >fnt
 sta 756

 lda <ant
 sta 560
 lda >ant
 sta 561

 lda #$ff
 sta $d301
 sta 764

ll
 ldy 764
 iny
 beq ll

 mva #0 559
 lda:cmp:req 20
 rts

; ini intro

 blk update address
 blk update public