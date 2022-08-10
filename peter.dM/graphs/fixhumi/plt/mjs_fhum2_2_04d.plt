#!/usr/bin/gnuplot -persist
# mjs_fhum2_2_04d.plt

set style data lines
set grid front
set key left center
set key font ",16"
set terminal pngcairo size 1920,480 transparent
set output "../png/mjs_fhum2_2_04d.png"
set xdata time
set timefmt "%Y-%m-%d.%H:%M:%S"
set format x "%H\n%d"
set autoscale xfix
set xtics 14400
set mxtics 4
set xtics  font ", 18"
set ytics  nomirror
set y2tics nomirror
set ytics  font ", 18" textcolor rgbcolor "#0000FF" 
set y2tics font ", 18" textcolor rgbcolor "#000000" 
set grid xtics ytics
set pointsize 0.1
set boxwidth 120
set style fill transparent solid 0.10 noborder


plot \
   "< cat ../../knmi/lst/knmi_thdrs_290_04d.lst"  using 1:($3)  title '< rel. humidity KNMI-290    '  axis x1y1  w lp  lw 12  lc rgbcolor '#BFBFFF'        pt 3, \
   "< cat ../../knmi/lst/knmi_thdrs_290_04d.lst"  using 1:($4)  title '         dewpoint KNMI-290 >'  axis x1y2  w lp  lw 12  lc rgbcolor '#BFFFBF'        pt 3, \
   "< cat ../../knmi/lst/knmi_thdrs_290_04d.lst"  using 1:($2)  title '      temperature KNMI-290 >'  axis x1y2  w lp  lw 12  lc rgbcolor '#FFBFBF'        pt 3, \
   "< cat ../lst/mjs_fhum2_2_cal_04d.lst"         using 1:($4)  title '< rel. humidity calculated >'  axis x1y1  w lp  lw 2   lc rgbcolor '#0000FF'  dt 1  pt 7 ps 0.5, \
   "< cat ../lst/mjs_fhum2_2_cal_04d.lst"         using 1:($5)  title '           dewpoint mjs-68 >'  axis x1y2  w lp  lw 2   lc rgbcolor '#007F00'  dt 1  pt 7 ps 0.5, \
   "< cat ../lst/mjs_fhum2_2_cal_04d.lst"         using 1:($3)  title '       temperature mjs-176 >'  axis x1y2  w lp  lw 2   lc rgbcolor '#FF0000'  dt 1  pt 7 ps 0.5, \

