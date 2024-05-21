#include "operators.h"

vector<double> operator-(vector<double>& a, vector<double>& b) {
    vector<double> result(a.size());

    for (int i = 0; i < a.size(); i++) {
        result[i] = a[i] - b[i];
    }

    return result;
}

vector<double> operator+(const vector<double>& a, const vector<double>& b) {
    vector<double> result(a.size());

    for (int i = 0; i < a.size(); i++) {
        result[i] = a[i] + b[i];
    }

    return result;
}