load('filtr_dielektryczny.mat');

[~,~,~,~,~, err_norm_jacobi,time_jacobi, iterations_jacobi,~] = solve_Jacobi_AB(A, b);
[~,~,~, err_norm_gauss_seidel,time_GS, iterations_gauss_seidel,~] = solve_Gauss_Seidel_AB(A, b);
tic;
x = A\b;
res = A*x-b;
error = norm(res);
time_basic = toc;

if iterations_jacobi > iterations_gauss_seidel
    bigger_iterations = iterations_jacobi;
else
    bigger_iterations = iterations_gauss_seidel;
end
    error_table = ones(bigger_iterations,1) * error;

subplot(2,1,1);
plot(1:bigger_iterations, error_table, 'LineWidth', 2, 'Color', 'blue');
hold on;
plot(1:iterations_jacobi, err_norm_jacobi(1:iterations_jacobi), 'LineWidth', 2, 'Color', 'red');
hold off;

xlabel('Iteracje');
ylabel('Norma błędu rezydualnego');
title('Metoda Jacobiego');
legend('Metoda bezpośrednia', 'Metoda Jacobiego', 'Location','northeastoutside');
grid on;

subplot(2,1,2);
plot(1:bigger_iterations, error_table, 'LineWidth', 2, 'Color', 'blue');
hold on;
plot(1:iterations_gauss_seidel, err_norm_gauss_seidel(1:iterations_gauss_seidel), 'LineWidth', 2, 'Color', 'green');
hold off;

xlabel('Iteracje');
ylabel('Norma błędu rezydualnego');
title('Metoda Gaussa-Siedla');
legend('Metoda bezpośrednia', 'Metoda Gaussa-Siedla', 'Location','northeastoutside');
grid on;

disp('Wyniki czasowe');
disp(['Metoda bezpośrednia: ' num2str(time_basic)]);
disp(['Metoda Jacobiego: ' num2str(time_jacobi)]);
disp(['Metoda Gaussa-Siedla: ' num2str(time_GS)]);





