#include "func.h"
#include "operators.h"

double euclideanNorm(vector<double>& vec) {
    double sumSquares = 0.0;
    for (int i = 0; i < vec.size(); i++) {
        sumSquares += pow(vec[i], 2);
    }
    return sqrt(sumSquares);
}

double normRes(matrixClass A, vector<double> x, vector<double> b) {
    vector<double> help = (A * x);
    vector<double> res = help - b;

    return euclideanNorm(res);
}

void forwardSubstitution(matrixClass L, vector<double>& y, vector<double>& b) {
    y.push_back(b[0]);

    for (int i = 1; i < b.size(); i++) {
        double sum = 0.0;
        for (int j = 0; j < i; j++) {
            sum += L[i][j] * y[j];
        }
        y.push_back(b[i] - sum);
    }
}

void backwardSubstitution(matrixClass U, vector<double>& x, vector<double>& y) {
    x.resize(y.size());

    x[x.size() - 1] = y[y.size() - 1] / U[U.size - 1][U.size - 1];

    for (int i = x.size() - 2; i >= 0; i--) {
        double sum = 0.0;
        for (int j = i + 1; j < x.size(); j++) {
            sum += U[i][j] * x[j];
        }
        x[i] = (y[i] - sum) / U[i][i];
    }
}

vector<double> generateB(int n, int f) {
    vector<double> result(n);

    for (int i = 0; i < n; i++) {
        result[i] = sin(i * (f + 1));
    }
    return result;
}
