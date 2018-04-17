#include "config.hpp"
#include <sstream>
#include <math.h>
#include <string>

using namespace std;

class Bloque{
	public:
		String tag;
		String data;
		char mesi;
		int bit_v;
		bool lru;
		int count_lru;
		String block_or_set;
		int len_bit_direction;

	Bloque(bool lru){
		this->tag = NULL;
		this->data = NULL;
		this->mesi = MESI_init;
		this->bit_v = BIT_V;
		this->lru = lru;

			if !lru {
			//  V | MESI | TAG | DATO
			this->block_or_set = [this->bit_v]+[this->mesi]+[this->tag]+[this->data]
			}
			else {
				this->count_lru = 0;
				this->block_or_set = [this->bit_v]+[this->count_lru]+[this->mesi]+ [this->tag]+[this->data];
			}
	};

	void writeBlock(String tag, String data="Guardar dato"){
		this->bit_v = 1;
		this->data = data;
		this->tag = tag;

		if (this->lru){
			this->count_lru = 1;		
		}
	};

	String infoBloque(){
		if (!this->lru){
			return std::to_string(this->bit_v) + "|" + this->mesi + "|" + this->tag + "|" this->data;
		}
		else{
			return std::to_string(this->bit_v) + "|"+ std::(this->count_lru)  + "|" + this->mesi + "|" + this->tag + "|" this->data;
		}		
	};

	~Bloque(){
	};
};


class Cache{
	public:
	bool lru;
	string name;
	int num_block_or_set;
	int block_size;
	int total_size;
	int way_set_associative;
	int tag;
	int index;
	int offset;
	bool bus_active;
	bool type;
	int hit;
	int miss;
	Bloque* memory;
	string Bin_num;
	

	Cache(string name, int total_size, int block_size, int way_set_associative, bool lru, bool cache_type){
	this->lru = lru;
	this->name = name;
	this->num_block_or_set = 0;
	this->block_size = block_size;
	this->total_size = total_size*1024;
	this->way_set_associative = way_set_associative
	this->tag = 0;
	this->index = 0;
	this->offset = log2(this->block_size/8);
	this->bus_active = FALSE;
	this->type = cache_type;
	this->hit = 0;
	this->miss = 0;

//Se ordena calcula el tamano del arreglo a memoria
		if (!this->way_set_associative){
			this->num_block_or_set = this->total_size/this->block_size
			this->memory = new int[2*this->num_block_or_set]; 
				
			for (int num_index = 0, num_block_or_set > num_index, ++num_index){
			// Index | Bloque o Set
				this->memory[2*num_index] = num_index;
				this->memory[2*num_index + 1] = Bloque(this->lru);	
				
			}
		}
		else{
			this->num_block_or_set = this->total_size/(this->way_set_associative*this->block_size);
			this->memory = new int[(1+ this->way_set_associative)*this->num_block_or_set];
			for(int num_index = 0, num_block_or_set > num_index, ++num_index){
			// Index | Bloque0 | Bloque1 | .... | BloqueN		
				this->memory[(this->way_set_associative + 1)*num_index] = num_index;
				for(int block = 0, way_set_associative > block, ++block){
					this->memory[(this->way_set_associative + 1)*num_index + block + 1] = Bloque(this->lru);
				}
			}
				
		}	

	};

	String hexcedToBin(direction){
		string sReturn = "";
		for (int i = 0; i < sHex.length (); ++i)
		{
			switch (direction[i])
			{
				case '0': sReturn.append ("0000"); break;
				case '1': sReturn.append ("0001"); break;
				case '2': sReturn.append ("0010"); break;
				case '3': sReturn.append ("0011"); break;
				case '4': sReturn.append ("0100"); break;
				case '5': sReturn.append ("0101"); break;
				case '6': sReturn.append ("0110"); break;
				case '7': sReturn.append ("0111"); break;
				case '8': sReturn.append ("1000"); break;
				case '9': sReturn.append ("1001"); break;
				case 'a': sReturn.append ("1010"); break;
				case 'b': sReturn.append ("1011"); break;
				case 'c': sReturn.append ("1100"); break;
				case 'd': sReturn.append ("1101"); break;
				case 'e': sReturn.append ("1110"); break;
				case 'f': sReturn.append ("1111"); break;
			}
		}
		return sReturn;
	};

	String hexcedToDec(direction){

	};

	String binToDec(direction){

	};

	specifyDirection(direction){
		if !this->index{
			len_bit_direction = (len(direction) - 2)*4;	
			this->index = log2(this->num_block_or_set);
			this->tag = len_bit_direction - this->index - this->offset;
		}
	};

	blockPrQuery(direction){
		bin_num = Cache.hexcedToBin(direction)
		tag  = bin_num.replace()
////////////////////////////////////////////////////////
	};

	

	~Cache(){
	};
};



























