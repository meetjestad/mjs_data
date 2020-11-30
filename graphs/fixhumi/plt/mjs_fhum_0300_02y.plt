#!/usr/bin/gnuplot -persist
# mjs_fhum_0300_02y.plt

set style data lines
set grid front
set key left top
set key font ", 18"
set terminal png size 1920,480 transparent
set output "../png/mjs_fhum_0300_02y.png"
set xdata time
set timefmt "%Y-%m-%d.%H:%M:%S"
set format x "    %m\n    %y"
set autoscale xfix
set xtics 2592000
set mxtics 4
set xtics font ", 18"
set ytics font ", 18"
set grid xtics ytics
set pointsize 0.1
set boxwidth 60
set style fill transparent solid 0.10 noborder


plot \
   "< cat ../lst/knmi_th_02y.lst"       using 1:($2)  title 'KNMI temperature' w lp lw 8 lc rgbcolor '#FFBFBF' pt 3, \
   "< cat ../lst/knmi_th_02y.lst"       using 1:($3)  title 'KNMI humidity'    w lp lw 8 lc rgbcolor '#BFBFFF' pt 3, \
   "< cat ../lst/mjs_fhum_0300_02y.lst" using 2:($7)  title 'temperature'      w lp lw 4 lc rgbcolor '#FF0000' pt 3, \
   "< cat ../lst/mjs_fhum_0300_02y.lst" using 2:($8)  title 'humidity (org)'   w lp lw 1 lc rgbcolor '#BFBFFF' pt 3, \
   "< cat ../lst/mjs_fhum_0300_02y.lst" using 2:($11) title 'humidity (corr)'  w lp lw 4 lc rgbcolor '#0000FF' pt 3
