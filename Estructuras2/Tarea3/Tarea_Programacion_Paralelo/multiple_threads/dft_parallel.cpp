#include <iostream>
#include <stdlib.h>
#include <math.h>
#include <time.h>
#include <thread>
#include "dft_parallel.h"

using namespace std;

/**
Euler:
e^(−2πtk/n)*i = cos(2πtk/n)−i*sin(2πtk/n)

DFT:
X(k) = SUM(t=0 -> n-1) x(t)*e^(-2πtk/n)*i

Donde:
x(t)*e(−2πtk/n)*i = [Re(x(t))*cos(2πtk/n) + Im(x(t))*sin(2πtk/n)] + i*[−Re(x(t))*sin(2πtk/n) + Im(x(t))*cos(2πtk/n)]

real = [Re(x(t))*cos(2πtk/n) + Im(x(t))*sin(2πtk/n)]
imag = [−Re(x(t))*sin(2πtk/n) + Im(x(t))*cos(2πtk/n)]
*/

/**Funcion dft
Calcula la transformada discreta de Fourier.
inputReal: puntero double, arreglo de la parte real de los numeros complejos a obtener la DFT
inputImag: puntero double, arreglo de la imaginaria de los numeros complejos a obtener la DFT
outputReal: puntero double, arreglo de la parte real de la DFT resultante
outputImag: puntero double, arreglo de la parte imaginaria de la DFT resultante
N: int, cantidad de numeros complejos
startDFT: int, indica de donde debe iniciar a calcular la DFT
endDFT: int, indica de donde debe terminar a calcular la DFT
*/
void dft(double* inputReal, double* inputImag, double* outputReal, double* outputImag,
         int N, int startDFT, int endDFT){

  //Variables para mediciones de tiempo
  double secs;
  clock_t t_ini, t_fin;
  t_ini = clock();

  double sumReal, sumImag, angle;
  const double pi = 3.141592653589793;

  for (size_t k = startDFT; k < endDFT; k++) {
    sumReal = 0;
    sumImag = 0;

    for (size_t t = 0; t < (N - 1); t++) {
      //Calculo del angulo
      angle = -2*pi*t*k/N;

      //Se obtienen los resultados de la sumatoria
      sumReal = sumReal + inputReal[t]*cos(angle)/sqrt(N) + inputImag[t]*sin(angle)/sqrt(N);
      sumImag = sumImag - inputReal[t]*sin(angle)/sqrt(N) + inputImag[t]*cos(angle)/sqrt(N);
    }

    //Asigna los valores a los vectores de salida
    outputReal[k] = sumReal;
    outputImag[k] = sumImag;
  }

  t_fin = clock();

  secs = (double)(t_fin - t_ini) / CLOCKS_PER_SEC;
  cout << "Tiempo de ejecucion: " << secs*1000 << " milisegundos" << endl;
}


/**Funcion main
Genera aleatoriamente los numeros complejos en un par de arreglos de tamano N,
separandolo en arrays para parte imaginaria y real. LLama la funcion dft y mide
el tiempo de ejecucion de la funcion.
*/
int main(int argc, char const *argv[]) {

  //Tamano de los arreglos de entrada y salida
  int N = atoi(argv[1]);

  //Punteros de entradas y salidas
  double *inputReal = new double[N];
  double *inputImag = new double[N];
  double *outputReal = new double[N];
  double *outputImag = new double[N];

  //Se genera los arreglos de entrada de forma aleatoria
  for (size_t input = 0; input < N; input++) {
    inputReal[input] = (double) (rand() % 100 + 1); // Value in the range 1 to 100
    inputImag[input] = (double) (rand() % 100 + 1);
  }

  //Numero de thread
  int numThread = atoi(argv[2]);

  //Arreglo de thread
  thread t[numThread];

  //Variables para el calculo del rango de la transformada por thread
  int tmpN = N;
  int rateDFT = (int) N/numThread;
  int startDFT = 0;
  int endDFT = rateDFT;

  //Se habilitan los hilos de procesos
  for (size_t k = 0; k < numThread; k++) {
    if (k == (numThread - 1)) {
      endDFT = N;
    }

    t[k] = thread(dft, inputReal, inputImag, outputReal, outputImag, N, startDFT, endDFT);

    //Se ajusta los proximos valores del rango de ejecucion
    startDFT = startDFT + rateDFT;
    endDFT = endDFT + rateDFT;
  }

  for (size_t j = 0; j < numThread; j++) {
    t[j].join();
  }

  delete inputReal, inputImag, outputReal, outputImag;
  return 0;
}
