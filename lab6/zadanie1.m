function [country, source, degrees, y_original, y_approximation, mse] = zadanie1(energy)
% Głównym celem tej funkcji jest wyznaczenie aproksymacji danych o produkcji energii elektrycznej w wybranym kraju i z wybranego źródła energii.
% Wybór kraju i źródła energii należy określić poprzez nadanie w tej funkcji wartości zmiennym typu string: country, source.
% Dopuszczalne wartości tych zmiennych można sprawdzić poprzez sprawdzenie zawartości struktury energy zapisanej w pliku energy.mat.
% 
% energy - struktura danych wczytana z pliku energy.mat
% country - [String] nazwa kraju
% source  - [String] źródło energii
% degrees - wektor zawierający cztery stopnie wielomianu dla których wyznaczono aproksymację
% y_original - dane wejściowe, czyli pomiary produkcji energii zawarte w wektorze energy.(country).(source).EnergyProduction
% y_approximation - tablica komórkowa przechowująca cztery wartości funkcji aproksymującej dane wejściowe. y_approximation stanowi aproksymację stopnia degrees(i).
% mse - wektor o rozmiarze 4x1: mse(i) zawiera wartość błędu średniokwadratowego obliczonego dla aproksymacji stopnia degrees(i).



country = 'Poland';
source = 'Solar';
degrees = [1, 5, 10, 20];
y_original = [];
y_approximation= {};
mse = [];

% Sprawdzenie dostępności danych
if isfield(energy, country) && isfield(energy.(country), source)
    % Przygotowanie danych do aproksymacji
    y_original = energy.(country).(source).EnergyProduction;
    dates = energy.(country).(source).Dates;

    x = linspace(-1,1,length(y_original))';

    % Pętla po wielomianach różnych stopni
    for i = 1:length(degrees)
        p = polyfit(x, y_original, degrees(i));
        z = polyval(p,x);
        y_approximation{i} = z;
        mse_val = 0;
        for j = 1:length(y_original)
            mse_val = mse_val + (y_original(j) - z(j))^2;
        end
        mse_val = mse_val/length(y_original);
        mse(i) = mse_val;
    end

else
    disp(['Dane dla (country=', country, ') oraz (source=', source, ') nie są dostępne.']);
end

figure;
subplot(2,1,1);
hold on;
plot(y_original, 'DisplayName', 'Original data', 'LineWidth', 1.2);
for i = 1:length(degrees)
    plot(y_approximation{i}, 'DisplayName', "Polynomial degree: " + degrees(i));
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