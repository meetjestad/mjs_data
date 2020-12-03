#!/usr/bin/gnuplot -persist
# mjs_pm_068_02d_9422.plt

set style data lines
set grid front
set key left top
set key font ", 18"
set terminal png size 1920,480 transparent
set output "mjs_pm_068_02d_9422.png"
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
set boxwidth 60
set style fill transparent solid 0.10 noborder


plot \
   "< cat mjs_pm_068_02d_9422.lst" using 1:($2)  title 'temperature'  w lp lw 2 lc rgbcolor '#FF0000' pt 3, \
   "< cat mjs_pm_068_02d_9422.lst" using 1:($3)  title 'humidity'     w lp lw 2 lc rgbcolor '#0000FF' pt 3, \
   "< cat mjs_pm_068_02d_9422.lst" using 1:($5)  title 'pm2.5'        w lp lw 2 lc rgbcolor '#4F4F4F' pt 3, \
   "< cat mjs_pm_068_02d_9422.lst" using 1:($6)  title 'NO2'          w lp lw 3 lc rgbcolor '#BFBFBF' pt 3
