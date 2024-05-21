function [nodes_Chebyshev, V, V2, original_Runge, interpolated_Runge, interpolated_Runge_Chebyshev] = zadanie2()
% nodes_Chebyshev - wektor wierszowy zawierający N=16 węzłów Czebyszewa drugiego rodzaju
% V - macierz Vandermonde obliczona dla 16 węzłów interpolacji rozmieszczonych równomiernie w przedziale [-1,1]
% V2 - macierz Vandermonde obliczona dla węzłów interpolacji zdefiniowanych w wektorze nodes_Chebyshev
% original_Runge - wektor wierszowy zawierający wartości funkcji Runge dla wektora x_fine=linspace(-1, 1, 1000)
% interpolated_Runge - wektor wierszowy wartości funkcji interpolującej określonej dla równomiernie rozmieszczonych węzłów interpolacji
% interpolated_Runge_Chebyshev - wektor wierszowy wartości funkcji interpolującej wyznaczonej
%       przy zastosowaniu 16 węzłów Czebyszewa zawartych w nodes_Chebyshev 
    N = 16;
    x_fine = linspace(-1, 1, 1000);
    nodes_Chebyshev = get_Chebyshev_nodes(N);

    V = vandermonde_matrix(N);
    V2 = vandermonde_matrix_chebyshev(N, nodes_Chebyshev);
    original_Runge = 1./(1+25*(x_fine.^2));


    interpolation_nodes = linspace(-1,1,N);
    interpolation_nodes_values = 1./(1+25.*(interpolation_nodes.^2));
    c_runge = V \ interpolation_nodes_values.';
    interpolated_Runge = polyval(flipud(c_runge), x_fine);
    
    interpolation_nodes_values_chebyshev = 1./(1+25.*(nodes_Chebyshev.^2));
    c_runge_chebyshev = V2 \ interpolation_nodes_values_chebyshev.';
    interpolated_Runge_Chebyshev = polyval(flipud(c_runge_chebyshev), x_fine);


    


    subplot(2,1,1);
    plot(x_fine, original_Runge); %reference data
    hold on;
    plot(interpolation_nodes, interpolation_nodes_values, 'o'); % function value
    plot(x_fine, interpolated_Runge, Color='red');
    hold off;
    xlabel('x')
    ylabel('y')
    title('Interpolation - uniform nodes')
    legend('Original Runge', 'Interpolation nodes', 'Interpolated Runge', 'Location','bestoutside')
    

    subplot(2, 1, 2);
    plot(x_fine, original_Runge); %reference data
    hold on;
    plot(nodes_Chebyshev, interpolation_nodes_values_chebyshev, 'o'); % function value
    plot(x_fine, interpolated_Runge_Chebyshev, Color='red');
    hold off;
    xlabel('x')
    ylabel('y')
    title('Interpolation - Chebyshev nodes')
    legend('Original Runge', 'Chebyshev nodes', 'Interpolated Runge', 'Location','bestoutside')
end
