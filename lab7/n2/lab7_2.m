clear all
close all
clc
function [Ex, Ey] = E_field_semicircle(x, y)
    R_semi = 1.5;
    x_center = 0;
    y_center = 0;
    N_segments = 100;
    lambda = 1.0;

    Ex = 0;
    Ey = 0;

    for i = 1:N_segments
        theta = pi * (i - 0.5) / N_segments;

        x0 = x_center + R_semi * cos(theta);
        y0 = y_center + R_semi * sin(theta);

        r_vec_x = x - x0;
        r_vec_y = y - y0;

        r = sqrt(r_vec_x^2 + r_vec_y^2);

        if r < 1e-10
            r = 1e-10;
        end

        dq = lambda * R_semi * pi / N_segments;

        Ex = Ex + dq * r_vec_x / r^3;
        Ey = Ey + dq * r_vec_y / r^3;
    end
end

xmin = -3.7;
xmax = 3.7;
ymin = -3.7;
ymax = 3.7;

R_semi = 1.5;
num_lines_semi = 16;
R0_semi = 0.1;
dl = 0.02;
max_steps = 2000;

FID = fopen('lab7_task2.txt', 'wt');
if FID == -1
    error('Не удалось открыть файл lab7_2.txt для записи');
end

for direction = 1:2
    for j = 1:num_lines_semi
        theta_start = pi * j / (num_lines_semi + 1);

        if direction == 1
            x = (R_semi + R0_semi) * cos(theta_start);
            y = (R_semi + R0_semi) * sin(theta_start);
        else
            x = (R_semi - R0_semi) * cos(theta_start);
            y = (R_semi - R0_semi) * sin(theta_start);
        end

        cnt = 0;
        stop = false;

        while ~stop
            fprintf(FID, '%g\t%g\n', x, y);

            [Ex, Ey] = E_field_semicircle(x, y);
            E_mag = sqrt(Ex^2 + Ey^2);

            if E_mag < 1e-10
                stop = true;
                break;
            end

            if direction == 2
                dx = -dl * Ex / E_mag;
                dy = -dl * Ey / E_mag;
            else
                dx = dl * Ex / E_mag;
                dy = dl * Ey / E_mag;
            end

            x = x + dx;
            y = y + dy;
            cnt = cnt + 1;

            if x < xmin || x > xmax || y < ymin || y > ymax
                stop = true;
            end

            r_to_center = sqrt(x^2 + y^2);
            if abs(r_to_center - R_semi) < 0.02 && y > 0
                stop = true;
            end

            if cnt >= max_steps
                stop = true;
            end
        end

        fprintf(FID, '\n');
    end
end

fclose(FID);
fprintf('\n✓ Данные задания 2 сохранены в файл: lab7_2.txt\n');
