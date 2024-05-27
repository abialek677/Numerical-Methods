#include <iostream>
#include <vector>
#include <fstream>
#include <string>
#include <cmath>
#include <algorithm>
#include "matrixClass.h"
using namespace std;

#define M_PI 3.14159265358979323846

#define FILE_LINES 500

vector<int> node_count = { 3, 7, 11, 20};
vector<int> chebyshev_count = { 4, 8, 12, 20, 50, 100, 250};
vector<string> sources = {"tczew_starogard", "rozne_wniesienia"};

struct Node {
	double x;
	double y;
};

double lagrange(vector<Node>& nodes, double x);
vector<Node> getData(const string& path, int nodes_num);
void saveData(const vector<double>& x_values, const vector<double>& y_values, const vector<Node>& nodes, const string& interpolated_path, const string& nodes_path);
double splines(vector<Node>& nodes, double x);
void LU_decomposition(matrixClass& A, vector<double>& b, vector<double>& x);
void PLU(matrixClass& P, matrixClass& L, matrixClass& U);
void forwardSubstitution(matrixClass L, vector<double>& y, vector<double>& b);
void backwardSubstitution(matrixClass U, vector<double>& x, vector<double>& y);
vector<Node> getChebyshevNodes(vector<Node>& nodes, int n);
vector<Node> getAllNodes(const string& path);


int main() {
    for (string source : sources) {
        for (int val : node_count) {
            vector<Node> nodes = getData(".\\sources\\" + source + ".txt", val);
            
            vector<double> y_values;
            vector<double> x_values;
            vector<double> y_values_splines;
            for (double i = nodes[0].x; i < nodes[nodes.size() - 1].x; i++) {
                bool flag = true;
                x_values.push_back(i);
                for (int j = 0; j < nodes.size(); j++) {
                    if (abs(i - nodes[j].x) < 1.0) {
                        y_values.push_back(nodes[j].y);
                        y_values_splines.push_back(nodes[j].y);
                        flag = false;
                        break;
                    }
                }
                if (flag) {
                    y_values.push_back(lagrange(nodes, i));
                    y_values_splines.push_back(splines(nodes, i));
                }                
            }

            


            saveData(x_values, y_values, nodes, "interpolation_" + source + ".txt", "nodes_" + source + ".txt");
            saveData(x_values, y_values_splines, nodes, "interpolation_splines_" + source + ".txt", "nodes_" + source + ".txt");

        }
        for (int val : chebyshev_count) {
            vector<Node> allNodes = getAllNodes(".\\sources\\" + source + ".txt");
            vector<Node> chebNodes = getChebyshevNodes(allNodes, val);
            vector<double> x_values_cheb;
            vector<double> y_values_cheb;
            for (double i = chebNodes[0].x; i < chebNodes[chebNodes.size() - 1].x; i++) {
                bool flag = true;
                x_values_cheb.push_back(i);
                for (int j = 0; j < chebNodes.size(); j++) {
                    if (abs(i - chebNodes[j].x) < 1.0) {
                        y_values_cheb.push_back(chebNodes[j].y);
                        flag = false;
                        break;
                    }
                }
                if (flag) {
                    y_values_cheb.push_back(lagrange(chebNodes, i));
                }
            }

            saveData(x_values_cheb, y_values_cheb, chebNodes, "interpolation_chebyshev_" + source + ".txt", "nodes_cheb_" + source + ".txt");
        }
    }
	return 0;
}


double lagrange(vector<Node>& nodes, double x) {
    double temp = 0;
    for (int i = 0; i < nodes.size(); i++) {
		double y = 1;
        for (int j = 0; j < nodes.size(); j++) {
            if (i != j) {
				y *= (x - nodes[j].x) / (nodes[i].x - nodes[j].x);
			}
        }
        temp += y * nodes[i].y;
	}
    return temp;
}

vector<Node> getData(const string& path, int nodes_num) {
    ifstream file(path);
    vector<Node> nodes;

    double x, y;
    for (int i = 0; i < FILE_LINES; i++) {
        file >> x >> y;
        Node node;
        node.x = x;
        node.y = y;
        nodes.push_back(node);
    }

    file.close();

    int step = FILE_LINES/nodes_num;

    vector<Node> selectedNodes;
    for (int i = 0; i < nodes.size(); i+= step) {
        selectedNodes.push_back(nodes[i]);
	}

    return selectedNodes;
}

void saveData(const vector<double>& x_values, const vector<double>& y_values, const vector<Node>& nodes, const string& interpolated_path, const string& nodes_path) {
    string node_count = ".\\outputs\\" + to_string(nodes.size()) + '_';
    string int_path = node_count + interpolated_path;
    ofstream outputFile(int_path);

    for (int i = 0; i < x_values.size(); ++i) {
        outputFile << x_values[i] << " " << y_values[i] << '\n';
    }

    outputFile.close();
    string n_path = node_count + nodes_path;
    ofstream nodesFile(n_path);

    for (int i = 0; i < nodes.size(); i++) {
		nodesFile << nodes[i].x << " " << nodes[i].y << '\n';
	}
}


double splines(vector<Node>& nodes, double x) {
    int n = 4*(nodes.size() - 1);
    matrixClass M(n);
    vector<double> b(n, 0);
    vector<double> result(n, 1);


    // set node value
    M[0][0] = 1;
    b[0] = nodes[0].y;

    // known function value 
    double h = nodes[1].x - nodes[0].x;
    M[1][0] = 1;
    M[1][1] = h;
    M[1][2] = h * h;
    M[1][3] = h * h * h;
    b[1] = nodes[1].y;
    

    // c0 = 0
    // second derivative in the first node = 0
    M[2][2] = 1;
    b[2] = 0;

    // second derivative in the last node = 0
    h = nodes[nodes.size() - 1].x - nodes[nodes.size() - 2].x;
    M[3][M.size - 2] = 2;
    M[3][M.size - 1] = 6 * h;
    b[3] = 0;

    for (int i = 4; i < n; i += 4) {
        int nodeIndex = (i / 4) - 1;

        // value in node
        double h = nodes[nodeIndex + 1].x - nodes[nodeIndex].x;
        M[i][i] = 1;
        b[i] = nodes[nodeIndex + 1].y;

        // a + b*h + c*h^2 + d*h^3 = y
        M[i + 1][i] = 1;
        M[i + 1][i + 1] = h;
        M[i + 1][i + 2] = h * h;
        M[i + 1][i + 3] = h * h * h;
        b[i + 1] = nodes[nodeIndex + 2].y;

        // b + 2c*h + 3d*h^2 = b(nodeIndex+1)
        // continuity of the first derivative
        M[i + 2][i - 3] = 1;
        M[i + 2][i - 2] = 2 * h;
        M[i + 2][i - 1] = 3 * h * h;
        M[i + 2][i + 1] = -1;
        b[i + 2] = 0;

        // 2c + 6d*h = 2*c(nodeIndex+1)
        // continuity of the second derivative
        M[i + 3][i - 2] = 2;
        M[i + 3][i - 1] = 6 * h;
        M[i + 3][i + 2] = -2;
        b[i + 3] = 0;
    }



    LU_decomposition(M, b, result);
    
    double returnValue = 0;
    for (int i = 0; i < n-1; i++) {
        if (x >= nodes[i].x && x <= nodes[i + 1].x) {
            double h = x - nodes[i].x;

            for (int j = 0; j < 4; j++) {
                returnValue += result[4*i + j] * pow(h, j);
            }
            break;
        }
    }
    return returnValue;
}

void LU_decomposition(matrixClass& A, vector<double>& b, vector<double>& x) {
    int n = A.size;
    matrixClass L(n);
    matrixClass U = A;
    matrixClass P(n); //pivot matrix

    for (int i = 0; i < A.size; i++) {
		L[i][i] = 1;
        P[i][i] = 1;
	}

    PLU(P, L, U);

    vector<double> y;
    b = P * b;
    forwardSubstitution(L, y, b);
    backwardSubstitution(U, x, y);


}

void PLU(matrixClass& P, matrixClass& L, matrixClass& U) {
    int n = P.size;
    for (int i = 0; i < n; i++) {
        double pivot_element = U[i][i];
        bool pivot = false;
        int pivot_index = i;

        for (int j = i; j < n; j++) {
            if (abs(U[j][i]) > abs(pivot_element)) {
				pivot_element = U[j][i];
				pivot_index = j;
				pivot = true;
			}
        }

        if (pivot) {
            U.swapRows(i, pivot_index);
            P.swapRows(i, pivot_index);
            L.swapRows(i, pivot_index);
        }

        for (int j = 0; j < i; j++) {
            L[i][j] = U[i][j] / U[j][j];
            for (int k = j; k < n; k++) {
                U[i][k] -= L[i][j] * U[j][k];
            }
        }

	}
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

vector<Node> getChebyshevNodes(vector<Node>& nodes, int n) {
    vector<Node> chebNodes(n);
    double a = nodes[0].x;
    double b = nodes[nodes.size() - 1].x;
    for (int i = 1; i <= n; i++) {
		chebNodes[n-i].x = (a + b) * 0.5 + ((b - a) * 0.5) * cos((2 * i - 1) * M_PI / (2 * n));
	}

    for (auto& chebNode : chebNodes) {
        auto closestNode = min_element(nodes.begin(), nodes.end(), [&chebNode](const Node& left, const Node& right) {
            return abs(left.x - chebNode.x) < abs(right.x - chebNode.x);
            });
        chebNode.y = closestNode->y;
    }

    return chebNodes;
}

vector<Node> getAllNodes(const string& path) {
    ifstream file(path);
    vector<Node> nodes;

    double x, y;
    for (int i = 0; i < FILE_LINES; i++) {
        file >> x >> y;
        Node node;
        node.x = x;
        node.y = y;
        nodes.push_back(node);
    }

    file.close();

    return nodes;
}


