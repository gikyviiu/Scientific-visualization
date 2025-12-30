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
            % Значения потенциала в углах ячейки:
            % b (i, j+1) --- c_val (i+1, j+1)
            %     |               |
            % a (i, j)   --- d (i+1, j)
            
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

            % Вспомогательные переменные шагов сетки для краткости
            dx = x(i+1) - x(i);
            dy = y(j+1) - y(j);

            switch (nq)
                case {1, 14}
                    % Левая сторона (между a и b) и Нижняя сторона (между a и d)
                    x1 = x(i);
                    y1 = y(j) + dy * (level - a) / (b - a);
                    
                    x2 = x(i) + dx * (level - a) / (d - a);
                    y2 = y(j);
                    
                    fprintf(FID, '%.6g %.6g %.6g\n%.6g %.6g %.6g\n\n', x1, y1, level, x2, y2, level);
                    cnt++;
                    
                case {2, 13}
                    % Нижняя сторона (между a и d) и Правая сторона (между d и c_val)
                    x1 = x(i) + dx * (level - a) / (d - a);
                    y1 = y(j);
                    
                    x2 = x(i+1);
                    y2 = y(j) + dy * (level - d) / (c_val - d);
                    
                    fprintf(FID, '%.6g %.6g %.6g\n%.6g %.6g %.6g\n\n', x1, y1, level, x2, y2, level);
                    cnt++;
                    
                case {3, 12}
                    % Левая сторона (между a и b) и Правая сторона (между d и c_val)
                    x1 = x(i);
                    y1 = y(j) + dy * (level - a) / (b - a);
                    
                    x2 = x(i+1);
                    y2 = y(j) + dy * (level - d) / (c_val - d);
                    
                    fprintf(FID, '%.6g %.6g %.6g\n%.6g %.6g %.6g\n\n', x1, y1, level, x2, y2, level);
                    cnt++;
                    
                case {4, 11}
                    % Правая сторона (между d и c_val) и Верхняя сторона (между b и c_val)
                    x1 = x(i+1);
                    y1 = y(j) + dy * (level - d) / (c_val - d);
                    
                    x2 = x(i) + dx * (level - b) / (c_val - b);
                    y2 = y(j+1);
                    
                    fprintf(FID, '%.6g %.6g %.6g\n%.6g %.6g %.6g\n\n', x1, y1, level, x2, y2, level);
                    cnt++;
                    
                case {5, 10}
                    % Седловая точка (обычно требует уточнения, оставляем пропуск как в оригинале)
                    ;
                    
                case {6, 9}
                    % Нижняя сторона (между a и d) и Верхняя сторона (между b и c_val)
                    x1 = x(i) + dx * (level - a) / (d - a);
                    y1 = y(j);
                    
                    x2 = x(i) + dx * (level - b) / (c_val - b);
                    y2 = y(j+1);
                    
                    fprintf(FID, '%.6g %.6g %.6g\n%.6g %.6g %.6g\n\n', x1, y1, level, x2, y2, level);
                    cnt++;
                    
                case {7, 8}
                    % Левая сторона (между a и b) и Верхняя сторона (между b и c_val)
                    x1 = x(i);
                    y1 = y(j) + dy * (level - a) / (b - a);
                    
                    x2 = x(i) + dx * (level - b) / (c_val - b);
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



content = fileread('lab6.txt');
printf("\n=== Содержимое файла ===\n");
printf("%s", content);

% Отрисовка для проверки (опционально)
clf;
[CC, HH] = contour(x, y, A', c, "linewidth", 1.5);
clabel(CC, HH, "fontsize", 9);
title("Контрольный график (Octave)", "fontsize", 11);
axis equal; grid on;