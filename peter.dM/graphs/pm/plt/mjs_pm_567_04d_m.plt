#!/usr/bin/gnuplot -persist
# mjs_pm_567_04d_m.plt

set style data lines
set grid front
set key left center
set key font ", 10"
set key opaque
set terminal png size 960,240 transparent
set output "mjs_pm_567_04d_m.png"
set xdata time
set timefmt "%Y-%m-%d.%H:%M:%S"
set format x "%d\n%Hh"
set autoscale xfix
set xtics 14400
set mxtics 4
set xtics font ", 10"
set ytics nomirror
set y2tics nomirror
set ytics font ", 10" textcolor rgb "red" 
set y2tics font ", 10" textcolor rgb "blue" 
set grid xtics ytics
set boxwidth 60
set style fill transparent solid 0.10 noborder


plot \
   "< cat mjs_pm_567_04d_m.lst"  using 1:($2)  title '< temperature   '  axis x1y1  lt 1  lw 2  lc rgbcolor '#FF0000', \
   "< cat mjs_pm_567_04d_m.lst"  using 1:($3)  title '     humidity >'   axis x1y2  lt 2  lw 2  lc rgbcolor '#0000FF', \
   "< cat mjs_pm_567_04d_m.lst"  using 1:($5)  title '        pm2.5 >'   axis x1y2  lt 3  lw 2  dashtype 1  lc rgbcolor '#7F7F7F', \
   "< cat mjs_pm_567_04d_m.lst"  using 1:($6)  title '   pm10-pm2.5 >'   axis x1y2  lt 6  lw 3  dashtype 2  lc rgbcolor '#7F7F7F'
