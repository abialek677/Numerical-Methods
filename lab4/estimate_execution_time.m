function time_delta = estimate_execution_time(N)
% time_delta - różnica pomiędzy estymowanym czasem wykonania algorytmu dla zadanej wartości N a zadanym czasem M
% N - liczba parametrów wejściowych
M = 5000; % [s]

if N <= 0
    error('time has to be positive');
end

t = (power(N, 16/11) + power(N, pi*pi/8))/1000;
time_delta = t - M;

end
