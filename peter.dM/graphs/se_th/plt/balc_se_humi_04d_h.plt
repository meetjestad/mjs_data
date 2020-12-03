#!/usr/bin/gnuplot -persist
# balc_se_humi_04d_h.plt

set style data lines
set grid front
set key left bottom
set key font ",16"
set terminal pngcairo size 1920,960 transparent
set output "balc_se_humi_04d_h.png"
set xdata time
set timefmt "%Y-%m-%d.%H:%M:%S"
set format x "%d\n%H"
set autoscale xfix
set xtics 14400
set mxtics 4
set xtics font ", 18"
set ytics font ", 18"
set grid xtics ytics
set pointsize 0.1
set boxwidth 120
set style fill transparent solid 0.10 noborder


plot \
   "< cat balc_se_humi_04d_h.lst" using 1:($11) title 'KNMI'      w lp lw 12 lc rgbcolor '#0000FF' pt 3, \
   "< cat balc_se_humi_04d_h.lst" using 1:($2)  title 'dht11'     w lp lw 2 lc rgbcolor '#FF0000' dt 1 pt 3, \
   "< cat balc_se_humi_04d_h.lst" using 1:($4)  title 'dht22'     w lp lw 2 lc rgbcolor '#00FF00' dt 1 pt 3, \
   "< cat balc_se_humi_04d_h.lst" using 1:($5)  title 'am2320'    w lp lw 2 lc rgbcolor '#007F7F' dt 1 pt 3, \
   "< cat balc_se_humi_04d_h.lst" using 1:($6)  title 'bme280'    w lp lw 2 lc rgbcolor '#0000FF' dt 1 pt 3, \
   "< cat balc_se_humi_04d_h.lst" using 1:($7)  title 'si7021:0'  w lp lw 2 lc rgbcolor '#7F007F' dt 1 pt 3, \
   "< cat balc_se_humi_04d_h.lst" using 1:($8)  title 'si7021:1'  w lp lw 2 lc rgbcolor '#7F007F' dt 1 pt 3, \
   "< cat balc_se_humi_04d_h.lst" using 1:($9)  title 'si7021:2'  w lp lw 2 lc rgbcolor '#7F007F' dt 1 pt 3, \
   "< cat balc_se_humi_04d_h.lst" using 1:($10) title 'si7021:3'  w lp lw 2 lc rgbcolor '#7F007F' dt 1 pt 3



#  "< cat balc_se_humi_04d_h.lst" using 1:($3)  title 'dht21'     w lp lw 2 lc rgbcolor '#7F7F00' dt 1 pt 3, \
