#include "computationMethods.h"
#include "func.h"
using namespace chrono;

const double yTolerance = 1e-9;


double jacobiMethodNEW(matrixClass A, vector<double>& b, vector<double>& normResVector) {

    vector<double> x(A.size, 1);

    double nRes;
    int iterations;

    vector<double> newX(A.size);
    auto start = high_resolution_clock::now();
    for (int k = 0; k < 1000; k++) {
        iterations = k + 1;


        for (int i = 0; i < A.size; i++) {
            double sum1 = 0.0;
            double sum2 = 0.0;

            for (int j = 0; j < i; j++) {
                sum1 += A[i][j] * x[j];
            }

            for (int j = i + 1; j < A.size; j++) {
                sum2 += A[i][j] * x[j];
            }

            newX[i] = (b[i] - sum1 - sum2) / A[i][i];
        }

        x = newX;

        nRes = normRes(A, x, b);

        normResVector.push_back(nRes);

        if (nRes < yTolerance) {
            break;
        }
    }
    auto stop = high_resolution_clock::now();

    auto duration = duration_cast<microseconds>(stop - start).count() * 1e-6;

    cout << "\tIterations: " << iterations << '\n';
    cout << "\tResidual norm: " << nRes << '\n';
    cout << "\tDuration: " << duration << "s\n\n";
    return (double)duration;
}

double gaussSiedelMethod(matrixClass A, vector<double>& b, vector<double>& normResVector) {
    vector<double> x(A.size, 1);

    double nRes;
    int iterations;
    auto start = high_resolution_clock::now();
    for (int k = 0; k < 1000; k++) {
        iterations = k + 1;


        for (int i = 0; i < A.size; i++) {
            double sum1 = 0.0;
            double sum2 = 0.0;

            for (int j = 0; j < i; j++) {
                sum1 += A[i][j] * x[j];
            }

            for (int j = i + 1; j < A.size; j++) {
                sum2 += A[i][j] * x[j];
            }

            x[i] = (b[i] - sum1 - sum2) / A[i][i];
        }

        nRes = normRes(A, x, b);

        normResVector.push_back(nRes);

        if (nRes < yTolerance) {
            break;
        }
    }
    auto stop = high_resolution_clock::now();
    auto duration = duration_cast<microseconds>(stop - start).count() * 1e-6;

    cout << "\tIterations: " << iterations << '\n';
    cout << "\tResidual norm: " << nRes << '\n';
    cout << "\tDuration: " << duration << "s\n\n";
    return (double)duration;
}

double LU(matrixClass A, vector<double>& b) {
    int n = A.size;
    matrixClass L(n, 1, 0, 0);
    matrixClass U = A;

    auto start = high_resolution_clock::now();
    for (int i = 1; i < n; i++) {
        for (int j = 0; j < i; j++) {
            L[i][j] = U[i][j] / U[j][j];
            for (int k = j; k < n; k++) {
                U[i][k] -= L[i][j] * U[j][k];
            }
        }
    }



    vector<double> y;
    vector<double> x;

    forwardSubstitution(L, y, b);

    backwardSubstitution(U, x, y);
    auto stop = high_resolution_clock::now();


    double nRes = normRes(A, x, b);


    auto duration = duration_cast<microseconds>(stop - start).count() * 1e-6;

    cout << "\tResidual norm: " << nRes << '\n';
    cout << "\tDuration: " << duration << "s\n\n";
    return (double)duration;
}
