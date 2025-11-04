# lab3-4.plt — Сохранение каждой орбитали в отдельный файл (диапазон ±0.8)

reset
set encoding utf8

# Функции полиномов Лежандра
P0(x) = 1
P1(x) = x
P2(x) = (3*x**2 - 1)/2
P3(x) = (5*x**3 - 3*x)/2

# Функции сферических гармоник |Y_l(theta)|
Y0(theta) = sqrt(1/(4*pi)) * abs(P0(cos(theta)))
Y1(theta) = sqrt(3/(4*pi)) * abs(P1(cos(theta)))
Y2(theta) = sqrt(5/(4*pi)) * abs(P2(cos(theta)))
Y3(theta) = sqrt(7/(4*pi)) * abs(P3(cos(theta)))

# Общие настройки
set parametric
set hidden3d
set view equal xyz
unset key
set isosamples 51, 51
set tics 0.2

# Масштаб: теперь от -0.8 до 0.8
scale = 0.8

# -------------------------------
# s-орбиталь
# -------------------------------
set terminal pngcairo size 800, 600 enhanced font "Arial,12"
set output "s_orbital.png"

set multiplot title "s-орбиталь (l=0)" font ",16"

# 3D-график (диапазон ±0.8)
set size square 0.8, 0.8
set origin 0, 0
set title "3D"
set xrange [-scale:scale]
set yrange [-scale:scale]
set zrange [-scale:scale]
set xyplane at -0.8
splot [0:pi] [0:2*pi] Y0(u)*sin(u)*cos(v), \
              Y0(u)*sin(u)*sin(v), \
              Y0(u)*cos(u) with lines lc rgb "red" lw 2

# 2D-сечение в Oxz (диапазон ±0.8)
set size square 0.5, 0.5
set origin 0.55, 0.15
set title "Oxz"
plot [0:2*pi] Y0(t)*sin(t), Y0(t)*cos(t) with lines lc rgb "red" lw 2 \
     axes x1y1

unset multiplot
set output

# -------------------------------
# p-орбиталь
# -------------------------------
set output "p_orbital.png"

set multiplot title "p-орбиталь (l=1)" font ",16"

# 3D-график
set size square 0.8, 0.8
set origin 0, 0
set title "3D"
set xrange [-scale:scale]
set yrange [-scale:scale]
set zrange [-scale:scale]
set xyplane at -0.8
splot [0:pi] [0:2*pi] Y1(u)*sin(u)*cos(v), \
              Y1(u)*sin(u)*sin(v), \
              Y1(u)*cos(u) with lines lc rgb "blue" lw 2

# 2D-сечение
set size square 0.5, 0.5
set origin 0.55, 0.15
set title "Oxz"
plot [0:2*pi] Y1(t)*sin(t), Y1(t)*cos(t) with lines lc rgb "blue" lw 2 \
     axes x1y1

unset multiplot
set output

# -------------------------------
# d-орбиталь
# -------------------------------
set output "d_orbital.png"

set multiplot title "d-орбиталь (l=2)" font ",16"

# 3D-график
set size square 0.8, 0.8
set origin 0, 0
set title "3D"
set xrange [-scale:scale]
set yrange [-scale:scale]
set zrange [-scale:scale]
set xyplane at -0.8
splot [0:pi] [0:2*pi] Y2(u)*sin(u)*cos(v), \
              Y2(u)*sin(u)*sin(v), \
              Y2(u)*cos(u) with lines lc rgb "green" lw 2

# 2D-сечение
set size square 0.5, 0.5
set origin 0.55, 0.15
set title "Oxz"
plot [0:2*pi] Y2(t)*sin(t), Y2(t)*cos(t) with lines lc rgb "green" lw 2 \
     axes x1y1

unset multiplot
set output

# -------------------------------
# f-орбиталь
# -------------------------------
set output "f_orbital.png"

set multiplot title "f-орбиталь (l=3)" font ",16"

# 3D-график
set size square 0.8, 0.8
set origin 0, 0
set title "3D"
set xrange [-scale:scale]
set yrange [-scale:scale]
set zrange [-scale:scale]
set xyplane at -0.8
splot [0:pi] [0:2*pi] Y3(u)*sin(u)*cos(v), \
              Y3(u)*sin(u)*sin(v), \
              Y3(u)*cos(u) with lines lc rgb "magenta" lw 2

# 2D-сечение
set size square 0.5, 0.5
set origin 0.55, 0.15
set title "Oxz"
plot [0:2*pi] Y3(t)*sin(t), Y3(t)*cos(t) with lines lc rgb "magenta" lw 2 \
     axes x1y1

unset multiplot
set output

print "Готово! Файлы созданы:"
print "  s_orbital.png"
print "  p_orbital.png"
print "  d_orbital.png"
print "  f_orbital.png"