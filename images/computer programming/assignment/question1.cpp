#include <iostream>

using namespace std;

int main()

// calculate the sum of numbers from 1 to 2020 using the formula sum= (n/2)(2a+(n-1)d)
// n= number of terms to be added, a= the first number, d=the difference between each number and the following number

{
	int a=1, n=2020, d=1;
	int sum= (n/2) * (2*a + (n-1)*d);
	
	cout << "The sum of numbers from 1 to 2020 is " << sum << endl;
	
	return 0;
}
