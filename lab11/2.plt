set encoding utf8

reset

# 1. Математический расчет координат пятиугольника
n = 5          # количество зарядов
q = 1.0        # величина заряда
R = 0.35       # радиус (расстояние от центра до заряда)
cx = 0.5       # центр системы по X
cy = 0.5       # центр по Y
cz = 0.5       # центр по Z

set print $my_charges
do for [i=0:n-1] {
    # Угол в радианах для каждой вершины
    theta = 2.0 * pi * i / n
    x = cx + R * cos(theta)
    y = cy + R * sin(theta)
    print sprintf("%f %f %f %f", x, y, cz, q)
}
set print

# 2. Подготовка воксельной сетки
set vgrid $vgrid1 size 60
set vxrange [0:1]; set vyrange [0:1]; set vzrange [0:1]

# Функция потенциала с "мягким" ограничением в центре заряда
pot(r) = r > 0.02 ? 1.0/r : 50.0

# Заполнение сетки (суммирование потенциалов)
vfill $my_charges using 1:2:3:(0.1):($4 * pot(VoxelDistance))

# 3. Настройки отображения
set xrange [0:1]; set yrange [0:1]; set zrange [0:1]
set xyplane at -0.1
set border 4095
unset key
set view 65, 40

# Цветовая схема для потенциала
set palette defined (0 "blue", 5 "cyan", 10 "yellow", 15 "orange", 20 "red")
set cbrange [5:20]

# Настройка плоских срезов (как в вашем примере)
set urange [0:1]; set vrange [0:1]
set samples 60; set isosamples 60
set style fill transparent solid 0.5

# 4. Отрисовка горизонтальных срезов (эквипотенциальные плоскости)
splot for [j=3:7] "++" using 1:2:(j/10.):(voxel($1, $2, j/10.)) with pm3d, \
      $my_charges using 1:2:3 with points pt 7 ps 1.5 lc rgb "black"

pause -1 "Вид 1 (горизонтальные срезы). Нажмите Enter"

# 5. Отрисовка вертикальных срезов
set view 65, 120
splot for [j=3:7] "++" using (j/10.):1:2:(voxel(j/10., $1, $2)) with pm3d, \
      $my_charges using 1:2:3 with points pt 7 ps 1.5 lc rgb "black"

pause -1 "Вид 2 (вертикальные срезы). Конец."