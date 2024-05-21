function plot_problem_5(N,time_Jacobi,time_Gauss_Seidel,iterations_Jacobi,iterations_Gauss_Seidel)
% Opis wektorów stanowiących parametry wejściowe:
% N - rozmiary analizowanych macierzy
% time_Jacobi - czasy wyznaczenia rozwiązania metodą Jacobiego
% time_Gauss_Seidel - czasy wyznaczenia rozwiązania metodą Gaussa-Seidla
% iterations_Jacobi - liczba iteracji wymagana do wyznaczenia rozwiązania metodą Jacobiego
% iterations_Gauss_Seide - liczba iteracji wymagana do wyznaczenia rozwiązania metodą Gauss-Seidla


subplot(2,1,1);
plot(N,time_Jacobi);
hold on;
plot(N, time_Gauss_Seidel);
hold off;
xlabel('Rozmiar macierzy');
ylabel('Czas wyznaczania rozwiązania');
title('Czas wyznaczania rozwiazania rownania macierzowego w zaleznosci od rozmiaru macierzy: Jacobi/Gauss-Siedel');
legend('Jacobi', 'Gauss-Siedel', 'Location', 'eastoutside');


subplot(2,1,2);
transposed_J = iterations_Jacobi';
transposed_GS = iterations_Gauss_Seidel';
bar_data = [transposed_J, transposed_GS];
bar(N, bar_data);
xlabel('Rozmiar macierzy');
ylabel('Liczba iteracji wyznaczania rozwiązania');
title('Iteracje wyznaczania rozwiazania rownania macierzowego w zaleznosci od rozmiaru macierzy: Jacobi/Gauss-Siedel');
legend('Jacobi', 'Gauss-Siedel', 'Location', 'eastoutside');
%print -dpng zadanie5.png

end
