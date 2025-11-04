reset 
set encoding utf8 

set terminal pdfcairo enhanced font "Times New Roman,12" 
set output "pdfcairo.pdf" 

set label 1 "φ(x) = e^{-x^2/2} / √2π" at 1.2, 0.25 
set label 2 "Φ(x) = ∫@_{-∞}^x &{i} φ(t) dt" at 1.2, 0.8 

set key top left title "{/:Bold Легенда}" 
set xtics ( "-π/2" -pi/2, "0" 0, "π/2" pi/2 )  

plot [-3:3] exp(-0.5*x**2) /sqrt(2*pi) t "{/:Normal φ(x)}", norm(x) t "Φ(x)" 

set output 



set terminal epscairo enhanced font "Times New Roman,12"
set output "epscario.eps"

set label 1 "φ(x) = e^{-x²/2} / √2π" at 1.2, 0.25
set label 2 "Φ(x) = ∫_{-∞}^x φ(t) dt" at 1.2, 0.8

set key top left title "{/:Bold Легенда}"
set xtics ("-π/2" -pi/2, "0" 0, "π/2" pi/2)

plot [-3:3] exp(-0.5*x**2)/sqrt(2*pi) t "{/:Normal φ(x)}", norm(x) t "Φ(x)"

set output