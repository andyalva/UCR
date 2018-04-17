# coding=utf-8

# Clases
from cache import Cache, Bloque
# Config
from config import MESI_m, MESI_e, MESI_s, MESI_i


class Bus(object):
    """
    Clase general de un bus de comunicaciones
    """
    def __init__(self, name, processor_1, processor_2, cache_l2):
        """
        name: String, nombre del bus
        processor_N: Objeto, instancia de la clase CPU
        cache_2: Objetos, cache tipo L2
        """
        self.name = name
        self.processor_1 = processor_1
        self.processor_2 = processor_2
        self.cache_l2 = cache_l2

    def busRd(self, direction, cache_1, cache_2):
        """
        direction: String, indica la direccion para lectura
            en hexadecimal, en base 16
        cache_N: Boleano, indica cual cache activa el bus
        """
        if cache_1:
            if not self.processor_2.cache_l1.bus_active:
                block_req = self.processor_2.prRd(direction, True)

                if block_req is None:
                    return None
                else:
                    if not (block_req.mesi == MESI_i):
                        block_req.mesi = MESI_s
                        block_req.count_lru += 1
                        return block_req
                    else:
                        return None

        elif cache_2:
            if not self.processor_1.cache_l1.bus_active:
                block_req = self.processor_1.prRd(direction, True)

                if block_req is None:
                    return None
                else:
                    if not (block_req.mesi == MESI_i):
                        block_req.mesi = MESI_s
                        block_req.count_lru += 1
                        return block_req
                    else:
                        return None

        else:
            self.cache_l2.bus_active = True
            block_req = self.cache_l2.cacheRd(direction)

            if block_req is None:
                # Simulacion que L2 trae dato de RAM
                tag = self.cache_l2.blockPrQuery(direction)[0]
                index = self.cache_l2.blockPrQuery(direction)[1]
                block_req = self.cache_l2.memory[2*index + 1]
                block_req.writeBlock(tag, '-RAM')

            else:
                if not (block_req.mesi == MESI_i) and block_req.bit_v:
                    block_req.mesi = MESI_s
                else:
                    # Simulacion que L2 trae dato de RAM
                    tag = self.cache_l2.blockPrQuery(direction)[0]
                    index = self.cache_l2.blockPrQuery(direction)[1]
                    block_req = self.cache_l2.memory[2*index + 1]
                    block_req.writeBlock(tag, direction)

            block_req.mesi = MESI_s
            self.cache_l2.bus_active = False
            return block_req.data

    def busUpgr(self, direction_hex, cache_1, cache_2):
        """
        Pone en invalido (MESI_i) bloques que antes se encontraban en
            compartidos (MESI_s) al desarrollarse una escritura en uno de los
            caches
        direction_hex: String, direccion en hexadecimal
        cache_N: Boleano, indica cual cache activa el busUpgr
        """
        block_req_l2 = self.cache_l2.cacheRd(direction_hex)

        if cache_1:
            block_req_l1 = self.processor_2.cache_l1.cacheRd(direction_hex)

        elif cache_2:
            block_req_l1 = self.processor_1.cache_l1.cacheRd(direction_hex)

        if not (block_req_l1 is None):
            block_req_l1.mesi = MESI_i

        if not (block_req_l2 is None):
            block_req_l2.mesi = MESI_i

    def mesiWrite(self, block_adr, cache_1, cache_2, direction_hex):
        """
        Cambia el estado de los bloques (MESI_x) en la escritura dependiendo
            del estado anterior
        block_adr: Entero, numero en base 10, indica la direccion del bloque
            a escribir dentro de la memoria
        cache_lN: Boleano, indica cual cache de los procesadores (cache_l1)
            activa el mesiWrite
        """
        if cache_1:
            tag = self.processor_1.cache_l1.blockPrQuery(direction_hex)[0]

            block_req = self.processor_1.cache_l1.memory[block_adr]
            block_mesi = block_req.mesi

        elif cache_2:
            tag = self.processor_2.cache_l1.blockPrQuery(direction_hex)[0]

            block_req = self.processor_2.cache_l1.memory[block_adr]
            block_mesi = block_req.mesi

        if block_mesi == MESI_m:
            block_req.writeBlock(tag, direction_hex)
            print '\n'

        elif block_mesi == MESI_e:
            block_req.writeBlock(tag, direction_hex)
            block_req.mesi = MESI_m
            print '\n'

        elif block_mesi == MESI_s:
            block_req.writeBlock(tag, direction_hex)
            block_req.mesi = MESI_m

            if cache_1:
                self.processor_1.bus.busUpgr(direction_hex, cache_1, cache_2)
            elif cache_2:
                self.processor_2.bus.busUpgr(direction_hex, cache_1, cache_2)

            print '\n'

        elif block_mesi == MESI_i:
            block_req.writeBlock(tag, direction_hex)
            block_req.mesi = MESI_m

            if cache_1:
                self.processor_1.bus.busUpgr(direction_hex, cache_1, cache_2)
            elif cache_2:
                self.processor_2.bus.busUpgr(direction_hex, cache_1, cache_2)

            print '\n'
