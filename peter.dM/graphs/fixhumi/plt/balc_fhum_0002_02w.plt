#!/usr/bin/gnuplot -persist
# balc_fhum_0002_02w.plt

set style data lines
set grid front
set key left top
set key font ", 18"
set terminal png size 1920,480 transparent
set output "../png/balc_fhum_0002_02w.png"
set xdata time
set timefmt "%Y-%m-%d.%H:%M:%S"
set format x "    %d\n    %b"
set autoscale xfix
set xtics 86400
set mxtics 4
set xtics font ", 18"
set ytics font ", 18"
set ytics nomirror
set y2tics nomirror
set ytics font ", 18" textcolor rgb "red" 
set y2tics font ", 18" textcolor rgb "blue" 
set grid xtics ytics
set pointsize 0.1
set boxwidth 60
set style fill transparent solid 0.10 noborder


plot \
   "< cat ../../knmi/lst/knmi_thdrs_02w.lst"  using 1:($2)  title '< KNMI temperature   '  axis x1y1  w lp  lw 8  lc rgbcolor '#FFBFBF'  pt 3, \
   "< cat ../../knmi/lst/knmi_thdrs_02w.lst"  using 1:($3)  title '      KNMI humidity >'  axis x1y2  w lp  lw 8  lc rgbcolor '#BFBFFF'  pt 3, \
   "< cat ../lst/balc_fhum_0002_02w.lst"      using 2:($7)  title '< temperature        '  axis x1y1  w lp  lw 4  lc rgbcolor '#FF0000'  pt 3, \
   "< cat ../lst/balc_fhum_0002_02w.lst"      using 2:($8)  title '     humidity (org) >'  axis x1y2  w lp  lw 1  lc rgbcolor '#0000FF'  pt 3, \
   "< cat ../lst/balc_fhum_0002_02w.lst"      using 2:($11) title '    humidity (corr) >'  axis x1y2  w lp  lw 4  lc rgbcolor '#0000FF'  pt 3
