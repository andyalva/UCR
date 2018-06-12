#include <stdio.h>
#include <time.h>

int main(){
    int row, col, i, j;
    int ENB;

    int a[5][5] = {0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24};
    int b[5][5] = {0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24};

    col = 5;
    row = 5;

    waitFor(5);
    ENB = 1;

    for (i=0; i<row; ++i){
        for (j=0; j<col; ++j){
            int val_a = a[i][j];
            int val_b = b[i][j];
            matrixsum(col,row,val_a,val_b,i,j,ENB);
        }
    }
}

//Time delay
int waitFor (unsigned int secs) {
    unsigned int retTime = time(0) + secs;   // Get finishing time.
    while (time(0) < retTime);               // Loop until it arrives.
    return 0;
}

int matrixsum(int c, int r,int a, int b, int i, int j, int ENB){  

    if(ENB > 0){
        int sum[5][5];
        
        //Suma ambos terminos
        sum[i][j]=a+b;

        // Displaying the result
        if(i==4 & j==4){
            printf("\nSum of two matrix is: \n\n");

            for(i=0;i<r;++i)
                for(j=0;j<c;++j)

                {
                    printf("%d   ",sum[i][j]);
                    if(j==c-1)
                    {
                        printf("\n\n");
                    }
                }
            return 0;
        }
    }
}