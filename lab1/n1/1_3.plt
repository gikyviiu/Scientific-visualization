reset
set parametric
set trange [0 : 2*pi/3]
set size ratio 1
set title "График параметрической функции: x=sin(3t), y=cos(3t)"

set xlabel "x = sin(3t)"
set ylabel "y = cos(3t)"
set style line 1 lc rgb "blue" lw 2

plot sin(3*t), cos(3*t) with lines linestyle 1
unset parametric