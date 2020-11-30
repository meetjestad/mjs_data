#!/usr/bin/gnuplot -persist
# mjs_pm_567_06m_h.plt

set style data lines
set grid front
set key left center
set key font ", 18"
set key opaque
set terminal png size 1920,480 transparent
set output "mjs_pm_567_06m_h.png"
set xdata time
set timefmt "%Y-%m-%d.%H:%M:%S"
set format x "      %b\n    %d"
set autoscale xfix
set xtics 604800
set mxtics 7
set xtics font ", 18"
set ytics nomirror
set y2tics nomirror
set ytics font ", 18" textcolor rgb "red" 
set y2tics font ", 18" textcolor rgb "blue" 
set grid xtics ytics
set boxwidth 60
set style fill transparent solid 0.10 noborder


plot \
   "< cat mjs_pm_567_06m_h.lst"  using 1:($2)  title '< temperature   '  axis x1y1  lt 1  lw 2  lc rgbcolor '#FF0000', \
   "< cat mjs_pm_567_06m_h.lst"  using 1:($3)  title '     humidity >'   axis x1y2  lt 2  lw 2  lc rgbcolor '#0000FF', \
   "< cat mjs_pm_567_06m_h.lst"  using 1:($5)  title '        pm2.5 >'   axis x1y2  lt 3  lw 2  dashtype 1  lc rgbcolor '#7F7F7F', \
   "< cat mjs_pm_567_06m_h.lst"  using 1:($6)  title '   pm10-pm2.5 >'   axis x1y2  lt 6  lw 3  dashtype 2  lc rgbcolor '#7F7F7F'
