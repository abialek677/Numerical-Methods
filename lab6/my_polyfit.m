function p = my_polyfit(x, y, n)

matrix = zeros(length(x), n+1);

for i = 1:length(x)
    for j = 1:(n+1)
        matrix(i,j) = x(i)^(n+1-j);
    end
end

    p = (matrix' * matrix) \ (matrix' * y);
    p = p';
end