#!/usr/bin/gnuplot -persist
# mjs_mjs20_0567_pm_04d.plt

set style data lines
set grid front
set key left top
set key font ", 18"
set key opaque
set terminal png size 1920,480 transparent
set output "../png/mjs_mjs20_0567_pm_04d.png"
set xdata time
set timefmt "%Y-%m-%d.%H:%M:%S"
set format x "%H\n%d"
set autoscale xfix
set xtics 14400
set mxtics 4
set xtics font ", 18"
set ytics nomirror
set y2tics nomirror
set ytics font ", 18" textcolor rgbcolor "#7F7F7F"
set y2tics font ", 18" textcolor rgbcolor "#BFBFBF" 
set grid xtics ytics
set boxwidth 60
set style fill transparent solid 0.10 noborder


plot \
   "< cat ../lst/mjs_mjs20_0567_th_04d.lst"  using 1:($5)     title 'pm2.5     '  axis x1y1  lt 1  lw 2  lc rgbcolor '#7F7F7F', \
   "< cat ../lst/mjs_mjs20_0567_th_04d.lst"  using 1:($6-$5)  title 'pm10-pm2.5'  axis x1y2  lt 2  lw 3  lc rgbcolor '#BFBFBF'
