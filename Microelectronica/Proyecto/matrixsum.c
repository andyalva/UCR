
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