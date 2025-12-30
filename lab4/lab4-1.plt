reset
phi(x,y) = log(sqrt(x**2+y**2))
splot phi(x,y)
pause -1 'Ok'
set contour both
replot
pause -1 'Ok'
set isosamples 100
replot
pause -1 'Ok'
unset surface
replot
pause -1 'Ok'
set view map
replot
pause -1 'Ok'
set key outside
set size square
replot
pause -1 'Ok'
set table "lab4.dat"
replot
unset table