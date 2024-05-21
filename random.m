% Define matrix A and vector b
a1 = 9;
a2 = 1;
a3 = 1;
n = 10;
A = zeros(n);
A = A + diag(a1 * ones(n, 1));
for i = 1:n-1
    A(i, i+1) = a2;
    A(i+1, i) = a2;
end
for i = 1:n-2
    A(i, i+2) = a3;
    A(i+2, i) = a3;
end
b = sin((0:n-1) .* 4);

% Perform LU decomposition
[L, U] = lu(A);

% Display matrices L and U
disp('Lower triangular matrix L:');
disp(L);
disp('Upper triangular matrix U:');
disp(U);
