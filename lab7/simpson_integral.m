function result = simpson_integral(handle, n)
    a = 0;
    b = 5;
    delta = (b-a)/n;
    result = 0;
    for i=1:n
        xi = a + (i-1)*delta;
        xi_1 = a + i*delta;
        middle = (xi + xi_1)/2;
        result = result + handle(xi) + 4*handle(middle) + handle(xi_1);
    end
    result = result * delta/6;
end