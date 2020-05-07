
 icl '..\packed.hea'

 .get [fntCon]	'grat_OK.fnt'

 .get [scrCon]	'grat_OK.scr'

 .get [pmgCon+$300]	'congrat_pmg.obx'

 .sav [$d800] 'packed_grat.dat',(pmgCon+$800)-$d800
