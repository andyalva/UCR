#include <stdio.h>
#include <omp.h>
#include <time.h>
/*
int main(){
    int n;
    int this_thread = omp_get_thread_num();
    int num_threads = omp_get_num_threads();
    int my_start = (this_thread  ) * 10 / num_threads;
    int my_end   = (this_thread+1) * 10 / num_threads;

    #pragma omp parallel for num_thread(4)
    for(n=my_start; n<my_end; ++n){
        printf(" %d, %d", this_thread, num_threads);
        printf(".\n");}
        return 0;
}*/

test() {
    int i;
    int h = omp_get_thread_num();
   for(i=0;i<100000000;i++);
   printf("%d", h);
}
main() {
    clock_t begin = clock();
    int i;
    printf("Num of CPU: %d\n", omp_get_num_procs());
    #pragma omp parallel for num_threads(4)
    for(i=0;i<100;i++) test();
    clock_t end = clock();
    double time_spent = (double)(end - begin) / CLOCKS_PER_SEC;
    printf("\n");
    printf ("%f", time_spent);
}