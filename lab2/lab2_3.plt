reset

set title "Поверхность data3d.dat"
set xlabel "x"
set ylabel "y"
set zlabel "z"

set hidden3d
set dgrid3d 10,10
set view 60, 30

splot 'data3d.dat' with lines title "«Проволочная» поверхность"
pause 3


set pm3d
replot 'data3d.dat' with lines title " "
