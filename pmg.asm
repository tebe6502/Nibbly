// grafika PMG dla pola gry

 opt h-
 org $2000

 dta $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
 dta $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
 dta $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
 dta $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
 dta $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
 dta $00,$00,$00,$00,$00,$00,$00,$00,$00,$01,$0A,$00,$0A,$00,$00,$00
 dta $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
 dta $00,$04,$09,$02,$09,$07,$0D,$07,$09,$03,$0D,$0F,$0F,$0F,$0F,$0F
 dta $0F,$0E,$0A,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
 dta $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
 dta $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
 dta $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
 dta $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
 dta $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
 dta $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
 dta $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00

 dta $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
 dta $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
 dta $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
 dta $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
 dta $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
 dta $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00	// od tego adresu fillujemy 4*16
 dta $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
 dta $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
 dta $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
 dta $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
 dta $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
 dta $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
 dta $00,$00,$00,$00,$00,$00,$00,$00
 :16 brk
 dta %00100000,%01000000,%00100000,%00100000,%00100000,%00100000,%01000000,%00100000
 :32 brk

 dta $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
 dta $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
 dta $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
 dta $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
 dta $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
 dta $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00	// od tego adresu fillujemy 4*16
 dta $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
 dta $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
 dta $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
 dta $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
 dta $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
 dta $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
 dta $00,$00,$00,$00,$00,$00,$00,$00
 :16 brk
 dta %10010000,%00100000,%10010000,%10010000,%10010000,%10010000,%00100000,%10010000
 :32 brk

 :40 brk
 dta $AA,$FF,$AA,$AA,$AA,$AA,$AA,$AA
 dta $55,$55,$55,$55,$55,$55,$55,$55,$AA,$FF,$AA,$AA,$AA,$AA,$AA,$AA
 dta $55,$55,$55,$55,$55,$55,$55,$55,$AA,$FF,$AA,$AA,$AA,$AA,$AA,$AA
 dta $55,$55,$55,$55,$55,$55,$55,$55,$AA,$FF,$AA,$AA,$AA,$AA,$AA,$AA
 dta $55,$55,$55,$55,$55,$55,$55,$55,$AA,$FF,$AA,$AA,$AA,$AA,$AA,$AA
 dta $55,$55,$55,$55,$55,$55,$55,$55,$AA,$FF,$AA,$AA,$AA,$AA,$AA,$AA
 dta $55,$55,$55,$55,$55,$55,$55,$55,$AA,$FF,$AA,$AA,$AA,$AA,$AA,$AA
 dta $55,$55,$55,$55,$55,$55,$55,$55,$AA,$FF,$AA,$AA,$AA,$AA,$AA,$AA
 dta $55,$55,$55,$55,$55,$55,$55,$55,$AA,$FF,$AA,$AA,$AA,$AA,$AA,$AA
 dta $55,$55,$55,$55,$55,$55,$55,$55
; $AA,$FF,$AA,$AA,$AA,$AA,$AA,$AA
; dta $55,$55,$55,$55,$55,$55,$55,$55
 :16 brk
 :+15 brk
 dta %00001110
 dta %00100000,%01000000,%00100000,%00100000,%00100000,%00100000,%01000000,%00100000
 :+2 dta %00001111
 :16+6+8 brk

 :40 brk
 dta $AA,$FF,$AA,$AA,$AA,$AA,$AA,$AA
 dta $55,$55,$55,$55,$55,$55,$55,$55,$AA,$FF,$AA,$AA,$AA,$AA,$AA,$AA
 dta $55,$55,$55,$55,$55,$55,$55,$55,$AA,$FF,$AA,$AA,$AA,$AA,$AA,$AA
 dta $55,$55,$55,$55,$55,$55,$55,$55,$AA,$FF,$AA,$AA,$AA,$AA,$AA,$AA
 dta $55,$55,$55,$55,$55,$55,$55,$55,$AA,$FF,$AA,$AA,$AA,$AA,$AA,$AA
 dta $55,$55,$55,$55,$55,$55,$55,$55,$AA,$FF,$AA,$AA,$AA,$AA,$AA,$AA
 dta $55,$55,$55,$55,$55,$55,$55,$55,$AA,$FF,$AA,$AA,$AA,$AA,$AA,$AA
 dta $55,$55,$55,$55,$55,$55,$55,$55,$AA,$FF,$AA,$AA,$AA,$AA,$AA,$AA
 dta $55,$55,$55,$55,$55,$55,$55,$55,$AA,$FF,$AA,$AA,$AA,$AA,$AA,$AA
 dta $55,$55,$55,$55,$55,$55,$55,$55
; $AA,$FF,$AA,$AA,$AA,$AA,$AA,$AA
; dta $55,$55,$55,$55,$55,$55,$55,$55
 :16 brk
 :16 brk
 dta %10010000,%00100000,%10010000,%10010000,%10010000,%10010000,%00100000,%10010000
 :32 brk
