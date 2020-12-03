#!/usr/bin/gnuplot -persist
# rivm_pm_068_03m_9731.plt

set style data lines
set grid front
set key left top
set key font ", 18"
set terminal png size 1920,480 transparent
set output "rivm_pm_068_03m_9731.png"
set xdata time
set timefmt "%Y-%m-%d.%H:%M:%S"
set format x "    %m\n    %d"
set autoscale xfix
set xtics 604800
set mxtics 7
set xtics font ", 18"
set ytics font ", 18"
set grid xtics ytics
set pointsize 0.1
set boxwidth 60
set style fill transparent solid 0.10 noborder


plot \
   "< cat rivm_pm_068_03m_9731.lst" using 1:($2*10)  title 'pm2.5nat * 10'  w lp lw 2 lc rgbcolor '#4F4F4F' pt 3, \
   "< cat rivm_pm_068_03m_9731.lst" using 1:($3)     title 'pm2.5eu'        w lp lw 3 lc rgbcolor '#BFBFBF' pt 3
