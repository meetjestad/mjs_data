#!/usr/bin/gnuplot -persist
# $Id: lmn_pm_NL10821_04d.plt $
# Author: Peter Demmer for Meetjestad!


set title 'Meet je stad!' font ', 36' textcolor rgb 'grey' offset 0, -6
set style data lines
set grid front
set key left top
set key font ", 18"
set terminal png size 1920,480 transparent
set output "../png/lmn_pm_NL10821_04d.png"
set xdata time
set timefmt "%Y-%m-%d.%H:%M:%S"
set format x "%H\n%d"
set autoscale xfix
set xtics 14400
set mxtics 4
set xtics font ', 18'
set ytics font ', 18'
set style line 10 lc rgb 'black' lt 1 lw 1
set grid xtics ytics ls 10, ls 10
set pointsize 0.1
set boxwidth 60
set style fill transparent solid 0.10 noborder


plot \
   "< cat ../lst/lmn_pm_NL10821_cal_04d.lst"     using 1:($3)  title 'Winkelhorst'  w lp  lw 12  lc rgbcolor '#BFBFBF'  pt 3, \
   "< cat ../../pm/lst/mjs_pm_0068_cal_04d.lst"  using 1:($3)  title 'mjs0068    '  w lp  lw 2   lc rgbcolor '#FF0000'  pt 3, \
   
   #"< cat ../../pm/lst/mjs_pm_2008_cal_04d.lst"  using 1:($3)  title 'mjs2008    '  w lp  lw 2   lc rgbcolor '#007F00'  pt 3, \

   #"< cat ../../pm/lst/mjs_pm_2028_cal_04d.lst"  using 1:($3)  title 'mjs2028    '  w lp  lw 2   lc rgbcolor '#0000FF'  pt 3, \

