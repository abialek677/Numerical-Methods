function [xsolution,ysolution,iterations,xtab,xdif] = secant_method(a,b,max_iterations,ytolerance,fun)
% a - lewa granica przedziału poszukiwań miejsca zerowego (x0=a)
% b - prawa granica przedziału poszukiwań miejsca zerowego (x1=b)
% max_iterations - maksymalna liczba iteracji działania metody siecznych
% ytolerance - wartość abs(fun(xsolution)) powinna być mniejsza niż ytolerance
% fun - nazwa funkcji, której miejsce zerowe będzie wyznaczane
%
% xsolution - obliczone miejsce zerowe
% ysolution - wartość fun(xsolution)
% iterations - liczba iteracji wykonana w celu wyznaczenia xsolution
% xtab - wektor z kolejnymi kandydatami na miejsce zerowe, począwszy od x2
% xdiff - wektor wartości bezwzględnych z różnic pomiędzy i-tym oraz (i+1)-ym elementem wektora xtab; xdiff(1) = abs(xtab(2)-xtab(1));

xsolution = [];
ysolution = [];
iterations = 0;
xtab = [];
xdif = [];

xtab(1) = b - (fun(b)*(b-a))/(fun(b)-fun(a));
xtab(2) = xtab(1) - (fun(xtab(1))*(xtab(1)-b))/(fun(xtab(1))-fun(b));
xdif(1) = abs(xtab(2) - xtab(1));
for i = 3:max_iterations
    iterations = i;
    xtab(i) = xtab(i-1) - (fun(xtab(i-1))*(xtab(i-1)-xtab(i-2)))/(fun(xtab(i-1))-fun(xtab(i-2)));
    xdif(i-1) = abs(xtab(i) - xtab(i-1));

    xsolution = xtab(i);
    ysolution = fun(xtab(i));
    if abs(ysolution) < ytolerance
        break;
    end


end
xtab = xtab';
xdif = xdif';



end
