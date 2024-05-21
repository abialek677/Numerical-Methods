function impedance_delta = impedance_magnitude(omega)

R = 525;
C = 7*power(10, -5);
L = 3;
M = 75; % docelowa wartość modułu impedancji

if omega <= 0
    error("Omega has to have value higher than 0")
end

Z = 1/sqrt(1/(R*R) + power((omega*C - 1/(omega*L)),2));

Z = abs(Z);


impedance_delta = Z - M;

end