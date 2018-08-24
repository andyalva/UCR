#include <omp.h>

int  *matrixsum(int *a, int *b, int ENB, int row, int col)
{
    static int sum[320000];
    int i, j;
    int row4 = row / 4;


        if (ENB > 0){
            int num = omp_get_thread_num();

            for (i = num * row4; i < ((num+1)*row4); i++){
                //printf("%d", num);
                for(j = 0; j < col; j++){
                    sum[i*col+j] = a[i*col+j] + b[i*col+j];
                }
                
            }

        }
    

    return sum;
}

int *nose(int *a, int *b, int ENB, int row, int col){
    int in;
    int *ac;
    #pragma omp parallel for num_threads(4)
    for(in=0;in<4;in++){
    ac = matrixsum(a, b, ENB, row, col);
    }
    return ac;
}
