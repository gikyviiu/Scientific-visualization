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

