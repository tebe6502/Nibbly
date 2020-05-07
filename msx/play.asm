
 org $a000
 ins 'nibbly.sid'


 org $2000

main

 lda #5
 jsr sid_init

loop

 lda:cmp:req 20

 jsr emulator
 
 jmp loop


 .link 'nibbly_msx.obx'

 run main