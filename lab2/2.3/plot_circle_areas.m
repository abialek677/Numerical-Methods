function plot_circle_areas(circle_areas)


plot(circle_areas)
ylabel('Sum value')
xlabel('Circle count')
title('Sum of areas of circles')
ylim([0, max(circle_areas)])

end