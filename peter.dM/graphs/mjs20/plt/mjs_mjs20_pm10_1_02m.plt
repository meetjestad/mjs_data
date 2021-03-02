#!/usr/bin/gnuplot -persist
# mjs_mjs20_pm10_1_02m.plt

set style data lines
set grid front
set key left top
set key font ", 18"
set key opaque
set terminal png size 1920,480 transparent
set output "../png/mjs_mjs20_pm10_1_02m.png"
set xdata time
set timefmt "%Y-%m-%d.%H:%M:%S"
set format x "     %d\n       %b"
set autoscale xfix
set xtics 604800
set mxtics 7
set xtics  font ", 18"
set ytics  nomirror
set y2tics nomirror
set ytics  font ", 18" textcolor rgb "#BFBFBF" 
set y2tics font ", 18" textcolor rgb "#BFBFBF" 
set grid xtics ytics
set boxwidth 60
set style fill transparent solid 0.10 noborder


plot \
   "< cat ../lst/mjs_mjs20_2001_th_02m.lst"   using 1:($6-$5)  title 'pm10-pm2.5 2001'  axis x1y1  lt 1  lw 2  lc rgbcolor '#A22A2A', \
   "< cat ../lst/mjs_mjs20_2003_th_02m.lst"   using 1:($6-$5)  title 'pm10-pm2.5 2003'  axis x1y1  lt 1  lw 2  lc rgbcolor '#FFA500', \
   "< cat ../lst/mjs_mjs20_2004_th_02m.lst"   using 1:($6-$5)  title 'pm10-pm2.5 2004'  axis x1y1  lt 1  lw 2  lc rgbcolor '#FFFF00', \
   "< cat ../lst/mjs_mjs20_2005_th_02m.lst"   using 1:($6-$5)  title 'pm10-pm2.5 2005'  axis x1y1  lt 1  lw 2  lc rgbcolor '#007F00', \

   #"< cat ../lst/mjs_mjs20_2000_th_02m.lst"   using 1:($6-$5)  title 'pm10-pm2.5 2000'  axis x1y1  lt 1  lw 2  lc rgbcolor '#000000', \
   #"< cat ../lst/mjs_mjs20_2002_th_02m.lst"   using 1:($6-$5)  title 'pm10-pm2.5 2002'  axis x1y1  lt 1  lw 2  lc rgbcolor '#FF0000', \
   #"< cat ../lst/mjs_mjs20_2006_th_02m.lst"   using 1:($6-$5)  title 'pm10-pm2.5 2006'  axis x1y1  lt 1  lw 2  lc rgbcolor '#0000FF', \
   #"< cat ../lst/mjs_mjs20_2007_th_02m.lst"   using 1:($6-$5)  title 'pm10-pm2.5 2007'  axis x1y1  lt 1  lw 2  lc rgbcolor '#7F007F'
