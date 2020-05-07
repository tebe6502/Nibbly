
// konwersja plikow SCR na poszczegolne levele
 
murek	= 1

src	= $0000
dst	= $1000

len	= 3*9	// dlugosc danych dla jednego levelu
lvls	= 100	// liczba leveli

 opt l-

 ?ofs = 0
 
 cnv 'n01.scr'
 cnv 'n02.scr'
 cnv 'n03.scr'
 cnv 'n04.scr'
 cnv 'n05.scr'
 cnv 'n06.scr'
 cnv 'n07.scr'
 cnv 'n08.scr'
 cnv 'n09.scr'
 cnv 'n10.scr'
 cnv 'n11.scr'
 cnv 'n12.scr'
 cnv 'n13.scr'
 cnv 'n14.scr'
 cnv 'n15.scr'
 cnv 'n16.scr'
 cnv 'n17.scr'
 cnv 'n18.scr'
 cnv 'n19.scr'
 cnv 'n20.scr'
 cnv 'n21.scr'
 cnv 'n22.scr'
 cnv 'n23.scr'
 cnv 'n24.scr'
 cnv 'n25.scr'
 cnv 'n26.scr'
 cnv 'n27.scr'
 cnv 'n28.scr'
 cnv 'n29.scr'
 cnv 'n30.scr'
 cnv 'n31.scr'
 cnv 'n32.scr'
 cnv 'n33.scr'
 cnv 'n34.scr'
 cnv 'n35.scr'
 cnv 'n36.scr'
 cnv 'n37.scr'
 cnv 'n38.scr'
 cnv 'n39.scr'
 cnv 'n40.scr'
 cnv 'n41.scr'
 cnv 'n42.scr'
 cnv 'n43.scr'
 cnv 'n44.scr'
 cnv 'n45.scr'
 cnv 'n46.scr'
 cnv 'n47.scr'
 cnv 'n48.scr'
 cnv 'n49.scr'
 cnv 'n50.scr'
 cnv 'n51.scr'
 cnv 'n52.scr'
 cnv 'n53.scr'
 cnv 'n54.scr'
 cnv 'n55.scr'
 cnv 'n56.scr'
 cnv 'n57.scr'
 cnv 'n58.scr'
 cnv 'n59.scr'
 cnv 'n60.scr'
 cnv 'n61.scr'
 cnv 'n62.scr'
 cnv 'n63.scr'
 cnv 'n64.scr'
 cnv 'n65.scr'
 cnv 'n66.scr'
 cnv 'n67.scr'
 cnv 'n68.scr'
 cnv 'n69.scr'
 cnv 'n70.scr'
 cnv 'n71.scr'
 cnv 'n72.scr'
 cnv 'n73.scr'
 cnv 'n74.scr'
 cnv 'n75.scr'
 cnv 'n76.scr'
 cnv 'n77.scr'
 cnv 'n78.scr'
 cnv 'n79.scr'
 cnv 'n80.scr'
 cnv 'n81.scr'
 cnv 'n82.scr'
 cnv 'n83.scr'
 cnv 'n84.scr'
 cnv 'n85.scr'
 cnv 'n86.scr'
 cnv 'n87.scr'
 cnv 'n88.scr'
 cnv 'n89.scr'
 cnv 'n90.scr'
 cnv 'n91.scr'
 cnv 'n92.scr'
 cnv 'n93.scr'
 cnv 'n94.scr'
 cnv 'n95.scr'
 cnv 'n96.scr'
 cnv 'n97.scr'
 cnv 'n98.scr'
 cnv 'n99.scr'
 cnv 'n00.scr'
 
 .sav [dst] 'levels.dat',len*lvls


 opt l-

.macro cnv
 .get [src] :1,80,18*40
 
 ?y = 0
 .rept 9
 
 ?x=2
 tbyte
 .put [dst+?ofs+0] = ^?b 
 .put [dst+?ofs+1] = >?b 
 .put [dst+?ofs+2] = <?b 
 
 ?ofs += 3
 
 ?y += 2
 .endr
 
 

.endm


.macro tbyte
 ?b=0
 ?bit=$800000
 
 .rept 18

 ift .get[src+?x+.r*2+?y*40+1] = murek
  ?b=?b+?bit  
 eif

 ?bit=?bit >> 1
 .endr
 
.endm