#!/usr/bin/gnuplot -persist
# mjs_mjs20_2039_pm_04d.plt

set style data lines
set grid front
set key left top
set key font ", 18"
set key opaque
set terminal png size 1920,480 transparent
set output "../png/mjs_mjs20_2039_pm_04d.png"
set xdata time
set timefmt "%Y-%m-%d.%H:%M:%S"
set format x "%H\n%d"
set autoscale xfix
set xtics 14400
set mxtics 4
set xtics font ", 18"
set ytics  font ", 18" textcolor rgb "#000000" 
set y2tics font ", 18" textcolor rgb "#000000" 
set grid xtics ytics
set boxwidth 60
set style fill transparent solid 0.10 noborder


plot \
   "< cat ../lst/mjs_mjs20_2039_pm_04d.lst"  using 1:($6-$5)/10  title '< pm10. only >'  lt 1  lw 5  lc rgbcolor '#BFBFBF', \
   "< cat ../lst/mjs_mjs20_2039_pm_04d.lst"  using 1:($5-$4)/10  title '< pm4.0 only >'  lt 1  lw 4  lc rgbcolor '#9F9F9F', \
   "< cat ../lst/mjs_mjs20_2039_pm_04d.lst"  using 1:($4-$3)/10  title '< pm2.5 only >'  lt 1  lw 3  lc rgbcolor '#7F7F7F', \
   "< cat ../lst/mjs_mjs20_2039_pm_04d.lst"  using 1:($3/10)     title '< pm1.0 only >'  lt 1  lw 2  lc rgbcolor '#1F1F1F'

