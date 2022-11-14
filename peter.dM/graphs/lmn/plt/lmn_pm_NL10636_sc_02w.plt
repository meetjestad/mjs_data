#!/usr/bin/gnuplot -persist
# $Id: lmn_pm_NL10636_sc_02w.plt $
# Author: Peter Demmer for Meetjestad!

set style line 10 lc rgb 'black' lt 1 lw 1
set style line 11 lc rgb 'red'  ps 1 pt 7
set style line 12 lc rgb 'green' 
set style line 13 lc rgb 'blue' 
set title 'Meet je stad!' font ', 36' textcolor rgb 'grey' offset 0, -6
#set style data lines
set grid front
set key right bottom
set key font ", 18"
set terminal png size 480,480 transparent
set output "../png/lmn_pm_NL10636_sc_02w.png"
set xrange [0:]
set yrange [0:]
set autoscale xfix
set autoscale yfix
#set xtics 14400
#set mxtics 4
set xtics font ', 18'
set ytics font ', 18'
set grid xtics ytics ls 10, ls 10
set pointsize 0.1
set boxwidth 60
set style fill transparent solid 0.10 noborder


plot \
   "< grep -v '?' ../lst/lmn_pm_NL10636_pas_02w.lst"  using 2:3  title 'NL10636-mjs719'  ls 11  w p, \

