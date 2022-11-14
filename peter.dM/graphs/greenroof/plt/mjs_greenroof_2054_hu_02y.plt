#!/usr/bin/gnuplot -persist
# mjs_greenroof_2054_hu_02y.plt

set style data lines
set grid front
set key left top
set key font ",16"
set terminal pngcairo size 1920,480 transparent
set output "../png/mjs_greenroof_2054_hu_02y.png"
set xdata time
set timefmt "%Y-%m-%d.%H:%M:%S"
set format x "       %b\n     %y"
set autoscale xfix
set xtics 2592000
set mxtics 4
set xtics  font ", 18"
set ytics  nomirror
set y2tics nomirror
set ytics  font ", 18" textcolor rgbcolor "#0000FF" 
set y2tics font ", 18" textcolor rgbcolor "#007F00" 
set grid xtics ytics
set pointsize 0.1
set boxwidth 120
set style fill transparent solid 0.10 noborder


plot \
   "< cat ../../knmi/lst/knmi_thdrs_02y.lst"      using 1:($6)  title '<  7-day rainfall (KNMI) '  axis x1y1  w lp  lw  3  lc rgbcolor '#0000FF'        pt 3, \
   "< cat ../lst/mjs_greenroof_2054_ca_02y.lst"   using 1:($4)  title '        roof humidity % >'  axis x1y2  w lp  lw 2   lc rgbcolor '#007F00'  dt 1  pt 7 ps 0.5

