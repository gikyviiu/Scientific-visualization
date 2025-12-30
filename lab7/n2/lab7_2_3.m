clear all
close all
clc

function z = phi(x, y)
    R_semi = 1.5;
    x_center = 0;
    y_center = 0;
    N_segments = 100;
    lambda = 1.0;

    z = 0;
    for i = 1:N_segments
        theta = pi * (i - 0.5) / N_segments;

        x0 = x_center + R_semi * cos(theta);
        y0 = y_center + R_semi * sin(theta);

        r = sqrt((x - x0)^2 + (y - y0)^2);
        if r < 1e-10
            r = 1e-10;
        end

        dq = lambda * R_semi * pi / N_segments;
        z = z + dq / r;
    end
end

N = 300;
xmin = -3.7;
xmax = 3.7;
ymin = -3.7;
ymax = 3.7;

hx = (xmax - xmin) / (N - 1);
hy = (ymax - ymin) / (N - 1);

x = linspace(xmin, xmax, N);
y = linspace(ymin, ymax, N);

A = zeros(N, N);
for i = 1:N
    for j = 1:N
        A(i, j) = phi(x(i), y(j));
    end
end

phi_min = min(min(A));
phi_max = max(max(A));
fprintf('phi_min = %g, phi_max = %g\n', phi_min, phi_max);

NL = 12;
hc = 0.5;

FID = fopen('lab7_2_equipotential.txt', 'wt');
if FID == -1
    error('Не удалось открыть файл lab7_2_equipotential.txt для записи');
end

for k = 1:NL
    c_k = -(NL-1)*hc/2 + (k-1)*hc;
    fprintf('Уровень %i: c = %g\n', k, c_k);

    cnt = 0;

    for i = 1:N-1
        for j = 1:N-1
            aij = A(i, j);
            bij = A(i, j+1);
            cij = A(i+1, j+1);
            dij = A(i+1, j);

            nq = 0;
            if (aij > c_k)
                nq = nq + 1;
            end
            if (bij > c_k)
                nq = nq + 8;
            end
            if (cij > c_k)
                nq = nq + 4;
            end
            if (dij > c_k)
                nq = nq + 2;
            end

            if nq == 1 || nq == 14
                t1 = (c_k - aij) / (bij - aij);
                x1 = x(i);
                y1 = y(j) + t1 * hy;

                t2 = (c_k - aij) / (dij - aij);
                x2 = x(i) + t2 * hx;
                y2 = y(j);

                fprintf(FID, '%g %g %g\n', x1, y1, c_k);
                fprintf(FID, '%g %g %g\n\n', x2, y2, c_k);
                cnt = cnt + 1;

            elseif nq == 2 || nq == 13
                t1 = (c_k - aij) / (dij - aij);
                x1 = x(i) + t1 * hx;
                y1 = y(j);

                t2 = (c_k - dij) / (cij - dij);
                x2 = x(i+1);
                y2 = y(j) + t2 * hy;

                fprintf(FID, '%g %g %g\n', x1, y1, c_k);
                fprintf(FID, '%g %g %g\n\n', x2, y2, c_k);
                cnt = cnt + 1;

            elseif nq == 3 || nq == 12
                t1 = (c_k - aij) / (bij - aij);
                x1 = x(i);
                y1 = y(j) + t1 * hy;

                t2 = (c_k - dij) / (cij - dij);
                x2 = x(i+1);
                y2 = y(j) + t2 * hy;

                fprintf(FID, '%g %g %g\n', x1, y1, c_k);
                fprintf(FID, '%g %g %g\n\n', x2, y2, c_k);
                cnt = cnt + 1;

            elseif nq == 4 || nq == 11
                t1 = (c_k - bij) / (cij - bij);
                x1 = x(i) + t1 * hx;
                y1 = y(j+1);

                t2 = (c_k - dij) / (cij - dij);
                x2 = x(i+1);
                y2 = y(j) + t2 * hy;

                fprintf(FID, '%g %g %g\n', x1, y1, c_k);
                fprintf(FID, '%g %g %g\n\n', x2, y2, c_k);
                cnt = cnt + 1;

            elseif nq == 5 || nq == 10
                center_value = (aij + bij + cij + dij) / 4;

                if center_value > c_k
                    t1 = (c_k - aij) / (bij - aij);
                    x1 = x(i);
                    y1 = y(j) + t1 * hy;

                    t2 = (c_k - dij) / (cij - dij);
                    x2 = x(i+1);
                    y2 = y(j) + t2 * hy;

                    fprintf(FID, '%g %g %g\n', x1, y1, c_k);
                    fprintf(FID, '%g %g %g\n\n', x2, y2, c_k);
                    cnt = cnt + 1;
                else
                    t1 = (c_k - aij) / (dij - aij);
                    x1 = x(i) + t1 * hx;
                    y1 = y(j);

                    t2 = (c_k - bij) / (cij - bij);
                    x2 = x(i) + t2 * hx;
                    y2 = y(j+1);

                    fprintf(FID, '%g %g %g\n', x1, y1, c_k);
                    fprintf(FID, '%g %g %g\n\n', x2, y2, c_k);
                    cnt = cnt + 1;
                end

            elseif nq == 6 || nq == 9
                t1 = (c_k - aij) / (dij - aij);
                x1 = x(i) + t1 * hx;
                y1 = y(j);

                t2 = (c_k - bij) / (cij - bij);
                x2 = x(i) + t2 * hx;
                y2 = y(j+1);

                fprintf(FID, '%g %g %g\n', x1, y1, c_k);
                fprintf(FID, '%g %g %g\n\n', x2, y2, c_k);
                cnt = cnt + 1;

            elseif nq == 7 || nq == 8
                t1 = (c_k - aij) / (bij - aij);
                x1 = x(i);
                y1 = y(j) + t1 * hy;

                t2 = (c_k - bij) / (cij - bij);
                x2 = x(i) + t2 * hx;
                y2 = y(j+1);

                fprintf(FID, '%g %g %g\n', x1, y1, c_k);
                fprintf(FID, '%g %g %g\n\n', x2, y2, c_k);
                cnt = cnt + 1;
            end
        end
    end

    fprintf('Уровень %i: найдено %i отрезков\n', k, cnt);

    if k ~= NL
        fprintf(FID, '\n');
    end
end

fclose(FID);
fprintf('\n✓ Эквипотенциали задания 2 сохранены в файл: lab7_2_equipotential.txt\n');
