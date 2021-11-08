#!/usr/bin/gnuplot -persist
# balc_7021_humi_01d_h.plt

set style data lines
set grid front
set key left bottom
set key font ",16"
set terminal pngcairo size 1920,960 transparent
set output "../png/balc_7021_humi_01d_h.png"
set xdata time
set timefmt "%Y-%m-%d.%H:%M:%S"
set format x "%H\n%d"
set autoscale xfix
set xtics 3600
set mxtics 2
set xtics font ", 18"
set ytics font ", 18"
set grid xtics ytics
set pointsize 0.1
set boxwidth 120
set style fill transparent solid 0.10 noborder


plot \
   "< cat ../../knmi/lst/knmi_thdrsT_01d.lst" using 1:($4)  title 'KNMI humidity'  w lp lw 12 lc rgbcolor '#0000FF' pt 3,  \
   "< cat ../lst/balc_7021_humi_01d_h.lst" using 1:($2)  title 'sensor 1'     w lp lw 2  lc rgbcolor '#A22A2A' dt 1 pt 3, \
   "< cat ../lst/balc_7021_humi_01d_h.lst" using 1:($3)  title 'sensor 2'     w lp lw 2  lc rgbcolor '#FF0000' dt 1 pt 3, \
   "< cat ../lst/balc_7021_humi_01d_h.lst" using 1:($4)  title 'sensor 3'     w lp lw 2  lc rgbcolor '#FFA500' dt 1 pt 3, \
   "< cat ../lst/balc_7021_humi_01d_h.lst" using 1:($5)  title 'sensor 4'     w lp lw 2  lc rgbcolor '#FFFF00' dt 1 pt 3, \
   "< cat ../lst/balc_7021_humi_01d_h.lst" using 1:($6)  title 'sensor 5'     w lp lw 2  lc rgbcolor '#007F00' dt 1 pt 3, \
   "< cat ../lst/balc_7021_humi_01d_h.lst" using 1:($7)  title 'sensor 6'     w lp lw 2  lc rgbcolor '#0000FF' dt 1 pt 3

