function plot_circles(circles,a,index_number)

    axis equal;
    axis([0 a 0 a]);
    hold on
    for i = 1:size(circles, 2)
        plot_circle(circles(1,i),circles(2,i),circles(3,i))
        pause(0.1);
    end
    hold off
end