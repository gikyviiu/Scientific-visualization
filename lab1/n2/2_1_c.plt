reset 
set pm3d
set hidden3d

set xrange [0 : 2]
set yrange [0 : 2]
set zrange [0 : 500]  

set isosamples 100, 100

set palette rgbformulae 33,13,10

set title "Поверхность Розенброка: f(x,y) = (1-x)^2 + 100(y-x^2)^2"

f(x,y) = (1 - x)**2 + 100*(y - x**2)**2


splot f(x,y) with pm3d title "Розенброк"

set label 1 "Минимум (1,1)" at 1,1,0 point pt 7 ps 2 lc rgb "red"

