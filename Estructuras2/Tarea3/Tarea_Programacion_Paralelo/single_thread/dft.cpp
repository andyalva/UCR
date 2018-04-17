#include <iostream>
#include <stdlib.h>
#include <math.h>
#include <time.h>
#include "dft.h"

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
*/
void dft(double* inputReal, double* inputImag, double* outputReal, double* outputImag, int N){

  double sumReal, sumImag, angle;
  const double pi = 3.141592653589793;

  for (size_t k = 0; k < N; k++) {
    sumReal = 0;
    sumImag = 0;

    for (size_t t = 0; t < (N - 1); t++) {
      angle = -2*pi*t*k/N;
      sumReal = sumReal + inputReal[t]*cos(angle)/sqrt(N) + inputImag[t]*sin(angle)/sqrt(N);
      sumImag = sumImag - inputReal[t]*sin(angle)/sqrt(N) + inputImag[t]*cos(angle)/sqrt(N);
    }

    outputReal[k] = sumReal;
    outputImag[k] = sumImag;
  }
}


/**Funcion main
Genera aleatoriamente los numeros complejos en un par de arreglos de tamano N,
separandolo en arrays para parte imaginaria y real. LLama la funcion dft y mide
el tiempo de ejecucion de la funcion.
*/
int main(int argc, char const *argv[]) {

  //Definicion de variables
  double secs;
  clock_t t_ini, t_fin;
  int N = atoi(argv[1]);
  double *inputReal = new double[N];
  double *inputImag = new double[N];
  double *outputReal = new double[N];
  double *outputImag = new double[N];

  //Se genera los arreglos de entrada de forma aleatoria
  for (size_t input = 0; input < N; input++) {
    inputReal[input] = (double) (rand() % 100 + 1); // Value in the range 1 to 100
    inputImag[input] = (double) (rand() % 100 + 1);
  }

  t_ini = clock();
  dft(inputReal, inputImag, outputReal, outputImag, N);
  t_fin = clock();

  secs = (double)(t_fin - t_ini) / CLOCKS_PER_SEC;
  cout << "Tiempo de ejecucion: " << secs*1000 << " milisegundos" << endl;
  cout << "\n" << endl;

  delete inputReal, inputImag, outputReal, outputImag;
  return 0;
}
