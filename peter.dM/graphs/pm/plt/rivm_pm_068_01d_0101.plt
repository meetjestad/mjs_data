#!/usr/bin/gnuplot -persist
# rivm_pm_068_01d_0101.plt

set style data lines
set grid front
set key left top
set key font ", 18"
set terminal png size 1920,480 transparent
set output "rivm_pm_068_01d_0101.png"
set xdata time
set timefmt "%Y-%m-%d.%H:%M:%S"
set format x "%d\n%H"
set autoscale xfix
set yrange [:700]
set xtics 14400
set mxtics 4
set xtics font ", 18"
set ytics font ", 18"
set grid xtics ytics
set pointsize 0.1
set boxwidth 60
set style fill transparent solid 0.10 noborder


plot \
   "< grep -v '#' rivm_pm_068_01d_0101.lst" using 1:($5)  title 'pm2.5'        w lp lw 2 lc rgbcolor '#4F4F4F' pt 3
