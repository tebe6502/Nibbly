
/*
  Program DLI i program rastra

  Aktualizacja panelu wpleciona zostala w kod programu zmian rastra
*/


	?old_dli = *


dli0
_c0 lda #$74
 sta $d40a
 sta color1

 dli_quit dli0_1

*---

dli0_1
; line=32

 lda #$22
 ldx #$00
lives equ *-1
_c9 ldy #$36
 sta $d40a
 sta gtictl
 stx $d01e
 sty color1
; lda #$00
; sta $d01e
 inc byt3
 cmp byt2

; line=33

 jsr wait24cycle
 lda #$30
 sta $D002
 lda #$70
; sta $D01E
 ldy cyfry+20,x
 sta $D002
 lda #$90
 sta $D002
 lda #$00
 lda #$B0
 sta $D002
 lda #$00
 sty panel_lives+40*2

; line=34

 jsr wait24cycle
 lda #$30
 sta $D002
 lda #$70
; sta $D01E
 ldy cyfry+30,x
 sta $D002
 lda #$90
 sta $D002
 lda #$00
 lda #$B0
 sta $D002
 lda #$00
 sty panel_lives+40*3

; line=35

 jsr wait24cycle
 lda #$30
 sta $D002
 lda #$70
; sta $D01E
 ldy cyfry+40,x
 sta $D002
 lda #$90
 sta $D002
 lda #$00
 lda #$B0
 sta $D002
 lda #$00
 sty panel_lives+40*4

; line=36

 jsr wait24cycle
 lda #$30
 sta $D002
 lda #$70
; sta $D01E
 ldy cyfry+50,x
 sta $D002
 lda #$90
 sta $D002
 lda #$00
 lda #$B0
 sta $D002
 lda #$00
 sty panel_lives+40*5

; line=37

 jsr wait24cycle
 lda #$30
 sta $D002
 lda #$70
; sta $D01E
 ldy cyfry+60,x
 sta $D002
 lda #$90
 sta $D002
 lda #$00
 lda #$B0
 sta $D002
 lda #$00
 sty panel_lives+40*6

; line=38

 jsr wait24cycle
 lda #$30
 sta $D002
 lda #$70
 sta $D01E
 sta $D002
 lda #$90
 sta $D002
 lda #$00
 lda #$B0
 sta $D002
 lda #$00
 sta $D01E

; line=39

 jsr wait24cycle
 lda #$30
 sta $D002
 lda #$70
 sta $D01E
 sta $D002
 lda #$90
 sta $D002
 lda #$00
 lda #$B0
 sta $D002
 lda #$00
 sta $D01E

; line=40

c13 lda #$74
 ldx #$74
 ldy #$00
 sta colpm2
 sta colpm3
 sty $d01e
 ldx #$00
round_0 equ *-1
 sta $d01e
 cmp byt2

; line=41

 jsr wait24cycle
 lda #$30
 sta $D002
 lda #$70
; sta $D01E
 ldy cyfry+20,x
 sta $D002
 lda #$90
 sta $D002
 lda #$00
 lda #$B0
 sta $D002
 lda #$00
 sty panel_round+40*2

; line=42

 jsr wait24cycle
 lda #$30
 sta $D002
 lda #$70
; sta $D01E
 ldy cyfry+30,x
 sta $D002
 lda #$90
 sta $D002
 lda #$00
 lda #$B0
 sta $D002
 lda #$00
 sty panel_round+40*3

; line=43

 jsr wait24cycle
 lda #$30
 sta $D002
 lda #$70
; sta $D01E
 ldy cyfry+40,x
 sta $D002
 lda #$90
 sta $D002
 lda #$00
 lda #$B0
 sta $D002
 lda #$00
 sty panel_round+40*4

; line=44

 jsr wait24cycle
 lda #$30
 sta $D002
 lda #$70
; sta $D01E
 ldy cyfry+50,x
 sta $D002
 lda #$90
 sta $D002
 lda #$00
 lda #$B0
 sta $D002
 lda #$00
 sty panel_round+40*5

; line=45

 jsr wait24cycle
 lda #$30
 sta $D002
 lda #$70
; sta $D01E
 ldy cyfry+60,x
 sta $D002
 lda #$90
 sta $D002
 lda #$00
 lda #$B0
 sta $D002
 lda #$00
 sty panel_round+40*6

; line=46

 jsr wait24cycle
 lda #$30
 sta $D002
 lda #$70
 sta $D01E
 sta $D002
 lda #$90
 sta $D002
 lda #$00
 lda #$B0
 sta $D002
 lda #$00
 sta $D01E

; line=47

 jsr wait24cycle
 lda #$30
 sta $D002
 lda #$70
 sta $D01E
 sta $D002
 lda #$90
 sta $D002
 lda #$00
 lda #$B0
 sta $D002
 lda #$00
 sta $D01E

; line=48

c15 lda #$0A
 ldx #$0A
 ldy #$00
 sta colpm2
 sta colpm3
 sty $d01e
 ldx #$00
round_1 equ *-1
 sta $d01e
 cmp byt2

; line=49

 jsr wait24cycle
 lda #$30
 sta $D002
 lda #$70
; sta $D01E
 ldy cyfry+20,x
 sta $D002
 lda #$90
 sta $D002
 lda #$00
 lda #$B0
 sta $D002
 lda #$00
 sty panel_round+40*2+1

; line=50

 jsr wait24cycle
 lda #$30
 sta $D002
 lda #$70
; sta $D01E
 ldy cyfry+30,x
 sta $D002
 lda #$90
 sta $D002
 lda #$00
 lda #$B0
 sta $D002
 lda #$00
 sty panel_round+40*3+1

; line=51

 jsr wait24cycle
 lda #$30
 sta $D002
 lda #$70
; sta $D01E
 ldy cyfry+40,x
 sta $D002
 lda #$90
 sta $D002
 lda #$00
 lda #$B0
 sta $D002
 lda #$00
 sty panel_round+40*4+1

; line=52

 jsr wait24cycle
 lda #$30
 sta $D002
 lda #$70
; sta $D01E
 ldy cyfry+50,x
 sta $D002
 lda #$90
 sta $D002
 lda #$00
 lda #$B0
 sta $D002
 lda #$00
 sty panel_round+40*5+1

; line=53

 jsr wait24cycle
 lda #$30
 sta $D002
 lda #$70
; sta $D01E
 ldy cyfry+60,x
 sta $D002
 lda #$90
 sta $D002
 lda #$00
 lda #$B0
 sta $D002
 lda #$00
 sty panel_round+40*6+1

; line=54

 jsr wait24cycle
 lda #$30
 sta $D002
 lda #$70
 sta $D01E
 sta $D002
 lda #$90
 sta $D002
 lda #$00
 lda #$B0
 sta $D002
 lda #$00
 sta $D01E

; line=55

 jsr wait24cycle
 lda #$30
 sta $D002
 lda #$70
 sta $D01E
 sta $D002
 lda #$90
 sta $D002
 lda #$00
 lda #$B0
 sta $D002
 lda #$00
 sta $D01E

; line=56

c17 lda #$74
 ldx #$74
 ldy #$00
 sta colpm2
 sta colpm3
 sty $d01e
 ldx #$00
round_2 equ *-1
 sta $d01e
 cmp byt2

; line=57

 jsr wait24cycle
 lda #$30
 sta $D002
 lda #$70
; sta $D01E
 ldy cyfry+20,x
 sta $D002
 lda #$90
 sta $D002
 lda #$00
 lda #$B0
 sta $D002
 lda #$00
 sty panel_round+40*2+2

; line=58

 jsr wait24cycle
 lda #$30
 sta $D002
 lda #$70
; sta $D01E
 ldy cyfry+30,x
 sta $D002
 lda #$90
 sta $D002
 lda #$00
 lda #$B0
 sta $D002
 lda #$00
 sty panel_round+40*3+2

; line=59

 jsr wait24cycle
 lda #$30
 sta $D002
 lda #$70
; sta $D01E
 ldy cyfry+40,x
 sta $D002
 lda #$90
 sta $D002
 lda #$00
 lda #$B0
 sta $D002
 lda #$00
 sty panel_round+40*4+2

; line=60

 jsr wait24cycle
 lda #$30
 sta $D002
 lda #$70
; sta $D01E
 ldy cyfry+50,x
 sta $D002
 lda #$90
 sta $D002
 lda #$00
 lda #$B0
 sta $D002
 lda #$00
 sty panel_round+40*5+2

; line=61

 jsr wait24cycle
 lda #$30
 sta $D002
 lda #$70
; sta $D01E
 ldy cyfry+60,x
 sta $D002
 lda #$90
 sta $D002
 lda #$00
 lda #$B0
 sta $D002
 lda #$00
 sty panel_round+40*6+2

; line=62

 jsr wait24cycle
 lda #$30
 sta $D002
 lda #$70
 sta $D01E
 sta $D002
 lda #$90
 sta $D002
 lda #$00
 lda #$B0
 sta $D002
 lda #$00
 sta $D01E

; line=63

 jsr wait24cycle
 lda #$30
 sta $D002
 lda #$70
 sta $D01E
 sta $D002
 lda #$90
 sta $D002
 lda #$00
 lda #$B0
 sta $D002
 lda #$00
 sta $D01E

; line=64

c19 lda #$0A
 ldx #$0A
 ldy #$00
 sta colpm2
 sta colpm3
 sty $d01e
 ldx #$00
clock_1 equ *-1
 sta $d01e
 cmp byt2

; line=65

 jsr wait24cycle
 lda #$30
 sta $D002
 lda #$70
; sta $D01E
 ldy cyfry+20,x
 sta $D002
 lda #$90
 sta $D002
 lda #$00
 lda #$B0
 sta $D002
 lda #$00
 sty panel_clock+40*2+1

; line=66

 jsr wait24cycle
 lda #$30
 sta $D002
 lda #$70
; sta $D01E
 ldy cyfry+30,x
 sta $D002
 lda #$90
 sta $D002
 lda #$00
 lda #$B0
 sta $D002
 lda #$00
 sty panel_clock+40*3+1

; line=67

 jsr wait24cycle
 lda #$30
 sta $D002
 lda #$70
; sta $D01E
 ldy cyfry+40,x
 sta $D002
 lda #$90
 sta $D002
 lda #$00
 lda #$B0
 sta $D002
 lda #$00
 sty panel_clock+40*4+1

; line=68

 jsr wait24cycle
 lda #$30
 sta $D002
 lda #$70
; sta $D01E
 ldy cyfry+50,x
 sta $D002
 lda #$90
 sta $D002
 lda #$00
 lda #$B0
 sta $D002
 lda #$00
 sty panel_clock+40*5+1

; line=69

 jsr wait24cycle
 lda #$30
 sta $D002
 lda #$70
; sta $D01E
 ldy cyfry+60,x
 sta $D002
 lda #$90
 sta $D002
 lda #$00
 lda #$B0
 sta $D002
 lda #$00
 sty panel_clock+40*6+1

; line=70

 jsr wait24cycle
 lda #$30
 sta $D002
 lda #$70
 sta $D01E
 sta $D002
 lda #$90
 sta $D002
 lda #$00
 lda #$B0
 sta $D002
 lda #$00
 sta $D01E

; line=71

 jsr wait24cycle
 lda #$30
 sta $D002
 lda #$70
 sta $D01E
 sta $D002
 lda #$90
 sta $D002
 lda #$00
 lda #$B0
 sta $D002
 lda #$00
 sta $D01E

; line=72

c21 lda #$74
 ldx #$74
 ldy #$00
 sta colpm2
 sta colpm3
 sty $d01e
 ldx #$00
clock_3 equ *-1
 sta $d01e
 cmp byt2

; line=73

 jsr wait24cycle
 lda #$30
 sta $D002
 lda #$70
; sta $D01E
 ldy cyfry+20,x
 sta $D002
 lda #$90
 sta $D002
 lda #$00
 lda #$B0
 sta $D002
 lda #$00
 sty panel_clock+40*2+3

; line=74

 jsr wait24cycle
 lda #$30
 sta $D002
 lda #$70
; sta $D01E
 ldy cyfry+30,x
 sta $D002
 lda #$90
 sta $D002
 lda #$00
 lda #$B0
 sta $D002
 lda #$00
 sty panel_clock+40*3+3

; line=75

 jsr wait24cycle
 lda #$30
 sta $D002
 lda #$70
; sta $D01E
 ldy cyfry+40,x
 sta $D002
 lda #$90
 sta $D002
 lda #$00
 lda #$B0
 sta $D002
 lda #$00
 sty panel_clock+40*4+3

; line=76

 jsr wait24cycle
 lda #$30
 sta $D002
 lda #$70
; sta $D01E
 ldy cyfry+50,x
 sta $D002
 lda #$90
 sta $D002
 lda #$00
 lda #$B0
 sta $D002
 lda #$00
 sty panel_clock+40*5+3

; line=77

 jsr wait24cycle
 lda #$30
 sta $D002
 lda #$70
; sta $D01E
 ldy cyfry+60,x
 sta $D002
 lda #$90
 sta $D002
 lda #$00
 lda #$B0
 sta $D002
 lda #$00
 sty panel_clock+40*6+3

; line=78

 jsr wait24cycle
 lda #$30
 sta $D002
 lda #$70
 sta $D01E
 sta $D002
 lda #$90
 sta $D002
 lda #$00
 lda #$B0
 sta $D002
 lda #$00
 sta $D01E

; line=79

 jsr wait24cycle
 lda #$30
 sta $D002
 lda #$70
 sta $D01E
 sta $D002
 lda #$90
 sta $D002
 lda #$00
 lda #$B0
 sta $D002
 lda #$00
 sta $D01E

; line=80

f0 lda >fnt		// tutaj wlaczamy zestaw z napisem
nap_gti ldx #$24
c23 ldy #$0A
 sta chbase
 stx gtictl
 sty colpm2
 lda #$0A
 sty colpm3
 cmp byt2

; line=81

 jsr wait24cycle
 lda #$30
 sta $D002
 lda #$70
 sta $D01E
 sta $D002
 lda #$90
 sta $D002
 ldx #$00
clock_4 equ *-1
 lda #$B0
 sta $D002
 lda #$00
 sta $D01E

; line=82

 jsr wait24cycle
 lda #$30
 sta $D002
 lda #$70
; sta $D01E
 ldy cyfry+20,x
 sta $D002
 lda #$90
 sta $D002
 lda #$00
 lda #$B0
 sta $D002
 lda #$00
 sty panel_clock+40*2+4

; line=83

 jsr wait24cycle
 lda #$30
 sta $D002
 lda #$70
; sta $D01E
 ldy cyfry+30,x
 sta $D002
 lda #$90
 sta $D002
 lda #$00
 lda #$B0
 sta $D002
 lda #$00
 sty panel_clock+40*3+4

; line=84

 jsr wait24cycle
 lda #$30
 sta $D002
 lda #$70
; sta $D01E
 ldy cyfry+40,x
 sta $D002
 lda #$90
 sta $D002
 lda #$00
 lda #$B0
 sta $D002
 lda #$00
 sty panel_clock+40*4+4

; line=85

 jsr wait24cycle
 lda #$30
 sta $D002
 lda #$70
; sta $D01E
 ldy cyfry+50,x
 sta $D002
 lda #$90
 sta $D002
 lda #$00
 lda #$B0
 sta $D002
 lda #$00
 sty panel_clock+40*5+4

; line=86

 jsr wait24cycle
 lda #$30
 sta $D002
 lda #$70
; sta $D01E
 ldy cyfry+60,x
 sta $D002
 lda #$90
 sta $D002
 lda #$00
 lda #$B0
 sta $D002
 lda #$00
 sty panel_clock+40*6+4

; line=87

 jsr wait24cycle
 lda #$30
 sta $D002
 lda #$70
 sta $D01E
 sta $D002
 lda #$90
 sta $D002
 lda #$00
 lda #$B0
 sta $D002
 lda #$00
 sta $D01E

; line=88

c25 lda #$74
 ldx #$74
 ldy #$00
 sta colpm2
 sta colpm3
 sty $d01e
 ldx #$00
punkt_0 equ *-1
 sta $d01e
 cmp byt2

; line=89

 jsr wait24cycle
 lda #$30
 sta $D002
 lda #$70
; sta $D01E
 ldy cyfry+20,x
 sta $D002
 lda #$90
 sta $D002
 lda #$00
 lda #$B0
 sta $D002
 lda #$00
 sty panel_punkt+40*2+0

; line=90

 jsr wait24cycle
 lda #$30
 sta $D002
 lda #$70
; sta $D01E
 ldy cyfry+30,x
 sta $D002
 lda #$90
 sta $D002
 lda #$00
 lda #$B0
 sta $D002
 lda #$00
 sty panel_punkt+40*3+0

; line=91

 jsr wait24cycle
 lda #$30
 sta $D002
 lda #$70
; sta $D01E
 ldy cyfry+40,x
 sta $D002
 lda #$90
 sta $D002
 lda #$00
 lda #$B0
 sta $D002
 lda #$00
 sty panel_punkt+40*4+0

; line=92

 jsr wait24cycle
 lda #$30
 sta $D002
 lda #$70
; sta $D01E
 ldy cyfry+50,x
 sta $D002
 lda #$90
 sta $D002
 lda #$00
 lda #$B0
 sta $D002
 lda #$00
 sty panel_punkt+40*5+0

; line=93

 jsr wait24cycle
 lda #$30
 sta $D002
 lda #$70
; sta $D01E
 ldy cyfry+60,x
 sta $D002
 lda #$90
 sta $D002
 lda #$00
 lda #$B0
 sta $D002
 lda #$00
 sty panel_punkt+40*6+0

; line=94

 jsr wait24cycle
 lda #$30
 sta $D002
 lda #$70
 sta $D01E
 sta $D002
 lda #$90
 sta $D002
 lda #$00
 lda #$B0
 sta $D002
 lda #$00
 sta $D01E

; line=95

 jsr wait24cycle
 lda #$30
 sta $D002
 lda #$70
 sta $D01E
 sta $D002
 lda #$90
 sta $D002
 lda #$00
 lda #$B0
 sta $D002
 lda #$00
 sta $D01E

; line=96

c27 lda #$0A
 ldx #$0A
 ldy #$00
 sta colpm2
 sta colpm3
 sty $d01e
 ldx #$00
punkt_1 equ *-1
 sta $d01e
 cmp byt2

; line=97

 jsr wait24cycle
 lda #$30
 sta $D002
 lda #$70
; sta $D01E
 ldy cyfry+20,x
 sta $D002
 lda #$90
 sta $D002
 lda #$00
 lda #$B0
 sta $D002
 lda #$00
 sty panel_punkt+40*2+1

; line=98

 jsr wait24cycle
 lda #$30
 sta $D002
 lda #$70
; sta $D01E
 ldy cyfry+30,x
 sta $D002
 lda #$90
 sta $D002
 lda #$00
 lda #$B0
 sta $D002
 lda #$00
 sty panel_punkt+40*3+1

; line=99

 jsr wait24cycle
 lda #$30
 sta $D002
 lda #$70
; sta $D01E
 ldy cyfry+40,x
 sta $D002
 lda #$90
 sta $D002
 lda #$00
 lda #$B0
 sta $D002
 lda #$00
 sty panel_punkt+40*4+1

; line=100

 jsr wait24cycle
 lda #$30
 sta $D002
 lda #$70
; sta $D01E
 ldy cyfry+50,x
 sta $D002
 lda #$90
 sta $D002
 lda #$00
 lda #$B0
 sta $D002
 lda #$00
 sty panel_punkt+40*5+1

; line=101

 jsr wait24cycle
 lda #$30
 sta $D002
 lda #$70
; sta $D01E
 ldy cyfry+60,x
 sta $D002
 lda #$90
 sta $D002
 lda #$00
 lda #$B0
 sta $D002
 lda #$00
 sty panel_punkt+40*6+1

; line=102

 jsr wait24cycle
 lda #$30
 sta $D002
 lda #$70
 sta $D01E
 sta $D002
 lda #$90
 sta $D002
 lda #$00
 lda #$B0
 sta $D002
 lda #$00
 sta $D01E

; line=103

 jsr wait24cycle
 lda #$30
 sta $D002
 lda #$70
 sta $D01E
 sta $D002
 lda #$90
 sta $D002
 lda #$00
 lda #$B0
 sta $D002
 lda #$00
 sta $D01E

; line=104

c29 lda #$74
 ldx #$74
 ldy #$00
 sta colpm2
 sta colpm3
 sty $d01e
 ldx #$00
punkt_2 equ *-1
 sta $d01e
 cmp byt2

; line=105

 jsr wait24cycle
 lda #$30
 sta $D002
 lda #$70
; sta $D01E
 ldy cyfry+20,x
 sta $D002
 lda #$90
 sta $D002
 lda #$00
 lda #$B0
 sta $D002
 lda #$00
 sty panel_punkt+40*2+2

; line=106

 jsr wait24cycle
 lda #$30
 sta $D002
 lda #$70
; sta $D01E
 ldy cyfry+30,x
 sta $D002
 lda #$90
 sta $D002
 lda #$00
 lda #$B0
 sta $D002
 lda #$00
 sty panel_punkt+40*3+2

; line=107

 jsr wait24cycle
 lda #$30
 sta $D002
 lda #$70
; sta $D01E
 ldy cyfry+40,x
 sta $D002
 lda #$90
 sta $D002
 lda #$00
 lda #$B0
 sta $D002
 lda #$00
 sty panel_punkt+40*4+2

; line=108

 jsr wait24cycle
 lda #$30
 sta $D002
 lda #$70
; sta $D01E
 ldy cyfry+50,x
 sta $D002
 lda #$90
 sta $D002
 lda #$00
 lda #$B0
 sta $D002
 lda #$00
 sty panel_punkt+40*5+2

; line=109

 jsr wait24cycle
 lda #$30
 sta $D002
 lda #$70
; sta $D01E
 ldy cyfry+60,x
 sta $D002
 lda #$90
 sta $D002
 lda #$00
 lda #$B0
 sta $D002
 lda #$00
 sty panel_punkt+40*6+2

; line=110

 jsr wait24cycle
 lda #$30
 sta $D002
 lda #$70
 sta $D01E
 sta $D002
 lda #$90
 sta $D002
 lda #$00
 lda #$B0
 sta $D002
 lda #$00
 sta $D01E

; line=111

 jsr wait24cycle
 lda #$30
 sta $D002
 lda #$70
 sta $D01E
 sta $D002
 lda #$90
 sta $D002
 lda #$00
 lda #$B0
 sta $D002
 lda #$00
 sta $D01E

; line=112

c31 lda #$0A
 ldx #$0A
 ldy #$00
 sta colpm2
 sta colpm3
 sty $d01e
 ldx #$00
punkt_3 equ *-1
 sta $d01e
 cmp byt2

; line=113

 jsr wait24cycle
 lda #$30
 sta $D002
 lda #$70
; sta $D01E
 ldy cyfry+20,x
 sta $D002
 lda #$90
 sta $D002
 lda #$00
 lda #$B0
 sta $D002
 lda #$00
 sty panel_punkt+40*2+3

; line=114

 jsr wait24cycle
 lda #$30
 sta $D002
 lda #$70
; sta $D01E
 ldy cyfry+30,x
 sta $D002
 lda #$90
 sta $D002
 lda #$00
 lda #$B0
 sta $D002
 lda #$00
 sty panel_punkt+40*3+3

; line=115

 jsr wait24cycle
 lda #$30
 sta $D002
 lda #$70
; sta $D01E
 ldy cyfry+40,x
 sta $D002
 lda #$90
 sta $D002
 lda #$00
 lda #$B0
 sta $D002
 lda #$00
 sty panel_punkt+40*4+3

; line=116

 jsr wait24cycle
 lda #$30
 sta $D002
 lda #$70
; sta $D01E
 ldy cyfry+50,x
 sta $D002
 lda #$90
 sta $D002
 lda #$00
 lda #$B0
 sta $D002
 lda #$00
 sty panel_punkt+40*5+3

; line=117

 jsr wait24cycle
 lda #$30
 sta $D002
 lda #$70
; sta $D01E
 ldy cyfry+60,x
 sta $D002
 lda #$90
 sta $D002
 lda #$00
 lda #$B0
 sta $D002
 lda #$00
 sty panel_punkt+40*6+3

; line=118

 jsr wait24cycle
 lda #$30
 sta $D002
 lda #$70
 sta $D01E
 sta $D002
 lda #$90
 sta $D002
 lda #$00
 lda #$B0
 sta $D002
 lda #$00
 sta $D01E

; line=119

 jsr wait24cycle
 lda #$30
 sta $D002
 lda #$70
 sta $D01E
 sta $D002
 lda #$90
 sta $D002
 lda #$00
 lda #$B0
 sta $D002
 lda #$00
 sta $D01E

; line=120

c33 lda #$74
 ldx #$74
 ldy #$00
 sta colpm2
 sta colpm3
 sty $d01e
 ldx #$00
punkt_4 equ *-1
 sta $d01e
 cmp byt2

; line=121

 jsr wait24cycle
 lda #$30
 sta $D002
 lda #$70
; sta $D01E
 ldy cyfry+20,x
 sta $D002
 lda #$90
 sta $D002
 lda #$00
 lda #$B0
 sta $D002
 lda #$00
 sty panel_punkt+40*2+4

; line=122

 jsr wait24cycle
 lda #$30
 sta $D002
 lda #$70
; sta $D01E
 ldy cyfry+30,x
 sta $D002
 lda #$90
 sta $D002
 lda #$00
 lda #$B0
 sta $D002
 lda #$00
 sty panel_punkt+40*3+4

; line=123

 jsr wait24cycle
 lda #$30
 sta $D002
 lda #$70
; sta $D01E
 ldy cyfry+40,x
 sta $D002
 lda #$90
 sta $D002
 lda #$00
 lda #$B0
 sta $D002
 lda #$00
 sty panel_punkt+40*4+4

; line=124

 jsr wait24cycle
 lda #$30
 sta $D002
 lda #$70
; sta $D01E
 ldy cyfry+50,x
 sta $D002
 lda #$90
 sta $D002
 lda #$00
 lda #$B0
 sta $D002
 lda #$00
 sty panel_punkt+40*5+4

; line=125

 jsr wait24cycle
 lda #$30
 sta $D002
 lda #$70
; sta $D01E
 ldy cyfry+60,x
 sta $D002
 lda #$90
 sta $D002
 lda #$00
 lda #$B0
 sta $D002
 lda #$00
 sty panel_punkt+40*6+4

; line=126

 jsr wait24cycle
 lda #$30
 sta $D002
 lda #$70
 sta $D01E
 sta $D002
 lda #$90
 sta $D002
 lda #$00
 lda #$B0
 sta $D002
 lda #$00
 sta $D01E

; line=127

 jsr wait24cycle
 lda #$30
 sta $D002
 lda #$70
 sta $D01E
 sta $D002
 lda #$90
 sta $D002
 lda #$00
 lda #$B0
 sta $D002
nap_p1x lda #$00
nap_p1r sta $D01E

; line=128

f1 lda >fnt		// tutaj przywracamy wlasciwy zestaw
nap_gti2 ldx #$22
c35 ldy #$0A
 sta chbase
 stx gtictl
 sty colpm2
 lda #$0A
 sty colpm3
 cmp byt2

; line=129

; jsr wait24cycle

nap_col0 lda #0
 sta colpm0
nap_col1 lda #0
 sta colpm1
 lda #$00
 sta $d01e
 lda #$00
 sta $d01e

 lda #$30
 sta $D002
 lda #$70
 sta $D01E
 sta $D002
 lda #$90
 sta $D002
 ldx #$00
punkt_5 equ *-1
 lda #$B0
 sta $D002
 lda #$00
 sta $D01E

; line=130

 jsr wait24cycle
 lda #$30
 sta $D002
 lda #$70
; sta $D01E
 ldy cyfry+20,x
 sta $D002
 lda #$90
 sta $D002
 lda #$00
 lda #$B0
 sta $D002
 lda #$00
 sty panel_punkt+40*2+5

; line=131

 jsr wait24cycle
 lda #$30
 sta $D002
 lda #$70
; sta $D01E
 ldy cyfry+30,x
 sta $D002
 lda #$90
 sta $D002
 lda #$00
 lda #$B0
 sta $D002
 lda #$00
 sty panel_punkt+40*3+5

; line=132

 jsr wait24cycle
 lda #$30
 sta $D002
 lda #$70
; sta $D01E
 ldy cyfry+40,x
 sta $D002
 lda #$90
 sta $D002
 lda #$00
 lda #$B0
 sta $D002
 lda #$00
 sty panel_punkt+40*4+5

; line=133

 jsr wait24cycle
 lda #$30
 sta $D002
 lda #$70
; sta $D01E
 ldy cyfry+50,x
 sta $D002
 lda #$90
 sta $D002
 lda #$00
 lda #$B0
 sta $D002
 lda #$00
 sty panel_punkt+40*5+5

; line=134

 jsr wait24cycle
 lda #$30
 sta $D002
 lda #$70
; sta $D01E
 ldy cyfry+60,x
 sta $D002
 lda #$90
 sta $D002
 lda #$00
 lda #$B0
 sta $D002
 lda #$00
 sty panel_punkt+40*6+5

; line=135

 jsr wait24cycle
 lda #$30
 sta $D002
 lda #$70
 sta $D01E
 sta $D002
 lda #$90
 sta $D002
 lda #$00
 lda #$B0
 sta $D002
 lda #$00
 sta $D01E

; line=136

c37 lda #$74
 ldx #$74
 ldy #$00
 sta colpm2
 sta colpm3
 sty $d01e
 lda #$00
 sta $d01e
 cmp byt2

; line=137

 jsr wait24cycle
 lda #$30
 sta $D002
 lda #$70
 sta $D01E
 sta $D002
 lda #$90
 sta $D002
 lda #$00
 lda #$B0
 sta $D002
 lda #$00
 sta $D01E

; line=138

 jsr wait24cycle
 lda #$30
 sta $D002
 lda #$70
 sta $D01E
 sta $D002
 lda #$90
 sta $D002
 lda #$00
 lda #$B0
 sta $D002
 lda #$00
 sta $D01E

; line=139

 jsr wait24cycle
 lda #$30
 sta $D002
 lda #$70
 sta $D01E
 sta $D002
 lda #$90
 sta $D002
 lda #$00
 lda #$B0
 sta $D002
 lda #$00
 sta $D01E

; line=140

 jsr wait24cycle
 lda #$30
 sta $D002
 lda #$70
 sta $D01E
 sta $D002
 lda #$90
 sta $D002
 lda #$00
 lda #$B0
 sta $D002
 lda #$00
 sta $D01E

; line=141

 jsr wait24cycle
 lda #$30
 sta $D002
 lda #$70
 sta $D01E
 sta $D002
 lda #$90
 sta $D002
 lda #$00
 lda #$B0
 sta $D002
 lda #$00
 sta $D01E

; line=142

 jsr wait24cycle
 lda #$30
 sta $D002
 lda #$70
 sta $D01E
 sta $D002
 lda #$90
 sta $D002
 lda #$00
 lda #$B0
 sta $D002
 lda #$00
 sta $D01E

; line=143

 jsr wait24cycle
 lda #$30
 sta $D002
 lda #$70
 sta $D01E
 sta $D002
 lda #$90
 sta $D002
 lda #$00
 lda #$B0
 sta $D002
 lda #$00
 sta $D01E

; line=144

c39 lda #$0A
 ldx #$0A
 ldy #$22
 sta colpm2
 sta colpm3
 sty gtictl
 lda #$00
 sta $d01e
 cmp byt2

; line=145

 jsr wait24cycle
 lda #$30
 sta $D002
 lda #$70
 sta $D01E
 sta $D002
 lda #$90
 sta $D002
 lda #$00
 lda #$B0
 sta $D002
 lda #$00
 sta $D01E

; line=146

 jsr wait24cycle
 lda #$30
 sta $D002
 lda #$70
 sta $D01E
 sta $D002
 lda #$90
 sta $D002
 lda #$00
 lda #$B0
 sta $D002
 lda #$00
 sta $D01E

; line=147

 jsr wait24cycle
 lda #$30
 sta $D002
 lda #$70
 sta $D01E
 sta $D002
 lda #$90
 sta $D002
 lda #$00
 lda #$B0
 sta $D002
 lda #$00
 sta $D01E

; line=148

 jsr wait24cycle
 lda #$30
 sta $D002
 lda #$70
 sta $D01E
 sta $D002
 lda #$90
 sta $D002
 lda #$00
 lda #$B0
 sta $D002
 lda #$00
 sta $D01E

; line=149

 jsr wait24cycle
 lda #$30
 sta $D002
 lda #$70
 sta $D01E
 sta $D002
 lda #$90
 sta $D002
 lda #$00
 lda #$B0
 sta $D002
 lda #$00
 sta $D01E

; line=150

 jsr wait24cycle
 lda #$30
 sta $D002
 lda #$70
 sta $D01E
 sta $D002
 lda #$90
 sta $D002
 lda #$00
 lda #$B0
 sta $D002
 lda #$00
 sta $D01E

; line=151

 jsr wait24cycle
 lda #$30
 sta $D002
 lda #$70
 sta $D01E
 sta $D002
 lda #$90
 sta $D002
 lda #$00
 lda #$B0
 sta $D002
 lda #$00
 sta $D01E

; line=152

c41 lda #$74
 ldx #$74
 ldy #$00
 sta colpm2
 sta colpm3
 sty $d01e
 lda #$00
 sta $d01e
 cmp byt2

; line=153

 jsr wait24cycle
 lda #$30
 sta $D002
 lda #$70
 sta $D01E
 sta $D002
 lda #$90
 sta $D002
 lda #$00
 lda #$B0
 sta $D002
 lda #$00
 sta $D01E

; line=154

 jsr wait24cycle
 lda #$30
 sta $D002
 lda #$70
 sta $D01E
 sta $D002
 lda #$90
 sta $D002
 lda #$00
 lda #$B0
 sta $D002
 lda #$00
 sta $D01E

; line=155

 jsr wait24cycle
 lda #$30
 sta $D002
 lda #$70
 sta $D01E
 sta $D002
 lda #$90
 sta $D002
 lda #$00
 lda #$B0
 sta $D002
 lda #$00
 sta $D01E

; line=156

 jsr wait24cycle
 lda #$30
 sta $D002
 lda #$70
 sta $D01E
 sta $D002
 lda #$90
 sta $D002
 lda #$00
 lda #$B0
 sta $D002
 lda #$00
 sta $D01E

; line=157

 jsr wait24cycle
 lda #$30
 sta $D002
 lda #$70
 sta $D01E
 sta $D002
 lda #$90
 sta $D002
 lda #$00
 lda #$B0
 sta $D002
 lda #$00
 sta $D01E

; line=158

 jsr wait24cycle
 lda #$30
 sta $D002
 lda #$70
 sta $D01E
 sta $D002
 lda #$90
 sta $D002
 lda #$00
 lda #$B0
 sta $D002
 lda #$00
 sta $D01E

; line=159

 jsr wait24cycle
 lda #$30
 sta $D002
 lda #$70
 sta $D01E
 sta $D002
 lda #$90
 sta $D002
 lda #$00
 lda #$B0
 sta $D002
 lda #$00
 sta $D01E

; line=160

c43 lda #$0A
 ldx #$0A
 ldy #$00
 sta colpm2
 sta colpm3
 sty $d01e
 lda #$00
 sta $d01e
 cmp byt2

; line=161

 jsr wait24cycle
 lda #$30
 sta $D002
 lda #$70
 sta $D01E
 sta $D002
 lda #$90
 sta $D002
 lda #$00
 lda #$B0
 sta $D002
 lda #$00
 sta $D01E

; line=162

 jsr wait24cycle
 lda #$30
 sta $D002
 lda #$70
 sta $D01E
 sta $D002
 lda #$90
 sta $D002
 lda #$00
 lda #$B0
 sta $D002
 lda #$00
 sta $D01E

; line=163

 jsr wait24cycle
 lda #$30
 sta $D002
 lda #$70
 sta $D01E
 sta $D002
 lda #$90
 sta $D002
 lda #$00
 lda #$B0
 sta $D002
 lda #$00
 sta $D01E

; line=164

 jsr wait24cycle
 lda #$30
 sta $D002
 lda #$70
 sta $D01E
 sta $D002
 lda #$90
 sta $D002
 lda #$00
 lda #$B0
 sta $D002
 lda #$00
 sta $D01E

; line=165

 jsr wait24cycle
 lda #$30
 sta $D002
 lda #$70
 sta $D01E
 sta $D002
 lda #$90
 sta $D002
 lda #$00
 lda #$B0
 sta $D002
 lda #$00
 sta $D01E

; line=166

 jsr wait24cycle
 lda #$30
 sta $D002
 lda #$70
 sta $D01E
 sta $D002
 lda #$90
 sta $D002
 lda #$00
 lda #$B0
 sta $D002
 lda #$00
 sta $D01E

; line=167

 jsr wait24cycle
 lda #$30
 sta $D002
 lda #$70
 sta $D01E
 sta $D002
 lda #$90
 sta $D002
 lda #$00
 lda #$B0
 sta $D002
 lda #$00
 sta $D01E

; line=168

c45 lda #$74
 ldx #$74
 ldy #$00
 sta colpm2
 sta colpm3
 sty $d01e
 lda #$00
 sta $d01e
 cmp byt2

; line=169

 jsr wait24cycle
 lda #$30
 sta $D002
 lda #$70
 sta $D01E
 sta $D002
 lda #$90
 sta $D002
 lda #$00
 lda #$B0
 sta $D002
 lda #$00
 sta $D01E

; line=170

 jsr wait24cycle
 lda #$30
 sta $D002
 lda #$70
 sta $D01E
 sta $D002
 lda #$90
 sta $D002
 lda #$00
 lda #$B0
 sta $D002
 lda #$00
 sta $D01E

; line=171

 jsr wait24cycle
 lda #$30
 sta $D002
 lda #$70
 sta $D01E
 sta $D002
 lda #$90
 sta $D002
 lda #$00
 lda #$B0
 sta $D002
 lda #$00
 sta $D01E

; line=172

 jsr wait24cycle
 lda #$30
 sta $D002
 lda #$70
 sta $D01E
 sta $D002
 lda #$90
 sta $D002
 lda #$00
 lda #$B0
 sta $D002
 lda #$00
 sta $D01E

; line=173

 jsr wait24cycle
 lda #$30
 sta $D002
 lda #$70
 sta $D01E
 sta $D002
 lda #$90
 sta $D002
 lda #$00
 lda #$B0
 sta $D002
 lda #$00
 sta $D01E

; line=174

 jsr wait24cycle
 lda #$30
 sta $D002
 lda #$70
 sta $D01E
 sta $D002
 lda #$90
 sta $D002
 lda #$00
 lda #$B0
 sta $D002
 lda #$00
 sta $D01E

; line=175

 jsr wait24cycle
 lda #$30
 sta $D002
 lda #$70
 sta $D01E
 sta $D002
 lda #$90
 sta $D002
 lda #$00
 lda #$B0
 sta $D002
 lda #$00
 sta $D01E

; line=176

_c1 lda #$0a
 sta color1

 inc gate	; od tej linii synchronizuje sie ROBAL

 dli_quit dli2


*---


dli2
_c2 lda #$74
 sta $d40a
 sta color1

 dli_quit dli3


*--- PANEL

dli3

p0 lda #$14
 STA $D40A

 sta color0
 sta colpm1
 sta colpm3
p1 lda #$78
 sta color1
 sta colpm0
_c10 lda #$0C
 sta color2
_c11 lda #$3C
 sta color3

 lda #$1
 sta gtictl

 lda #$00
 sta sizep0
 sta sizep1
 sta sizep2
 sta sizep3
 sta colpm2

 lda #48
 sta hposp2
 sta hposp3

 dli_quit dli_panel


*---

; line=192

dli_panel

 sta $d40a

 inc byt2		; tutaj bitmapa z panelem
 lda #$00
 sta $d01e
 lda #$00
 sta $d01e
 lda #$00
 cmp byt2
 sta colbak
 cmp byt2
 lda #$00
 sta $d01e
 lda #$00
 sta $d01e
_c3 lda #$b4
 inc byt2
 sta $d01e

; line=23

 sta colbak
 lda #$00
 lda #$00
 sta $d01e
 lda #$00
 sta $d01e
 lda #$00
 sta $d01e
 lda #$00
 cmp byt2
 sta colbak
 cmp byt2
 ldx #$0e
 sta $d01e
p2 lda #$78
 sta colpm2
_c4 lda #$b4
 cmp byt2
 stx $d01e

; line=24

 cmp byt2		; zaczynamy mnozyc duchy
 sta colbak
 cmp byt2
 lda #$00
 sta color1
 nop
 lda #$40
 sta $D001
 sta $D000
 lda #$64
 sta $D001
 sta $D000
 lda #$64+52
 sta $D001
 sta $D000
 lda bajt
 sta $D001
 sta $D000
; inc byt2


.rept 7 \ linia \ .endr

 
*- 1
p3 lda #$78
 ldx #$00
 ldy #$00
 sta color1
 stx colpm2
 sty $d01e
 lda #$00
 sta $d01e
 cmp byt2
 sta colbak
 cmp byt2
 sta $d01e
 lda #$00
 sta $d01e
 sta $d01e
_c5 lda #$b4
 sta $d01e
 inc byt2
 sta colbak

*- 2
p4 lda #$78
; ldx #$00
; ldy #$00
 sta color1
 stx $d01e
 sty $d01e
 lda #$00
 sta $d01e
 cmp byt2
 sta colbak
 cmp byt2
 sta $d01e
 lda #$00
 sta $d01e
 sta $d01e
_c6 lda #$b4
 sta $d01e
 inc byt2
 sta colbak

*- 3
p5 lda #$78
; ldx #$00
; ldy #$00
 sta color1
 stx $d01e
 sty $d01e
 lda #$00
 sta $d01e
 cmp byt2
 sta colbak
 cmp byt2
 sta $d01e
 lda #$00
 sta $d01e
 sta $d01e
_c7 lda #$b4
 sta $d01e
 inc byt2
 sta colbak

 :2 sta $d40a

 lda #$00
 sta $d40a
 sta color2

 jmp nmiQ

;--

wait60cycle
 jsr _rts
 cmp byt3
wait44cycle
 inc byt3
 nop
wait36cycle
 jsr _rts
wait24cycle
 jsr _rts
_rts rts

;--


.macro linia
 lda #$00
 ldx #$00
 ldy #$00
 sta color1
 stx $d01e
 sty $d01e
 lda #$40
 sta $D001
 sta $D000
 lda #$64
 sta $D001
 sta $D000
 lda #$64+52
 sta $D001
 sta $D000
 lda bajt
 sta $D001
 sta $D000
; inc byt2
.endm


.macro dli_quit

 .if .hi(?old_dli)==.hi(:1)
   mva <:1 vdli+1
 .else
   mwa #:1 vdli+1
 .endif

  jmp nmiQ

  .def ?old_dli
.endm
