function result = trapeze_integral(handle, n)
    a = 0;
    b = 5;
    delta = (b-a)/n;
    result = 0;
    for i=1:n
        xi = a + (i-1)*delta;
        xi_1 = a + i*delta;
        trapeze_val = (handle(xi) + handle(xi_1))/2;
        result = result + trapeze_val;
    end
    result = result * delta;
end