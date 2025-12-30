clear all
close all
clc

function [Ex, Ey] = E_field_charges(x, y)
    % Пять одинаковых зарядов
    q_val = 1;
    q = [q_val, q_val, q_val, q_val, q_val];
    
    % Позиции в вершинах правильного пятиугольника (радиус = R_poly)
    R_poly = 1.0;  % радиус описанной окружности
    angles = 2 * pi * (0:4)' / 5;
    x0 = R_poly * cos(angles);
    y0 = R_poly * sin(angles);

    Ex = 0;
    Ey = 0;

    for i = 1:5
        r_vec_x = x - x0(i);
        r_vec_y = y - y0(i);

        r = sqrt(r_vec_x^2 + r_vec_y^2);

        if r < 1e-10
            r = 1e-10;
        end

        Ex = Ex + q(i) * r_vec_x / r^3;
        Ey = Ey + q(i) * r_vec_y / r^3;
    end
end

% Границы области
xmin = -3.0;
xmax = 3.0;
ymin = -3.0;
ymax = 3.0;

% Параметры пятиугольника
R_poly = 1.0;
angles = 2 * pi * (0:4)' / 5;
x0 = R_poly * cos(angles);
y0 = R_poly * sin(angles);
q = [1, 1, 1, 1, 1];  % все заряды равны

% Количество линий на каждый заряд
num_lines_per_charge = [8, 8, 8, 8, 8];  % можно сделать одинаковым для всех

% Параметры интегрирования
R0 = 0.05;            % начальное смещение от заряда
dl = 0.02;            % шаг интегрирования
max_steps = 2000;
Rmin_safe = 0.05;     % минимальное безопасное расстояние до любого заряда

% Открытие файла для записи
FID = fopen('lab7_1.txt', 'wt');
if FID == -1
    error('Не удалось открыть файл lab7_1.txt для записи');
end

% Генерация силовых линий
for i = 1:5
    num_lines = num_lines_per_charge(i);
    for j = 1:num_lines
        angle = 2 * pi * j / num_lines;
        x = x0(i) + R0 * cos(angle);
        y = y0(i) + R0 * sin(angle);

        cnt = 0;
        stop = false;

        while ~stop
            fprintf(FID, '%g\t%g\n', x, y);

            [Ex, Ey] = E_field_charges(x, y);
            E_mag = sqrt(Ex^2 + Ey^2);

            if E_mag < 1e-10
                stop = true;
                break;
            end

            dx = dl * Ex / E_mag;
            dy = dl * Ey / E_mag;

            x = x + dx;
            y = y + dy;
            cnt = cnt + 1;

            % Выход за границы области
            if x < xmin || x > xmax || y < ymin || y > ymax
                stop = true;
            end

            % Слишком близко к любому заряду
            for k = 1:5
                r_k = sqrt((x - x0(k))^2 + (y - y0(k))^2);
                if r_k < Rmin_safe
                    stop = true;
                    break;
                end
            end

            if cnt >= max_steps
                stop = true;
            end
        end

        fprintf(FID, '\n');  % пустая строка — разделитель между линиями
    end
end

fclose(FID);
fprintf('\n✓ Данные сохранены в файл: lab7_1.txt\n');