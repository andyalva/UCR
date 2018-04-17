#include "bus.cpp"
#include "cache.cpp"
#include "config.hpp"
#include <fstream>
#include <string>

class CPU{
	int tmp_ptr;
	int ptr_instr;
	int num_cpu;
	int* all_instructions;
	int* tmp_instructions;
	int cont_instructions;
	Cache* cache_l1;
	Bus* bus;


	CPU(int num_cpu){
		this->tmp_ptr = 0;
		this->ptr_instr = 0;
		this->num_cpu = num_cpu;
		this->all_instructions = NULL;
		this->tmp_instructions = NULL;
		this->cont_instructions = 0;
	};

	void setCache(Cache* cache_l1){

		this->cache_l1 = cache_l1;

	};
	
	void setBus(Bus* bus){

		this->bus = bus;

	};

	void readInstruction(){
		ifstream infile("cpu.txt");
		if !(this->all_instructions.size()){
			if (this->num_cpu == 1){
				if(infile.good()){
					this->all_instructions = getline(infile, this->all_instructions);
				}  
			}
		}
	
	};

	~CPU(int num_cpu, int set_instruction){

	};



};
