%%writefile dinamico.cu
#include <iostream>
#include <cuda_runtime.h>

// Kernel secundario que se lanzará de manera dinámica
__global__ void kernelSecundario() {
    int idx = threadIdx.x + blockIdx.x * blockDim.x;
    printf("Hilo %d ejecutando kernel secundario\n", idx);
}

// Kernel principal que lanza el kernel secundario
__global__ void kernelPrincipal() {
    int idx = threadIdx.x + blockIdx.x * blockDim.x;
    printf("Hilo %d ejecutando kernel principal\n", idx);

    // Lanzamiento dinámico de un 
    //nuevo kernel desde dentro del kernel principal
    if (idx == 0) {
        kernelSecundario<<<1, 10>>>();
    }
}

int main() {
    // Lanzamiento del kernel principal
    kernelPrincipal<<<1, 10>>>( );
    
    // Sincronización
    cudaDeviceSynchronize();
    
    return 0;
}
