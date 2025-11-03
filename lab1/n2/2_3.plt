reset

set parametric
set urange [0 : 6*pi] 
set samples 500
set size ratio 1
set title "Винтовая линия: x=cos(u), y=sin(u), z=u"

set xlabel "x"
set ylabel "y"
set zlabel "z"

set grid

set view 60, 30

splot cos(u), sin(u), u \
      with lines lw 2 lc rgb "blue" title "Винтовая линия"

