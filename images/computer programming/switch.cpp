#include <iostream>

using namespace std;

int main()

{
	int opselect, num1, num2;
	
	cout << "Plese enter two integer numbers." << endl;
	cin >> num1 >> num2;
	
	cout << "Enter a select code: " << endl;
	cout << " 1 for addition" << endl;
	cout << " 2 for subtraction " << endl;
	cout << " 3 for multiplication " << endl;
	cout << " 4 for division " << endl;
	cout << " 5 for modulus " << endl;
	cout << " 0 to exit" << endl;
	cin >> opselect;
	
	switch (opselect)
	{
		case 1:
		 cout << num1 << " + " << num2 << " = " << num1+num2 << endl;
		 break;
		 
		case 2:
		  cout << num1 << " - " << num2 << " = " << num1-num2 << endl;
		  break;
		  
		case 3:
		   cout << num1 << " * " << num2 << " = " << num1*num2 << endl;
		   break;
		   
		case 4:
		    cout << num1 << " / " << num2 << " = " << num1/num2 << endl;
		    break;
		    
		case 5:
			 cout << num1 << " % " << num2 << " = " << num1%num2 << endl;
			 break;
			 
		case 0:
			break;
			
		default:
			cout << "You have entered an invalid code." << endl;
	}

return 0;

}	
