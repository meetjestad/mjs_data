#!/usr/bin/gnuplot -persist
# mjs_light_0068_04d.plt

set style data lines
set grid front
set key left top
set key font ", 18"
set terminal png size 1920,480 transparent
set output "../png/mjs_light_0068_04d.png"
set xdata time
set timefmt "%Y-%m-%d.%H:%M:%S"
set format x "%H\n%d"
set autoscale xfix
set xtics 14400
set mxtics 4
set xtics font ", 18"
set ytics  nomirror
set y2tics nomirror
set ytics  font ", 18" textcolor rgbcolor "#FF7F00" 
set y2tics font ", 18" textcolor rgbcolor "#00007F" 
set grid xtics ytics
set pointsize 0.1
set boxwidth 60
set style fill transparent solid 0.10 noborder


plot \
   "< cat ../../knmi/lst/knmi_thdrs_04d.lst"        using 1:($7)       title '< light KNMI [J/cm2/h]'  axis x1y1  w lp  lw 12  lc rgbcolor '#FFDFBF'  pt 3, \
   "< cat ../lst/mjs_light_0068_sb_04d.lst"            using 1:($3/1000)  title '< light 68 [1000 lx]'    axis x1y1  w lp  lw 2   lc rgbcolor '#DF5F3F'  pt 3, \
   "< cat ../../batt/lst/mjs_batt_2008_sb_04d.lst"  using 1:($3)       title 'solar 2008 [mV] >'       axis x1y2  w lp  lw 2   lc rgbcolor '#0000FF'  pt 3

