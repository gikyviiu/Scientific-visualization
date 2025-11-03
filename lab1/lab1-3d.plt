set encoding utf8



reset

set dgrid3d 5,20  

set xrange [-2 : 2]
set yrange [-2 : 2]
set zrange [-4 : 4]

set hidden3d

set title "Гиперболический параболоид: z = x^2 - y^2"

f(x,y) = x**2 - y**2

splot f(x,y) with lines lw 1 lc rgb "blue" title "z = x^2 - y^2"
pause 2


reset

set hidden3d
set pm3d

set xrange [-2 : 2]
set yrange [-2 : 2]
set zrange [-0.5 : 0.5]

set isosamples 50, 50

set title "Поверхность: z = sin(xy)cos(xy)"

f(x,y) = sin(x*y) * cos(x*y)

splot f(x,y) with pm3d title "z = sin(xy)cos(xy)"
pause 2






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
pause 2




reset

set parametric

set hidden3d

set pm3d interpolate 2,2

set urange [0.05 : pi - 0.05]  
set vrange [0 : 2*pi + 0.01]   

set xrange [-3 : 3]
set yrange [-3 : 3]
set zrange [-3 : 3]

set isosamples 80, 80

set title "Псевдосфера: x=sin(u)cos(v), y=sin(u)sin(v), z=ln(tan(u/2)) + cos(u)"

x(u,v) = sin(u) * cos(v)
y(u,v) = sin(u) * sin(v)
z(u,v) = log(tan(u/2.0)) + cos(u)

splot x(u,v), y(u,v), z(u,v) with pm3d title "Псевдосфера"
pause 2





reset

set parametric
set urange [0 : 6*pi] 
set samples 500
set size ratio 1
set title "Винтовая линия: x=cos(u), y=sin(u), z=u"

set xlabel "x"
set ylabel "y"
set zlabel "z"

set grid

set view 60, 30

splot cos(u), sin(u), u \
      with lines lw 2 lc rgb "blue" title "Винтовая линия"

pause 2







reset

set parametric
set urange [0 : 2*pi]
set samples 1000
set size ratio 1

set title "Обмотка тора: x=(10+3sin(15u))cos(u), y=(10+3sin(15u))sin(u), z=2cos(15u)"
set xlabel "x"
set ylabel "y"
set zlabel "z"

set grid

splot (10 + 3*sin(15*u)) * cos(u), \
      (10 + 3*sin(15*u)) * sin(u), \
      2 * cos(15*u) \
      with lines lw 2 lc rgb "red" title "Обмотка тора"
