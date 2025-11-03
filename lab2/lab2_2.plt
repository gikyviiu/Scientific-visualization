reset

$data << EOD
1   0.55
2   0.70
3   0.77
4   0.82
5   0.85
EOD

y(x) = a*x + b

a = 0.1
b = 0.5

fit y(x) $data via a, b

str = sprintf("y(x) = %.2fx + %.2f", a, b)


set key outside right top
set xlabel "x"
set ylabel "y"
set xrange [0:6]
set yrange [0:1.2]

plot \
    $data using 1:2:(0.1):(0.05*$2) with xyerrorbars lt rgb "purple" pt 7 ps 1.5 title "эксперимент", \
    $data using 1:2 smooth csplines lt rgb "green" lw 2 title "кубический сплайн", \
    y(x) with lines lt rgb "blue" lw 2 title str


print "Сумма квадратов отклонений (FIT_WSSR): ", FIT_WSSR
print "Параметры: a =", a, ", b =", b


pause -1