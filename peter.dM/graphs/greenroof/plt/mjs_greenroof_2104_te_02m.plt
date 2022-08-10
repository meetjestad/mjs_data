#!/usr/bin/gnuplot -persist
# mjs_greenroof_2104_te_02m.plt

set style data lines
set grid front
set key left top
set key font ",16"
set terminal pngcairo size 1920,480 transparent
set output "../png/mjs_greenroof_2104_te_02m.png"
set xdata time
set timefmt "%Y-%m-%d.%H:%M:%S"
set format x "     %d\n       %b"
set autoscale xfix
set xtics 604800
set mxtics 4
set xtics  font ", 18"
set ytics  nomirror
set y2tics nomirror
set ytics  font ", 18" textcolor rgbcolor "#FF7F00" 
set y2tics font ", 18" textcolor rgbcolor "#FF0000" 
set grid xtics ytics
set pointsize 0.1
set boxwidth 120
set style fill transparent solid 0.10 noborder


plot \
   "< cat ../../knmi/lst/knmi_thdrsR_260_02m.lst"  using 1:($7)  title '< solar radiation (KNMI) '  axis x1y1  w lp  lw 12  lc rgbcolor '#FFDFBF'        pt 3, \
   "< cat ../lst/mjs_greenroof_2104_ca_02m.lst"    using 1:($3)  title '  ambient temperature C >'  axis x1y2  w lp  lw 4   lc rgbcolor '#FF7F7F'  dt 1  pt 7 ps 0.5, \
   "< cat ../lst/mjs_greenroof_2104_ca_02m.lst"    using 1:($5)  title '     roof temperature C >'  axis x1y2  w lp  lw 2   lc rgbcolor '#FF0000'  dt 1  pt 7 ps 0.5

