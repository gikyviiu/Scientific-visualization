reset
set encoding utf8
set parametric
unset key
set size square
set xrange [-1.5:1.5]
set yrange [-1.5:1.5]
set xlabel "x(t)"
set ylabel "y(t)"
set title "Фигуры Лиссажу"

A1 = 1.0   # амплитуда по x
A2 = 1.0   # амплитуда по y
omega1 = 1 # частота по x
omega2 = 2 # частота по y
phi2 = 0   # фаза по y (фиксирована)

N = 50     # всего кадров
dphi = 2*pi/N

set terminal gif animate delay 50 size 600,600
set output "lissagu.gif"

do for [k=0:N-1] {
    phi1 = k * dphi
    set title sprintf("φ₁ = %.2f rad, φ₂ = 0", phi1)
    plot A1*sin(omega1*t + phi1) , A2*sin(omega2*t + phi2) lw 2 lc rgb "blue" \
         with lines title sprintf("φ₁ - φ₂ = %.2f", phi1 - phi2)
}

set output
pause -1 