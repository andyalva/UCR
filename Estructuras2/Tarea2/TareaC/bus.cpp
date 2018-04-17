#include "cache.cpp"
#include "config.hpp"
#include <iostream>
#include <string>

using namespace std;

class Bus{
	public:
	string name;
	Processor processor_1;
	Processor processor_2;
	Processor processor_3;
	Processor processor_4;
	Cache cache_l2;
	Cache cache_1, 
	Cache cache_2
	Cache cache_3; 
	Cache cache_4;
	string direction;
	int block_adr;
	string direction_hex;
	string tag;


	Bus(string name, Cache processor_1, Cache processor_2, Cache processor_3, Cache processor_4, Cache cache_1, Cache cache_2, Cache cache_3, Cache cache_4){
		this->name = name;
		this->processor_1 = processor_1;
		this->processor_2 = processor_2;
		this->processor_3 = processor_3;
		this->processor_4 = processor_4;
		this->cache_l2 = cache_l2;

	};

	Bloque busRd(string direction, Cache processor_1, Cache processor_2, Cache processor_3, Cache processor_4, Cache cache_1, Cache cache_2, Cache cache_3, Cache cache_4){
		if (cache_1){
			if !this->processor_2.cache_l1.bus_active{
				if !this->processor_3.cache_l1.bus_active{
					if !this->processor_4.cache_l1.bus_active{
						block_req = this->processor_2.prRd(direction, TRUE);
						if (block_req == NULL){
							return NULL;		
						}
						else{
							if !(block_req.mesi == MESI_i){
								block_req.mesi = MESI_s;
								block_req.count_lru += 1;
								return block_req;
							}
							else{
								return	NULL;		
							}			
						}
					}
				}
			}
		}
		else if( cache_2){
			if !this->processor_1.cache_l1.bus_active{
				if !this->processor_3.cache_l1.bus_active{
					if !this->processor_4.cache_l1.bus_active{
						block_req = this->processor_2.prRd(direction, TRUE);
						if (block_req == NULL){
							return NULL;		
						}
						else{
							if !(block_req.mesi == MESI_i){
								block_req.mesi = MESI_s;
								block_req.count_lru += 1;
								return block_req;
							}
							else{
								return	NULL;			
							}			
						}
					}
				}
			}
		}
		else if (cache_3){
			if !this->processor_1.cache_l1.bus_active{
				if !this->processor_2.cache_l1.bus_active{
					if !this->processor_4.cache_l1.bus_active{
						block_req = this->processor_2.prRd(direction, TRUE);
						if (block_req == NULL){
							return NULL;		
						}
						else{
							if !(block_req.mesi == MESI_i){
								block_req.mesi = MESI_s;
								block_req.count_lru += 1;
								return block_req;
							}
							else{
								return	NULL;			
							}			
						}
					}
				}
			}
		}
		else if( cache_4){
			if !this->processor_1.cache_l1.bus_active{
				if !this->processor_2.cache_l1.bus_active{
					if !this->processor_3.cache_l1.bus_active{
						block_req = this->processor_2.prRd(direction, TRUE);
						if (block_req == NULL){
							return NULL;		
						}
						else{
							if !(block_req.mesi == MESI_i){
								block_req.mesi = MESI_s;
								block_req.count_lru += 1;
								return block_req;
							}
							else{
								return	NULL;			
							}			
						}
					}
				}
			}
		}
		else{
			this->cache_l2.bus_active = TRUE;
			block_req = this->cache_l2.cacheRd(direction);
			
			if (block_req == NULL){
				//Simulacion que L2 trae el dato a RAM
				tag = this->cache_l2.blockPrQuery(direction)[0];
				index = this->cache_l2.blockPrQuery(direction)[1];
				block_req = this->cache_l2.memory[2*index + 1];
				block_req.writeBlock(tag, "-RAM");	
			}
			else{
				if !(block_req.mesi == MESI_i) & block_req.bit_v{
					block_req.mesi = MESI_s;
				}
				else{ //Simulacion
					tag = this->cache_l2.blockPrQuery(direction)[0];
					index = this->cache_l2.blockPrQuery(direction)[1];
					block_req = this->cache_l2.memory[2*index + 1];
					block_req.writeBlock(tag, "-RAM");
				}
			}
			block_req.mesi = MESI_s;
			this->cache_l2.bus_active = FALSE;
			return block_req.data;
		}
	};

	void busUpgr(string direction_hex, Cache cache_1, Cache cache_2, Cache cache_3, Cache cache_4){
		block_req_l2 = this->cache_l2.cacheRd(direction_hex);
		
		if (cache_1){
				
		}
		else if( cache_2){

		}
		else if (cache_3){

		}
		else if (cache_4){

		}
		
		if (!(block_req_l1 == NULL)){
			block_req_l1.mesi = MESI_i;		
		}
		if !(block_req_l2 == NULL){
			block_req_l2.mesi = MESI_i;	
		}

	};

	mesiWrite(int block_adr, Cache cache_1, Cache cache_2, Cache cache_3, Cache cache_4, string direction_hex){
		if( cache_1){
			tag = this->processor_1.cache_l1.blockPrQuery(direction_hex)[0];
			block_req = this->processor_1.cache_l1.memory[block_adr];
			block_mesi = block_req.mesi;
		}
		else if( cache_2){
			tag = this->processor_2cache_l1.blockPrQuery(direction_hex)[0];
			block_req = this->processor_2.cache_l1.memory[block_adr];
			block_mesi = block_req.mesi;
		}
		else if (cache_3){
			tag = this->processor_3.cache_l1.blockPrQuery(direction_hex)[0];
			block_req = this->processor_3.cache_l1.memory[block_adr];
			block_mesi = block_req.mesi;
		}
		else if (cache_4){
			tag = this->processor_4.cache_l1.blockPrQuery(direction_hex)[0];
			block_req = this->processor_4.cache_l1.memory[block_adr];
			block_mesi = block_req.mesi;
		}
		
		if (block_mesi == MESI_m){
			block_req.writeBlock(tag, direction_hex);
			cout << '\n';		
		}

		else if (block_mesi == MESI_e){
			block_req.writeBlock(tag, direction_hex);
			block_req.mesi = MESI_m;
			cout << '\n';		
		}
		else if (block_mesi == MESI_s){
			block_req.writeBlock(tag, direction_hex);
			block_req.mesi = MESI_m;
			cout << '\n';		
		
			if (cache_1){
				this->processor_1.bus.busUpgr(direction_hex, cache_1, cache_2, cache_3, cache_4);			
			}
			else if(cache_2){
				this->processor_2.bus.busUpgr(direction_hex, cache_1, cache_2, cache_3, cache_4);			
			}
			else if (cache_3){
				this->processor_3.bus.busUpgr(direction_hex, cache_1, cache_2, cache_3, cache_4);			
			}		
			else if (cache_4){
				this->processor_4.bus.busUpgr(direction_hex, cache_1, cache_2, cache_3, cache_4);			
			}
			
			cout << '\n';
		}
		else if (block_mesi == MESI_i){
			block_req.writeBlock(tag, direction_hex);
			block_req.mesi = MESI_m;
			cout << '\n';		
		
			if (cache_1){
				this->processor_1.bus.busUpgr(direction_hex, cache_1, cache_2, cache_3, cache_4);			
			}
			else if (cache_2){
				this->processor_2.bus.busUpgr(direction_hex, cache_1, cache_2, cache_3, cache_4);			
			}
			else if (cache_3){
				this->processor_3.bus.busUpgr(direction_hex, cache_1, cache_2, cache_3, cache_4);			
			}		
			else if (cache_4){
				this->processor_4.bus.busUpgr(direction_hex, cache_1, cache_2, cache_3, cache_4);			
			}
			
			cout << '\n';
		}
		
	};
};
