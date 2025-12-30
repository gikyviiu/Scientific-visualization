clear all
close all
clc

%% Параметры задачи
R_poly = 1.0;          % радиус описанной окружности пятиугольника
q_val = 1.0;           % величина каждого заряда
N = 300;               % разрешение сетки
xmin = -3.0; xmax = 3.0;
ymin = -3.0; ymax = 3.0;

%% Координаты 5 зарядов (правильный пятиугольник)
angles = 2 * pi * (0:4) / 5;
x0 = R_poly * cos(angles);
y0 = R_poly * sin(angles);
q = repmat(q_val, 1, 5);  % [1, 1, 1, 1, 1]

%% Функция потенциала phi(x, y)
function z = phi(x, y, x0, y0, q)
    z = 0;
    for i = 1:length(q)
        r = sqrt((x - x0(i))^2 + (y - y0(i))^2);
        if r < 1e-12
            r = 1e-12;
        end
        z = z + q(i) / r;
    end
end

%% Функция поля E(x, y) — для силовых линий
function [Ex, Ey] = E_field(x, y, x0, y0, q)
    Ex = 0; Ey = 0;
    for i = 1:length(q)
        dx = x - x0(i);
        dy = y - y0(i);
        r = sqrt(dx^2 + dy^2);
        if r < 1e-12
            r = 1e-12;
        end
        Ex = Ex + q(i) * dx / r^3;
        Ey = Ey + q(i) * dy / r^3;
    end
end

%% === Силовые линии ===

num_lines_per_charge = 8;
R0 = 0.05;             % стартовое смещение от заряда
dl = 0.02;             % шаг интегрирования
max_steps = 2000;
Rmin_safe = 0.05;      % минимальное расстояние до любого заряда

FID1 = fopen('sil.txt', 'wt');
if FID1 == -1
    error('Не удалось открыть sil.txt');
end

for i = 1:5
    for j = 1:num_lines_per_charge
        angle = 2 * pi * j / num_lines_per_charge;
        x = x0(i) + R0 * cos(angle);
        y = y0(i) + R0 * sin(angle);

        cnt = 0;
        stop = false;
        while ~stop
            fprintf(FID1, '%.10g\t%.10g\n', x, y);

            [Ex, Ey] = E_field(x, y, x0, y0, q);
            E_mag = sqrt(Ex^2 + Ey^2);
            if E_mag < 1e-10
                stop = true;
                break;
            end

            x = x + dl * Ex / E_mag;
            y = y + dl * Ey / E_mag;
            cnt = cnt + 1;

            % Проверки на выход из области / приближение к заряду
            if x < xmin || x > xmax || y < ymin || y > ymax
                stop = true;
            end
            for k = 1:5
                if sqrt((x - x0(k))^2 + (y - y0(k))^2) < Rmin_safe
                    stop = true;
                    break;
                end
            end

            if cnt >= max_steps
                stop = true;
            end
        end
        fprintf(FID1, '\n');  % разделитель между линиями
    end
end
fclose(FID1);
fprintf('Силовые линии сохранены в sil.txt\n');

%% === Эквипотенциальные линии ===

hx = (xmax - xmin) / (N - 1);
hy = (ymax - ymin) / (N - 1);
x = linspace(xmin, xmax, N);
y = linspace(ymin, ymax, N);

% Вычисление потенциала на сетке
A = zeros(N, N);
for i = 1:N
    for j = 1:N
        A(i, j) = phi(x(i), y(j), x0, y0, q);
    end
end

NL = 12;
c_levels = linspace(1.5, 8.0, NL);  

FID2 = fopen('eq.txt', 'wt');
if FID2 == -1
    error('Не удалось открыть eq.txt');
end

for k = 1:NL
    c_k = c_levels(k);
    cnt = 0;

    for i = 1:N-1
        for j = 1:N-1
            aij = A(i, j);
            bij = A(i, j+1);
            cij = A(i+1, j+1);
            dij = A(i+1, j);

            nq = 0;
            if aij > c_k, nq = nq + 1; end
            if bij > c_k, nq = nq + 8; end
            if cij > c_k, nq = nq + 4; end
            if dij > c_k, nq = nq + 2; end

            % Обработка конфигураций (marching squares)
            if nq == 1 || nq == 14
                t1 = (c_k - aij) / (bij - aij + 1e-15); x1 = x(i);               y1 = y(j) + t1 * hy;
                t2 = (c_k - aij) / (dij - aij + 1e-15); x2 = x(i) + t2 * hx;     y2 = y(j);
                fprintf(FID2, '%.10g %.10g\n%.10g %.10g\n\n', x1, y1, x2, y2); cnt = cnt + 1;

            elseif nq == 2 || nq == 13
                t1 = (c_k - aij) / (dij - aij + 1e-15); x1 = x(i) + t1 * hx;     y1 = y(j);
                t2 = (c_k - dij) / (cij - dij + 1e-15); x2 = x(i+1);             y2 = y(j) + t2 * hy;
                fprintf(FID2, '%.10g %.10g\n%.10g %.10g\n\n', x1, y1, x2, y2); cnt = cnt + 1;

            elseif nq == 3 || nq == 12
                t1 = (c_k - aij) / (bij - aij + 1e-15); x1 = x(i);               y1 = y(j) + t1 * hy;
                t2 = (c_k - dij) / (cij - dij + 1e-15); x2 = x(i+1);             y2 = y(j) + t2 * hy;
                fprintf(FID2, '%.10g %.10g\n%.10g %.10g\n\n', x1, y1, x2, y2); cnt = cnt + 1;

            elseif nq == 4 || nq == 11
                t1 = (c_k - bij) / (cij - bij + 1e-15); x1 = x(i) + t1 * hx;     y1 = y(j+1);
                t2 = (c_k - dij) / (cij - dij + 1e-15); x2 = x(i+1);             y2 = y(j) + t2 * hy;
                fprintf(FID2, '%.10g %.10g\n%.10g %.10g\n\n', x1, y1, x2, y2); cnt = cnt + 1;

            elseif nq == 5 || nq == 10
                center_val = (aij + bij + cij + dij) / 4;
                if center_val > c_k
                    t1 = (c_k - aij) / (bij - aij + 1e-15); x1 = x(i);               y1 = y(j) + t1 * hy;
                    t2 = (c_k - dij) / (cij - dij + 1e-15); x2 = x(i+1);             y2 = y(j) + t2 * hy;
                else
                    t1 = (c_k - aij) / (dij - aij + 1e-15); x1 = x(i) + t1 * hx;     y1 = y(j);
                    t2 = (c_k - bij) / (cij - bij + 1e-15); x2 = x(i) + t2 * hx;     y2 = y(j+1);
                end
                fprintf(FID2, '%.10g %.10g\n%.10g %.10g\n\n', x1, y1, x2, y2); cnt = cnt + 1;

            elseif nq == 6 || nq == 9
                t1 = (c_k - aij) / (dij - aij + 1e-15); x1 = x(i) + t1 * hx;     y1 = y(j);
                t2 = (c_k - bij) / (cij - bij + 1e-15); x2 = x(i) + t2 * hx;     y2 = y(j+1);
                fprintf(FID2, '%.10g %.10g\n%.10g %.10g\n\n', x1, y1, x2, y2); cnt = cnt + 1;

            elseif nq == 7 || nq == 8
                t1 = (c_k - aij) / (bij - aij + 1e-15); x1 = x(i);               y1 = y(j) + t1 * hy;
                t2 = (c_k - bij) / (cij - bij + 1e-15); x2 = x(i) + t2 * hx;     y2 = y(j+1);
                fprintf(FID2, '%.10g %.10g\n%.10g %.10g\n\n', x1, y1, x2, y2); cnt = cnt + 1;
            end
        end
    end
    fprintf('Уровень %2i (c = %5.2f): найдено %4i отрезков\n', k, c_k, cnt);
end

fclose(FID2);
fprintf('Эквипотенциали сохранены в eq.txt\n');