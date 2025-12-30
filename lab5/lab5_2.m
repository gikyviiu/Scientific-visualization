more off 

# Функция потенциала для полукруглой нити
function z = phi(x, y) 
    R = 0.5;          
    M = 100;          
    theta = linspace(0, pi, M); # Углы от 0 до 180 градусов
    
    
    xq = R * cos(theta); 
    yq = R * sin(theta);
    dq = 1/M;         
    
    
    dist = sqrt((x - xq).^2 + (y - yq).^2) + 1e-9;
    z = sum(dq ./ dist); 
endfunction 

# Сетка
N = 80; 
xmin = -1; xmax = 1;
ymin = -1; ymax = 1;
hx = (xmax - xmin) / (N - 1);
hy = (ymax - ymin) / (N - 1);
x = linspace(xmin, xmax, N); 
y = linspace(ymin, ymax, N); 

A = zeros(N, N);
for i = 1:N 
    for j = 1:N 
        A(i,j) = phi(x(i), y(j)); 
    endfor 
endfor 


phi_min = min(A(:));
phi_max = max(A(:));

levels = linspace(phi_min * 1.1, 5, 12); 


FID = fopen('lab5_2.txt', 'wt'); 

for k = 1:length(levels)
    c_val = levels(k);
    cnt = 0;
    # Поиск точек вдоль Y
    for i = 1:N 
        for j = 1:N-1 
            if ((A(i,j)-c_val)*(A(i,j+1)-c_val) < 0) 
                yc = y(j) + (c_val-A(i,j))/(A(i,j+1)-A(i,j))*hy;
                fprintf(FID, '%g\t%g\t%g\n', x(i), yc, c_val);
                cnt++;
            endif 
        endfor 
    endfor 
    fprintf(FID, '\n');
    # Поиск точек вдоль X
    for j = 1:N 
        for i = 1:N-1 
            if ((A(i,j)-c_val)*(A(i+1,j)-c_val) < 0) 
                xc = x(i) + (c_val-A(i,j))/(A(i+1,j)-A(i,j))*hx;
                fprintf(FID, '%g\t%g\t%g\n', xc, y(j), c_val);
                cnt++;
            endif 
        endfor 
    endfor 
    fprintf(FID, '\n\n');
endfor 
fclose(FID);



content = fileread('lab5_2.txt');
printf("\n=== Содержимое файла ===\n");
printf("%s", content);



clf;
[cc, hh] = contour(x, y, A', levels, "linewidth", 1.5);
clabel(cc, hh);
hold on;
# Рисуем саму нить для наглядности
t = linspace(0, pi, 100);
plot(0.5*cos(t), 0.5*sin(t), 'r', 'LineWidth', 3);
title("Изолинии потенциала полукруглой нити");
axis square;
colorbar();