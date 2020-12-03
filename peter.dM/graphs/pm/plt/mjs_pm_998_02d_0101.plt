#!/usr/bin/gnuplot -persist
# mjs_pm_998_02d_0101.plt

set style data lines
set grid front
set key left top
set key font ", 18"
set terminal png size 1920,480 transparent
set output "mjs_pm_998_02d_0101.png"
set xdata time
set timefmt "%Y-%m-%d.%H:%M:%S"
set xrange ["2019-12-31.18:00:00":"2020-01-01.06:00:00"]
set format x "%d\n%H"
set autoscale xfix
set xtics 3600
set mxtics 4
set xtics font ", 18"
set ytics font ", 18"
set grid xtics ytics
set pointsize 0.1
set boxwidth 60
set style fill transparent solid 0.10 noborder


plot \
   "< cat mjs_pm_998_02d_0101.lst" using 1:($2)     title 'temperature'  w lp lw 2 lc rgbcolor '#FF0000' pt 3, \
   "< cat mjs_pm_998_02d_0101.lst" using 1:($3)     title 'humidity'     w lp lw 2 lc rgbcolor '#0000FF' pt 3, \
   "< cat mjs_pm_998_02d_0101.lst" using 1:($4)     title 'pm1'          w lp lw 3 lc rgbcolor '#00000F' pt 3, \
   "< cat mjs_pm_998_02d_0101.lst" using 1:($5-$4)  title 'pm2.5-pm1'    w lp lw 5 lc rgbcolor '#5F5F5F' pt 3, \
   "< cat mjs_pm_997_02d_0101.lst" using 1:($6-$5)  title 'pm10-pm2.5'   w lp lw 7 lc rgbcolor '#BFBFBF' pt 3
