
* dane dla ekranu tyttulowego

 icl '..\packed.hea'

 .get [fntTit]	'title_ok_3.fnt'

 .get [logo1]	'logomax1.dat'
 .get [logo2]	'logomax2.dat'

 ?tmp = litery

 .get [?tmp]	'title_ok_3_litery.scr',0,32
 .put [?tmp+32] = 13, 13						; preparujemy dodatkowy znak '.'

 .get [?tmp+34]	'title_ok_3_litery.scr',32,32
 .put [?tmp+34+32] = 30, 31						; preparujemy dodatkowy znak '.'

 .get [scrTit]	'title_OK_3.scr'

 :15*32	.put[scrTit+#] = .get[$f000+#]&$7f

 :64	.put[scrTit+15*32+#] = 13		// SYMBOLU EXTERNAL nie mozna przypisac do .PUT
						// wiec musimy zrobic to "z lapki" :)

 .sav [$d800] 'packed_data.dat',(scrTit+$400)-$d800	// zgrywamy pamiec $d800..
