#include<iostream>
using namespace std;
int findMin(int x, int y, int z); 
int main()
{
int a, b, z, m;

cout << "Please enter first number: " ;
cin >> a;

cout << "Please enter second number : " ;
cin >> b;

cout << "Please enter third number : " ;
cin >> z;

m= findMin (a,b,z); 

cout << "The smaller number is " << m << endl;

return 0;
}

int findMin ( int x, int y, int z )
{
int p;
	if (x<y)
		z=x;
	else
		z=y;
return z;
}

