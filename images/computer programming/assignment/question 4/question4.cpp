#include <iostream>
#include <iomanip>
#include <fstream>
#include <string>

using namespace std;

int main()

{
	ofstream output;
	output.open ("test.txt");
	
	string name1 = "Andrew Miller"; double a1 = 87.50, a2 = 89, a3 = 65.75, a4 = 37, a5 = 98.50;
	string name2 = "Green Sheila"; double b1 = 91.05, b2 = 75.88, b3 = 50, b4 = 65.50, b5 = 74.30;
	string name3 = "Sethi Amit"; double c1 = 49.82, c2 = 75, c3 = 30, c4 = 74, c5 = 86.30;
	
	output << fixed << showpoint;
	output << setprecision(2);
	output << setw(1) << name1 << setw(7) << a1 << setw(7) << a2 << setw(7) << a3 << setw(7) << a4 << setw(7) << a5 << endl;
	output << setw(1) << name2 << setw(8) << b1 << setw(7) << b2 << setw(7) << b3 << setw(7) << b4 << setw(7) << b5 << endl;
	output << setw(1) << name3 << setw(10) << c1 << setw(7) << c2 << setw(7) << c3 << setw(7) << c4 << setw(7) << c5 << endl;
	
	output.close();
	  
return 0;
	
}
