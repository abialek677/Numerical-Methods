function [A,b,M,bm,x,err_norm_table,time,iterations,index_number] = solve_Jacobi_AB(A,b)
% A - macierz z równania macierzowego A * x = b
% b - wektor prawej strony równania macierzowego A * x = b
% M - macierz pomocnicza opisana w instrukcji do Laboratorium 3
% bm - wektor pomocniczy opisany w instrukcji do Laboratorium 3
% x - rozwiązanie równania macierzowego
% err_norm - norma błędu rezydualnego rozwiązania x; err_norm = norm(A*x-b)
% time - czas wyznaczenia rozwiązania x
% iterations - liczba iteracji wykonana w procesie iteracyjnym metody Jacobiego
% index_number - Twój numer indeksu
index_number = 193677;
L1 = 7;


U = triu(A,1);
L = tril(A,-1);
D = diag(A);
D = diag(D);

M = -D\(L+U);
bm = D\b;
x = ones(size(A,1),1);
iterations = -1;
%err_norm = 1;
err_norm_table = zeros(1000,1);
tic;
for i=1:1000
    iterations = i;
    x = M*x+bm;
    res = A*x-b;
    err_norm = norm(res);
    err_norm_table(i) = err_norm;
    if err_norm < 1e-12
       break; 
    end
end
time = toc;
end