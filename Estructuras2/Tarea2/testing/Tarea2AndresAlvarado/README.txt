Para ejecutar el programa primero hay que compilarlo con el comando make

$ make

Con esto se creará el ejecutable mesi_cache. Para correrlo este requiere un argumento que sera el .txt que se asignó para la lectura.
Antes de esto se debe solicitar un nodo del cluster por lo que se debe correr el comando:

$ qsub -I -q phi-debug

Con esto ya se puede proceder a correr el programa de la siguiente manera:

$ ./mesi_cache memory-trace-gcc.trace


