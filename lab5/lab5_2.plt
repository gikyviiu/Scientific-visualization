set encoding utf8
reset
set title "Эквипотенциали поля полукруглой нити"
set size square
unset key

set palette rgbformulae 33, 13, 10

set xrange [-1:1]
set yrange [-1:1]

set xlabel "x"
set ylabel "y"

plot "lab5_2.txt" lc palette z pt 7 ps 0.25

pause -1