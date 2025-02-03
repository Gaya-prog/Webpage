#include <iostream>
#include <fstream>
#include <string>
#include <iomanip>

using namespace std;

int main()

{
	ifstream input;
	input.open ("test.txt");
	
	ofstream output;
	output.open("testavg.txt"); 
	
	string name1, middleName1, name2, middleName2, name3, middleName3; 
	double a1, a2, a3, a4, a5;
	double b1, b2, b3, b4, b5;
	double c1, c2, c3, c4, c5;
	
	cout << fixed << showpoint;
	cout << setprecision(2);
	
	output << fixed << showpoint;
	output << setprecision(2);
	
	input >> name1 >> middleName1 >> a1 >> a2 >> a3 >> a4 >> a5;
	output << setw(1) << name1 << " " << middleName1 << " " << setw(7) << a1 << " " << a2 << " " << a3 << " " << a4 << " " << a5 << endl;
	cout << setw(1) << name1 << " " << middleName1 << " " << setw(7) << a1 << " " << a2 << " " << a3 << " " << a4 << " " << a5 << endl;
	
	input >> name2 >> middleName2 >> b1 >> b2 >> b3 >> b4 >> b5;
	output << setw(1) << name2 << " " << middleName2 << " " << setw(8) << b1 << " " << b2 << " " << b3 << " " << b4 << " " << b5 << endl;
	cout << setw(1) << name2 << " " << middleName2 << " " << setw(8) << b1 << " " << b2 << " " << b3 << " " << b4 << " " << b5 << endl;
	
	input >> name3 >> middleName3 >> c1 >> c2 >> c3 >> c4 >> c5;
	output << setw(1) << name3 << " " << middleName3 << " " << setw(10) << c1 << " " << b2 << " " << b3 << " " << b4 << " " << b5 << endl;
	cout << setw(1) << name3 << " " << middleName3 << " " << setw(10) << c1 << " " << b2 << " " << b3 << " " << b4 << " " << b5 << endl;
	
	input.close();
	
	cout << " " << endl;
	output << " " << endl;
	
	double avg1 = (a1+a2+a3+a4+a5)/5;
	double avg2 = (b1+b2+b3+b4+b5)/5;
	double avg3 = (c1+c2+c3+c4+c5)/5;
	
	cout << "The average test score of " << name1 << " " << middleName1 << " " << "is " << avg1 << endl;
	output << "The average test score of " << name1 << " " << middleName1 << " " << "is " << avg1 << endl;
	
	cout << "The average test score of " << name2 << " " << middleName2 << " " << "is " << avg2 << endl;
	output << "The average test score of " << name2 << " " << middleName2 << " " << "is " << avg2 << endl;
	
	cout << "The average test score of " << name3 << " " << middleName3 << " " << "is " << avg3 << endl;
	output << "The average test score of " << name3 << " " << middleName3 << " " << "is " << avg3 << endl;
	
	output.close();
	
	return 0;
}
