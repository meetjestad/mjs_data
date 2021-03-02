#!/usr/bin/gnuplot -persist
# mjs_pm_vw_0567_12h.plt

set style data lines
set grid front
set key left top
set key font ",16"
set terminal pngcairo size 1920,480 transparent
set output "../png/mjs_pm_vw_0567_12h.png"
set xdata time
set timefmt "%Y-%m-%d.%H:%M:%S"
set format x "%H\n%d"
set autoscale xfix
set xtics 3600
set mxtics 4
set xtics  font ", 18"
set ytics  nomirror
set y2tics nomirror
set ytics  font ", 18" textcolor rgbcolor "#FF7F00" 
set y2tics font ", 18" textcolor rgbcolor "#000000" 
set grid xtics ytics
set pointsize 0.1
set boxwidth 120
set style fill transparent solid 0.10 noborder


plot \
   "< cat ../lst/mjs_pm_vw_0567_2020_ckd_12h.lst"  using 1:($3)  title '<  567 PM2.5 19-20 >'  axis x1y2  w lp  lw 3   lc rgbcolor '#FF7F00'  dt 1  pt 3, \
   "< cat ../lst/mjs_pm_vw_2002_2021_ckd_12h.lst"  using 1:($3)  title '< 2002 PM2.5 20-21 >'  axis x1y2  w lp  lw 3   lc rgbcolor '#007F00'  dt 1  pt 3
