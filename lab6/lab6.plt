set encoding utf8
reset
set title "Эквипотенциали: 5 зарядов в вершинах пятиугольника (Marching Squares)"
set size square
unset key
set palette rgbformulae 33, 13, 10
plot [-1:1] [-1:1] "lab6.txt" with lines lc palette z lw 2
pause -1