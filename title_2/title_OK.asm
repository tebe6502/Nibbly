logo1 = $e000
logo2 = logo1+1920

 org $1000

;logo1	ins 'logomax1.dat'
;logo2	ins 'logomax2.dat'

 .link 'title_2.obx'

 .link '..\title\title_fade.obx'

 .link 'input_string.obx'


 .print 'End: ',*

 run title_main
