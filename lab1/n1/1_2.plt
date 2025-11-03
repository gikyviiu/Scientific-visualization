reset
set title "Графики трёх функций"
set xlabel "x"
set ylabel "y"

plot \
    sin(x) with lines lc "red" lw 3 title "sin(x)", \
    sin(x)/x with lines lc "blue" dt 2 lw 2 title "sin(x)/x", \
    sin(x**3/100) with linespoints lc "green" lw 2 pt 13 ps 2 title "sin(x³/100)"