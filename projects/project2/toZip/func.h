#pragma once


#include "matrixClass.h"
#include <vector>
#include <cmath>

double euclideanNorm(vector<double>& vec);
double normRes(matrixClass A, vector<double> x, vector<double> b);

void forwardSubstitution(matrixClass L, vector<double>& y, vector<double>& b);
void backwardSubstitution(matrixClass U, vector<double>& x, vector<double>& y);

vector<double> generateB(int n, int f);