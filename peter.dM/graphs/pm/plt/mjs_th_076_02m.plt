#!/usr/bin/gnuplot -persist
# mjs_th_076_02m.plt

set style data lines
set grid front
set key left top
set key font ", 18"
set terminal png size 1920,480 transparent
set output "mjs_th_076_02m.png"
set xdata time
set timefmt "%Y-%m-%d.%H:%M:%S"
set format x "    %m\n    %d"
set autoscale xfix
set xtics 604800
set mxtics 7
set xtics font ", 18"
set ytics font ", 18"
set grid xtics ytics
set pointsize 0.1
set boxwidth 60
set style fill transparent solid 0.10 noborder


plot \
   "< cat mjs_th_076_02m.lst" using 1:($2)  title 'temperature'  w lp lw 2 lc rgbcolor '#FF0000' pt 3, \
   "< cat mjs_th_076_02m.lst" using 1:($3)  title 'humidity'     w lp lw 2 lc rgbcolor '#0000FF' pt 3
