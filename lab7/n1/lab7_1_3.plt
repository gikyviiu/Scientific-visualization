reset
set encoding utf8
set title "Задание 8: Эквипотенциали (красный) и силовые линии (синий)\nВариант 8: 5 одинаковых зарядов в вершинах правильного пятиугольника"
set size square
set xrange [-3.0:3.0]
set yrange [-3.0:3.0]
set xlabel "x"
set ylabel "y"
set grid

R = 1.0

set object 1 circle at R*cos(0),              R*sin(0)              size 0.1 fc rgb "black" fillstyle solid
set object 2 circle at R*cos(2*pi/5),         R*sin(2*pi/5)         size 0.1 fc rgb "black" fillstyle solid
set object 3 circle at R*cos(4*pi/5),         R*sin(4*pi/5)         size 0.1 fc rgb "black" fillstyle solid
set object 4 circle at R*cos(6*pi/5),         R*sin(6*pi/5)         size 0.1 fc rgb "black" fillstyle solid
set object 5 circle at R*cos(8*pi/5),         R*sin(8*pi/5)         size 0.1 fc rgb "black" fillstyle solid

set label "q" at R*cos(0),              R*sin(0) + 0.20 center
set label "q" at R*cos(2*pi/5),         R*sin(2*pi/5) + 0.20 center
set label "q" at R*cos(4*pi/5) - 0.18,  R*sin(4*pi/5) + 0.12 center
set label "q" at R*cos(6*pi/5) - 0.18,  R*sin(6*pi/5) - 0.12 center
set label "q" at R*cos(8*pi/5) + 0.18,  R*sin(8*pi/5) - 0.12 center

# Отображение данных
plot "eq.txt" using 1:2 with lines lc rgb "red" lw 1.5 title "Эквипотенциали", \
     "lab7_1.txt" using 1:2 with lines lc rgb "blue" lw 1 title "Силовые линии"

pause -1 "OK"