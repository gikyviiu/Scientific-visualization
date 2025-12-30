reset
set encoding utf8

M = 1
phi(x,y) = -M * x / (2*pi * (x**2 + y**2))

set xrange [-5:5]
set yrange [-5:5]

set contour base
unset surface
set view map
set size square
set isosamples 200

set cntrparam levels discrete -0.5, -0.2, -0.1, -0.05, 0.05, 0.1, 0.2, 0.5

set table "lab4-dipole.dat"
splot phi(x,y)
unset table

unset key
set title "Эквипотенциали диполя"
plot "lab4-dipole.dat" with lines lw 1 lc rgb "red"

pause -1 "lab4-dipole.dat создан."