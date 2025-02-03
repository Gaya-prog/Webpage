#include <iostream>
#include <cmath>

using namespace std;

int main()

/*a)Prompts the user to input five decimal numbers.
  b)Prints the five decimal numbers.*/

{
	double a;
	double b;
	double c;
	double d;
	double e;
	
    cout << "a)Write down five decimal numbers." << endl; 
	cin >> a >> b >> c >> d >> e;
	
	cout << " " << endl;
	cout << "b)a=" << a;
	cout << "  b=" << b ;
	cout << "  c=" << c ;
	cout << "  d=" << d ;
	cout << "  e=" << e << endl;
	cout << " " << endl;

/*c)Converts each decimal number to the nearest integer.
  d)Prints the sum and average of the five integers.*/
    
    cout << "c)The nearest integer of a is " << round(a) << endl;
    cout << "  The nearest integer of b is " << round(b) << endl;
    cout << "  The nearest integer of c is " << round(c) << endl;
    cout << "  The nearest integer of d is " << round(d) << endl;
    cout << "  The Nearest integer of e is " << round(e) << endl;
    cout << " " << endl;
    
    int sum=round(a)+round(b)+round(c)+round(d)+round(e);
    int average= sum/5;
    cout << "d)The sum of the five integers is " << sum << endl;
    cout << "  The average number of the five integers is " << average << endl;
	 
return 0;
}
