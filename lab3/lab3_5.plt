# lab3-5.plt — Зависимость атмосферного давления от высоты (формат SVG)

reset
set encoding utf8

# Физические константы
p0 = 1        # давление на поверхности (нормируем к 1)
mu = 0.029    # молярная масса воздуха, кг/моль
g = 9.81      # ускорение свободного падения, м/с²
R = 8.31      # универсальная газовая постоянная, Дж/(моль·К)

# Функция барометрической формулы
p(z, T) = p0 * exp(- mu * g * (z * 1000) / (R * T))

# Настройки графика
set title "Зависимость атмосферного давления от высоты"
set xlabel "z, км"
set ylabel "p/p₀"

set xrange [0:100]          # высота от 0 до 100 км
set logscale y              # логарифмическая шкала по Y
set format y "10^{%L}"      # красивый формат для логарифма

set key top right           # легенда в правом верхнем углу
set grid                    # сетка

# Настройка терминала SVG
set terminal svg enhanced mouse standalone size 800,600 font "Arial,12"
set output "barometric.svg"

# Построение графиков для трёх температур
plot p(x, 200) lw 2 lc rgb "red"   t "T=200 K", \
     p(x, 300) lw 2 lc rgb "green" t "T=300 K", \
     p(x, 400) lw 2 lc rgb "blue"  t "T=400 K"

set output
pause -1 "Файл barometric.svg создан"