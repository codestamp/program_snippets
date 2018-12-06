/*
*	Source: https://stackoverflow.com/questions/24704710/cuda-ptxas-options-v-shared-memory-and-cudafuncattributes-sharedsizebytes-do
* 	Three issues get clarified here:
*	1. use of cudaFuncAttributes(&attr,kernel), refer the documentation at
*	   http://developer.download.nvidia.com/compute/cuda/3_0/toolkit/docs/online/group__CUDART__HIGHLEVEL_g0b85e087210b47056cb6fc03a0e264e8.html
*	   This function obtains the attributes of the function (kernel), kernel must be a global function
*	2. Second is an issue on the sidelines about using printf statement inside kernel
*          https://docs.nvidia.com/cuda/cuda-c-programming-guide/index.html#formatted-output
*	   printf() can be used in devices with compute capability 2.x or higher, must use -arch=sm_20 and cudaDeviceSynchronize() after the kernel 
*          call inside the host function.
*      	3. usage of -Xptxas=-v for reading the memory usage
	   $ nvcc -Wno-deprecated-gpu-targets  -Xptxas=-v -arch=sm_20 -o 061218c 061218c.cu 
	   ptxas info    : 22 bytes gmem, 16 bytes cmem[14]
	   ptxas info    : Compiling entry function '_Z8mykernelv' for 'sm_20'
	   ptxas info    : Function properties for _Z8mykernelv
	       8 bytes stack frame, 0 bytes spill stores, 0 bytes spill loads
	       ptxas info    : Used 17 registers, 128 bytes smem, 32 bytes cmem[0]

*/


#include <stdio.h>

__global__ void mykernel(){
  __shared__ int data[32];
  printf("Hello\n");
  for (int i = 0; i < 32; i++)
    printf("data[%d] = %d\n", i, data[i]);
}

int main(){

  cudaFuncAttributes attr;
  mykernel<<<1,1>>>();
  cudaDeviceSynchronize();
  cudaFuncGetAttributes(&attr, mykernel);
  printf("shared mem usage: %zu bytes\n", attr.sharedSizeBytes);
  return 0;
}


