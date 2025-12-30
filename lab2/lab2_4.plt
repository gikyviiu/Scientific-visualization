set encoding utf8
reset

set title "Поверхность matrix.dat"
set xlabel "x (столбец)"
set ylabel "y (строка)"
set zlabel "z"

set hidden3d
set pm3d


splot 'matrix.dat' matrix with pm3d title "Матричная поверхность"



pause 3
set view map
replot