
/*
  generowanie 8 zestawow znakow na podstawie NIBLY_GED_OK.FNT
  kazdy zestaw bedzie zawieral jedna klatke animacji klocka
  klockow jest 12, faz animacji 8 czyli 8 zestawow znakow potrzeba

  n/w program operuje na pamieci MADS'a tworzac kolejne zestawy znakow od adresu FNT ($D800)
  znaki 0..83 z kazdego zestawu sa w pelni wykorzystywane, zostaja nam do dypozycji znaki 84..127

  zestaw NAP wykorzystywany jest od 0..97, reszta pozostaje do dyspozycji
*/

 	icl 'nibbly.hea'


	ile	equ 8+1		// ile zestawow ma zapisac od adresu FNT


	.extrn depack_move, sid_mem		.word

	.extrn inputPointer, outputPointer	.byte

	.extrn INFLATE .proc(.word inputPointer, outputPointer) .var


	.reloc


 lda:cmp:req 20

 sei
 mva #0   $d40e
 mva #$fe $d301

; przepiszemy znak 16 do znaku 17
; do znaku 16 przepiszemy znak 4

.rept ile
 .get [fnt+#*$400] 'gfx\nibly_FNT_ok_2.fnt'
 
 .put [fnt+#*$400+17*8]   = .get [fnt+#*$400+16*8]
 .put [fnt+#*$400+17*8+1] = .get [fnt+#*$400+16*8+1]
 .put [fnt+#*$400+17*8+2] = .get [fnt+#*$400+16*8+2]
 .put [fnt+#*$400+17*8+3] = .get [fnt+#*$400+16*8+3]
 .put [fnt+#*$400+17*8+4] = .get [fnt+#*$400+16*8+4]
 .put [fnt+#*$400+17*8+5] = .get [fnt+#*$400+16*8+5]
 .put [fnt+#*$400+17*8+6] = .get [fnt+#*$400+16*8+6]
 .put [fnt+#*$400+17*8+7] = .get [fnt+#*$400+16*8+7]

 .put [fnt+#*$400+16*8]   = .get [fnt+#*$400+4*8]
 .put [fnt+#*$400+16*8+1] = .get [fnt+#*$400+4*8+1]
 .put [fnt+#*$400+16*8+2] = .get [fnt+#*$400+4*8+2]
 .put [fnt+#*$400+16*8+3] = .get [fnt+#*$400+4*8+3]
 .put [fnt+#*$400+16*8+4] = .get [fnt+#*$400+4*8+4]
 .put [fnt+#*$400+16*8+5] = .get [fnt+#*$400+4*8+5]
 .put [fnt+#*$400+16*8+6] = .get [fnt+#*$400+4*8+6]
 .put [fnt+#*$400+16*8+7] = .get [fnt+#*$400+4*8+7]
 
.endr

	
 cnv 'fazy\w_prawo.mic' , 2 , phaseidx.@rr , 512
 cnv 'fazy\w_lewo.mic' , 2 , phaseidx.@ll , 512

 cnv 'fazy\w_dol.mic' , 512 , phaseidx.@dd , 2
 cnv 'fazy\w_gore.mic' , 512 , phaseidx.@uu , 2
 
 cnv 'fazy\dol_lewo.mic' , 512+2 , phaseidx.@dl , 4
 cnv 'fazy\dol_prawo.mic' , 512 , phaseidx.@dr , 4

 cnv 'fazy\gora_lewo.mic' , 2 , phaseidx.@ul , 4
 cnv 'fazy\gora_prawo.mic' , 0 , phaseidx.@ur , 4

 cnv 'fazy\lewo_dol.mic' , 0 , phaseidx.@ld , 4
 cnv 'fazy\lewo_gora.mic' , 512 , phaseidx.@lu , 4

 cnv 'fazy\prawo_dol.mic' , 2 , phaseidx.@rd , 4
 cnv 'fazy\prawo_gora.mic' , 512+2 , phaseidx.@ru , 4

*---

 cnv 'fazy\w_prawo.mic' , 0 , phaseidx.@right , 512
 cnv 'fazy\w_lewo.mic' , 4 , phaseidx.@left , 512

 cnv 'fazy\w_dol.mic' , 0 , phaseidx.@down , 2
 cnv 'fazy\w_gore.mic' , 512*2 , phaseidx.@up , 2


 ldx #3
 ldy #0
c0 lda depack_move,y
c1 sta INFLATE,y
 iny
 bne c0
 inc c0+2
 inc c1+2
 dex
 bne c0

 INFLATE	#nibbly_msx	,	__sid_mem
 
; lda 712
; sta $d01a

; lda #{nop}
; sta paski
; sta paski+1
; sta paski+2


.local
 ldx #4
 ldy #0
c0 lda screen,y
c1 sta scr,y
 iny
 bne c0
 inc c0+2
 inc c1+2
 dex
 bne c0
.end

 
 mva #$ff $d301
 mva #$40 $d40e
 cli
 rts


__sid_mem dta a(sid_mem)


// modyfikujemy 8 pierwszych zestawow, wstawiajac na ich koniec CODE_OK.FNT

 :ile-1		.get [fnt+#*$400+chr_cod*8] 'gfx\code2_OK.fnt',0,44*8

 .sav [fnt] 'all_fnt.dat',ile*$400
 

screen	
 ins 'gfx\nibly_fnt_ok_2.scr',40,24*40


nibbly_msx
 ins 'nibbly.def'


*---

 blk update address
 blk update external

*---

 opt l-

.macro cnv
 ?char = chr+:3

 .get :1

 get_char :2 , 0 , :4
 get_char :2 , 1 , :4
 get_char :2 , 2 , :4
 get_char :2 , 3 , :4
 get_char :2 , 4 , :4
 get_char :2 , 5 , :4
 get_char :2 , 6 , :4
 get_char :2 , 7 , :4

.endm

.macro get_char
 ?tmp = :1+:2*:3

 :+8 .put[fnt+:2*$400+?char*8+#] = .get[?tmp+#*32]

 :+8 .put[fnt+:2*$400+?char*8+#+8] = .get[?tmp+1+#*32]

 ?tmp += 256

 :+8 .put[fnt+:2*$400+?char*8+#+16] = .get[?tmp+#*32]

 :+8 .put[fnt+:2*$400+?char*8+#+24] = .get[?tmp+1+#*32]

.endm
