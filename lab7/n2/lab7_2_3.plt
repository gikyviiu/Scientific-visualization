set encoding utf8
set title "Задание 3: Эквипотенциали (красный) и силовые линии (синий)\nЗаряженная полуокружность"
set size square
set xrange [-3.7:3.7]
set yrange [-3.7:3.7]
set xlabel "x"
set ylabel "y"
set grid

# Параметры полуокружности
R = 1.5

# Рисуем саму полуокружность (заряженная нить)
set parametric
set trange [0:pi]
set samples 100

plot R*cos(t), R*sin(t) with lines lc rgb "black" lw 3 title "Заряженная нить", \
     "lab7_2_equipotential.txt" using 1:2 with lines lc rgb "red" lw 1.5 title "Эквипотенциали", \
     "lab7_2.txt" using 1:2 with lines lc rgb "blue" lw 1 title "Силовые линии"
pause -1 "OK"
