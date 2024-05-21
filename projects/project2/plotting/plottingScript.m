%data read

file = fopen('data.txt', 'r');

Line = fgetl(file);
Jacobi_Error_AB = str2num(Line);

Line = fgetl(file);
Gauss_Error_AB = str2num(Line);

Line = fgetl(file);
Jacobi_Error_CD = str2num(Line);

Line = fgetl(file);
Gauss_Error_CD = str2num(Line);

Line = fgetl(file);
Jacobi_Times = str2num(Line);

Line = fgetl(file);
Gauss_Times = str2num(Line);

Line = fgetl(file);
LU_Times = str2num(Line);

Line = fgetl(file);
Matrix_Sizes = str2num(Line);


%plotting

%AB
figure;
semilogy(1:length(Jacobi_Error_AB), Jacobi_Error_AB, 'LineWidth',2);
hold on;
semilogy(1:length(Gauss_Error_AB), Gauss_Error_AB, 'LineWidth',2);

xlabel('Iteration')
ylabel('Norm of residual vector')

title('Jacobi and Gauss-Seidel methods for matrix A')

legend('Jacobi Method', 'Gauss-Seidel Method', 'Location','best');
grid on;
grid minor;

hold off;


%CD
figure;
semilogy(1:length(Jacobi_Error_CD), Jacobi_Error_CD, 'LineWidth',2);
hold on;
semilogy(1:length(Gauss_Error_CD), Gauss_Error_CD, 'LineWidth',2);

xlabel('Iteration') 
ylabel('Norm of residual vector')

title('Jacobi and Gauss-Seidel methods for matrix C')

legend('Jacobi Method', 'Gauss-Seidel Method', 'Location','best');
grid on;
grid minor;

hold off;

%E
figure;
plot(Matrix_Sizes,Jacobi_Times, 'LineWidth',2);
hold on;
plot(Matrix_Sizes,Gauss_Times, 'LineWidth',2);
plot(Matrix_Sizes,LU_Times, 'LineWidth',2);

xlabel('Size of matrix')
ylabel('Computing time [s]')

title('Time needed for calculating linear solution for different matrix sizes');

legend('Jacobi Method', 'Gauss-Seidel Method', 'LU decomposition', 'Location','best');
grid on;
grid minor;

hold off;

figure;
semilogy(Matrix_Sizes,Jacobi_Times, 'LineWidth',2);
hold on;
semilogy(Matrix_Sizes,Gauss_Times, 'LineWidth',2);
semilogy(Matrix_Sizes,LU_Times, 'LineWidth',2);

xlabel('Size of matrix')
ylabel('Computing time [s]')

title('Time needed for calculating linear solution for different matrix sizes');

legend('Jacobi Method', 'Gauss-Seidel Method', 'LU decomposition', 'Location','best');
grid on;
grid minor;

hold off;


