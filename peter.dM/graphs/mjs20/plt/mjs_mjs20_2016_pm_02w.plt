#!/usr/bin/gnuplot -persist
# mjs_mjs20_2016_pm_02w.plt

set style data lines
set grid front
set key left top
set key font ", 18"
set key opaque
set terminal png size 1920,480 transparent
set output "../png/mjs_mjs20_2016_pm_02w.png"
set xdata time
set timefmt "%Y-%m-%d.%H:%M:%S"
set format x "     %d\n       %b"
set autoscale xfix
set xtics 86400
set mxtics 4
set xtics font ", 18"
set ytics  nomirror
set y2tics nomirror
set ytics  font ", 18" textcolor rgb "#7F7F7F" 
set y2tics font ", 18" textcolor rgb "#3F3F3F" 
set grid xtics ytics
set boxwidth 60
set style fill transparent solid 0.10 noborder


plot \
   "< cat ../lst/mjs_mjs20_2016_pm_02w.lst"  using 1:($6-$5)/10  title '< pm10.0  '  axis x1y1  lt 1  lw 5  lc rgbcolor '#BFBFBF', \
   "< cat ../lst/mjs_mjs20_2016_pm_02w.lst"  using 1:($5-$4)/10  title '< pm4.0   '  axis x1y1  lt 1  lw 4  lc rgbcolor '#9F9F9F', \
   "< cat ../lst/mjs_mjs20_2016_pm_02w.lst"  using 1:($4-$3)/10  title '  pm2.5  >'  axis x1y2  lt 1  lw 3  lc rgbcolor '#7F7F7F', \
   "< cat ../lst/mjs_mjs20_2016_pm_02w.lst"  using 1:($3/10)     title '  pm1.0  >'  axis x1y2  lt 1  lw 2  lc rgbcolor '#1F1F1F'
   #"< cat ../lst/mjs_mjs20_2016_pm_02w.lst"  using 1:($10-$9) title '  nc10.0 >'  axis x1y2  lt 2  lw 5  dashtype 1  lc rgbcolor '#EFCF6F', \
   #"< cat ../lst/mjs_mjs20_2016_pm_02w.lst"  using 1:($9-$8)  title '   nc4.0 >'  axis x1y2  lt 2  lw 4  dashtype 1  lc rgbcolor '#CFAF4F', \
   #"< cat ../lst/mjs_mjs20_2016_pm_02w.lst"  using 1:($8-$7)  title '   nc2.5 >'  axis x1y2  lt 2  lw 3  dashtype 1  lc rgbcolor '#AF8F2F', \
   #"< cat ../lst/mjs_mjs20_2016_pm_02w.lst"  using 1:($7)     title '   nc1.0 >'  axis x1y2  lt 2  lw 2  dashtype 1  lc rgbcolor '#8F6F0F'
