#!/usr/bin/gnuplot -persist
# mjs_pm_487_02w.plt

set style data lines
set grid front
set key left top
set key font ", 18"
set terminal png size 1920,480 transparent
set output "mjs_pm_487_02w.png"
set xdata time
set timefmt "%Y-%m-%d.%H:%M:%S"
set format x "    %m\n    %d"
set autoscale xfix
set xtics 86400
set mxtics 6
set xtics font ", 18"
set ytics font ", 18"
set grid xtics ytics
set pointsize 0.1
set boxwidth 60
set style fill transparent solid 0.10 noborder


plot \
   "< cat mjs_pm_487_02w.lst" using 1:($2)  title 'temperature'  w lp lw 2 lc rgbcolor '#FF0000' pt 3, \
   "< cat mjs_pm_487_02w.lst" using 1:($3)  title 'humidity'     w lp lw 2 lc rgbcolor '#0000FF' pt 3, \
   "< cat mjs_pm_487_02w.lst" using 1:($5)  title 'pm2.5'        w lp lw 2 lc rgbcolor '#7F7F7F' pt 3, \
   "< cat mjs_pm_487_02w.lst" using 1:($6)  title 'pm10-pm2.5'   w lp lw 3 lc rgbcolor '#7F7F7F' pt 3
