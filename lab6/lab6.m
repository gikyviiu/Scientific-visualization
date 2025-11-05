more off

function z = phi(x, y)
    q = ones(1, 5);  
    R = 0.5;
    theta = 2 * pi * (0:4) / 5; 
    x0 = R * cos(theta);
    y0 = R * sin(theta);
    eps_reg = 0.05;  
    r_sq = (x - x0).^2 + (y - y0).^2 + eps_reg^2;
    z = sum(q ./ sqrt(r_sq));
endfunction

% Параметры сетки
N = 100;
xmin = -1; xmax = 1;
ymin = -1; ymax = 1;
x = linspace(xmin, xmax, N);
y = linspace(ymin, ymax, N);

% Вычисление потенциала
A = zeros(N, N);
for i = 1:N
    for j = 1:N
        A(i, j) = phi(x(i), y(j));
    endfor
endfor

% Диапазон потенциала
phi_min = min(min(A));
phi_max = max(max(A));
printf("Потенциал: от %g до %g\n", phi_min, phi_max);


NL = 7;
c = linspace(phi_min + 0.1*(phi_max - phi_min), phi_max - 0.1*(phi_max - phi_min), NL);


filename = 'lab6.txt';
FID = fopen(filename, 'wt');
if FID == -1
    error("Не удалось создать файл %s", filename);
endif

% Основной цикл по уровням
for k = 1:NL
    level = c(k);
    printf('Уровень %i: c = %g\n', k, level);
    cnt = 0;

    % Обход всех ячеек
    for i = 1:N-1
        for j = 1:N-1
            % Значения потенциала в углах ячейки 
            a = A(i, j);       
            b = A(i, j+1);     
            c_val = A(i+1, j+1); 
            d = A(i+1, j);     

            % Кодируем, какие углы выше уровня
            nq = 0;
            if (a > level) nq += 1; endif  % 0001
            if (b > level) nq += 8; endif  % 1000
            if (c_val > level) nq += 4; endif  % 0100
            if (d > level) nq += 2; endif  % 0010

            
            switch (nq)
                case {1, 14}
                    % Линия проходит через левую и нижнюю стороны
                    x1 = x(i);
                    y1 = (y(j) + y(j+1)) / 2;
                    x2 = (x(i) + x(i+1)) / 2;
                    y2 = y(j);
                    fprintf(FID, '%.6g %.6g %.6g\n%.6g %.6g %.6g\n\n', x1, y1, level, x2, y2, level);
                    cnt++;
                case {2, 13}
                    % Через нижнюю и правую
                    x1 = (x(i) + x(i+1)) / 2;
                    y1 = y(j);
                    x2 = x(i+1);
                    y2 = (y(j) + y(j+1)) / 2;
                    fprintf(FID, '%.6g %.6g %.6g\n%.6g %.6g %.6g\n\n', x1, y1, level, x2, y2, level);
                    cnt++;
                case {3, 12}
                    % Через левую и правую
                    x1 = x(i);
                    y1 = (y(j) + y(j+1)) / 2;
                    x2 = x(i+1);
                    y2 = (y(j) + y(j+1)) / 2;
                    fprintf(FID, '%.6g %.6g %.6g\n%.6g %.6g %.6g\n\n', x1, y1, level, x2, y2, level);
                    cnt++;
                case {4, 11}
                    % Через правую и верхнюю
                    x1 = x(i+1);
                    y1 = (y(j) + y(j+1)) / 2;
                    x2 = (x(i) + x(i+1)) / 2;
                    y2 = y(j+1);
                    fprintf(FID, '%.6g %.6g %.6g\n%.6g %.6g %.6g\n\n', x1, y1, level, x2, y2, level);
                    cnt++;
                case {5, 10}
                    ;
                case {6, 9}
                    % Через нижнюю и верхнюю
                    x1 = (x(i) + x(i+1)) / 2;
                    y1 = y(j);
                    x2 = (x(i) + x(i+1)) / 2;
                    y2 = y(j+1);
                    fprintf(FID, '%.6g %.6g %.6g\n%.6g %.6g %.6g\n\n', x1, y1, level, x2, y2, level);
                    cnt++;
                case {7, 8}
                    % Через левую и верхнюю
                    x1 = x(i);
                    y1 = (y(j) + y(j+1)) / 2;
                    x2 = (x(i) + x(i+1)) / 2;
                    y2 = y(j+1);
                    fprintf(FID, '%.6g %.6g %.6g\n%.6g %.6g %.6g\n\n', x1, y1, level, x2, y2, level);
                    cnt++;
                otherwise
                    ;
            endswitch
        endfor
    endfor

    printf('  -> найдено %i отрезков\n', cnt);

    if (k < NL)
        fprintf(FID, '\n');
    endif
endfor

fclose(FID);


 clf;
 [CC, HH] = contour(x, y, A', c, "linewidth", 1.5);
 clabel(CC, HH, "fontsize", 9);
 title("Контрольный график (Octave)", "fontsize", 11);
 axis equal; grid on;