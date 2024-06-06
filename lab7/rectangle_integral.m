function result = rectangle_integral(handle, n)
    a = 0;
    b = 5;
    delta = (b-a)/n;
    result = 0;
    for i=1:n
        xi = a + (i-1)*delta;
        xi_1 = a + i*delta;
        middle = (xi + xi_1)/2;
        result = result + handle(middle);
    end
    result = result * delta;
end