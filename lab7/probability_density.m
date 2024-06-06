function result = probability_density(t)
    um = 10;
    sigma = 3;

    e_val = exp((-(t-um)^2)/(2*sigma^2));

    result = (1/(sigma*sqrt(2*pi))) * e_val;

end