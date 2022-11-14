#!/usr/bin/gnuplot -persist
# mjs_pm_0719_04d.plt

set style data lines
set grid front
set key left top
set key font ", 18"
set terminal png size 1920,480 transparent
set output "../png/mjs_pm_0719_04d.png"
set xdata time
set timefmt "%Y-%m-%d.%H:%M:%S"
set format x "%H\n%d"
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
   "< cat ../lst/mjs_pm_0719_cal_04d.lst" using 1:($3)  title 'pm2.5'        w lp lw 2 lc rgbcolor '#7F7F7F' pt 3, \
   "< cat ../lst/mjs_pm_0719_cal_04d.lst" using 1:($4)  title 'pm10'         w lp lw 3 lc rgbcolor '#7F7F7F' pt 3, \

