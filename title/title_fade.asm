;color_nr = 23+9

	.extrn cloc, ftmp .byte

	.extrn __l_tcol, __h_tcol, __t_satur, __t_color, color_nr, black_skip .word


	.public FADE_IN, FADE_OUT, SAVE_COLOR, WAIT


	.reloc

;-----------;
;-  WAIT   -;
;-----------;
.proc wait (.byte x) .reg
 lda:cmp:req cloc
 dex
 bne wait
 rts
.endp

;-----------;
;-  FADE   -;
;-----------;
.proc fade
 stx adr+1
 sty adr+2

 WAIT #6
 
 mva #16 licz
fad
 WAIT #2

adr jsr $ffff

 dec licz
 bne fad
 rts

licz brk
.endp

;-----------;
;- FADE IN -;
;-----------;
.proc fade_in

 ldx <fade
 ldy >fade
 jmp :fade

fade

 mwa __l_tcol  adr0+1
 mwa __h_tcol  adr1+1
 mwa __t_satur adr2+1
 mwa __t_color adr3+1

 mvx #0 count

fade_l
adr0 lda $ffff,x
 sta ftmp
adr1 lda $ffff,x
 sta ftmp+1

 ldy #1
 lda (ftmp),y
 tay

 and #$f0
adr3 cmp $ffff,x
 beq skp1

 tya
 add #$10
 tay

skp1

 tya
 and #$0f
adr2 cmp $ffff,x
 beq skp0

 iny

skp0

 tya
 ldy #1
 sta (ftmp),y

 inx
 bne skp
 inc count

 inc adr0+2
 inc adr1+2
 inc adr2+2
 inc adr3+2

skp
 cpx color_nr
 bne fade_l
 rts

count brk
.endp

;------------;
;- FADE OUT -;
;------------;
.proc fade_out

 ldx <fade
 ldy >fade
 jmp :fade

fade

 mwa __l_tcol  adr0+1
 mwa __h_tcol  adr1+1

 mvx #0 count

fade_l
adr0 lda $ffff,x
 sta ftmp
adr1 lda $ffff,x
 sta ftmp+1

 ldy #1
 lda (ftmp),y
 tay

 and #$0f
 beq skp0

 dey

skp0

 tya
 and #$f0
 beq skp1

 tya
 sub #$10
 tay

skp1
 tya

 ldy #1
 sta (ftmp),y

 inx
 bne skp
 inc count

 inc adr0+2
 inc adr1+2

skp
 cpx color_nr
 bne fade_l
 rts

count brk
.endp

;--------------;
;- SAVE COLOR -;
;--------------;
.proc save_color

 mwa __l_tcol  adr0+1
 mwa __h_tcol  adr1+1
 mwa __t_satur adr2+1
 mwa __t_color adr3+1

 mvx #0 count

save_l
adr0 lda $ffff,x
 sta ftmp
adr1 lda $ffff,x
 sta ftmp+1

 ldy #1
 lda (ftmp),y
 pha
 and #$0f
adr2 sta $ffff,x
 pla
 and #$f0
adr3 sta $ffff,x

 lda black_skip
 bne _skp

 lda #0        ; black screen (all colors = $00)
 sta (ftmp),y

_skp
 inx
 bne skp
 inc count

 inc adr0+2
 inc adr1+2
 inc adr2+2
 inc adr3+2

skp
 cpx color_nr
 bne save_l
 rts

count brk
.endp

/*
.proc tab
l_tcol
 dta l(c0,c1,c2,c3,c4,c5,c6,c7,c8,c9)
 dta l(c10,c11,c12,c13,c14,c15,c16,c17,c18,c19)
 dta l(c20,c21,c22)
 dta l(pal-1,pal,pal+1)
 dta l(pal+2,pal+3,pal+4)
 dta l(pal+5,pal+6,pal+7)

h_tcol
 dta h(c0,c1,c2,c3,c4,c5,c6,c7,c8,c9)
 dta h(c10,c11,c12,c13,c14,c15,c16,c17,c18,c19)
 dta h(c20,c21,c22)
 dta h(pal-1,pal,pal+1)
 dta h(pal+2,pal+3,pal+4)
 dta h(pal+5,pal+6,pal+7)

t_satur .ds color_nr
t_color .ds color_nr
.endp
*/

 blk update external
 blk update address
 blk update public
