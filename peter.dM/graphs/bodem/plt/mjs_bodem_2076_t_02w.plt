#!/usr/bin/gnuplot -persist
# mjs_bodem_2076_t_02w.plt

set style data lines
set grid front
set key left top
set key font ",16"
set terminal pngcairo size 1920,480 transparent
set output "../png/mjs_bodem_2076_t_02w.png"
set xdata time
set timefmt "%Y-%m-%d.%H:%M:%S"
set format x "     %d\n       %b"
set autoscale xfix
set xtics 86400
set mxtics 4
set xtics font ", 18"
set ytics nomirror
set y2tics nomirror
set ytics font ", 18" textcolor rgb "orange"
set y2tics font ", 18" textcolor rgb "red" 
set grid xtics ytics
set pointsize 0.1
set boxwidth 120
set style fill transparent solid 0.10 noborder


plot \
   "< cat ../../knmi/lst/knmi_thdrsR_260_02w.lst"  using 1:($7)  title '< Solar KNMI'        axis x1y1  w lp  lw 12  lc rgbcolor '#FFFF7F'  dt 1  pt 3, \
   "< cat ../../knmi/lst/knmi_thdrsR_260_02w.lst"       using 1:($2)  title 'Temperature KNMI >'  axis x1y2  w lp  lw 12  lc rgbcolor '#FFDFDF'  dt 1  pt 3, \
   "< cat ../lst/mjs_bodem_2076_ca_02w.lst"        using 1:($5)  title 'Temp 10 cm >'          axis x1y2  w lp  lw 5   lc rgbcolor '#DF0000'  dt 1  pt 3, \
   "< cat ../lst/mjs_bodem_2076_ca_02w.lst"        using 1:($7)  title 'Temp 40 cm >'          axis x1y2  w lp  lw 4   lc rgbcolor '#9F0000'  dt 1  pt 3, \

