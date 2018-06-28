#include <stdio.h>
#include <time.h>
#include "matrixsum.c"

int main(){
    clock_t begin = clock();

    int row, col, i, j;
    int ENB;

    int a[5][5] = {0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24};
    int b[5][5] = {0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24};

    col = 5;
    row = 5;

    //waitFor(5);
    ENB = 1;

    for (i=0; i<row; ++i){
        for (j=0; j<col; ++j){
            int val_a = a[i][j];
            int val_b = b[i][j];
            matrixsum(col,row,val_a,val_b,i,j,ENB);
        }
    }
    clock_t end = clock();
    double time_spent = (double)(end - begin) / CLOCKS_PER_SEC;

}

//Time delay
int waitFor (unsigned int secs) {
    unsigned int retTime = time(0) + secs;   // Get finishing time.
    while (time(0) < retTime);               // Loop until it arrives.
    return 0;
}