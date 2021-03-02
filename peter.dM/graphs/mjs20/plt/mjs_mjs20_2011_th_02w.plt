#!/usr/bin/gnuplot -persist
# mjs_mjs20_2011_th_02w.plt

set style data lines
set grid front
set key left top
set key font ", 18"
set key opaque
set terminal png size 1920,320 transparent
set output "../png/mjs_mjs20_2011_th_02w.png"
set xdata time
set timefmt "%Y-%m-%d.%H:%M:%S"
set format x "     %d\n       %b"
set autoscale xfix
set xtics 86400
set mxtics 4
set xtics font ", 18"
set ytics  nomirror
set y2tics nomirror
set ytics  font ", 18" textcolor rgb "red" 
set y2tics font ", 18" textcolor rgb "blue" 
set grid xtics ytics
set boxwidth 60
set style fill transparent solid 0.10 noborder


plot \
   "< cat ../../knmi/lst/knmi_thdrs_02w.lst"  using 1:($2)  title '< KNMI temperature  '  axis x1y1  lt 1  lw 6  lc rgbcolor '#FFCFCF', \
   "< cat ../../knmi/lst/knmi_thdrs_02w.lst"  using 1:($3)  title '     KNMI humidity >'  axis x1y2  lt 2  lw 6  lc rgbcolor '#CFCFFF', \
   "< cat ../lst/mjs_mjs20_2011_th_02w.lst"   using 1:($3)  title '< temperature       '  axis x1y1  lt 1  lw 2  lc rgbcolor '#FF0000', \
   "< cat ../lst/mjs_mjs20_2011_th_02w.lst"   using 1:($4)  title '          humidity >'  axis x1y2  lt 2  lw 2  lc rgbcolor '#0000FF'
