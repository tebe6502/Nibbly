   opt h+
   org $b000

buf equ $2000
sc1 equ $6010
sc2 equ $8010

hlp equ $80
ind equ hlp+2
bf1 equ ind+1
bf2 equ bf1+2
pix equ bf2+2
len equ pix+1
inx equ len+1

px  equ 13

ant dta d'p',b($4e)
ad dta a(sc1)
   dta d'....................'
   dta d'....................'
   dta d'....................'
   dta d'....................'
   dta d'.....................'
   dta b($4e)
ad_ dta a(sc1+4080)
   dta d'....................'
   dta d'....................'
   dta d'....................'
   dta d'....................'
   dta d'.................'
   dta b($70),b($4e)
i1 dta a(pas1),b($4e)
i2 dta a(pas2),b($4e)
i3 dta a(pas1),b($4e)
i4 dta a(pas2),b($4e)
i5 dta a(pas1),b($4e)
i6 dta a(pas2),b($70)
   dta b($42),a(bar)
   dta b($41),a(ant)
bar  org *+40
pas1 org *+40
pas2 org *+40

* Incjacja
*---------
in ldx >$e000
   ldy >$a000
   jsr fnt

   ldx <ant
   ldy >ant
   stx 560
   sty 561

   lda #$00
   sta col+3
   lda #$02
   sta col
   lda #$04
   sta col+1
   lda #$06
   sta col+2

   lda #0
   sta pix
   ldy #119
cl sta bar,y
   dey
   bpl cl

   ldx #0
   ldy #0
ps lda kol1,x
   sta pas1,y
   sta pas1+1,y
   sta pas1+2,y
   sta pas1+3,y
   lda kol2,x
   sta pas2,y
   sta pas2+1,y
   sta pas2+2,y
   sta pas2+3,y
   iny
   iny
   iny
   iny
   inx
   cpx #7
   bne ps

   ldx #64
   ldy #0
   tya
cr sta sc1-$10,y
   dey
   bne cr
   inc cr+2
   dex
   bne cr

   lda 20
ww cmp 20
   beq ww

   cld
   sei
   lda #$fe
   sta $d301
   lda #0
   sta $d40e

   ldx <vbl
   ldy >vbl
   stx $fffa
   sty $fffa+1

   lda #$40
   sta $d40e

   ldx >$a000
   ldy >$e000
   jsr fnt

* Utworz obraz
*-------------
skip jsr abuf
   ldx <sc1
   ldy >sc1
   stx bf1
   sty bf1+1

   ldx <sc2
   ldy >sc2
   stx bf2
   sty bf2+1
   lda #0
   sta len

lp_ ldy #0
   lda (hlp),y
   lsr @
   lsr @
   lsr @
   lsr @
   jsr szuk
   ldy #0
   lda (hlp),y
   and #$f
   jsr szuk

   inw hlp

   lda hlp
   cmp <buf+16000
   lda hlp+1
   sbc >buf+16000
   bcc lp_

   lda #0
   sta inx
   jsr neg
rep lda #0
   sta 20
wai lda 20
   cmp #6
   bne wai

   lda col
   ldx #px
   jsr hex

   lda col+1
   ldx #px+4
   jsr hex

   lda col+2
   ldx #px+8
   jsr hex

   lda col+3
   ldx #px+12
   jsr hex

   jsr neg

   lda 53279
   cmp #6
   beq nxt
   cmp #5
   beq sel
   cmp #3
   beq opt
   jmp rep

nxt jsr neg
   inc inx
   lda inx
   cmp #4
   bne rep
   lda #0
   sta inx
   jmp rep

sel ldy inx
   lda col,y
   and #$f
   clc
   adc #2
   and #$f
   sta mm+1
   lda col,y
   and #$f0
mm ora #0
   sta col,y
   jmp rep

opt ldy inx
   lda col,y
   clc
   adc #16
   sta col,y
   jmp rep

neg lda inx
   asl @
   asl @
   clc
   adc #px
   tay
   lda bar,y
   eor #$80
   sta bar,y
   lda bar+1,y
   eor #$80
   sta bar+1,y
   rts

szuk tax
is lda kol1,x
   ldy pix
   and tand,y
   ldy #0
   ora (bf1),y
   sta (bf1),y

is2 lda kol2,x
   ldy pix
   and tand,y
   ldy #0
   ora (bf2),y
   sta (bf2),y

   inc pix
   lda pix
   cmp #4
   bne om
   lda #0
   sta pix
   inc len
   lda len
   cmp #40
   bne skp
   lda #0
   sta len
eo lda #0
   eor #1
   sta eo+1
   beq t1

   ldx <kol2
   ldy >kol2
   stx is+1
   sty is+2
   ldx <kol1
   ldy >kol1
   stx is2+1
   sty is2+2
   jmp skp

t1 ldx <kol1
   ldy >kol1
   stx is+1
   sty is+2
   ldx <kol2
   ldy >kol2
   stx is2+1
   sty is2+2

skp inc bf1
   bne *+4
   inc bf1+1

   inc bf2
   bne *+4
   inc bf2+1
om rts

abuf ldx <buf
   ldy >buf
   stx hlp
   sty hlp+1
   rts

vbl pha
   sta $d40f

   inc $14

   lda col
   sta $d016
   lda col+1
   sta $d017
   lda col+2
   sta $d018
   lda col+3
   sta $d01a

   lda $14
   and #1
   beq n0
n1 lda >sc2
   sta ad+1
   lda >sc2+4080
   sta ad_+1
   lda <pas1
   sta i1
   sta i3
   sta i5
   lda <pas2
   sta i2
   sta i4
   sta i6
   jmp ex

n0 lda >sc1
   sta ad+1
   lda >sc1+4080
   sta ad_+1
   lda <pas2
   sta i1
   sta i3
   sta i5
   lda <pas1
   sta i2
   sta i4
   sta i6

ex pla
   rti

hex pha
 lsr @
 lsr @
 lsr @
 lsr @
 jsr hx
 pla
 and #$f
hx tay
 lda thex,y
 sta bar,x
 inx
 rts
thex dta d'0123456789ABCDEF'

fnt stx f1+2
   sty f2+2
   ldx #4
   ldy #0
f1 lda $e000,y
f2 sta $2000,y
   dey
   bne f1
   inc f1+2
   inc f2+2
   dex
   bne f1
   rts

col dta d'    '
tand dta b($c0),b($30),b($0c),b($03)
kol1 dta b($00,$00,$55,$55,$aa,$aa,$ff,$ff)
kol2 dta b($00,$55,$55,$aa,$aa,$ff,$ff,$ff)

	org $2000-118
	ins 'logo2.bmp'

 run in