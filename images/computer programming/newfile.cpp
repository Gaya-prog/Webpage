#include <iostream>
#include <fstream>
using namespace std;

int main()

{
	ofstream output;
	output.open("myfile.txt");
	
	output << "This is my file.";
	
	output.close();
	
	return 0; 
}
