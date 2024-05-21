#include "matrixClass.h"

matrixClass::matrixClass(int n) {
    matrix.resize(n, vector<double>(n, 0));
    size = n;
}

vector<double>& matrixClass::operator[](int i) {
    return matrix[i];
}

vector<double> matrixClass::operator*(vector<double> x) {
    vector<double> result(size);
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
    matrixClass result(size);

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
    matrixClass result(a.size);

    for (int i = 0; i < a.size; i++) {
        for (int j = 0; j < a.size; j++) {
            result[i][j] = matrix[i][j] + a[i][j];
        }
    }
    return result;
}

matrixClass matrixClass::operator*(double num) {
    matrixClass result(size);
    for (int i = 0; i < size; i++) {
        for (int j = 0; j < size; j++) {
            result[i][j] = matrix[i][j] * num;
        }
    }
    return result;
}

void matrixClass::swapRows(int i, int j) {
	vector<double> temp = matrix[i];
	matrix[i] = matrix[j];
	matrix[j] = temp;
}
