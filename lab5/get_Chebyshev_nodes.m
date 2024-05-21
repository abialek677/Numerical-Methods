function nodes = get_Chebyshev_nodes(N)
    % oblicza N węzłów Czebyszewa drugiego rodzaju
    nodes = zeros(1,N);
    for i = 1:N
        nodes(i) = cos((i-1)*pi/(N-1));
    end
end