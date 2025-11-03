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