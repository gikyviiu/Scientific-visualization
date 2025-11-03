set encoding utf8
reset

set xlabel "x"
set ylabel "y"

set style line 1 lc rgb "blue" lw 2
set style line 2 lc rgb "red" lw 2 pt 7 ps 1.5

# 1
plot 'data2d.dat' index 7 with lines ls 1 title "Функция"
pause 3

# 2
replot 'data2d.dat' index 7 every 10:10  with points ls 2 title "Маркеры каждую 10-ю точку"
pause 3

# 3
plot 'data2d.dat' index 7 using 1:(abs($2)) with lines ls 1 title "|y|"

# 4
plot 'data2d.dat' index 7 using 1:2 smooth bezier with lines ls 1 title "Безье", \
     '' index 7 using 1:2 every 10:10 with points ls 2 title "Маркеры"
