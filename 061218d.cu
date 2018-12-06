#include <stdio.h>
/* 
   using printf in kernel, don't forget to call 
   cudaDeviceSynchronize() after kernel call in the host
*/

__global__ void helloCUDA(float f)
{
    printf("Hello thread %d, f=%f\n", threadIdx.x, f);
}

int main()
{
    helloCUDA<<<1, 5>>>(1.2345f);
    cudaDeviceSynchronize();
    return 0;
}
