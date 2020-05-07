
*--- INTRO

 org $2000

intro

 lda #1
 sta 82

 clrscr

 print ' ' 
 print '           NIBBLY 14.04.2006'
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

 rts

 .print 'End: ',*

 ini intro


 opt l-
 icl 'clrscr.mac'
 icl 'print.mac'
