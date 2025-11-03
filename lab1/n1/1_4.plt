reset
set polar
set trange [0 : 2*pi]
set samples 500

set title "8-лепестковая роза"
set grid polar
set size ratio -1

plot 3 * sin(4*t)**2 with lines lc "red" lw 2 title "ρ = 3·sin²(4φ)"