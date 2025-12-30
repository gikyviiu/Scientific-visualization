set encoding utf8

reset

# 1. Параметры системы
n = 5          # Количество зарядов
q = 1.0        # Величина каждого заряда
R = 0.4        # Радиус описанной окружности пятиугольника
cx = 0.5       # Центр по X
cy = 0.5       # Центр по Y
cz = 0.5       # Плоскость размещения зарядов

# 2. Генерация координат зарядов (правильный пятиугольник)
set print $my_charges
do for [i=0:n-1] {
    theta = 2.0 * pi * i / n
    x = cx + R * cos(theta)
    y = cy + R * sin(theta)
    print sprintf("%f %f %f %f", x, y, cz, q)
}
set print

# 3. Настройка воксельной сетки
set vgrid $vgrid1 size 50  # Увеличили разрешение для плавности
set vxrange [0:1]; set vyrange [0:1]; set vzrange [0:1]

# Функция потенциала (1/r)
pot(r) = r > 0.01 ? 1.0/r : 100.0

# Заполнение сетки: суммируем потенциал от каждого заряда
vfill $my_charges using 1:2:3:(0.1):($4 * pot(VoxelDistance))

# 4. Визуализация
set xrange [0:1]; set yrange [0:1]; set zrange [0:1]
set view 60, 30
set xyplane at 0
set border 4095
unset key

# Настройка цветовой схемы для изоповерхностей
set palette defined (0 "blue", 5 "cyan", 10 "yellow", 20 "red")
set cbrange [5:25]

# Отрисовка нескольких уровней потенциала (изоповерхностей)
set style data points
splot $vgrid1 with isosurface level 10.0 lc palette, \
      $vgrid1 with isosurface level 15.0 lc palette, \
      $my_charges using 1:2:3 with points pt 7 ps 2 lc rgb "black"

pause -1 "Нажмите Enter для выхода"