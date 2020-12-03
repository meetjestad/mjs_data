#!/usr/bin/gnuplot -persist
# mjs_bodem_0519_c_04d.plt

set style data lines
set grid front
set key left top
set key font ",16"
set terminal pngcairo size 1920,480 transparent
set output "mjs_bodem_0519_c_04d.png"
set xdata time
set timefmt "%Y-%m-%d.%H:%M:%S"
set format x "%d\n%H"
set autoscale xfix
set xtics 14400
set mxtics 4
set xtics font ", 18"
set ytics font ", 18"
set grid xtics ytics
set pointsize 0.1
set boxwidth 120
set style fill transparent solid 0.10 noborder


plot \
   "< cat knmi_regen_04d.lst"       using 1:($3*1000) title 'regen7d'  w lp lw 8 lc rgbcolor '#0000FF' dt 1 pt 3, \
   "< cat mjs_bodem_0519_c_04d.lst" using 1:($3)      title 'C10'      w lp lw 2 lc rgbcolor '#0000DF' dt 1 pt 3, \
   "< cat mjs_bodem_0519_c_04d.lst" using 1:($4)      title 'C40'      w lp lw 3 lc rgbcolor '#00009F' dt 1 pt 3, \
   "< cat mjs_bodem_0519_c_04d.lst" using 1:($5)      title 'C80'      w lp lw 4 lc rgbcolor '#00004F' dt 1 pt 3, \
   "< cat mjs_bodem_0519_c_04d.lst" using 1:($6)      title 'C120'     w lp lw 5 lc rgbcolor '#000000' dt 1 pt 3
