function [circles, index_number, circle_areas,rand_counts, counts_mean] = generate_circles(a, r_max, n_max)
index_number = 193677; % numer Twojego indeksu
L1 = 7;
circles = zeros(3,n_max);
i = 1;

circle_areas = zeros(n_max,1);

rand_counts = zeros(1,n_max);
counts_mean = zeros(1,n_max);

count = 1;
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
    if boolean && i ~= 1
        circles(1,i) = radius;
        circles(2,i) = X;
        circles(3,i) = Y;
        circle_areas(i) = radius*radius*pi;
        rand_counts(i) = count;
        counts_mean(i) = count/i + counts_mean(i-1)*(i-1)/i;
        i = i+1;
        count = 1;
    elseif boolean
        circles(1,i) = radius;
        circles(2,i) = X;
        circles(3,i) = Y;
        circle_areas(i) = radius*radius*pi;
        rand_counts(i) = count;
        counts_mean(i) = count;
        i = i+1;
        count = 1;
    else
        count = count+1;
    end
end
circle_areas = cumsum(circle_areas);
end