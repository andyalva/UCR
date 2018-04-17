#include <stdlib.h>
#include <assert.h>
#include <fstream>
#include <sstream>
#include <string>
#include <istream>
#include <vector>
#include <iomanip>
#include "cache.h"
using namespace std;

void MESI(vector<Cache *> cacheArray, int proc_num, ulong address, char op, int num_proc)
{
	//For INVALID State
	if (cacheArray[proc_num]->findLine(address) == NULL)
	{ //PrRd --- For Read(C) : INVALID ---> SHARED | For Read(!C) : INVALID ---> EXCLUSIVE | FOR Write : INVALID ---> MODIFIED
		bool C = false;
		for (int i = 0; i < num_proc; i++)
		{
			if (i != proc_num && cacheArray[i]->findLine(address) != NULL)
			{
				C = true;
			}
		}
		if (op == 'L')
		{
			if (C == true)
			{
				cacheArray[proc_num]->Access(address, op);
				(cacheArray[proc_num]->findLine(address))->setFlags(SHARED);
				//Cache to Cache Transfer when Line exists in another processor and State INVALID-->SHARED
				cacheArray[proc_num]->num_of_cache_to_cache_transfer++;
				//Generate BusRD to turn modified to shared
				for (int i = 0; i < num_proc; i++)
				{
					if (i != proc_num && cacheArray[i]->findLine(address) != NULL)
					{
						if ((cacheArray[i]->findLine(address))->getFlags() == MODIFIED)
						{
							cacheArray[i]->writeBack(address);
							//cacheArray[proc_num]->num_of_chache_to_cache_transfer++;
						}
						else if ((cacheArray[i]->findLine(address))->getFlags() == EXCLUSIVE)
						{
							cacheArray[i]->num_of_interventions++;
							//cacheArray[proc_num]->num_of_chache_to_cache_transfer++;
						}
						(cacheArray[i]->findLine(address))->setFlags(SHARED);
					}
				}
			}
			else
			{
				cacheArray[proc_num]->Access(address, op);
				(cacheArray[proc_num]->findLine(address))->setFlags(EXCLUSIVE);
			}
			return;
		}
		else
		{ //Invalid ---> Modified
			cacheArray[proc_num]->Access(address, op);
			(cacheArray[proc_num]->findLine(address))->setFlags(MODIFIED);
			//Generates BusRDx to invalidate other caches
			for (int i = 0; i < num_proc; i++)
			{
				if (i != proc_num && cacheArray[i]->findLine(address) != NULL)
				{
					if ((cacheArray[i]->findLine(address))->getFlags() == SHARED)
					{
						cacheArray[i]->num_of_invalidations++;
						cacheArray[proc_num]->num_of_cache_to_cache_transfer++;
					}
					else if ((cacheArray[i]->findLine(address))->getFlags() == MODIFIED)
					{
						cacheArray[i]->writeBack(address);
					}
					(cacheArray[i]->findLine(address))->invalidate();
				}
			}
			return;
		}
	}
	//For Exclusive State
	if ((cacheArray[proc_num]->findLine(address))->getFlags() == EXCLUSIVE)
	{ //PrRd --- For Read : EXCLUSIVE ---> EXCLUSIVE | FOR Write : EXCLUSIVE ---> MODIFIED
		if (op == 'L')
		{
			cacheArray[proc_num]->Access(address, op);
			(cacheArray[proc_num]->findLine(address))->setFlags(EXCLUSIVE);
			return;
		}
		else
		{ //EXCLUSIVE ---> MODIFIED
			cacheArray[proc_num]->Access(address, op);
			(cacheArray[proc_num]->findLine(address))->setFlags(MODIFIED);
			return;
		}
	}
	//For SHARED State
	if ((cacheArray[proc_num]->findLine(address))->getFlags() == SHARED)
	{
		/*READ*/
		if (op == 'L')
		{
			cacheArray[proc_num]->Access(address, op);
			return;
		}
		/*WRITE*/
		else
		{ //Shared  ----> Modificado
			cacheArray[proc_num]->Access(address, op);
			(cacheArray[proc_num]->findLine(address))->setFlags(MODIFIED);
			//Generates BusUPGR to invalidate other caches
			for (int i = 0; i < num_proc; i++)
			{
				if (i != proc_num && cacheArray[i]->findLine(address) != NULL)
				{
					if ((cacheArray[i]->findLine(address))->getFlags() == SHARED)
					{
						cacheArray[i]->num_of_invalidations++;
					}
					(cacheArray[i]->findLine(address))->invalidate();
				}
			}
			return;
		}
	}
	//Modificado
	if ((cacheArray[proc_num]->findLine(address))->getFlags() == MODIFIED)
	{
		if (op == 'L')
		{
			cacheArray[proc_num]->Access(address, op);
			(cacheArray[proc_num]->findLine(address))->setFlags(MODIFIED);
			return;
		}
		else
		{
			cacheArray[proc_num]->Access(address, op);
			(cacheArray[proc_num]->findLine(address))->setFlags(MODIFIED);
			return;
		}
	}

	return;
}

int main(int argc, char *argv[])
{

	ifstream fin;
	FILE *pFile;

	int pro;
	uchar op;
	uint addr;

	if (argv[1] == NULL)
	{
		printf("input format: ");
		printf("./smp_cache  <trace_file> \n");
		exit(0);
	}

	int cache_size = 16000; //16Kb
	int cache_assoc = 16;
	int blk_size = 16;
	int num_processors = 4;
	char *fname = (char *)malloc(20); //Archivo de lectura
	fname = argv[1];
	vector<Cache *> cacheArray;

	for (int i = 0; i < num_processors; i++)
	{
		Cache *c = new Cache(cache_size, cache_assoc, blk_size);
		cacheArray.push_back(c);
	}

	pFile = fopen(fname, "r");

	if (pFile == 0)
	{
		printf("Error en la lectura, no es un formato aceptado\n");
		exit(0);
	}

	//print las estadisticas //
	int cont = 0;
	while (!feof(pFile))
	{
		pro = cont % 4;
		cont = cont + 1;
		fscanf(pFile, "%x %c \n", &addr, &op);
		MESI(cacheArray, pro, addr, op, num_processors);
	}

	fclose(pFile);

	for (int i = 0; i < num_processors; i++)
	{
		cout << "============ Simulation results (Cache " << i << ") ============" << endl;
		cout << "01. number of reads:                " << cacheArray[i]->getReads() << endl;
		cout << "02. number of read misses:          " << cacheArray[i]->getRM() << endl;
		cout << "03. number of writes:               " << cacheArray[i]->getWrites() << endl;
		cout << "04. number of write misses:         " << cacheArray[i]->getWM() << endl;
		cout << "05. total miss rate:                " << fixed << setprecision(2) << (cacheArray[i]->getWM() + cacheArray[i]->getRM()) * 100.0 / (cacheArray[i]->getReads() + cacheArray[i]->getWrites()) << '%' << endl;
	}
	return 0;
}
