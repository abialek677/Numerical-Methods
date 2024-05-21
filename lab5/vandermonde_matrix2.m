function V = vandermonde_matrix2(N)
    % Generuje macierz Vandermonde dla N punktów równomiernie rozmieszczonych w przedziale [0, 1]
    x = linspace(0, 1, N);
    V = zeros(N);
    for i = 1:N
        for j = 1:N
        V(i,j) = x(i) ^ (j-1);
        end
    end
end