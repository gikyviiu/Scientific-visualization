set encoding utf8
reset
M = 1.0
Vx(x,y) = -M / (2 * pi) * (y**2 - x**2) / ((x**2 + y**2)**2)
Vy(x,y) =  2 * M / (2 * pi) * x * y / ((x**2 + y**2)**2)
Vm(x,y)  = sqrt( Vx(x,y)**2 + Vy(x,y)**2 )
Vnx(x,y) = Vx(x,y)/Vm(x,y)
Vny(x,y) = Vy(x,y)/Vm(x,y)

scale = 0.7

set xrange [-10:10]
set yrange [-10:10]
set urange [-10:10]
set vrange [-10:10]
set size square
set isosamples 11
set samples 11
set table "lab4-4-dipole.dat"
plot "++" using 1:2:(scale*Vnx($1,$2)):(scale*Vny($1,$2)) with vector notitle
unset table
set isosamples 100
set samples 100
set view map

set title "Поле скорости для диполя"
set palette rgbformulae 33,13,10
set cbrange [0:0.05]
splot Vm(x,y) with pm3d, \
      "lab4-4-dipole.dat" using 1:2:(0):3:4:(0) with vector notitle lt -1

pause -1
