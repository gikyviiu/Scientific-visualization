reset
set multiplot layout 3,1 title "График ln(1 + cos(x))"

    set title "x ∈ [0; 10]"
    set xrange [0:10]
    #set yrange [-1:0.5]
    plot log(1 + cos(x)) with lines lc "red" lw 2 title "ln(1 + cos(x))"

    set title "x ∈ [0; 100]"
    set xrange [0:100]
    #set yrange [-1:0.5]
    plot log(1 + cos(x)) with lines lc "blue" lw 2 title "ln(1 + cos(x))"

    set title "x ∈ [0; 1000]"
    set xrange [0:1000]
    #set yrange [-1:0.5]
    plot log(1 + cos(x)) with lines lc "green" lw 2 title "ln(1 + cos(x))"

unset multiplot