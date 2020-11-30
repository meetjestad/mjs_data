#!/usr/bin/gnuplot -persist
# mjs_pm_176_01d.plt

set style data lines
set grid front
set key left top
set key font ", 18"
set terminal png size 1920,480 transparent
set output "mjs_pm_176_01d.png"
set xdata time
set timefmt "%Y-%m-%d.%H:%M:%S"
set format x "%d\n%H"
set autoscale xfix
set xtics 3600
set mxtics 4
set xtics font ", 18"
set ytics font ", 18"
set grid xtics ytics
set pointsize 0.1
set boxwidth 60
set style fill transparent solid 0.10 noborder


# w lp lw 2 lc rgbcolor '#FF0000' pt 3

plot \
   "< cat mjs_pm_176_01d.lst" using 1:($3) title 'temp 068'  w lp lw 2 lc rgbcolor '#FF0000' pt 3, \
   "< cat mjs_pm_176_01d.lst" using 1:($4) title 'humi 068'  w lp lw 2 lc rgbcolor '#0000FF' pt 3, \
   "< cat mjs_pm_176_01d.lst" using 1:($5) title 'pm2.5 068'  w lp lw 2 lc rgbcolor '#9F9F9F' pt 3, \
   "< cat mjs_pm_176_01d.lst" using 1:($6) title 'pm10 068'  w lp lw 2 lc rgbcolor '#5F5F5F' pt 3, \
   "< cat mjs_pm_176_01d.lst" using 1:($7) title 'temp 176'  w lp lw 2 lc rgbcolor '#EF0000' pt 3, \
   "< cat mjs_pm_176_01d.lst" using 1:($8) title 'humi 176'  w lp lw 2 lc rgbcolor '#0000EF' pt 3
