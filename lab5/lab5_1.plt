set encoding utf8
reset
set title "Эквипотенциали: 5 зарядов в вершинах пятиугольника"
set size square
unset key
set palette rgbformulae 33, 13, 10
plot [-1:1] [-1:1] "lab5.txt" lc palette z pt 7 ps 0.25
pause -1