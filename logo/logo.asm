

prg	= $1000

pmg	= $d800

chbase	= $D409

scr48	equ %00111111	;screen 48b
scr40	equ %00111110	;screen 40b
scr32	equ %00111101	;screen 32b

*--------------------------------

*--- INTRO

 org prg

intro
 mva #1 82

 clrscr

 print ' ' 
 print '           NIBBLY 31.05.2006'
 print '          -------------------' 
 print ' '
 print '                 CODE                 '*
 print '           Tomasz TEBE Biela'
 print ' '
 print '               GRAPHICS               '*
 print '          Kamil VIDOL Walaszek'
 print ' '
 print '                MUSIC                 '*
 print '          Thomas DRAX Mogensen'
 print ' ' 
 print '           SID2POKEY PLAYER           '*
 print '       Krzysztof SAINT Swiecicki'
 print ' '
 print ' '
 print '         Hardware Requirements        '*
 print '- CPU 6502, 64kB RAM, ANTIC, POKEY'
 print '- Joystick in port 1 (AUTOFIRE=OFF)'
 print '- Color TV'
 print ' '
 print '   >> Press any key to continue <<'

 mva #$ff 764

lop
 ldy 764
 iny
 beq lop

 lda #0
 :9 sta $d000+#

 rts

 ini intro

*--------------------------------

 org prg

s1	ins 'logo1.dat'
s2	ins 'logo2.dat'

a1
 dta $30
 :11 dta $70
 dta $4e,a(s1)
 :47 dta $e
; dta $70,$f0
; dta $44,a(scr)
; :6 dta 4
 dta $41,a(a2)

a2
 dta $30
 :11 dta $70
 dta $4e,a(s2)
 :47 dta $e
; dta $70,$f0
; dta $44,a(scr)
; :6 dta 4
 dta $41,a(a1)

logo
 mwa #$0604 708
 mwa #$0a08 710

 mwa #a1 560
 rts

 .print 'Program: ',intro,'..',*


 ini logo

; .get [0] 'logo1.dat'
; .get [1920] 'logo2.dat'
; .sav [0] 'logo.dat',2*1920

 opt l-
 icl 'clrscr.mac'
 icl 'print.mac'
 icl 'align.mac'
