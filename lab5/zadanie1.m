function [V, original_Runge, original_sine, interpolated_Runge, interpolated_sine] = zadanie1()
% Rozmiar tablic komórkowych (cell arrays) V, interpolated_Runge, interpolated_sine: [1,4].
% V{i} zawiera macierz Vandermonde wyznaczoną dla liczby węzłów interpolacji równej N(i)
% original_Runge - wektor wierszowy zawierający wartości funkcji Runge dla wektora x_fine=linspace(-1, 1, 1000)
% original_sine - wektor wierszowy zawierający wartości funkcji sinus dla wektora x_fine
% interpolated_Runge{i} stanowi wierszowy wektor wartości funkcji interpolującej 
%       wyznaczonej dla funkcji Runge (wielomian stopnia N(i)-1) w punktach x_fine
% interpolated_sine{i} stanowi wierszowy wektor wartości funkcji interpolującej
%       wyznaczonej dla funkcji sinus (wielomian stopnia N(i)-1) w punktach x_fine
    N = 4:4:16;
    x_fine = linspace(-1, 1, 1000);
    original_Runge = 1./(1+25*(x_fine.^2));


    subplot(2,1,1);

    plot(x_fine, original_Runge);
    hold on;
    labels = strings(1,length(N)+1);
    labels(1) = 'Original';
    for i = 1:length(N)
        V{i} = vandermonde_matrix(N(i));% macierz Vandermonde
        interpolation = linspace(-1,1,N(i)); % węzły interpolacji
        vector = 1./(1+25.*(interpolation.^2)); % wartości funkcji interpolowanej w węzłach interpolacji
        c_runge = V{i} \ vector.'; % współczynniki wielomianu interpolującego
        interpolated_Runge{i} = polyval(flipud(c_runge), x_fine); % interpolacja
        plot(x_fine, interpolated_Runge{i});
        labels(i+1) = ['N = ', num2str(N(i))];
    end
    legend(labels, 'Location','northeastoutside');
    title('Interpolated Runge');
    xlabel('x');
    ylabel('value');
    hold off

    original_sine = sin(2 * pi * x_fine);
    subplot(2,1,2);
    

    plot(x_fine, original_sine);
    hold on;

    for i = 1:length(N)
        interpolation = linspace(-1,1,N(i));
        vector = sin(2*pi*interpolation);
        c_runge = V{i} \ vector.';
        interpolated_sine{i} = polyval(flipud(c_runge), x_fine);
        plot(x_fine, interpolated_sine{i});
    end
    legend(labels, 'Location', 'northeastoutside')
    title('Intetrpolated sine');
    xlabel('x');
    ylabel('value');
    hold off
end