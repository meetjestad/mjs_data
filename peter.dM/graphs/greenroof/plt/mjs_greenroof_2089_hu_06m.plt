#!/usr/bin/gnuplot -persist
# mjs_greenroof_2089_hu_06m.plt

set style data lines
set grid front
set key left top
set key font ",16"
set terminal pngcairo size 1920,480 transparent
set output "../png/mjs_greenroof_2089_hu_06m.png"
set xdata time
set timefmt "%Y-%m-%d.%H:%M:%S"
set format x "     %d\n       %b"
set autoscale xfix
set xtics 604800
set mxtics 7
set xtics  font ", 18"
set ytics  nomirror
set y2tics nomirror
set ytics  font ", 18" textcolor rgbcolor "#7F7F7F" 
set y2tics font ", 18" textcolor rgbcolor "#007F00" 
set grid xtics ytics
set pointsize 0.1
set boxwidth 120
set style fill transparent solid 0.10 noborder


plot \
   "< cat ../../knmi/lst/knmi_thdrsR_260_06m.lst"  using 1:($6)  title '<  7-day rainfall (KNMI) '  axis x1y1  w lp  lw 12  lc rgbcolor '#BFBFBF'        pt 3, \
   "< cat ../lst/mjs_greenroof_2089_ca_06m.lst"    using 1:($4)  title '        roof humidity % >'  axis x1y2  w lp  lw 2   lc rgbcolor '#007F00'  dt 1  pt 7 ps 0.5

