#!/usr/bin/gnuplot -persist
# mjs_mjs20_humi_2_04d.plt

set style data lines
set grid front
set key left top
set key font ", 18"
set key opaque
set terminal png size 1920,480 transparent
set output "../png/mjs_mjs20_humi_2_04d.png"
set xdata time
set timefmt "%Y-%m-%d.%H:%M:%S"
set format x "%H\n%d"
set autoscale xfix
set xtics 14400
set mxtics 4
set xtics  font ", 18"
set ytics  nomirror
set y2tics nomirror
set ytics  font ", 18" textcolor rgb "blue" 
set y2tics font ", 18" textcolor rgb "blue" 
set grid xtics ytics
set boxwidth 60
set style fill transparent solid 0.10 noborder


plot \
   "< cat ../../knmi/lst/knmi_thdrs_04d.lst"  using 1:($3)  title 'KNMI humidity'  axis x1y1  lt 1  lw 6  lc rgbcolor '#CFCFFF', \
   "< cat ../lst/mjs_mjs20_2000_th_04d.lst"   using 1:($4)  title 'humidity 2000'  axis x1y1  lt 1  lw 2  lc rgbcolor '#000000', \
   "< cat ../lst/mjs_mjs20_2001_th_04d.lst"   using 1:($4)  title 'humidity 2001'  axis x1y1  lt 1  lw 2  lc rgbcolor '#A22A2A', \
   "< cat ../lst/mjs_mjs20_2002_th_04d.lst"   using 1:($4)  title 'humidity 2002'  axis x1y1  lt 1  lw 2  lc rgbcolor '#FF0000', \
   "< cat ../lst/mjs_mjs20_2003_th_04d.lst"   using 1:($4)  title 'humidity 2003'  axis x1y1  lt 1  lw 2  lc rgbcolor '#FFA500', \
   "< cat ../lst/mjs_mjs20_2004_th_04d.lst"   using 1:($4)  title 'humidity 2004'  axis x1y1  lt 1  lw 2  lc rgbcolor '#FFFF00', \
   "< cat ../lst/mjs_mjs20_2005_th_04d.lst"   using 1:($4)  title 'humidity 2005'  axis x1y1  lt 1  lw 2  lc rgbcolor '#007F00', \
   "< cat ../lst/mjs_mjs20_2006_th_04d.lst"   using 1:($4)  title 'humidity 2006'  axis x1y1  lt 1  lw 2  lc rgbcolor '#0000FF', \
   "< cat ../lst/mjs_mjs20_2007_th_04d.lst"   using 1:($4)  title 'humidity 2007'  axis x1y1  lt 1  lw 2  lc rgbcolor '#7F007F'

