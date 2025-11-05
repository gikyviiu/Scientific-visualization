more off

function z = phi(x, y)
    % Пять одинаковых положительных зарядов
    q = ones(1, 5);
    
    % Позиции зарядов: вершины правильного пятиугольника радиуса R = 0.5
    R = 0.5;
    theta = 2 * pi * (0:4) / 5;  % 0, 72°, 144°, 216°, 288°
    x0 = R * cos(theta);
    y0 = R * sin(theta);
    
    % Регуляризация: предотвращаем деление на ноль
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

% Вычисление потенциала в узлах сетки
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

% Уровни потенциала 
NL = 7;
c_min = max(phi_min * 1.2, 4.0);  
c_max = phi_max * 0.85;
c = linspace(c_min, c_max, NL);

filename = 'lab5_variant8.txt';
FID = fopen(filename, 'wt');
if (FID == -1)
    error("Ошибка: не удалось создать файл %s", filename);
endif

% Поиск точек пересечения уровней
for k = 1:NL
    level = c(k);
    printf('Уровень %i: c = %g\n', k, level);
    cnt = 0;

    %  Пересечения вдоль вертикальных линий (постоянный x)
    for i = 1:N
        for j = 1:N-1
            v1 = A(i, j) - level;
            v2 = A(i, j+1) - level;
            if (v1 * v2 < 0)  % есть пересечение
                t = v1 / (v1 - v2);  % интерполяция
                yc = y(j) + t * (y(j+1) - y(j));
                fprintf(FID, '%.6g\t%.6g\t%.6g\n', x(i), yc, level);
                cnt++;
            endif
        endfor
    endfor
    fprintf(FID, '\n');

    % Пересечения вдоль горизонтальных линий (постоянный y)
    for j = 1:N
        for i = 1:N-1
            v1 = A(i, j) - level;
            v2 = A(i+1, j) - level;
            if (v1 * v2 < 0)
                t = v1 / (v1 - v2);
                xc = x(i) + t * (x(i+1) - x(i));
                fprintf(FID, '%.6g\t%.6g\t%.6g\n', xc, y(j), level);
                cnt++;
            endif
        endfor
    endfor

    printf('  -> найдено %i точек\n', cnt);
    if (k < NL)
        fprintf(FID, '\n\n');
    endif
endfor

fclose(FID);
printf("\nФайл '%s' успешно создан.\n", filename);

content = fileread(filename);
printf("\n=== Содержимое файла ===\n");
printf("%s", content);

printf("\nПостроение контурного графика\n");
clf;
colormap("jet");
[CC, HH] = contour(x, y, A', c, "linewidth", 1.8);
clabel(CC, HH, c, "fontsize", 10, "fontweight", "bold");
title("Эквипотенциали: 5 зарядов в вершинах правильного пятиугольника", "fontsize", 12);
xlabel("x"); ylabel("y");
axis("equal");
grid on;
colorbar();