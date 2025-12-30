reset
set encoding utf8

M = 1
phi(x,y) = -M * x / (2*pi * (x**2 + y**2))

set xrange [-5:5]
set yrange [-5:5]

set palette defined (-1 "black", 0 "red", 1 "yellow")
set cbrange [-0.3 : 0.3]  

set view map
set size square
set isosamples 200

unset key
set title "Цветовая карта потенциала диполя с эквипотенциалями"

splot phi(x,y) with pm3d, \
      "lab4-dipole.dat" with lines lc rgb "black" lw 1 notitle
