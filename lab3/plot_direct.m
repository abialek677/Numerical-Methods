function plot_direct(N,vtime_direct)
    % N - wektor zawierający rozmiary macierzy dla których zmierzono czas obliczeń metody bezpośredniej
    % vtime_direct - czas obliczeń metody bezpośredniej dla kolejnych wartości N
    plot(N, vtime_direct);
    xlabel('Rozmiar macierzy');
    ylabel('Czas wyznaczania rozwiązania')
    title('Czas wyznaczania rozwiazania rownania macierzowego w zaleznosci od rozmiaru macierzy')
    %print -dpng zadanie2.png
end