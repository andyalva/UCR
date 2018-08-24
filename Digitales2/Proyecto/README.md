# Proyecto Digitales 2

Transaction Layer PCIe

Grupo #4

## Integrantes

Andrés Alvarado B30316

Alejandro Rojas B36049

Fernando González B43023

## División de Trabajo

* Andres Alvarado
  * FIFO
  * Memory
* Alejandro Rojas
  * FSM
* Fernando González
  * Round Robin

## Modules

### FIFO
El FIFO (First In First Out) funciona como una maquina de estados el cual tiene un buffer que funciona como memoria.
Cada vez que se hace una lectura el buffer rota todos los datos 1 byte hacia arriba.

#### Inputs

* BIG - Si esta activo el FIFO sera de 16 bytes y si esta apagado el FIFO sera de 8 bytes

* Data_IN - La informacion que ingresa, la cual sera escrita si la bandera de Write esta encendida

* Write - Indica si habra una escritura

* Read - Indica que habrá una lectura

#### Outputs

* ErrNoData - Se trato de leer cuando no habia nada en el FIFO

* ErrStackOverflow - Se trato de escribir un dato cuando el FIFO estaba lleno

* almostFull - Indica que el FIFO esta apunto de llenarse

* almostEmpty - Indica que el FIFO esta casi vacio.

### Memory


### FSM


### Round Robin

Este modulo funciona para darle prioridad al tráfico que proviene de cierto FIFO, tomando los datos de un stream serial que presenta cada 2 bits cuál es el FIFO que debe entregar la información.

#### Inputs

* request - Cadena serial que indica la prioridad de petición al FIFO.

* valid - Bit de válido para poder continuar el trabajo o pausarlo.

#### Outputs

* pop_id - Presenta el ID de cual debe pedir un pop del FIFO.

* read - Bit para validar la lectura de datos desde un módulo siguiente al diseñado.


## Make it work


## Documentación

El reporte se encuentra en un archivo de PDF en la carpeta "docs".

## Señales FSM

Inputs: clk, reset, init, almost_full, almost_empty, empty_Fifo, no_empty_Fifo, Fifo_overflow(Error cuando esta lleno el FIFO y llega otro dato), data_Fifo(Datos que llegan del FIFO)

Outputs: error_full, pausa, continua,

