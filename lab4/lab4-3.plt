set encoding utf8
reset

M = 1.0
phi(x,y) = -M * x / (2 * pi * (x**2 + y**2))

Vx(x,y) = -M / (2 * pi) * (y**2 - x**2) / ( (x**2 + y**2)**2 )
Vy(x,y) = 2 * M / (2 * pi) * x * y / ( (x**2 + y**2)**2 )

Vm(x,y)  = sqrt( Vx(x,y)**2 + Vy(x,y)**2 )
Vnx(x,y) = Vx(x,y)/Vm(x,y)
Vny(x,y) = Vy(x,y)/Vm(x,y)

scale=0.7

set isosamples 11
set samples 11
set xrange [-10:10]
set yrange [-10:10]
set urange [-10:10]
set vrange [-10:10]
set title "Поле направлений для диполя"
set size square

plot "++" using 1:2:(scale*Vnx($1,$2)):(scale*Vny($1,$2)) \
     with vectors notitle lt -1, \
     "lab4-dipole.dat" with lines notitle lt 1

pause -1
