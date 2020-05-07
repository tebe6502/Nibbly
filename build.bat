mads "logo\logo3.asm"	-i:"logo" -i:"macros" -s

mads "msx\sid2pokey.asm"	-i:"msx" -s

mads "title\title_fade.asm"	-i:"title" -s

mads "title_2\input_string.asm"	-i:"title_2" -s
mads "title_2\title_2.asm"	-i:"title_2" -s

mads "congrat\congrat_pmg.asm"	-i:"congrat" -s
mads "congrat\packed_grat.asm"	-i:"congrat" -s
mads "congrat\grat_OK.asm"	-i:"congrat" -s

mads init.asm -s
mads pmg.asm -s

zopfli --deflate all_fnt.dat -c >all_fnt.def
zopfli --deflate pmg.obx -c >pmg.def

zopfli --deflate "msx\nibbly.sid" -c >..\nibbly.def

zopfli --deflate "congrat\packed_grat.dat" -c >..\packed_grat.def
zopfli --deflate "packed_data\packed_data.dat" -c >..\packed_data.def

mads napisy.asm -s

mads nibbly.asm	-i:"macros" -l

pause
