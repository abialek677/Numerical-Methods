function [A,b,M,bm,x,err_norm,time,iterations,index_number] = solve_Jacobi(N)
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

[A,b] = generate_matrix(N,L1);

U = triu(A,1);
L = tril(A,-1);
D = diag(A);
D = diag(D);

M = -D\(L+U);
bm = D\b;
x = ones(N,1);
iterations = -1;
err_norm = 1;

tic;
for i=1:1000
    iterations = i;
    x = M*x+bm;
    res = A*x-b;
    err_norm = norm(res);
    if err_norm < 1e-12
       break; 
    end
end
time = toc;
end



