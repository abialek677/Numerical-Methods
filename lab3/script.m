% Define parameters
n = 10000;
a1 = 11;
a2 = -1;
a3 = -1;

% Create matrix A
A = zeros(n);
for i = 1:n
    A(i, i) = a1;
    if i < n
        A(i, i + 1) = a2;
        A(i + 1, i) = a2;
    end
    if i < n - 1
        A(i, i + 2) = a3;
        A(i + 2, i) = a3;
    end
end

% Display matrix A (optional)
disp('Matrix A:');
disp(A);

% Define function to generate vector b


% Generate vector b
f = 3;
b = generateB(n, f);

% Display vector b (optional)
disp('Vector b:');
disp(b);

[M, bm, x, err_norm_table, time, iterations, index_number] = solve_Gauss_Seidel_AB(A,b);

function b = generateB(n, f)
    b = zeros(n, 1);
    for i = 1:n
        b(i) = sin(i * (f + 1));
    end
end
