#include <stdio.h>

typedef char mytype;

int main() {
	int rows=10,cols=10;
	mytype **hMat=new mytype*[rows];
	hMat[0]=new mytype[rows*cols];

	for(int i=1;i<rows;i++)
		hMat[i]=hMat[i-1]+cols;

	//initialize 2D arrays
	for(int i=0;i<rows;i++) 
		for(int j=0;j<cols;j++)
			hMat[i][j]=i+j;

	mytype *dArr;
	cudaMalloc((void**)&dArr,rows*cols*sizeof(mytype));
	
	//copy to device
	cudaMemcpy(dArr,hMat[0],sizeof(mytype)*rows*cols,cudaMemcpyHostToDevice);

	//kernel call

	//copy from device
	cudaMemcpy(hMat[0],dArr,sizeof(mytype)*rows*cols,cudaMemcpyDeviceToHost);

	return 0;
}

	
