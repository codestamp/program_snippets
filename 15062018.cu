#include <cuda.h>
#include <iostream>

int main() {
	float **Tab2D;
	int X=5,Y=10;

	Tab2D=new float*[X];

	for(int i=0;i<X;i++) {
		Tab2D[i]=new float[Y];
	}

	//intialize with some random values
	for(int i=0;i<X;i++) {
		for(int j=0;j<Y;j++) {
			Tab2D[i][j]=(float)(rand()%10);
		}
	}

	//print
	for(int i=0;i<X;i++) {
		std::cout<<"\n";
		for(int j=0;j<Y;j++) {
			std::cout << Tab2D[i][j] << ' ';
		}
	}
	
	std::cout << std::endl;
	//free memory
	for(int i=0;i<X;i++)
		delete[] Tab2D[i];

	delete[] Tab2D;

	return 0;
}
