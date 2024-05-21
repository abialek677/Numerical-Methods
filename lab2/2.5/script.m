clear all
close all
format compact

r_max = 2;
n_max = 800;
a = 4;
[circles, index_number, circle_areas, rand_counts, counts_mean] = generate_circles(a, r_max, n_max);

%plot_counts_mean(counts_mean)

%plot_circle_areas(circle_areas)
plot_circles(circles,a,index_number)
%print -dpng zadanie5.png