#!/usr/bin/gnuplot -persist
# mjs_batt_2001_02w.plt

set style data lines
set grid front
set key left top
set key font ",16"
set terminal pngcairo size 1920,480 transparent
set output "../png/mjs_batt_2001_02w.png"
set xdata time
set timefmt "%Y-%m-%d.%H:%M:%S"
set format x "     %d\n       %b"
set autoscale xfix
set xtics 86400
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
   "< cat ../../knmi/lst/knmi_thdrs_02w.lst"  using 1:($7)  title '< zonnestraling (KNMI)  '  axis x1y1  w lp  lw 12  lc rgbcolor '#FFDFBF'        pt 3, \
   "< cat ../lst/mjs_batt_2001_sb_02w.lst"    using 1:($3)  title '                 solar >'  axis x1y2  w lp  lw 3   lc rgbcolor '#FF7F00'  dt 1  pt 3, \
   "< cat ../lst/mjs_batt_2001_sb_02w.lst"    using 1:($4)  title '               battery >'  axis x1y2  w lp  lw 3   lc rgbcolor '#7F7FFF'  dt 1  pt 3, \
   "< cat ../lst/mjs_batt_2001_sb_02w.lst"    using 1:($5)  title '                supply >'  axis x1y2  w lp  lw 3   lc rgbcolor '#007F00'  dt 1  pt 3
