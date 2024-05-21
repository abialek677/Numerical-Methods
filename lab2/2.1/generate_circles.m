function [circles, index_number] = generate_circles(a, r_max, n_max)
index_number = 193677; % numer Twojego indeksu
L1 = 7;
circles = zeros(3,n_max);
i = 1;
while i <= n_max
    radius = 0;
    while radius == 0
        radius = rand*r_max;
    end
    X = rand*(a-2*radius) + radius;
    Y = rand*(a-2*radius) + radius;
    boolean = true;
    for j = 1:i-1
        if ~checkSeparate(circles(1, j), circles(2, j), circles(3, j), radius, X, Y)
            boolean = false;
            break;
        end
    end
    if boolean
        circles(1,i) = radius;
        circles(2,i) = X;
        circles(3,i) = Y;
        i = i+1;
    end
end
end