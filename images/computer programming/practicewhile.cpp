#include <iostream>

using namespace std;

int main()

{
	int num1, num2;
	
	cout << "Write down two numbers.";
	cin >> num1 >> num2;

	if ( num1 > num2)
	cout << "The first number is greater.";

	else
	cout << "The first number is smaller.";
	
	return 0;
}
