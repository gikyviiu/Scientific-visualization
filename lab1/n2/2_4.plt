reset

set parametric
set urange [0 : 2*pi]
set samples 1000
set size ratio 1

set title "Обмотка тора: x=(10+3sin(15u))cos(u), y=(10+3sin(15u))sin(u), z=2cos(15u)"
set xlabel "x"
set ylabel "y"
set zlabel "z"

set grid

splot (10 + 3*sin(15*u)) * cos(u), \
      (10 + 3*sin(15*u)) * sin(u), \
      2 * cos(15*u) \
      with lines lw 2 lc rgb "red" title "Обмотка тора"