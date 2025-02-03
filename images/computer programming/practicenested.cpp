#include <iostream>

using namespace std;

int main()

{
	int numofc;
	
	cout << "Please enter your number of credits completed ";
	cin >> numofc;
	
	if (numofc < 32 )
	 cout << "Your grade level is Freshman.";
	
	else if ( numofc >= 32 && numofc <= 63)
	 cout << "Your grade level is Sophomore.";
	
	else if ( numofc >= 64 && numofc <= 95)
	 cout << "Your grade level is Junior.";
	 
	else
	 cout << "Your grade level is Senior.";

	
	return 0;
	
	
}
