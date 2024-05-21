#pragma once


#include <vector>
using namespace std;

class matrixClass {
public:
    vector<vector<double>> matrix;
    int size;

    matrixClass(int n);

    vector<double>& operator[](int i);
    vector<double> operator*(vector<double> x);
    matrixClass operator*(matrixClass A);
    matrixClass operator+(matrixClass a);
    matrixClass operator*(double num);

    void swapRows(int i, int j);
};