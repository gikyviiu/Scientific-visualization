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


