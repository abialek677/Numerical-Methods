clear all
close all
format compact

r_max = 2;
n_max = 200;
a = 4;
[circles, index_number] = generate_circles(a, r_max, n_max);

plot_circles(circles,a,index_number)
