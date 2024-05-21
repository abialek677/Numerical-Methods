#pragma once


#include <vector>
using namespace std;

class matrixClass {
public:
    vector<vector<double>> matrix;
    int size;

    matrixClass(int n, double a1, double a2, double a3);

    vector<double>& operator[](int i);
    vector<double> operator*(vector<double> x);
    matrixClass operator*(matrixClass A);
    matrixClass operator+(matrixClass a);
    matrixClass operator*(double num);
};