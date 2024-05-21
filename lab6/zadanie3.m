function [country, source, degrees, x_coarse, x_fine, y_original, y_yearly, y_approximation, mse] = zadanie3(energy)
% Głównym celem tej funkcji jest wyznaczenie aproksymacji rocznych danych o produkcji energii elektrycznej w wybranym kraju i z wybranego źródła energii.
% Wybór kraju i źródła energii należy określić poprzez nadanie w tej funkcji wartości zmiennym typu string: country, source.
% Dopuszczalne wartości tych zmiennych można sprawdzić poprzez sprawdzenie zawartości struktury energy zapisanej w pliku energy.mat.
% 
% energy - struktura danych wczytana z pliku energy.mat
% country - [String] nazwa kraju
% source  - [String] źródło energii
% degrees - wektor zawierający cztery stopnie wielomianu dla których wyznaczono aproksymację
% x_coarse - wartości x danych aproksymowanych
% x_fine - wartości, w których wyznaczone zostaną wartości funkcji aproksymującej
% y_original - dane wejściowe, czyli pomiary produkcji energii zawarte w wektorze energy.(country).(source).EnergyProduction
% y_yearly - wektor danych rocznych
% y_approximation - tablica komórkowa przechowująca cztery wartości funkcji aproksymującej dane roczne.
%   - y_approximation{i} stanowi aproksymację stopnia degrees(i)
%   - y_approximation{i} stanowi wartości funkcji aproksymującej w punktach x_fine.
% mse - wektor o rozmiarze 4x1: mse(i) zawiera wartość błędu średniokwadratowego obliczonego dla aproksymacji stopnia degrees(i).

country = 'Poland';
source = 'Solar';
degrees = 1:4;
x_coarse = [];
x_fine = [];
y_original = [];
y_yearly = [];
y_approximation = {};
mse = [];

% Sprawdzenie dostępności danych
if isfield(energy, country) && isfield(energy.(country), source)
    % Przygotowanie danych do aproksymacji
    dates = energy.(country).(source).Dates;
    y_original = energy.(country).(source).EnergyProduction;

    % Obliczenie danych rocznych
    n_years = floor(length(y_original) / 12);
    y_cut = y_original(end-12*n_years+1:end);
    y4sum = reshape(y_cut, [12 n_years]);
    y_yearly = sum(y4sum,1)';

    N = length(y_yearly);
    x_coarse = linspace(-1, 1, N)';
    x_fine = linspace(-1, 1, N*10)';

    % Pętla po wielomianach różnych stopni
    for i = 1:length(degrees)
        p = my_polyfit(x_coarse, y_yearly, degrees(i));
        z = polyval(p,x_fine);
        y_approximation{i} = z;
        mse_val = 0;
        z_orig = polyval(p, x_coarse);
        for j = 1:length(y_yearly)
            mse_val = mse_val + (y_yearly(j) - z_orig(j))^2;
        end
        mse_val = mse_val/length(y_yearly);
        mse(i) = mse_val;
    end

else
    disp(['Dane dla (country=', country, ') oraz (source=', source, ') nie są dostępne.']);
end

figure;
subplot(2,1,1);
hold on;
plot(x_coarse, y_yearly, 'DisplayName', 'Yearly data', 'LineWidth', 1.2);
for i = 1:length(degrees)
    plot(x_fine, y_approximation{i}, 'DisplayName', "Polynomial degree: " + degrees(i));
end
hold off;
title("Data approximation for country: " + country + " ; energy source: " + source)
xlabel('x')
ylabel('Energy production [TWh]')
legend('show', 'Location','bestoutside');

subplot(2,1,2);
bar(mse);
title('MSE for various polynomial degrees')
ylabel('MSE value')
xlabel('Polynomial degree')
set(gca, 'XTickLabel', degrees);
end
