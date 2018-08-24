#include <stdio.h>
#include <time.h>
#include "matrixsum.c"
#include <omp.h>

int main()
{
    clock_t begin = clock();

    int row = 8000;
    int col = 40;
    int i, j;
    int ENB;
    int *c;
    int a[320000];
    int b[320000];


    for (i = 0; i< row*col; i++){
        a[i] = i;
        b[i] = i;
    }

    //waitFor(5);
    ENB = 1;

    //Como corren al mismo tiempo no entra en orden.
    printf("Num of CPU: %d\n", omp_get_num_procs());
    #pragma omp parallel for num_threads(4)
    for(i = 0; i<4; i++){
    c = matrixsum(a, b, ENB, row, col);
    printf("entro vez #%d \n", i);
    }

    //Print Matrix Sum
    /*for (i = 0; i < row; i++)
    {
        for (j = 0; j < col; j++)
        {

            printf("%d, ", c[i * col + j]);
            if (j == col - 1)
            {
                printf("\n");
            }
        }
    }*/
    
    clock_t end = clock();
    double time_spent = (double)(end - begin) / CLOCKS_PER_SEC;
    printf ("%f", time_spent);
    return 0;
}

//Time delay
int waitFor(unsigned int secs)
{
    unsigned int retTime = time(0) + secs; // Get finishing time.
    while (time(0) < retTime)
        ; // Loop until it arrives.
    return 0;
}