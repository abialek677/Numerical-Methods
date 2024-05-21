#include <iostream>
#include <vector>
#include <cmath>
#include <chrono>
#include <iomanip>
#include <fstream>
#include "matrixClass.h"
#include "computationMethods.h"
#include "func.h"
#include "operators.h"
using namespace chrono;

#define N 977


void task_AB() {
	cout << "##################################\n";
	cout << "########## TASK A and B ##########\n";
	cout << "##################################\n\n";

	double a1 = 11;
	double a2 = -1;
	double a3 = -1;
	matrixClass A(N, a1, a2, a3);

	vector<double> b = generateB(N, 3);

	vector<double> normResJacobi;
	vector<double> normResGaussSiedel;


	cout << "Jacobi method\n";
	jacobiMethodNEW(A, b, normResJacobi);




	cout << "Gauss-Seidel method\n";
	gaussSiedelMethod(A, b, normResGaussSiedel);

	string fileName = "data.txt";

	ofstream outFile(fileName, ofstream::trunc); // trunc for clearing file before input, app for appending file

	if (outFile.is_open()) {
		for (double val : normResJacobi) {
			outFile << val << ' ';
		}
		outFile << "\n";

		for (double val : normResGaussSiedel) {
			outFile << val << ' ';
		}
		outFile << "\n";
		outFile.close();
	}
	else
	{
		cout << "Could not open file";
	}

}


void task_CD() {
	cout << "##################################\n";
	cout << "########## TASK C and D ##########\n";
	cout << "##################################\n\n";

	double a1 = 3;
	double a2 = -1;
	double a3 = -1;
	matrixClass A(N, a1, a2, a3);

	vector<double> b = generateB(N, 3);

	vector<double> normResJacobi;
	vector<double> normResGaussSiedel;


	cout << "Jacobi method\n";
	jacobiMethodNEW(A, b, normResJacobi);




	cout << "Gauss-Seidel method\n";
	gaussSiedelMethod(A, b, normResGaussSiedel);


	cout << "LU decomposition\n";
	LU(A, b);



	string fileName = "data.txt";

	ofstream outFile(fileName, ofstream::app); // trunc for clearing file before input, app for appending file

	if (outFile.is_open()) {
		for (double val : normResJacobi) {
			outFile << val << ' ';
		}
		outFile << "\n";


		for (double val : normResGaussSiedel) {
			outFile << val << ' ';
		}
		outFile << "\n";
		outFile.close();
	}
	else
	{
		cout << "Could not open file";
	}

}


void task_E() {
	cout << "##################################\n";
	cout << "############# TASK E #############\n";
	cout << "##################################\n\n";
	vector<int> nTable = {500,1000, 1500, 2000, 2500, 3000, 3500, 4000, 4500, 5000, 5500, 6000, 6500, 7000, 7500, 8000, 8500, 9000, 9500, 10000  };
	vector<double> jacobiTimes;
	vector<double> gaussSiedelTimes;
	vector<double> luTimes;

	for (int val : nTable) {
		cout << "\n#######  Results for N= " << val << "  #######\n";

		double a1 = 11;
		double a2 = -1;
		double a3 = -1;
		matrixClass A(val, a1, a2, a3);

		vector<double> b = generateB(val, 3);

		vector<double> normResJacobi;
		vector<double> normResGaussSiedel;


		cout << "Jacobi method\n";
		double durationJacobi = jacobiMethodNEW(A, b, normResJacobi);


		jacobiTimes.push_back(durationJacobi);


		cout << "Gauss-Seidel method\n";
		double durationGaussSiedel = gaussSiedelMethod(A, b, normResGaussSiedel);
		gaussSiedelTimes.push_back(durationGaussSiedel);


		cout << "LU decomposition\n";
		double durationLU = LU(A, b);
		luTimes.push_back(durationLU);
	}

	string fileName = "data.txt";

	ofstream outFile(fileName, ofstream::app); // trunc for clearing file before input, app for appending file

	if (outFile.is_open()) {

		for (double val : jacobiTimes) {
			outFile << val << ' ';
		}
		outFile << "\n";


		for (double val : gaussSiedelTimes) {
			outFile << val << ' ';
		}
		outFile << "\n";


		for (double val : luTimes) {
			outFile << val << ' ';
		}
		outFile << "\n";


		for (int val : nTable) {
			outFile << val << ' ';
		}
		outFile << "\n";

		outFile.close();
	}
	else
	{
		cout << "Could not open file";
	}
}


int main() {

	task_AB();

	task_CD();


	task_E();



	return 0;
}
