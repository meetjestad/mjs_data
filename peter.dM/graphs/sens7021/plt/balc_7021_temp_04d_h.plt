#!/usr/bin/gnuplot -persist
# balc_7021_temp_04d_h.plt

set style data lines
set grid front
set key left top
set key font ",16"
set terminal pngcairo size 1920,960 transparent
set output "balc_7021_temp_04d_h.png"
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
   "< cat ../lst/balc_7021_temp_04d_h.lst" using 1:($8)  title 'KNMI'     w lp lw 12 lc rgbcolor '#FF0000' pt 3, \
   "< cat ../lst/balc_7021_temp_04d_h.lst" using 1:($2)  title '1'        w lp lw 2 lc rgbcolor '#A22A2A' dt 1 pt 3, \
   "< cat ../lst/balc_7021_temp_04d_h.lst" using 1:($3)  title '2'        w lp lw 2 lc rgbcolor '#FF0000' dt 1 pt 3, \
   "< cat ../lst/balc_7021_temp_04d_h.lst" using 1:($4)  title '3'        w lp lw 2 lc rgbcolor '#FFA500' dt 1 pt 3, \
   "< cat ../lst/balc_7021_temp_04d_h.lst" using 1:($5)  title '4'        w lp lw 2 lc rgbcolor '#FFFF00' dt 1 pt 3, \
   "< cat ../lst/balc_7021_temp_04d_h.lst" using 1:($6)  title '5'        w lp lw 2 lc rgbcolor '#007F00' dt 1 pt 3, \
   "< cat ../lst/balc_7021_temp_04d_h.lst" using 1:($7)  title '6'        w lp lw 2 lc rgbcolor '#0000FF' dt 1 pt 3

#  "< cat ../lst/balc_7021_temp_04d_h.lst" using 1:($9)  title 'mcp9808'  w lp lw 4 lc rgbcolor '#000000' dt 1 pt 3, \
