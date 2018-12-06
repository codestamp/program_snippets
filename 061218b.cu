#include <cuda.h>
/*
   declaring variables in CUDA kernel
   https://stackoverflow.com/questions/17933702/declaring-variables-in-a-cuda-kernel
   Using -Xptxas=-v option we find that the variable a is not considered in the optimization
*/


__global__ void kernel(float* delt,float* deltb) {
	int i=blockIdx.x*blockDim.x+threadIdx.x;
	float a;
	a=delt[i]+deltb[i];
	a+=1;
}

int main() {
	float *h_delt,*h_deltb;
	h_delt=(float*)malloc(sizeof(float)*400);
	h_deltb=(float*)malloc(sizeof(float)*400);

	for(int i=0;i<400;i++) {
		h_delt[i]=i;
		h_deltb[i]=i;
	}

	float *d_delt,*d_deltb;
	cudaMalloc((void**)&d_delt,sizeof(float)*400);
	cudaMalloc((void**)&d_deltb,sizeof(float)*400);

	cudaMemcpy(d_delt,h_delt,sizeof(float)*400,cudaMemcpyHostToDevice);
	cudaMemcpy(d_deltb,h_deltb,sizeof(float)*400,cudaMemcpyHostToDevice);

	int threads=200;
	uint3 blocks=make_uint3(200,1,1);
	kernel<<<blocks,threads>>>(d_delt,d_deltb);

	free(h_delt); free(h_deltb);
	cudaFree(d_delt); cudaFree(d_deltb);

	return 0;
}
