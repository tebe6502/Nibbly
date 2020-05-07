/*
  INPUT STRING
  wprowadza znaki z klawiatury pod adres 'newString'
*/

ile_znakow	= 6

pusty		= "P"+1		; pusty znak czyli znak kropki '.'


;	.extrn cloc		.byte

	.extrn code_visual	.word
	
	.extrn WAIT .proc (.byte x) .reg

	.public INPUT_STRING, newString, pusty, ile_znakow, INPUT_STRING._1, INPUT_STRING._exit, INPUT_STRING._2


	.reloc

 
.proc input_string
 
; lda #0
; sta indY+1
 
 lda #$ff
 sta $d209

 mva #0  _2+1

_1 jsr new_key

   cmp #$9b
   beq _end
   cmp #$7e
   beq _del

char_ok
   ldy _2+1
   cpy #ile_znakow              ; liczba znakow do wpisania
   beq _1
_2 ldy #0
   sta newString,y
;   iny
;   sta (zp0),y
;   lda #zacheta
;   iny
;   sta (zp0),y
   inc _2+1
   jmp _1

_del ldy _2+1
   beq _skp

   lda #pusty
   sta newString,y
   dey

;   iny
;   sta (zp0),y
   dec _2+1
;_4 lda #zacheta
;   dey
;   sta (zp0),y 
_skp
   lda #pusty
   sta newString,y
   jmp _1

_end ldy _2+1
   sta newString,y

;indY ldy #0
; lda #$9b
; sta newString,y
 
; mwa #newString zp0
 rts
 
;---

new_key
 jsr CODE_VISUAL


get_key
; lda:cmp:req cloc
 WAIT #1

_exit nop

 lda $d20f
 and #4
 bne get_key
 
 ldy $d209
 lda tab,y
 cmp #pusty
 beq get_key
 
old_key cmp #0
 bne skp
 
delay ldx #6
 dex
 stx delay+1
 bne get_key
 
 ldx #6
 stx delay+1
 
skp
 sta old_key+1
 
 ldx #6
 stx delay+1
 rts

.endp


.array tab [256] .byte = pusty	; akceptowane litery A..P

 [63]:[127] = "A"
 [21]:[85]  = "B"
 [18]:[82]  = "C"
 [58]:[122] = "D"
 [42]:[106] = "E"
 [56]:[120] = "F"
 [61]:[125] = "G"
 [57]:[121] = "H"
 [13]:[77]  = "I"
 [1] :[65]  = "J"
 [5] :[69]  = "K"
 [0] :[64]  = "L"
 [37]:[101] = "M"
 [35]:[99]  = "N"
 [8] :[72]  = "O"
 [10]:[74]  = "P"
 
; [33]:[97]  = pusty
 [52]:[180] = $7e
 [12]:[76]  = $9b

.enda

 brk
newString	:ile_znakow+1	dta pusty


 blk update address
 blk update external
 blk update public
