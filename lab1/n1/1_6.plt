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