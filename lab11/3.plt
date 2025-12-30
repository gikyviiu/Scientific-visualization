set encoding utf8

reset

# 1. Расчет координат пятиугольника
n = 5          # количество зарядов
q = 1.0        # заряд каждого объекта
R = 0.35       # радиус пятиугольника
cx = 0.5       # центр X
cy = 0.5       # центр Y
cz = 0.5       # центр Z

set print $my_charges
do for [i=0:n-1] {
    theta = 2.0 * pi * i / n
    x = cx + R * cos(theta)
    y = cy + R * sin(theta)
    print sprintf("%f %f %f %f", x, y, cz, q)
}
set print

# 2. Создание воксельной сетки
set vgrid $vgrid2 size 60
set vxrange [0:1]; set vyrange [0:1]; set vzrange [0:1]

# Функция потенциала
pot(r) = r > 0.01 ? 1.0/r : 100.0

# Заполнение сетки
vfill $my_charges using 1:2:3:(0.15):($4 * pot(VoxelDistance))

# 3. Настройки визуализации (Первый вариант: 4 уровня)
set xrange [0:1]; set yrange [0:1]; set zrange [0:1]
set xyplane at -0.1; set border 4095; unset key
set pm3d depthorder
set view 65, 40

# Цветовая схема
set palette defined (5 "blue", 10 "cyan", 15 "yellow", 20 "red")
set cbrange [5:20]

splot $vgrid2 with isosurface level 7  linecolor palette frac 0.2, \
      $vgrid2 with isosurface level 10 linecolor palette frac 0.4, \
      $vgrid2 with isosurface level 13 linecolor palette frac 0.6, \
      $vgrid2 with isosurface level 16 linecolor palette frac 0.8, \
      $my_charges using 1:2:3 with points pt 7 ps 1.5 lc rgb "black"

pause -1 "Показаны 4 уровня. Нажмите Enter для перехода к циклу"

# 4. Второй вариант: Множество прозрачных слоев в цикле
set style fill transparent solid 0.2
set isosurface noinsidecolor
set palette defined (5 "blue", 10 "cyan", 15 "yellow", 20 "red")
set cbrange [5:25]

splot for [phi=6:24:2] $vgrid2 with isosurface level phi linecolor palette cb phi, \
      $my_charges using 1:2:3 with points pt 7 ps 1.5 lc rgb "black"

pause -1 "Завершено."