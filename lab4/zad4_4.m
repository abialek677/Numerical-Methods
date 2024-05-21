a = 1;
b = 50;
ytolerance = 1e-12;
max_iterations = 100;

[omega_bisection,~,~,tab_bis,dif_bis] = bisection_method(a,b,max_iterations,ytolerance,@impedance_magnitude);

[omega_secant,~,~,tab_sec,dif_sec] = secant_method(a,b,max_iterations,ytolerance,@impedance_magnitude);

figure;
sgtitle('impedance magnitude');
subplot(2,1,1);
plot(tab_bis, 'LineWidth',2);
hold on;
plot(tab_sec, 'LineWidth',2);
title('Zmiany przybliżenia wraz z iteracjami');
xlabel('Iteracja');
ylabel('Wartośc');
legend({'Metoda bisekcji', 'Metoda siecznych'},'Location', 'best');

subplot(2,1,2);
semilogy(dif_bis, 'LineWidth',2);
hold on;
semilogy(dif_sec, 'LineWidth',2);
title('Różnice pomiędzy przybliżeniami w kolejnych iteracjach');
xlabel('Iteracja');
ylabel('Wartośc');
legend({'Metoda bisekcji', 'Metoda siecznych'},'Location', 'best');