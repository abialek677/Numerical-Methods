function V = vandermonde_matrix(N)
    % Generuje macierz Vandermonde dla N równomiernie rozmieszczonych w przedziale [-1, 1] węzłów interpolacji
    x_coarse = linspace(-1,1,N);
    V = zeros(N);
    for i = 1:N
        for j = 1:N
        V(i,j) = x_coarse(i) ^ (j-1);
        end
    end
end