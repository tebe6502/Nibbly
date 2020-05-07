
/*
  INIT		- inicjalizacja playera dla songu DEFSONG
  LOOP		- glowna petla odgrywajaca i synchronizujaca sie z ramka
  RELOCATE_MEM	- przepisuje modul SID'a pod adres LOAD_ADRESS zapisany w module
  LOAD_ADRESS	- adres modulu SID w pamieci RAM, zapisany w odwrotnej kolejnosci (hi,lo)

  EMULATOR	- wlasciwy player SID'a

  21.06.2006
*/

* --- PLAYER UZYWA STRONY ZEROWEJ OD $F0..$FF --- *


 .public	emulator, sid_init, sid_restart, sid_mem, sid_end, sid_stop


 ORG $a000	; adres zgodny z adresem modulu SID
		; nastapi jego relokacja z tego miejsca w to samo miejsce :) 
		
sid_mem = $a000

; ins 'nibbly.sid'

sid_end = sid_mem + 6174		; dlugosc pliku SID

 .print 'SID: ',sid_mem,'..',sid_end


*--- SID2POKEY PLAYER

 org $9000

noise_tab equ *

 dta b($ff,$ff,$c8,$a4,$80,$60,$40,$20,$20,$1C,$19,$17,$15,$14,$12,$11)
 dta b($10,$0F,$0E,$0E,$0D,$0C,$0C,$0B,$0B,$0A,$0A,$0A,$09,$09,$09,$09)
 dta b($08,$08,$08,$08,$07,$07,$07,$07,$07,$07,$06,$06,$06,$06,$06,$06)
 dta b($06,$06,$06,$05,$05,$05,$05,$05,$05,$05,$05,$05,$05,$05,$05,$05)
 dta b($04,$04,$04,$04,$04,$04,$04,$04,$04,$04,$04,$04,$04,$04,$04,$04)
 dta b($04,$04,$04,$04,$04,$04,$03,$03,$03,$03,$03,$03,$03,$03,$03,$03)  ;5
 dta b($03,$03,$03,$03,$03,$03,$03,$03,$03,$03,$03,$03,$03,$03,$03,$03)  ;6
 dta b($03,$03,$03,$03,$03,$03,$03,$03,$03,$03,$03,$03,$03,$03,$03,$03)  ;7
 dta b($03,$03,$03,$03,$03,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02)  ;8
 dta b($02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02)  ;9
 dta b($02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02)  ;a
 dta b($02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02)  ;b
 dta b($02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02)  ;c
 dta b($02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02)  ;d
 dta b($02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02)  ;e
 dta b($02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$01,$01)  ;f

; dla 15 khz

loval_15

 dta b($00,$00,$ff,$01,$67,$56,$25,$01,$E4,$34,$8C,$AB,$63,$93,$23,$01)
 dta b($1F,$72,$F3,$9A,$62,$46,$43,$56,$7B,$B2,$F7,$4A,$A8,$12,$85,$01)
 dta b($84,$10,$A1,$39,$D7,$7A,$21,$CD,$7D,$31,$E9,$A3,$61,$22,$E5,$AB)
 dta b($73,$3E,$0B,$D9,$AA,$7C,$50,$25,$FC,$D4,$AE,$89,$65,$43,$21,$01)
 dta b($E1,$C2,$A5,$88,$6C,$51,$37,$1D,$04,$EC,$D4,$BD,$A7,$91,$7C,$67)
 dta b($53,$3F,$2C,$19,$07,$F5,$E3,$D2,$C1,$B1,$A1,$91,$82,$73,$64,$56)
 dta b($48,$3A,$2C,$1F,$12,$06,$F9,$ED,$E1,$D5,$C9,$BE,$B3,$A8,$9D,$93)
 dta b($88,$7E,$74,$6A,$61,$57,$4E,$45,$3C,$33,$2A,$22,$19,$11,$09,$01)
 dta b($F9,$F1,$E9,$E1,$DA,$D3,$CB,$C4,$BD,$B6,$AF,$A9,$A2,$9C,$95,$8F)
 dta b($88,$82,$7C,$76,$70,$6A,$65,$5F,$59,$54,$4E,$49,$43,$3E,$39,$34)
 dta b($2F,$2A,$25,$20,$1B,$16,$11,$0D,$08,$04,$FF,$FB,$F6,$F2,$ED,$E9)
 dta b($E5,$E1,$DD,$D9,$D5,$D1,$CD,$C9,$C5,$C1,$BD,$BA,$B6,$B2,$AF,$AB)
 dta b($A8,$A4,$A1,$9D,$9A,$96,$93,$90,$8D,$89,$86,$83,$80,$7D,$7A,$77)
 dta b($74,$71,$6E,$6B,$68,$65,$62,$5F,$5D,$5A,$57,$54,$52,$4F,$4C,$4A)
 dta b($47,$44,$42,$3F,$3D,$3A,$38,$35,$33,$31,$2E,$2C,$2A,$27,$25,$23)
 dta b($20,$1E,$1C,$1A,$17,$15,$13,$11,$0F,$0D,$0B,$09,$07,$05,$03,$01)


Index_15
 dta $00,$00,$56,$2A,$1A,$11,$C,$9,$8,$5,$5,$4,$3,$3,$2,$2
 dta $2,$2,$2,$1,$1,$1,$1,$1,$1,$1,$1,$0,$1,$80,$1,$80
 dta $1,$80,$1,$80,$1,$80,$80,$1,$80,$80,$1,$80,$80,$80,$1,$80
 dta $80,$80,$80,$1,$80,$80,$80,$80,$1,$80,$80,$80,$80,$80,$80,$80
 dta $1,$80,$80,$80,$80,$80,$80,$80,$80,$1,$80,$80,$80,$80,$80,$80
 dta $80,$80,$80,$80,$80,$1,$80,$80,$80,$80,$80,$80,$80,$80,$80,$80
 dta $80,$80,$80,$80,$80,$80,$1,$80,$80,$80,$80,$80,$80,$80,$80,$80
 dta $80,$80,$80,$80,$80,$80,$80,$80,$80,$80,$80,$80,$80,$80,$80,$80
 dta $1,$80,$80,$80,$80,$80,$80,$80,$80,$80,$80,$80,$80,$80,$80,$80
 dta $80,$80,$80,$80,$80,$80,$80,$80,$80,$80,$80,$80,$80,$80,$80,$80
 dta $80,$80,$80,$80,$80,$80,$80,$80,$80,$80,$80,$80,$80,$80,$80,$80
 dta $80,$80,$80,$80,$80,$80,$80,$80,$80,$80,$80,$80,$80,$80,$80,$80
 dta $80,$80,$80,$80,$80,$80,$80,$80,$80,$80,$80,$80,$80,$80,$80,$80
 dta $80,$80,$80,$80,$80,$80,$80,$80,$80,$80,$80,$80,$80,$80,$80,$80
 dta $80,$80,$80,$80,$80,$80,$80,$80,$80,$80,$80,$80,$80,$80,$80,$80
 dta $80,$80,$80,$80,$80,$80,$80,$80,$80,$80,$80,$80,$80,$80,$80,$80


Look_15
 dta b($00,$00,$FF,$A9,$7F,$65,$54,$48,$3F,$37,$32,$2D,$29,$26,$23,$21)
 dta b($1F,$1D,$1B,$19,$18,$17,$16,$15,$14,$13,$12,$11,$11,$10,$10,$0F)
 dta b($0F,$0E,$0E,$0D,$0D,$0C,$0C,$0C,$0B,$0B,$0B,$0A,$0A,$0A,$0A,$09)
 dta b($09,$09,$09,$09,$08,$08,$08,$08,$08,$07,$07,$07,$07,$07,$07,$07)
 dta b($07,$06,$06,$06,$06,$06,$06,$06,$06,$06,$05,$05,$05,$05,$05,$05)
 dta b($05,$05,$05,$05,$05,$05,$04,$04,$04,$04,$04,$04,$04,$04,$04,$04)
 dta b($04,$04,$04,$04,$04,$04,$04,$03,$03,$03,$03,$03,$03,$03,$03,$03)
 dta b($03,$03,$03,$03,$03,$03,$03,$03,$03,$03,$03,$03,$03,$03,$03,$03)
 dta b($03,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02)
 dta b($02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02)
 dta b($02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02)
 dta b($02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02)
 dta b($02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02)
 dta b($02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02)
 dta b($02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02)
 dta b($02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02)

; dla 64 khz

loval_64
 dta b($00,$FF,$FF,$FF,$FF,$FF,$FF,$00,$FF,$9E,$75,$81,$B6,$5A,$E5,$F8)
 dta b($A0,$D0,$B7,$3B,$44,$C1,$A3,$DC,$63,$2E,$35,$73,$E2,$7D,$3F,$25)
 dta b($2C,$50,$90,$E8,$57,$DC,$74,$1E,$D8,$A2,$7B,$61,$53,$52,$5B,$6E)
 dta b($8B,$B2,$E0,$17,$55,$9B,$E7,$3A,$93,$F1,$55,$BF,$2D,$A0,$17,$93)
 dta b($13,$96,$1D,$A8,$37,$C8,$5D,$F4,$8F,$2C,$CC,$6E,$13,$BA,$64,$F)
 dta b($BD,$6C,$1E,$D1,$87,$3E,$F6,$B1,$6D,$2A,$E9,$A9,$6B,$2E,$F2,$B7)
 dta b($7E,$46,$F,$D9,$A4,$70,$3E,$C,$DB,$AB,$7C,$4E,$20,$F4,$C8,$9D)
 dta b($73,$4A,$21,$F9,$D2,$AB,$85,$60,$3B,$17,$F3,$D0,$AE,$8C,$6A,$4A)
 dta b($29,$A,$EA,$CB,$AD,$8F,$71,$54,$38,$1C,$0,$E4,$C9,$AF,$94,$7A)
 dta b($61,$48,$2F,$16,$FE,$E6,$CF,$B7,$A0,$8A,$73,$5D,$48,$32,$1D,$8)
 dta b($F3,$DF,$CA,$B6,$A3,$8F,$7C,$69,$56,$44,$31,$1F,$D,$FB,$EA,$D9)
 dta b($C7,$B7,$A6,$95,$85,$75,$65,$55,$45,$36,$26,$17,$8,$F9,$EA,$DC)
 dta b($CE,$BF,$B1,$A3,$95,$88,$7A,$6D,$5F,$52,$45,$38,$2C,$1F,$13,$6)
 dta b($FA,$EE,$E2,$D6,$CA,$BE,$B3,$A7,$9C,$90,$85,$7A,$6F,$64,$5A,$4F)
 dta b($44,$3A,$2F,$25,$1B,$11,$7,$FD,$F3,$E9,$DF,$D6,$CC,$C3,$B9,$B0)
 dta b($A7,$9E,$95,$8C,$83,$7A,$71,$68,$60,$57,$4F,$46,$3E,$35,$2D,$25)

Index_64
 dta $00,$00,$00,$00,$00,$00,$00,$00,$19,$17,$13,$10,$D,$C,$9,$9
 dta $8,$7,$6,$5,$5,$5,$4,$4,$3,$3,$3,$3,$3,$2,$2,$2
 dta $2,$2,$2,$2,$1,$2,$1,$1,$2,$1,$1,$1,$1,$1,$1,$1
 dta $1,$1,$1,$80,$1,$1,$1,$80,$1,$1,$80,$1,$80,$1,$80,$1
 dta $80,$1,$80,$1,$80,$1,$80,$1,$80,$80,$1,$80,$80,$1,$80,$80
 dta $1,$80,$80,$1,$80,$80,$1,$80,$80,$80,$1,$80,$80,$80,$1,$80
 dta $80,$80,$80,$1,$80,$80,$80,$80,$1,$80,$80,$80,$80,$1,$80,$80
 dta $80,$80,$80,$1,$80,$80,$80,$80,$80,$80,$1,$80,$80,$80,$80,$80
 dta $80,$80,$80,$80,$80,$80,$80,$80,$80,$80,$1,$80,$80,$80,$80,$80
 dta $80,$80,$80,$80,$1,$80,$80,$80,$80,$80,$80,$80,$80,$80,$80,$80
 dta $1,$80,$80,$80,$80,$80,$80,$80,$80,$80,$80,$80,$80,$1,$80,$80
 dta $80,$80,$80,$80,$80,$80,$80,$80,$80,$80,$80,$80,$80,$1,$80,$80
 dta $80,$80,$80,$80,$80,$80,$80,$80,$80,$80,$80,$80,$80,$80,$80,$80
 dta $1,$80,$80,$80,$80,$80,$80,$80,$80,$80,$80,$80,$80,$80,$80,$80
 dta $80,$80,$80,$80,$80,$80,$80,$1,$80,$80,$80,$80,$80,$80,$80,$80
 dta $80,$80,$80,$80,$80,$80,$80,$80,$80,$80,$80,$80,$80,$80,$80,$80


Look_64
 dta b($00,$00,$00,$00,$00,$00,$00,$00,$FF,$E6,$CF,$BC,$AC,$9F,$93,$8A)
 dta b($81,$79,$72,$6C,$67,$62,$5D,$59,$55,$52,$4F,$4C,$49,$46,$44,$42)
 dta b($40,$3E,$3C,$3A,$38,$37,$35,$34,$33,$31,$30,$2F,$2E,$2D,$2C,$2B)
 dta b($2A,$29,$28,$27,$27,$26,$25,$24,$24,$23,$22,$22,$21,$21,$20,$20)
 dta b($1F,$1F,$1E,$1E,$1D,$1D,$1C,$1C,$1B,$1B,$1B,$1A,$1A,$1A,$19,$19)
 dta b($19,$18,$18,$18,$17,$17,$17,$16,$16,$16,$16,$15,$15,$15,$15,$14)
 dta b($14,$14,$14,$14,$13,$13,$13,$13,$13,$12,$12,$12,$12,$12,$11,$11)
 dta b($11,$11,$11,$11,$10,$10,$10,$10,$10,$10,$10,$F,$F,$F,$F,$F)
 dta b($F,$F,$F,$F,$F,$F,$F,$F,$F,$F,$F,$E,$E,$E,$E,$E)
 dta b($E,$E,$E,$E,$E,$D,$D,$D,$D,$D,$D,$D,$D,$D,$D,$D)
 dta b($D,$C,$C,$C,$C,$C,$C,$C,$C,$C,$C,$C,$C,$C,$B,$B)
 dta b($B,$B,$B,$B,$B,$B,$B,$B,$B,$B,$B,$B,$B,$B,$A,$A)
 dta b($A,$A,$A,$A,$A,$A,$A,$A,$A,$A,$A,$A,$A,$A,$A,$A)
 dta b($A,$9,$9,$9,$9,$9,$9,$9,$9,$9,$9,$9,$9,$9,$9,$9)
 dta b($9,$9,$9,$9,$9,$9,$9,$9,$8,$8,$8,$8,$8,$8,$8,$8)
 dta b($8,$8,$8,$8,$8,$8,$8,$8,$8,$8,$8,$8,$8,$8,$8,$8)

; TABLICE DLA ATTACK

att_a dta $0f,$0f,$0f,$0d,$08,$05,$04,$04,$03,$01,$00,$00,$00,$00,$00,$00
att_u dta $00,$00,$00,085,107,182,180,000,051,071,163,102,081,027,016,010

; TABLICE DLA DECAY

dec_a dta $0f,$0d,$06,$04,$02,$01,$01,$01,$01,$00,$00,$00,$00,$00,$00,$00
dec_u dta $00,085,170,113,206,231,145,085,017,109,054,034,027,009,005,003

x28tab dta 0,28,56,84,112,140,168,196,224,252,255


m_init jmp (init_adress)
m_play jmp (play_adress)


sid_version	brk
sid_offset	dta a(0)
hlenght		dta $20
load_adress	dta a($0010)
END_ADRESS	dta a(sid_end)
init_adress	dta a($1000)
play_adress	dta a($1003)
buf_start	dta a(0)
songs		dta 1
defsong		dta 1

header		dta b($50,$53,$49,$44)


zp_bufor	:4 brk

sid_regmap	:32 brk


zp_tmp1 equ $f0 ; $20
zp_tmp2 equ zp_tmp1+1

zp_tmp6 equ zp_tmp2+1
zp_tmp7 equ zp_tmp6+1

c12_lo equ zp_tmp1
c12_hi equ zp_tmp2


c1_frqlo equ zp_tmp2
c1_frqhi equ zp_tmp1
c1_pwlo  equ sid_regmap+2
c1_pwhi  equ sid_regmap+3
c1_ctrl  equ zp_tmp7
c1_atde  equ sid_regmap+5
c1_stre  equ sid_regmap+6

c2_frqlo brk
c2_frqhi brk
c2_pwlo  equ sid_regmap+9
c2_pwhi  equ sid_regmap+10
c2_ctrl  brk
c2_atde  equ sid_regmap+12
c2_stre  equ sid_regmap+13

c3_frqlo brk
c3_frqhi brk
c3_pwlo  equ sid_regmap+16
c3_pwhi  equ sid_regmap+17
c3_ctrl  brk
c3_atde  equ sid_regmap+19
c3_stre  equ sid_regmap+20


sid_init

 sta defsong

nextsong

 jsr siddescription
 beq good_sid

good_sid equ *

 lda load_adress+1
 sta $fe
 lda load_adress
 sta $ff
 ldx hlenght

test ldy #0
 lda ($fe),y
; cmp #{ldx $8000,y}
; beq testd

 cmp #{sta $8000}
 beq testd
 cmp #{sta $8000,x}
 beq testd
 cmp #{sta $8000,y}
 beq testd
 cmp #{stx $8000}
 beq testd
 cmp #{sty $8000}
 bne testn

testd ldy #2
 lda ($fe),y
 cmp #$d4
; jmp testn

 bne testn

 dey
 lda ($fe),y
; and #31
 cmp #31
 bcs testn

 adc <sid_regmap
 sta ($fe),y

 lda >sid_regmap
 adc #0
 iny
 sta ($fe),y

 lda $fe
 adc #3
 sta $fe
 bcc test
 bcs sprhi

testn inc $fe
 bne test
sprhi inc $ff
 beq restart
 dex
 bpl test

 lda #3
 sta $d20f
 sta $d21f

restart

 ldx #0

 txa
clr_sid sta sid_regmap,x
 inx
 cpx #$20
 bne clr_sid

 lda #0
 sta $314
 sta $315

 ldx defsong
 dex
 txa
 tay
 jsr m_init

 ldx $314
 beq no_c64nmi
 lda $315
 beq no_c64nmi

 stx play_adress
 sta play_adress+1

; lda #{rts}
; sta $ea31

no_c64nmi

; sei
; lda #$fe
; sta $d301

 ldy #0
 sty c1_oldctrl
 sty c2_oldctrl
 sty c3_oldctrl

 sty ch1_vol
 sty ch2_vol
 sty ch3_vol

 sty ch1_adsr
 sty ch2_adsr
 sty ch3_adsr

 sty ch1_cnt
 sty ch2_cnt
 sty ch3_cnt

 rts


EMULATOR

; dec $d01a
 JSR M_PLAY



; SID to POKEY routine ver. 2.99
; dynamic channel allocation

; lda #128
; sta $d01a

;-----------------
;Procedura emulujaca ADSR i reszte SIDa
;-----------------

MAX_15 EQU 13

 lda zp_tmp1
 sta zp_bufor
 lda zp_tmp2
 sta zp_bufor+1
 lda zp_tmp6
 sta zp_bufor+2
 lda zp_tmp7
 sta zp_bufor+3


; kopiowanie zmiennych do remapowania w locie !

 lda sid_regmap+4
 sta c1_ctrl

; obsluga glosnosci ADSR oraz czy ma byc cos odtwarzane

; kanal 1

; lda c1_ctrl
 lsr @
 bcc new1

 lda #0
c1_oldctrl equ *-1
 and #1
 bne new1
; lda #0
 sta ch1_adsr
 sta ch1_cnt

new1
 lda c1_ctrl      ; odczytaj rejestr kontrolny
 sta c1_oldctrl

 and #8           ; bit test - 1 zerowanie
 beq play1

 ldx #1          ; adsr =0
 stx ch1_vol     ; mute_channel
 dex
 stx ch1_cnt
 stx ch1_adsr
 beq mute1

play1 ldx #0
ch1_vol equ *-1

 bcc release1  ; czy ads czy release

; asdr start

 lda c1_atde 
 beq susy1

 ldy #0
ch1_adsr equ *-1
 bne sust1

; attack - volume 0 - max

 lsr @
 lsr @
 lsr @
 lsr @
 tay

 lda #0
ch1_cnt equ *-1
 clc
 adc att_u,y
 sta ch1_cnt

 txa
 adc att_a,y
 cmp #$f     ; max volume
 bcc nozer1

 lda #$ff    ; zminiejsz licznik
 sta ch1_cnt

 lda #$f     ; max volume
 sta ch1_adsr ; odlicznie w dol
 bne nozer1


; decay & sustainer

sust1 and #$f
susy1 tay

 lda c1_stre
 lsr @
 lsr @
 lsr @
 lsr @

 bne *+2
 lda #8

 sta zp_tmp1     ; prog sustainera


 lda ch1_cnt
 sec
 sbc dec_u,y
 sta ch1_cnt

 txa
 sbc dec_a,y
 bcc sustnow1 ; przekrecenie licznika - sustainer
 cmp zp_tmp1      ; prog sustainera
 bcs nozer1
sustnow1 lda zp_tmp1 ; mniejsze to sustainer
 bcc nozer1

; release

release1 beq mute1

 lda c1_stre
 and #$f
 tay

 lda ch1_cnt
 sec
 sbc dec_u,y
 sta ch1_cnt

 txa
 sbc dec_a,y
 bcs nozer1
 lda #0

nozer1 sta ch1_vol
 tax

mute1

 lda c1_ctrl
 BMI no_square

 AND #%11110000
 BEQ NO_SND

 ASL @
 bpl no_square
                  ; w przypadku nakladania roznych fal
 asl @            ; puszcza prostokat
 bne no_square    ;

; check pw_only

 lda c1_pwlo
 asl @
 lda c1_pwhi
 rol @
 AND #%00011111
 BEQ NO_SND
 CMP #$1F
 bcc no_square

NO_SND LDX #0
no_square  stx c12_tvol

; kanal 2

 lda sid_regmap+11
 sta c2_ctrl

; lda c2_ctrl
 lsr @
 bcc new2

 lda #0
c2_oldctrl equ *-1
 and #1
 bne new2
; lda #0
 sta ch2_adsr
 sta ch2_cnt

new2
 lda c2_ctrl      ; odczytaj rejestr kontrolny
 sta c2_oldctrl

 and #8           ; bit test - 1 zerowanie
 beq play2
 ldx #1           ; adsr =0
 stx ch2_vol
 dex
 stx ch2_adsr
 stx ch2_cnt

 beq mute2

play2 ldx #0
ch2_vol equ *-1

 bcc release2

 lda c2_atde
 beq susy2

 ldy #0
ch2_adsr equ *-1
 bne sust2

 lsr @
 lsr @
 lsr @
 lsr @
 tay
 lda #0
ch2_cnt equ *-1
 clc
 adc att_u,y
 sta ch2_cnt

 txa
 adc att_a,y
 cmp #$f
 bcc nozer2

 lda #$ff
 sta ch2_cnt

 lda #$f
 sta ch2_adsr
 bne nozer2

sust2 and #$f
susy2 tay

 lda c2_stre
 lsr @
 lsr @
 lsr @
 lsr @
 bne *+2
 lda #8
 sta zp_tmp1

 lda ch2_cnt
 sec
 sbc dec_u,y
 sta ch2_cnt

 txa
 sbc dec_a,y
 bcc sustnow2
 cmp zp_tmp1
 bcs nozer2

sustnow2 lda zp_tmp1
 bcc nozer2

release2 beq mute2

 lda c2_stre
 and #$f
 tay
 lda ch2_cnt
 sec
 sbc dec_u,y
 sta ch2_cnt

 txa
 sbc dec_a,y
 bcs nozer2

 lda #0
nozer2 sta ch2_vol
 tax

mute2

 lda c2_ctrl
 BMI no_square2

 AND #%11110000
 BEQ NO_SND2

 ASL @
 bpl no_square2
                  ; w przypadku nakladania roznych fal
 asl @            ; puszcza prostokat
 bne no_square2    ;

; check pw_only

 lda c2_pwlo
 asl @
 lda c2_pwhi
 rol @
 AND #%00011111
 BEQ NO_SND2
 CMP #$1F
 bcc no_square2

NO_SND2 LDX #0

no_square2 stx c2_tvol


; kanal 3


 lda sid_regmap+18
 sta c3_ctrl

; lda c3_ctrl
 lsr @
 bcc new
 lda #0
c3_oldctrl equ *-1
 and #1
 bne new
; lda #0
 sta ch3_adsr
 sta ch3_cnt

new

 lda c3_ctrl      ; odczytaj rejestr kontrolny
 sta c3_oldctrl

 and #8            ; bit test - 1 zerowanie
 beq play

 ldx #1           ; adsr =0
 stx ch3_vol
 dex
 stx ch3_adsr
 stx ch3_cnt
 beq mute

play ldx #0
ch3_vol equ *-1

 bcc release

 lda c3_atde
 beq susy

 ldy #0
ch3_adsr equ *-1
 bne sust

 lsr @
 lsr @
 lsr @
 lsr @
 tay

 lda #0
ch3_cnt equ *-1
 clc
 adc att_u,y
 sta ch3_cnt

 txa
 adc att_a,y
 cmp #$f
 bcc nozer

 lda #$ff
 sta ch3_cnt

 lda #$f
 sta ch3_adsr
 bne nozer

sust and #$f
susy tay

 lda c3_stre
 lsr @
 lsr @
 lsr @
 lsr @
 bne *+2
 lda #8

 sta zp_tmp1

 lda ch3_cnt
 sec
 sbc dec_u,y
 sta ch3_cnt

 txa
 sbc dec_a,y
 bcc sustnow
 cmp zp_tmp1
 bcs nozer

sustnow lda zp_tmp1
 bcc nozer


release beq mute

 lda c3_stre
 and #$f
 tay
 lda ch3_cnt
 sec
 sbc dec_u,y
 sta ch3_cnt

 txa
 sbc dec_a,y
 bcs nozer

 lda #0
nozer sta ch3_vol
 tax

mute

 lda c3_ctrl
 BMI no_square1

 AND #%11110000
 BEQ NO_SND1

 ASL @
 bpl no_square1
                  ; w przypadku nakladania roznych fal
 asl @            ; puszcza prostokat
 bne no_square1    ;

; check pw_only

 lda c3_pwlo
 asl @
 lda c3_pwhi
 rol @
 AND #%00011111
 BEQ NO_SND1
 CMP #$1F
 bcc no_square1

NO_SND1 LDX #0
no_square1 stx c3_tvol


; lda #38
; sta $d01a

; relokuj czestoliwosc

 lda sid_regmap
 sta c1_frqlo
 lda sid_regmap+1
 sta c1_frqhi

 lda sid_regmap+7
 sta c2_frqlo
 lda sid_regmap+8
 sta c2_frqhi

 lda sid_regmap+14
 sta c3_frqlo
 lda sid_regmap+15
 sta c3_frqhi

; nie ruszac rejestru Y !
; dynamiczn alokacja kanalow

 lda c2_ctrl
 bmi no_alloc

 ldx c3_ctrl
 bpl no_all3

 stx c2_ctrl
 sta c3_ctrl

 lda c3_tvol
 ldx c2_tvol
 stx c3_tvol
 sta c2_tvol

 lda c2_frqlo
 ldx c3_frqlo
 stx c2_frqlo
 sta c3_frqlo

 lda c2_frqhi
 ldx c3_frqhi
 stx c2_frqhi
 sta c3_frqhi

 jmp no_alloc

no_all3 ldx c1_ctrl
 bpl no_alloc

 stx c2_ctrl
 sta c1_ctrl

 lda c12_tvol
 ldx c2_tvol
 stx c12_tvol
 sta c2_tvol

 lda c2_frqlo
 ldx c1_frqlo
 stx c2_frqlo
 sta c1_frqlo

 lda c2_frqhi
 ldx c1_frqhi
 stx c2_frqhi
 sta c1_frqhi

no_alloc lda c12_tvol
 bne check_frq

 lda c1_frqhi
 jmp c3_tst

check_frq lda c1_frqhi
 cmp #9
 bcc no_swap

c3_tst ldx c3_frqhi
 cpx #9
 bcs no_swapx

 stx c1_frqhi
 sta c3_frqhi

 lda c3_frqlo
 ldx c1_frqlo
 stx c3_frqlo
 sta c1_frqlo

 lda c12_tvol
 ldx c3_tvol
 stx c12_tvol
 sta c3_tvol

 lda c1_ctrl
 ldx c3_ctrl
 sta c3_ctrl
 stx c1_ctrl

 jmp no_swap

; swap 1<>2 - gdy na 2 nie ma szumu !!

no_swapx bit c2_ctrl  ; 2 kanal nie gra szumu ??
 bmi no_swap          ;
                      ;
 ldx c2_frqhi         ;
 cpx #9               ;
 bcs no_swap          ;

 stx c1_frqhi
 sta c2_frqhi

 lda c2_frqlo
 ldx c1_frqlo
 stx c2_frqlo
 sta c1_frqlo

 lda c12_tvol
 ldx c2_tvol
 stx c12_tvol
 sta c2_tvol

 lda c1_ctrl
 ldx c2_ctrl
 sta c2_ctrl
 stx c1_ctrl


no_swap lda c2_ctrl ; jesli szum - nie ma arbitrazu !
 bmi no_arb

; 3 kanaly graja prostokat
; sprawdz ktore nie beda graly na 64 khz !

 ldy c2_tvol ; jesli 2 kanal nie gra - 2 kanaly bez zmian
 beq no_arb  ;

 ldy c12_tvol
 beq no_arb

 ldy c1_frqhi  ; 1 kanal !
 cpy #9        ; jest powyzej 64 khz - nie remapuj !
 bcs no_arb

; jesli 2 kanaly moga byc na 15 khz to mapuj pozostaly na 1 (dwukanalowy)

 ldx #2           ; licznik =2

 lda c2_frqhi     ; 2 kanal ma byc powyzej
 cmp #9           ; 64 khz ??
 bcs hi1          ; tak - nie zmniejszaj licznika
 dex
hi1

 lda c3_tvol
 beq no_arb

 lda c3_frqhi  ; 3 kanal ?
 cmp #9           ;
 bcs hi3          ;
 dex              ;
hi3

 dex
 bne no_arb

; sta screen
; stx $d01a

 ldx c1_ctrl
 bcs swap3_1

; swap 1-2

 lda c2_ctrl
 stx c2_ctrl
 sta c1_ctrl

 lda c2_frqhi
 sty c2_frqhi
 sta c1_frqhi

 lda c12_tvol
 ldy c2_tvol
 sta c2_tvol

 lda c2_frqlo
 ldx c1_frqlo
 stx c2_frqlo

 bcc no_a

swap3_1

 lda c3_ctrl
 stx c3_ctrl
 sta c1_ctrl

 lda c3_frqhi
 sty c3_frqhi
 sta c1_frqhi

 lda c12_tvol
 ldy c3_tvol
 sta c3_tvol

 lda c3_frqlo
 ldx c1_frqlo
 stx c3_frqlo
no_a sta c1_frqlo
 sty c12_tvol

no_arb


; sprawdzaj co jest na danym kanale i w jakim trybie ma pracowac
; obsluga czestotliwosci i znieksztalcenia

; dzwiek dwukanalowy

; lda #$ce
; sta $d01a

 lda c12_tvol
 beq clean

 ldy c1_frqhi
 BIT C1_CTRL
 BMI C1_CALC_NOISE

 lda c1_frqlo
 jsr c12_freq179 ; OBLICZ WYSOKOSC

 LDA zp_tmp1
 STA C12_LO
 LDA zp_tmp2

clean ldy #$28
 LDX #$E0        ; CZYSTY DZWIEK = PROSTOKAT
 bne CH2_TEST

C1_CALC_NOISE LDX #$80 ; SZUM

 LDA NOISE_TAB,Y

 CMP #10
 BCS NO_179MHZ
 tay
 lda x28tab+1,y

 STA C12_LO
 LDA #0

 ldy #$28
 bne CH2_TEST

NO_179MHZ lDy #0
 STy C12_LO


CH2_TEST stx c12_poly
 STy CLOCK_BASE
 STA C12_HI


; lda #192+8
; sta $d01a

; tu moga byc wykozystane tm_zp6,tm_zp7

; 2 KANAL SIDA

 LDX #1  ; W X JEST ZNACZNIK X=0 15KHZ, X<>0 64 KHZ

 LDA C2_tVOL
 BEQ NIE_GRA1

 LDY C2_FRQHI

 BIT c2_ctrl
 bmi c2_CALC_NOISE

 CPY #MAX_15
 BCc KHZ_64_1

 inx          ; ZAZNACZ ZE nie MOZE BYC 15 KHZ!
KHZ_64_1

 ldY #$e0         ; PROSTOKAT
 BNE CH3_TEST

C2_CALC_NOISE

 lda noise_tab,y

 CMP #10
 BCS NO_179MHZ1
 tay

 lda clock_base
 ora #$40
 sta clock_base

 lda x28tab+1,y

NO_179MHZ1 STA C2_ATARIF  ; 64 KHZ !
 ldy #$80

CH3_TEST stY c2_poly

NIE_GRA1

;TEST 3 KANALU
 LDA C3_tVOL
 BEQ NIE_GRA2

 LDY C3_FRQHI

 BIT c3_ctrl
 bmi c3_CALC_NOISE

 LDA #$E0
 STA C3_POLY

 CPY #MAX_15
 BCS set_64khz

nie_gra2 DEX          ; ZAZNACZ ZE MOZE BYC 15 KHZ!
 Beq SET_15KHZ
 BNE SET_64KHZ


C3_CALC_NOISE LDA #$80
 STA C3_POLY

 lda noise_tab,y
 STA C3_ATARIF


 cmp #10
 bcc SET_64KHZ

 dex
 bne set_64khz

 lsr @
 lsr @
 LSR @
 sta c3_atarif



SET_15KHZ INC CLOCK_BASE

        LDA CLOCK_BASE ;DZIEL CZESTOTLIWOSC SZUMU/4
        AND #$28
        BNE NO_MODIFY1
        LSR C12_HI
        LSR C12_HI
NO_MODIFY1

        BIT C2_CTRL
        BPL FREQ_CALC

        LDA CLOCK_BASE
        AND #$40
        BNE NOFREQ_CALC3

        lda C2_ATARIF
        lsr @
        lsr @
        lsr @
        sta C2_ATARIF

        JMP NOFREQ_CALC3

FREQ_CALC lda c2_frqlo
        ldx c2_frqhi

        JSR M_find15
        tya
        bne no_min2
        sta c2_tvol
no_min2 STy C2_ATARIF


NOFREQ_CALC3 BIT C3_CTRL
       BMI NOFREQ_CALC2

       lda c3_frqlo
       ldx c3_frqhi

       JSR M_Find15

       JMP store_freq3


SET_64KHZ
        BIT C2_CTRL
        BMI NOFREQ_CALC1

        lda c2_frqlo
        ldx c2_frqhi

        JSR M_FIND64
        tya
        bne no_min1
        sta c2_tvol
no_min1 STY C2_ATARIF

NOFREQ_CALC1 BIT C3_CTRL
       BMI NOFREQ_CALC2

       lda c3_frqlo
       ldx c3_frqhi

       JSR M_FIND64
store_freq3 tya
       bne no_min
       sta c3_tvol

no_min STY C3_ATARIF

NOFREQ_CALC2



; odgrywaj kanaly !


 lda #0 ; c3_tvol
c3_tvol equ *-1
 ora #0 ; c3_poly
c3_poly equ *-1

 LDX #0 
CLOCK_BASE equ *-1
 LDY C12_LO

 sta $d203
 sta $d213

 LDA #0            ;c3_atarif
c3_atarif equ *-1
 STA $D202
 STA $D212

 lda #0            ;c2_tvol
c2_tvol equ *-1
 ora #0            ;c2_poly
c2_poly equ *-1
 sta $d201
 sta $d211

 LDA #0            ;c2_atarif
c2_atarif equ *-1
 STA $D200
 STA $D210

 stx $d208
 stx $d218

 lda #0            ;c12_tvol
c12_tvol equ *-1
 ORA #0            ;C12_POLY
c12_poly equ *-1
 sta $d207
 sta $d217

 lda C12_HI

 sta $d206
 sta $d216

 sty $d204
 sty $d214

; tya
; pha

; koniec playera

; inc $d01a
;
;
; ldy #0
; pla
; sta ($f0),y
;
; inw $f0


 lda zp_bufor+3
 sta zp_tmp1+3
 lda zp_bufor+2
 sta zp_tmp1+2
 lda zp_bufor+1
 sta zp_tmp1+1
 lda zp_bufor
 sta zp_tmp1

 rts

; konwersja czestotliwosci dla 1.79 Mhz
; a - hi , y - lo

c12_freq179
 sta dzielnik_l1
 sty dzielnik_h1
 sta dzielnik_l11
 sty dzielnik_h11
 sta dzielnik_l12
 sty dzielnik_h12

 lda #$e4
 sta zp_tmp1

 ldx #8

 lda #0
 STA ZP_TMP7

m_jk asl zp_tmp1
 rol @
 ROL ZP_TMP7

 sta zp_tmp6
 sec
 sbc #0
dzielnik_l1 equ *-1
 tay

 lda ZP_TMP7
 sbc #0
dzielnik_h1 equ *-1

 bcc m_jjj
 sta zp_tmp7

 tya

 dex
 bne m_jk
 BEQ NEXT_DIV

m_jjj lda zp_tmp6

 dex
 bne m_jk

NEXT_DIV inx
 stx zp_tmp2
 stx zp_tmp1

DIV_16 asl @
 rol zp_tmp7

 sta zp_tmp6
 sec
 sbc #0
dzielnik_l11 equ *-1
 tay

 lda zp_tmp7
 sbc #0
dzielnik_h11 equ *-1

 bcc NO_STORE1

 sta zp_tmp7

 tya

 rol zp_tmp2

 bcc div_16
 bcs div_8

NO_STORE1 lda zp_tmp6
 rol zp_tmp2
 bcc div_16

DIV_8 asl @
 rol zp_tmp7

 sta zp_tmp6
 sec
 sbc #0
dzielnik_l12 equ *-1

 tay

 lda zp_tmp7
 sbc #0
dzielnik_h12 equ *-1

 bcc NO_STORE2

 sta zp_tmp7

 tya
 rol zp_tmp1
 bcc div_8
 rts

NO_STORE2 lda zp_tmp6
 rol zp_tmp1
 bcc div_8
 rts


; konwersja dla 64 khz

m_find64 cpx #$2a

 LDY Look_64,X
 bcs testhi
 BEQ M_EX

 pha
 LDa Index_64,x
 tax
 pla

f_xnt cmp Loval_64,y
 bcc m_l1
 dey
 dex
 bne f_xnt

m_l1 iny
M_EX rts

testhi cmp loval_64,y
 lda index_64,x
 bmi m_l1
 bcc m_l1
 rts

; konwersja dla 15 khz

m_find15 cpx #$14

 LDY Look_15,X
 bcs testhi15
 BEQ M_EX1

 pha
 LDa Index_15,x
 tax
 pla

f_xnu cmp Loval_15,y
 bcc m_l2

 dey
 dex
 bne f_xnu

m_l2 iny
M_EX1 rts

testhi15 cmp loval_15,y
 lda index_15,x
 bmi m_l2
 bcc m_l2
 rts


; errors!
; x=0 - no error

; exit - X - 01  - not a sid

not_a_sid ldx #1
 rts

siddescription equ *

 lda <sid_mem
 sta $f0
 lda >sid_mem
 sta $f1

 ldy #0
check_header lda ($f0),y
 cmp header,y
 bne not_a_sid
 iny
 cpy #4
 bcc check_header

; lda ($f0),y
; sta sid_version

 ldy #6
 lda ($f0),y
 sta sid_offset
 iny
 lda ($f0),y
 sta sid_offset+1

 ldy #8
 lda ($f0),y
 sta load_adress
 iny
 lda ($f0),y
 sta load_adress+1

 ldy #$a
 lda ($f0),y
 sta init_adress+1
 iny
 lda ($f0),y
 sta init_adress

 ldy #$c
 lda ($f0),y
 sta play_adress+1
 iny
 lda ($f0),y
 sta play_adress

 ldy #$f
 lda ($f0),y
 sta songs

 ldy #$11
 lda ($f0),y
 
; LDA #10               ; -------------------------------------------------!
; sta defsong

; $12-$15 - kazdy bit dla osobnego songu
; 0- nmi , 1 - cia play

; wyswietl tytul

/*
 ldy #$16
 ldx #0
loop lda ($f0),y
 jsr asc_to_ekr
 sta screen+6,x
 iny
 inx
 cpx #$20
 bne loop

; wyswietl autora

 ldx #0
loop1 lda ($f0),y
 jsr asc_to_ekr
 sta screen+48,x
 iny
 inx
 cpx #$20
 bne loop1

; wyswietl copyright

 ldx #0
loop2 lda ($f0),y
 jsr asc_to_ekr
 sta screen+91,x
 iny
 inx
 cpx #$20-4
 bne loop2
*/

; adres startowy pliku z c64

 lda $f0
 clc
 adc sid_offset+1
 sta $f0
 lda $f1

 adc sid_offset
 sta $f1

; lokacja pamieci gdzie ma byc sid

 lda load_adress
 beq from_cfile

; raw data !
 sta $f3
 lda load_adress+1
 sta $f2
 jmp show_a

; c64 file

from_cfile ldy #1
 lda ($f0),y
 sta $f3
 sta load_adress
 dey
 lda ($f0),y
 sta $f2
 sta load_adress+1

; pomin naglowek
 lda $f0
 clc
 adc #2
 sta $f0
 sta buf_start

 lda $f1
 adc #0
 sta $f1
 sta buf_start+1

; wyswietl adres ladowania
show_a

 jsr relocate_mem

 inc songs

 ldx #0
 rts


; relokacja pamieci

m_return equ *

 lda load_adress
 sta $f3
 lda load_adress+1
 sta $f2

 lda buf_start
 sta $f0
 lda buf_start+1
 sta $f1

; ile bajtów do relokacji

relocate_mem

 lda end_adress
 sec
 sbc $f0
 sta $f4
 lda end_adress+1
 sbc $f1
 sta $f5
 clc
 adc #1
 sta hlenght

; relokuj playera pod wlasciwy adres

 ldy #0
reloc  lda ($f2),y
 tax


 lda ($f0),y
 sta ($f2),y

 txa
 sta ($f0),y


 inw $f0
 inw $f2
 
 lda $f4
 sec
 sbc #1
 sta $f4
 lda $f5
 sbc #0
 sta $f5

 bcs reloc
 rts


.proc sid_stop

 ldy #8
 lda #0
stop
 sta $d200,y
 sta $d210,y
 dey
 bpl stop
 rts

.endp


.proc sid_restart (.byte a) .reg

 sta defsong
 jmp restart

.endp


 .print 'PLAYER: ',noise_tab,'..',*

*---

	blk update public
