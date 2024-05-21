function [country, source, degrees, x_coarse, x_fine, y_original, y_yearly, y_approximation, mse, msek] = zadanie5(energy)
% Głównym celem tej funkcji jest wyznaczenie danych na potrzeby analizy dokładności aproksymacji cosinusowej.
% 
% energy - struktura danych wczytana z pliku energy.mat
% country - [String] nazwa kraju
% source  - [String] źródło energii
% x_coarse - wartości x danych aproksymowanych
% x_fine - wartości, w których wyznaczone zostaną wartości funkcji aproksymującej
% y_original - dane wejściowe, czyli pomiary produkcji energii zawarte w wektorze energy.(country).(source).EnergyProduction
% y_yearly - wektor danych rocznych
% y_approximation - tablica komórkowa przechowująca wartości nmax funkcji aproksymujących dane roczne.
%   - nmax = length(y_yearly)-1
%   - y_approximation{i} stanowi aproksymację stopnia i
%   - y_approximation{i} stanowi wartości funkcji aproksymującej w punktach x_fine
% mse - wektor mający nmax wierszy: mse(i) zawiera wartość błędu średniokwadratowego obliczonego dla aproksymacji stopnia i.
%   - mse liczony jest dla aproksymacji wyznaczonej dla wektora x_coarse
% msek - wektor mający nmax wierszy: msek zawiera wartości błędów różnicowych zdefiniowanych w treści zadania 5
%   - msek(i) porównuj aproksymacje wyznaczone dla i-tego oraz (i+1) stopnia wielomianu
%   - msek liczony jest dla aproksymacji wyznaczonych dla wektora x_fine

country = 'Poland';
source = 'Solar';
degrees = [1, 2, 4, 8];
x_coarse = [];
x_fine = [];
y_original = [];
y_yearly = [];
y_approximation = {};
mse = [];
msek = [];

% Sprawdzenie dostępności danych
if isfield(energy, country) && isfield(energy.(country), source)
    % Przygotowanie danych do aproksymacji
    dates = energy.(country).(source).Dates;
    y_original = energy.(country).(source).EnergyProduction;
    y_original_mean = movmean(y_original,[11,0]);

    % Obliczenie danych rocznych
    n_years = floor(length(y_original) / 12);
    y_cut = y_original(end-12*n_years+1:end);
    y4sum = reshape(y_cut, [12 n_years]);
    y_yearly = sum(y4sum,1)';

    % degrees = 

    % Przygotowanie danych do aproksymacji
    N = length(y_yearly);
    P = (N-1)*8+1; % liczba wartości funkcji aproksymującej
    x_coarse = linspace(0, 1, N)';
    x_fine = linspace(0, 1, P)';

    % Pętla po wielomianach różnych stopni
    for i = 1:N
        X = dct2_custom(y_yearly, i);
        y_approximation{i} = idct2_custom(X, i, N, P);
        mse(i) = mean((y_yearly - idct2_custom(X, i, N, N)).^2);
        if(i ~= 1)
            msek(i-1) = mean((y_approximation{i} - y_approximation{i-1}).^2);
        end
    end
    mse = mse';
    msek = msek';

else
    disp(['Dane dla (country=', country, ') oraz (source=', source, ') nie są dostępne.']);
end

    figure;
    subplot(3,1,1);

    plot(x_coarse, y_yearly, 'DisplayName','Yearly data', 'LineWidth', 1.2)
    hold on;
    for i = 1:length(degrees)
        plot(x_fine, y_approximation{degrees(i)}, 'DisplayName', "Polynomial degree: " + degrees(i))
    end
    hold off;
    xlabel('x')
    ylabel('Energy production [TWh]')
    legend('show', 'Location','bestoutside');
    title("Polynomial approximation for yearly data; country: " + country + " ; energy source: " + source);


    subplot(3,1,2);
    semilogy(1:N, mse);
    xlabel('Polynomial degree');
    ylabel('MSE');
    title('MSE values for different degrees of polynomials');

    subplot(3,1,3);

    semilogy(1:(N-1), msek);
    xlabel('Polynomial degree');
    ylabel('MSEk');
    title('Differential error values for different degrees of polynomials')
end