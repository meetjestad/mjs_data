#!/usr/bin/gnuplot -persist
# $Id: lmn_pm_NL10636_02m.plt $
# Author: Peter Demmer for Meetjestad!


set title 'Meet je stad!' font ', 36' textcolor rgb 'grey' offset 0, -6
set style data lines
set grid front
set key left top
set key font ", 18"
set terminal png size 1920,480 transparent
set output "../png/lmn_pm_NL10636_02m.png"
set xdata time
set timefmt "%Y-%m-%d.%H:%M:%S"
set format x "     %d\n       %b"
set autoscale xfix
set xtics 604800
set mxtics 7
set xtics font ", 18"
set ytics font ", 18"
set style line 10 lc rgb 'black' lt 1 lw 1
set grid xtics ytics ls 10, ls 10
set pointsize 0.1
set boxwidth 60
set style fill transparent solid 0.10 noborder


plot \
   "< cat ../lst/lmn_pm_NL10636_cal_02m.lst"     using 1:($3)  title 'K.deJongweg'  w lp  lw 12  lc rgbcolor '#BFBFBF'  pt 3, \
   "< cat ../../pm/lst/mjs_pm_0719_cal_02m.lst"  using 1:($3)  title 'mjs0719    '  w lp  lw 2   lc rgbcolor '#FF0000'  pt 3, \
   
