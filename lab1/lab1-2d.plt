set encoding utf8

reset

set title "Синус"
set xlabel "x"
set ylabel "y"

plot sin(x) with lines lc 3 title "y = sin(x)"
pause 2





reset
set title "Графики трёх функций"
set xlabel "x"
set ylabel "y"

plot \
    sin(x) with lines lc "red" lw 3 title "sin(x)", \
    sin(x)/x with lines lc "blue" dt 2 lw 2 title "sin(x)/x", \
    sin(x**3/100) with linespoints lc "green" lw 2 pt 13 ps 2 title "sin(x³/100)"
pause 2






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
pause 2





reset
set polar
set trange [0 : 2*pi]
set samples 500

set title "8-лепестковая роза"
set grid polar
set size ratio -1

plot 3 * sin(4*t)**2 with lines lc "red" lw 2 title "ρ = 3·sin²(4φ)"
pause 2








reset
set multiplot layout 3,1 title "График ln(1 + cos(x))"

    set title "x ∈ [0; 10]"
    set xrange [0:10]
    #set yrange [-1:0.5]
    plot log(1 + cos(x)) with lines lc "red" lw 2 title "ln(1 + cos(x))"

    set title "x ∈ [0; 100]"
    set xrange [0:100]
    #set yrange [-1:0.5]
    plot log(1 + cos(x)) with lines lc "blue" lw 2 title "ln(1 + cos(x))"

    set title "x ∈ [0; 1000]"
    set xrange [0:1000]
    #set yrange [-1:0.5]
    plot log(1 + cos(x)) with lines lc "green" lw 2 title "ln(1 + cos(x))"

unset multiplot
pause 2





reset
set title "График функции f(x) = \\sqrt[3]{x^2 (x - 4.7)}"
set xlabel "x"
set ylabel "f(x)"
set grid

set xrange [-5 : 6]
set yrange [-5 : 5]
set samples 1000

f(x) = sgn(x**2 * (x - 4.7)) * abs(x**2 * (x - 4.7))**(1./3)

plot f(x) with lines lw 2 lc rgb "red" title "f(x) = \\sqrt[3]{x^2 (x - 4.7)}"