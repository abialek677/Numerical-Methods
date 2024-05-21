function V = vandermonde_matrix_chebyshev(N, x_coarse)
    % Generuje macierz Vandermonde dla N równomiernie rozmieszczonych w przedziale [-1, 1] węzłów interpolacji
    V = zeros(N);
    for i = 1:N
        for j = 1:N
        V(i,j) = x_coarse(i) ^ (j-1);
        end
    end
end