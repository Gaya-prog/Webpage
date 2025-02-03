#include <iostream>
#include <cmath>

using namespace std;

int main()

{
	
/*	The coordinates are (7,12) and (3,9).

    int x=3-7, y=9-12;
	int d= pow(x,2) + pow(y,2);
	
	cout << "The distance between point (7,12) and (3,9) is  " << sqrt(d) << endl;

    The coordinates are (-12,-15) and (22,5).*/
		
	int x=22-(-12), y=5-(-15);
	int d= pow(x,2) + pow(y,2);
	
	cout << "The distance between point (-12,-15) and (22,5) is " << sqrt(d) << endl;
	
	return 0;
	
}


