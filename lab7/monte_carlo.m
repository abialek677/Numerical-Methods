function [result, xr, yr] = monte_carlo(handle, n, yrmax)
    a = 0;
    b = 5;

    xr = zeros(1,n);
    yr = zeros(1,n);

    for i=1:n
        xr(i) = a + (b-a) * rand;
        yr(i) = yrmax * rand;
    end

    S = (b-a) * yrmax;
    n1 = 0;
    for i=1:n
        if(handle(xr(i)) > yr(i))
            n1 = n1 + 1;
        end
    end
    
    result = (n1/n)*S;
end