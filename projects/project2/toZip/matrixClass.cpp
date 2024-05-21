#include "matrixClass.h"

matrixClass::matrixClass(int n, double a1, double a2, double a3) {
    matrix.resize(n, std::vector<double>(n, 0));
    size = n;

    for (int i = 0; i < n; i++) {
        if (i != n - 1) {
            matrix[i][i + 1] = a2;
            matrix[i + 1][i] = a2;
        }
        if (i < n - 2) {
            matrix[i][i + 2] = a3;
            matrix[i + 2][i] = a3;
        }
        matrix[i][i] = a1;
    }
}

std::vector<double>& matrixClass::operator[](int i) {
    return matrix[i];
}

std::vector<double> matrixClass::operator*(std::vector<double> x) {
    std::vector<double> result(size);
    for (int i = 0; i < size; i++) {
        double value = 0;
        for (int j = 0; j < size; j++) {
            value += matrix[i][j] * x[j];
        }
        result[i] = value;
    }
    return result;
}

matrixClass matrixClass::operator*(matrixClass A) {
    matrixClass result(size, 0, 0, 0);

    for (int i = 0; i < size; i++) {
        for (int j = 0; j < size; j++) {
            double val = 0.0;
            for (int m = 0; m < size; m++) {
                val += matrix[i][m] * A[m][j];
            }
            result[i][j] = val;
        }
    }

    return result;
}

matrixClass matrixClass::operator+(matrixClass a) {
    matrixClass result(a.size, 0, 0, 0);

    for (int i = 0; i < a.size; i++) {
        for (int j = 0; j < a.size; j++) {
            result[i][j] = matrix[i][j] + a[i][j];
        }
    }
    return result;
}

matrixClass matrixClass::operator*(double num) {
    matrixClass result(size, 0, 0, 0);
    for (int i = 0; i < size; i++) {
        for (int j = 0; j < size; j++) {
            result[i][j] = matrix[i][j] * num;
        }
    }
    return result;
}
