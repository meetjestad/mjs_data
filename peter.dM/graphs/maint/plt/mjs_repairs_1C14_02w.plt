#!/usr/bin/gnuplot -persist
# $Id: graphs/maint/plt/mjs_repairs_1C14_02w.plt
# $Author: Peter >Demmer for Meetjestad!


set style data lines
set grid front
set key left bottom
set key font ",16"
set terminal pngcairo size 1920,480 transparent
set output "../png/mjs_repairs_1C14_02w.png"
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
   "< cat ../lst/mjs_repair_0060_cal_02w.lst"    using 1:($4)  title '  60'  axis x1y2  w lp  lw 6  dt 1  pt 7 ps 0.5, \
   "< cat ../lst/mjs_repair_0063_cal_02w.lst"    using 1:($4)  title '  63'  axis x1y2  w lp  lw 6  dt 1  pt 7 ps 0.5, \
   "< cat ../lst/mjs_repair_0081_cal_02w.lst"    using 1:($4)  title '  81'  axis x1y2  w lp  lw 6  dt 1  pt 7 ps 0.5, \
   "< cat ../lst/mjs_repair_0104_cal_02w.lst"    using 1:($4)  title ' 104'  axis x1y2  w lp  lw 6  dt 1  pt 7 ps 0.5, \
   "< cat ../lst/mjs_repair_0106_cal_02w.lst"    using 1:($4)  title ' 106'  axis x1y2  w lp  lw 6  dt 1  pt 7 ps 0.5, \
   "< cat ../lst/mjs_repair_0293_cal_02w.lst"    using 1:($4)  title ' 293'  axis x1y2  w lp  lw 6  dt 1  pt 7 ps 0.5, \
   "< cat ../lst/mjs_repair_0297_cal_02w.lst"    using 1:($4)  title ' 297'  axis x1y2  w lp  lw 6  dt 1  pt 7 ps 0.5, \
   "< cat ../lst/mjs_repair_0514_cal_02w.lst"    using 1:($4)  title ' 514'  axis x1y2  w lp  lw 6  dt 1  pt 7 ps 0.5, \
   "< cat ../lst/mjs_repair_0654_cal_02w.lst"    using 1:($4)  title ' 654'  axis x1y2  w lp  lw 6  dt 1  pt 7 ps 0.5, \

   #"< cat ../lst/mjs_repair_0167_cal_02w.lst"    using 1:($4)  title ' 167'  axis x1y2  w lp  lw 6  dt 1  pt 7 ps 0.5, \
   #"< cat ../lst/mjs_repair_0653_cal_02w.lst"    using 1:($4)  title ' 653'  axis x1y2  w lp  lw 6  dt 1  pt 7 ps 0.5, \
