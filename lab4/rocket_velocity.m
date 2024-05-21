function velocity_delta = rocket_velocity(t)
% velocity_delta - różnica pomiędzy prędkością rakiety w czasie t oraz zadaną prędkością M
% t - czas od rozpoczęcia lotu rakiety dla którego ma być wyznaczona prędkość rakiety
M = 750; % [m/s]
u = 2000;
m0 = 150000;
q = 2700;
g = 1.622;
if t <= 0
    error('time has to be positive');
end

V = u*log(m0/(m0-q*t))-g*t;

velocity_delta = V-M;



end
