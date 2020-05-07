
/*
  Program modyfikujacy zestaw znakow NAP odpowiednim napisem o numerze w regX <0..3>
  dodatkowo wstawia na ekran SCR odpowiednie znaki od CHR_NAP

  Maksymalnie wykorzystujemy 13*6 znaków (0..77) z zestawu NAP, w pozostalych znakach
  mamy ksztalt fontow dla liter kodu dostepu do levelu (80..)

  Uzywamy:
  	  napisy_maska_OK_2.mic, napisy_maska_OK_2.scr  -> dla operacji AND
  	  napisy_maska_2.mic, napisy_maska_2.scr        -> wlasciwa bitmapa
*/

	icl 'nibbly.hea'


	napis_w		= 14
	napis_h		= 6

	line_bmp	= 8*32
	line_chr	= 32

	adres		= scr+10*@sw+13-@sw
	ncode		= scr+15*@sw+14

	.extrn	spr0, spr1, mis0, mis1, hsiz, c3, c7, c8, _fnt, _fntG	.word
	.extrn	NEWCRC, zegar, txt_temp, _FIL_ROBAL, _CLR_HEAD		.word
	.extrn	dli.nap_gti, dli.nap_gti2, dli.nap_col0, dli.nap_col1	.word
	.extrn	dli.nap_p1r, dli.nap_p1x				.word

	.extrn	_tmp, posY, gate	.byte

	.public	TEXT, d_fnt, n_fnt, TEXT._rts, TEXT.napCol
	.public	_HEAD_RIGHT, _HEAD_LEFT, _HEAD_UP, _HEAD_DOWN

 	.reloc


.proc TEXT (.byte x) .reg

 stx napis+1		; w regX numer napisu do wyswietlenia


 ldy #0			; przepisujemy ksztalt znakow spod napisu do zestawu NAP

 mwa #nap+chr_nap*8  _move.dst+1

__lp
 mwa #adres _get.ekr+1

.rept napis_h
	jsr _get
	jsr _move
.endr
 
 iny
 cpy #napis_w
 bne __lp


napis ldx #0

 lda ladr,x		; przepisujemy bitmape z napisem do zestawu NAP
 sta src+1
 lda hadr,x
 sta src+2

 lda ltlo,x
 sta tlo+1
 lda htlo,x
 sta tlo+2

 lda <nap+chr_nap*8
 sta dst+1
 sta msk+1
 lda >nap+chr_nap*8
 sta dst+2
 sta msk+2

 mvx #3  zegar+1		; wartosc <>0 zatrzymuje ZEGAR czasu w NIBBLY

 ldy #0
msk lda $ffff,y
src and $ffff,y
tlo ora $ffff,y
dst sta $ffff,y
 iny
 bne msk
 inc msk+2
 inc src+2
 inc dst+2
 inc tlo+2
 dex
 bne msk

; kopiujemy stara zawartosc ekranu

 ldy #napis_w-1
_lp0
 :napis_h+2	mva adres+#*@sw,y  txt_temp+#*napis_w,y
 dey
 bpl _lp0


 jsr _FIL_ROBAL		; zamieniamy klocki robala na klocki z zestawu znakowego


 mwa #n_fnt _fnt+1	; ustawiamy zestaw znakow z napisami

 mva #{lda #}	_fntG	; kody CODE musza byc na zestawach FNT
 mva >fnt	_fntG+1


 jsr WAIT


 ?pos = 104

 lda #?pos		; ustawiamy duchy i pociski podkolorywujace napis
 sta spr0+1
 lda #?pos+18
 sta spr1+1
 lda #?pos+3
 sta mis0+1
; lda #108
; sta mis1+1

 lda #?pos+18-3
 sta dli.nap_p1x+1
 lda <hposp1
 sta dli.nap_p1r+1

 lda #3
 sta hsiz+1


 jsr _CLR_HEAD

 ldx napis+1
 ldy lpmg,x

 ldx #0

_cp
 mva pmg_napis0,y  pmg+$300+5*16+8,x	; modyfikacja PMG na podstawie konkretnego napisu
 mva pmg_napis1,y  pmg+$400+5*16+8,x
 mva pmg_napis2,y  pmg+$500+5*16+8,x

 iny
 inx
 cpx #48
 bne _cp
 
/*
 lda #0
 sta pmg+$300+5*16+8+48+1
 sta pmg+$400+5*16+8+48+1
 sta pmg+$500+5*16+8+48+1
 sta pmg+$300+5*16+8+48+1+1
 sta pmg+$400+5*16+8+48+1+1
 sta pmg+$500+5*16+8+48+1+1

 sta pmg+$300+5*16+8+48+1+6
 sta pmg+$400+5*16+8+48+1+6
 sta pmg+$500+5*16+8+48+1+6
 sta pmg+$300+5*16+8+48+1+7
 sta pmg+$400+5*16+8+48+1+7
 sta pmg+$500+5*16+8+48+1+7

 lda #$ff
.rept 4
 sta pmg+$300+5*16+8+48+1+2+.r
 sta pmg+$400+5*16+8+48+1+2+.r
 sta pmg+$500+5*16+8+48+1+2+.r

 sta pmg+$300+5*16+8+48+1+8+.r
 sta pmg+$400+5*16+8+48+1+8+.r
 sta pmg+$500+5*16+8+48+1+8+.r 
.endr
*/


napCol lda #$ea
 sta c7+1
 sta c8+1

 lda c3+1
 sub #4
 sta dli.nap_col0+1
 sta dli.nap_col1+1

 lda #$24
 sta dli.nap_gti+1
 sta dli.nap_gti2+1

 ldx napis+1			; wstawiamy znaki reprezentujace napis
 lda linv,x
 sta _put.inv+1
 lda hinv,x
 sta _put.inv+2
 
 ldy #0
 ldx #chr_nap
_lp
 mwa #adres _put.ekr+1
 mwa #adres _put.old+1

 :napis_h jsr _put
 
 iny
 cpy #napis_w
 bne _lp


 lda napis+1		; sprawdzamy czy to napis WELL DONE
 bne _skp		; bo jesli tak to wyswietlimy CODE
; lda NEWCRC+1
; beq _skp

 lda #$ff
 ldy #15
_fl
 sta pmg+$400+5*16+8+48,y
 sta pmg+$500+5*16+8+48,y
 dey
 bpl _fl
 
 jsr SCODE

_skp

;- wyswietlenie napisu

_rts nop

 lda:rne $d010		; czekamy na nacisniecie FIRE

 jsr WAIT


 mwa #d_fnt _fnt+1	; przywracamy stara zawartosc ekranu
; jsr WAIT

 lda #$22
 sta dli.nap_gti+1
 sta dli.nap_gti2+1

 lda #0
 sta spr0+1
 sta spr1+1
 sta mis0+1
 sta mis1+1

 lda <$d01e
 sta dli.nap_p1r+1

 ldy #napis_w-1
_lp1
 :napis_h+2	mva  txt_temp+#*napis_w,y  adres+#*@sw,y
 dey
 bpl _lp1


 lda #{nop}
 sta _rts
 sta _fntG
 sta _fntG+1

 rts

.endp


.proc _get
ekr lda $ffff,y
 and #$7f
 tax

 lda ekr+1
 add #@sw
 sta ekr+1
 scc
 inc ekr+2

 rts
.endp


.proc _put
 stx char+1
old lda $ffff,y
inv ora $ffff
 and #$80
char ora #0
ekr sta $ffff,y

 lda ekr+1
 add #@sw
 sta ekr+1
 sta old+1
 bcc _skp
 inc ekr+2
 inc old+2

_skp
 inw inv+1

 inx
 rts
.endp


.proc _move
 lda lfnt,x
 sta src+1
 lda hfnt,x
 sta src+2
 
 ldx #7
src lda $ffff,x
dst sta $ffff,x
 dex
 bpl src

 lda dst+1
 add #8
 sta dst+1
 scc
 inc dst+2
 rts

.endp


.proc wait
 lda:cmp:req gate
 rts
.endp


.proc SCODE

; lda #13+chr_cod
; sta ncode-1
; sta ncode-1+@sw
; sta ncode+12
; sta ncode+@sw+12

 ldy #0

 lda NEWCRC
 jsr __scode
 lda NEWCRC+1
 jsr __scode
 lda NEWCRC+2

__scode

 pha
 :4 lsr @
 jsr show
 pla
 and #$f

show
 asl @
 tax

 lda _code,x
 sta ncode,y
 lda _code+1,x
 sta ncode+1,y

 lda _code+32,x
 sta ncode+@sw,y
 lda _code+32+1,x
 sta ncode+@sw+1,y

 iny
 iny
 rts
.endp


 .put [$00] = $24,$5E,$38,$E7,$7F,$77,$AB,$50,$A0,$03,$97,$D7,$93,$48,$7E,$3C
 .put [$10] = $24,$5E,$3C,$E5,$FA,$FD,$DB,$54,$29,$D3,$E8,$E9,$CB,$16,$6E,$3C
 .put [$20] = $3C,$4A,$34,$BD,$7A,$7C,$7A,$10,$2C,$52,$00,$A5,$EF,$76,$7E,$3C
 .put [$30] = $3C,$6E,$76,$EF,$A5,$58,$5A,$64,$28,$51,$02,$05,$AB,$56,$7E,$3C

 .put [$40] = $18,$3C,$76,$7C,$EB,$EA,$7C,$FF,$7F,$FC,$6A,$2B,$6C,$36,$00,$00
 .put [$50] = $18,$3C,$6E,$3E,$D7,$56,$3E,$FF,$FE,$3C,$57,$D6,$34,$68,$10,$00
 .put [$60] = $00,$3C,$7E,$7E,$FF,$FF,$FF,$FF,$DB,$BD,$FF,$5A,$34,$2C,$24,$24
 .put [$70] = $24,$34,$2C,$34,$5A,$FF,$BD,$DB,$FF,$FE,$FD,$FA,$54,$28,$00,$00


_HEAD_RIGHT
 ldy posY

 :16 mva #.get[$00+#]  pmg+$400+8+#,y
 :16 mva #.get[$40+#]  pmg+$500+8+#,y
 rts


_HEAD_LEFT
 ldy posY

 :16 mva #.get[$10+#]  pmg+$400+8+#,y
 :16 mva #.get[$50+#]  pmg+$500+8+#,y
 rts


_HEAD_DOWN
 ldy posY

 lda #0
 sta pmg+$400+8-2,y
 sta pmg+$500+8-2,y
 sta pmg+$400+8-1,y
 sta pmg+$500+8-1,y

 sta pmg+$400+8+16+1,y
 sta pmg+$500+8+16+1,y
 sta pmg+$400+8+16,y
 sta pmg+$500+8+16,y

 :16 mva #.get[$20+#]  pmg+$400+8+#,y
 :16 mva #.get[$60+#]  pmg+$500+8+#,y
 rts


_HEAD_UP
 ldy posY

 lda #0
 sta pmg+$400+8-2,y
 sta pmg+$500+8-2,y
 sta pmg+$400+8-1,y
 sta pmg+$500+8-1,y

 sta pmg+$400+8+16+1,y
 sta pmg+$500+8+16+1,y
 sta pmg+$400+8+16,y
 sta pmg+$500+8+16,y

 :16 mva #.get[$30+#]  pmg+$400+8+#,y
 :16 mva #.get[$70+#]  pmg+$500+8+#,y
 rts


d_fnt dta h(fnt, fnt+$400, fnt+$800, fnt+$c00, fnt+$1000, fnt+$1400, fnt+$1800, fnt+$1c00)

n_fnt :8 dta h(nap)


lfnt	:128 dta l(fnt+#*8)

hfnt	:128 dta h(fnt+#*8)


ladr dta l(msk_welldone, msk_ouch, msk_notime, msk_gameover)	// maska napisu
hadr dta h(msk_welldone, msk_ouch, msk_notime, msk_gameover)

ltlo dta l(txt_welldone, txt_ouch, txt_notime, txt_gameover)	// napis
htlo dta h(txt_welldone, txt_ouch, txt_notime, txt_gameover)

linv dta l(inv_welldone, inv_ouch, inv_notime, inv_gameover)	// invers
hinv dta h(inv_welldone, inv_ouch, inv_notime, inv_gameover)

lpmg dta 0,48,48*2,48*3


msk_welldone
 cnv 0,'txt\napisy_maska_OK_2.mic'

msk_ouch
 cnv 6*line_bmp,'txt\napisy_maska_OK_2.mic'

msk_notime
 cnv 12*line_bmp,'txt\napisy_maska_OK_2.mic'

msk_gameover
 cnv 18*line_bmp,'txt\napisy_maska_OK_2.mic'


txt_welldone
 cnv 0,'txt\napisy_maska_2.mic'

txt_ouch
 cnv 6*line_bmp,'txt\napisy_maska_2.mic'

txt_notime
 cnv 12*line_bmp,'txt\napisy_maska_2.mic'

txt_gameover
 cnv 18*line_bmp,'txt\napisy_maska_2.mic'


inv_welldone
 cnv_inv 0,'txt\napisy_maska_2.scr'

inv_ouch
 cnv_inv 6*line_chr,'txt\napisy_maska_2.scr'

inv_notime
 cnv_inv 12*line_chr,'txt\napisy_maska_2.scr'

inv_gameover
 cnv_inv 18*line_chr,'txt\napisy_maska_2.scr'


pmg_napis0
 dta $03,$00,$01,$02,$00,$02,$00,$00
 dta $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
 dta $00,$00,$00,$01,$02,$01,$03,$01,$03,$01,$03,$01,$03,$03,$03,$03
 dta $03,$03,$02,$02,$00,$00,$00,$00
 
 dta $00,$00,$00,$00,$00,$00,$00,$00
 dta $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
 dta $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
 dta $00,$00,$00,$00,$00,$00,$00,$00
 	
 dta $00,$00,$00,$00,$00,$00,$00,$00
 dta $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
 dta $00,$00,$00,$00,$00,$00,$00,$02,$00,$02,$00,$02,$00,$02,$02,$02
 dta $02,$02,$02,$00,$00,$00,$00,$00
 	
 dta $00,$00,$00,$00,$00,$03,$03,$03
 dta $03,$03,$02,$02,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
 dta $00,$03,$03,$03,$03,$03,$03,$03,$03,$03,$03,$03,$03,$03,$03,$03
 dta $03,$03,$03,$03,$03,$03,$03,$00

pmg_napis1
 dta $00,$FF,$FF,$FF,$FF,$FF,$FF,$FB
 dta $FB,$FB,$FB,$FB,$FB,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$DD,$00
 dta $C9,$DD,$FD,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
 dta $FF,$FF,$FF,$FF,$DF,$DF,$C8,$00
 	
 dta $00,$00,$00,$00,$00,$00,$00,$00
 dta $D5,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
 dta $FF,$FF,$FF,$FF,$DD,$DD,$C9,$00,$00,$00,$00,$00,$00,$00,$00,$00
 dta $00,$00,$00,$00,$00,$00,$00,$00
 	
 dta $09,$1D,$1F,$1F,$1F,$1F,$1F,$1F
 dta $1F,$1F,$1F,$1F,$1F,$1F,$1F,$1F,$1F,$1F,$1F,$1F,$1F,$1F,$15,$00
 dta $C9,$FD,$FD,$FF,$FF,$FF,$CB,$4B,$4B,$4B,$4B,$4B,$4B,$4B,$5F,$5F
 dta $5F,$5F,$5F,$5F,$5F,$5F,$48,$00
 
 dta $C9,$DD,$DD,$FF,$FF,$FF,$FF,$FF
 dta $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$D4,$00
 dta $D5,$DF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
 dta $FB,$EB,$EB,$EB,$CB,$CB,$C9,$00
 
pmg_napis2
 dta $00,$E4,$E4,$E4,$E4,$E4,$E4,$24
 dta $A4,$A4,$A4,$A4,$3F,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$B7,$00
 dta $B7,$BF,$BF,$FF,$FF,$FF,$FF,$FE,$FE,$FE,$FE,$FE,$FE,$FF,$FF,$FF
 dta $FF,$FF,$FF,$FF,$FF,$FF,$A7,$00
 	
 dta $00,$00,$00,$00,$00,$00,$00,$00
 dta $35,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$E7,$E7,$FF,$FF,$FF,$FF,$FF
 dta $FF,$FF,$FF,$FF,$BF,$BF,$B5,$00,$00,$00,$00,$00,$00,$00,$00,$00
 dta $00,$00,$00,$00,$00,$00,$00,$00
 
 dta $B0,$B0,$F0,$F8,$F8,$F8,$F8,$F8
 dta $F8,$F8,$F8,$F8,$F8,$F8,$F8,$F8,$F8,$F8,$F8,$F8,$F0,$F0,$30,$00
 dta $B7,$BF,$BF,$FF,$FF,$FF,$BF,$BE,$BE,$BE,$BE,$BE,$BE,$BF,$FF,$FF
 dta $FF,$FF,$FF,$FF,$FF,$FF,$A7,$00
 
 dta $B7,$BF,$BF,$FF,$FF,$FF,$FF,$FE
 dta $FE,$FE,$FE,$FE,$FE,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$27,$00
 dta $36,$FF,$FF,$FF,$FF,$FF,$FF,$F7,$F7,$F7,$F7,$F7,$F7,$FF,$FF,$FF
 dta $BF,$BF,$BF,$BF,$BF,$BF,$35,$00


_code ins 'gfx\code2_OK.scr'+chr_cod,0,64

*---

 blk update address
 blk update external
 blk update public

*---

 opt l-

.macro cnv
 .get :2,:1,line_bmp*6

  .rept napis_w
    ?x=#
    ;row ?x
    :napis_h*8  dta .get[?x+#*32]
  .endr
.endm

/*
.macro row
 .rept napis_h*8
   dta .get[:1+.r*32] 
 .endr
.endm
*/

.macro cnv_inv
 .get :2,:1,line_chr*6

  :napis_w row_inv #
.endm

.macro row_inv
 .rept napis_h
   ift .get[:1+#*32]>$7f
    dta $80
   els
    dta 0
   eif
 .endr
.endm
