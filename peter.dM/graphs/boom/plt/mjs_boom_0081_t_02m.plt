#!/usr/bin/gnuplot -persist
# mjs_boom_0081_t_02m.plt

set style data lines
set grid front
set key left top
set key font ",16"
set terminal pngcairo size 1920,480 transparent
set output "../png/mjs_boom_0081_t_02m.png"
set xdata time
set timefmt "%Y-%m-%d.%H:%M:%S"
set format x "     %d\n       %b"
set autoscale xfix
set autoscale y
set autoscale y2
set xtics 604800
set mxtics 7
set xtics font ", 18"
set ytics font ", 18"
set ytics nomirror
set y2tics nomirror
set ytics  font ", 18" textcolor rgbcolor "#FF0000" 
set y2tics font ", 18" textcolor rgbcolor "#000000"
set grid xtics ytics
set pointsize 0.1
set boxwidth 120
set style fill transparent solid 0.10 noborder


# First line is dummy to line up KNMI and own timescales with each other:
plot \
   "< cat ../../knmi/lst/knmi_thdrs_02m.lst"  using 1:('?')  title ''                 axis x1y2  w lp  lw 0   lc rgbcolor '#FFFFFF'  dt 1  pt 3, \
   "< cat ../lst/mjs_boom_0081_ca_02m.lst"    using 1:($3)   title '< temperature  '  axis x1y1  w lp  lw 3   lc rgbcolor '#FF0000'  dt 1  pt 3, \
   "< cat ../lst/mjs_boom_0081_ca_02w.lst"    using 1:($5)   title '    diameter  >'  axis x1y2  w lp  lw 3   lc rgbcolor '#000000'  dt 1  pt 3, \

