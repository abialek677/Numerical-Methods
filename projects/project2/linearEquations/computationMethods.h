#pragma once


#include "matrixClass.h"
#include "operators.h"
#include <vector>
#include <iostream>
#include <chrono>


double jacobiMethodNEW(matrixClass A, vector<double>& b, vector<double>& normResVector);
double gaussSiedelMethod(matrixClass A, vector<double>& b, vector<double>& normResVector);
double LU(matrixClass A, vector<double>& b);