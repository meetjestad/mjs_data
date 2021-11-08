#!/usr/bin/gnuplot -persist
# mjs_bodem_0756_c_02m.plt

set style data lines
set grid front
set key left top
set key font ",16"
set terminal pngcairo size 1920,480 transparent
set output "../png/mjs_bodem_0756_c_02m.png"
set xdata time
set timefmt "%Y-%m-%d.%H:%M:%S"
set format x "     %d\n       %b"
set autoscale xfix
#set logscale y
set xtics 604800
set mxtics 7
set xtics font ", 18"
set ytics font ", 18"
set ytics nomirror
set y2tics nomirror
set ytics font ", 18" textcolor rgb "blue" 
set y2tics font ", 18" textcolor rgb "black" 
set grid xtics ytics
set pointsize 0.1
set boxwidth 120
set style fill transparent solid 0.10 noborder


plot \
   "< cat ../../knmi/lst/knmi_thdrs_02m.lst"        using 1:($6)  title '< regen7d [mm]  '  axis x1y1  w lp  lw 12  lc rgbcolor '#DFDFFF' dt 1 pt 3, \
   "< cat ../lst/mjs_bodem_0756_c_02m.lst"  using 1:($3)  title '  C10 [fF] >'      axis x1y2  w lp  lw 2   lc rgbcolor '#0000DF' dt 1 pt 3, \
   "< cat ../lst/mjs_bodem_0756_c_02m.lst"  using 1:($4)  title '  C40 [fF] >'      axis x1y2  w lp  lw 3   lc rgbcolor '#00009F' dt 1 pt 3, \
   "< cat ../lst/mjs_bodem_0756_c_02m.lst"  using 1:($5)  title '  C80 [fF] >'      axis x1y2  w lp  lw 4   lc rgbcolor '#00004F' dt 1 pt 3, \
   "< cat ../lst/mjs_bodem_0756_c_02m.lst"  using 1:($6)  title '  C120 [fF] >'     axis x1y2  w lp  lw 5   lc rgbcolor '#000000' dt 1 pt 3

# ../../knmi/lst/knmi_thdrs_04d.lst
