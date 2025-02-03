#include <iostream>
#include <fstream>
#include <string>
#include <iomanip>

using namespace std;

int main()

{
	ifstream input ("test.txt");
	
	string name1, name2, name3; 
	double a1, a2, a3, a4, a5;
	
	input >> name1 >> a1 >> a2 >> a3 >> a4 >> a5;
	cout << fixed << showpoint;
	cout << setprecision(2) ;
	cout << name1 << a1 << a2 << a3 << a4 << a5 << endl;
	
	return 0;
}
