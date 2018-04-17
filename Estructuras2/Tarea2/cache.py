# coding=utf-8

# Numpy
import numpy as np
# Config
from config import MESI_m, MESI_e, MESI_s, MESI_i, MESI_init, BIT_V


class Bloque(object):
    """
    Clase general de un bloque en el cache
    """
    def __init__(self, lru):
        """
        lru: Boleano, True indica si el bloque posee politica de reemplazo LRU
        """
        self.tag = None
        self.data = None
        self.mesi = MESI_init
        self.bit_v = BIT_V
        self.lru = lru

        if not lru:
            #  V | MESI | TAG | DATO
            self.block_or_set = [self.bit_v]+[self.mesi]+[self.tag]+[self.data]

        else:
            self.count_lru = 0

            #  V | LRU | MESI | TAG | DATO
            self.block_or_set = [self.bit_v]+[self.count_lru]+[self.mesi] + \
                                [self.tag]+[self.data]

    def writeBlock(self, tag, data='Guardar dato'):
        """
        Cambia el contenido del tag y data del bloque, ademas vuelve el bloque
            un bloque valido para lectura. No altera el estado de MESI
        tag: String, tag de la direccion
        data: String, contenido a guardar en el data del bloque
        """
        self.bit_v = 1
        self.data = data
        self.tag = tag

        if self.lru:
            self.count_lru = 1

    def infoBloque(self):
        """
        Retorna un string con el contenido del bloque
        """
        if not self.lru:
            return str(self.bit_v) + ' | ' + str(self.mesi) + ' | ' + \
                str(self.tag) + ' | ' + str(self.data)

        else:
            return str(self.bit_v) + ' | ' + str(self.count_lru) + ' | ' + \
                str(self.mesi) + ' | ' + str(self.tag) + ' | ' + str(self.data)


class Cache(object):
    """
    Clase general de un cache
    """

    def __init__(self, name, total_size, block_size,
                 way_set_associative, lru, cache_type):
        """
        nombre: String, indica el nombre del cache
        total_size: Entero, indica el tamaño del cache en kilobits
        block_size: Entero, indica el tamaño del bloque en bits
        way_set_associative: Entero, indica el numero de way set associative
        lru: Boleano, indica si el cache tiene politica LRU, de no tenerlo la
            politica es mapeo directo
        cache_type: Boleano, cuando es True indica que el cache es de tipo L1,
            de lo contrario es tipo L2
        """
        self.lru = lru
        self.name = name
        self.num_block_or_set = 0
        self.block_size = block_size
        self.total_size = total_size*1024
        self.way_set_associative = way_set_associative

        self.tag = 0
        self.index = 0
        self.offset = int(np.log2(self.block_size/8))

        self.bus_active = False
        self.type = cache_type

        self.hit = 0
        self.miss = 0

        # Se ordena calcula el tamaño del arreglo de la memoria
        if not self.way_set_associative:
            self.num_block_or_set = self.total_size/self.block_size
            self.memory = [None]*2*self.num_block_or_set

            for num_index in range(self.num_block_or_set):
                # Index | Bloque o Set
                self.memory[2*num_index] = num_index
                self.memory[2*num_index + 1] = Bloque(self.lru)
        else:
            self.num_block_or_set = \
                self.total_size/(self.way_set_associative*self.block_size)

            self.memory = \
                [None]*(1 + self.way_set_associative)*self.num_block_or_set

            for num_index in range(self.num_block_or_set):
                # Index | Bloque0 | Bloque1 | .... | BloqueN
                self.memory[(self.way_set_associative + 1)*num_index] = \
                    num_index

                for block in range(self.way_set_associative):
                    self.memory[(self.way_set_associative + 1)*num_index +
                                block + 1] = Bloque(self.lru)

    @staticmethod
    def hexcedToBin(direction):
        """
        Convierte un numero en base 16 a base 2, de hexadecimal a binario
        """
        hexced_to_dec = int(direction, 16)
        dec_to_bin = bin(hexced_to_dec)
        return dec_to_bin

    @staticmethod
    def hexcedToDec(direction):
        """
        Convierte un numero en base 16 a base 10, de hexadecimal a decimal
        """
        return int(direction, 16)

    @staticmethod
    def binToDec(bin_num):
        """
        Convierte un numero en base 2 a base 10
        """
        return int(bin_num, 2)

    def specifyDirection(self, direction):
        """
        Indica los tamaños en bit de tag, index en base a una direccion dada
        direcction: String, direccion en hexadecimal, incluye el '0x'
        """
        if not self.index:
            len_bit_direction = (len(direction) - 2)*4

            self.index = int(np.log2(self.num_block_or_set))
            self.tag = len_bit_direction - self.index - self.offset

    def blockPrQuery(self, direction):
        """ Retorna [tag, index, offset] (en base 10)
        En base a una direccion dada en hexadecimal, retorna el tag, index y
            offset que construye la direccion
        direction: String, representa un numero en hexadecimal, base 16
        """
        bin_num = Cache.hexcedToBin(direction)

        tag = bin_num.replace('0b', '')[:-int((self.index + self.offset))]
        index = bin_num[-int(self.index + 1):-int(self.offset)]
        offset = bin_num[-int(self.offset):]

        offset = Cache.binToDec(offset)
        tag = Cache.binToDec(tag)
        index = Cache.binToDec(index)
        return [tag, index, offset]

    def obtainLRU(self, index, tag):
        """ Retorna [block_adr, block_lru]
        Retorna el objeto Bloque junto con su ubicacion en la mamoria, del
            bloque que va a reemplazarse bajo la politica LRU
        index: Numero, indica en base 10 el numero de set o bloque en el cache
        tag: Numero, indica en base 10 el numero de tag
        """
        if not self.lru:
            raise ValueError('Cache no tiene politica LRU')
            return None
        else:
            if not self.way_set_associative:
                return None
            else:
                index_lru = index*(self.way_set_associative + 1)

                """
                for block in range(self.way_set_associative):
                    block_lru = self.memory[index_lru + block + 1]
                    block_adr = index_lru + block + 1

                    if not block_lru.bit_v:
                        return [block_adr, block_lru]
                """

                block_lru = self.memory[index_lru + 1]
                block_adr = index_lru + 1

                for block in range(self.way_set_associative):
                    if block_lru.count_lru > self.memory[index_lru +
                                                         block + 1].count_lru:

                        block_lru = self.memory[index_lru + block + 1]
                        block_adr = index_lru + block + 1

                    else:
                        continue

                return [block_adr, block_lru]

    def cacheRd(self, direction_hex):
        """ Retorna block_req o None
        Cache realiza una busque de un bloque a partir de la direccion
            hexadecimal, aumenta el contador de miss o hit
        direction_hex: String, direccion en hexadecimal
        """
        direction = self.blockPrQuery(direction_hex)

        tag_block_req = direction[0]
        index_block_req = direction[1]

        if not self.way_set_associative:
            block_req = self.memory[2*index_block_req + 1]

            if block_req.tag == tag_block_req and block_req.bit_v and block_req.mesi != MESI_i:
                self.hit += 1
                print 'Cache: ' + str(self.name) + ', S: HIT en ' + \
                    str(direction_hex)

                try:
                    block_req.count_lru += 1
                except:
                    pass

                return block_req

            else:
                print 'Cache: ' + str(self.name) + ', S: MISS en ' + \
                    str(direction_hex) + '\n\n'
                self.miss += 1
                return None

        else:
            for block in range(self.way_set_associative):
                block_req = self.memory[(self.way_set_associative +
                                         1)*index_block_req + 1 + block]

                if block_req.tag == tag_block_req and block_req.bit_v and block_req.mesi != MESI_i:
                    self.hit += 1
                    print 'Cache: ' + str(self.name) + ', S: HIT en ' \
                        + str(direction_hex)

                    block_req.count_lru += 1
                    return block_req
                else:
                    continue

            self.miss += 1
            print 'Cache: ' + str(self.name) + ', S: MISS en ' \
                + str(direction_hex)
            return None

    def printMemory(self):
        """
        Imprime la memoria cache: Index | Bloque o set
        """
        if not self.way_set_associative:
            for num_index in range(self.num_block_or_set):
                print '         '*4 + str(self.memory[2*num_index]) + \
                    '   ' + self.memory[2*num_index + 1].infoBloque()
        else:
            for num_index in range(self.num_block_or_set):
                to_print = ''

                for way_set in range(self.way_set_associative + 1):
                    try:
                        to_print = to_print + '    ' + str(
                            self.memory[(1 + self.way_set_associative)*num_index
                                        + way_set].infoBloque()) + '   '
                    except AttributeError:
                        to_print = to_print + '    ' + str(
                            self.memory[(1 + self.way_set_associative)*num_index
                                        + way_set]) + '   '

                print '         '*4 + to_print

    def getInformation(self):
        print '\n' + 'GENERAL INFORMATION: ' + self.name
        print 'lru: ' + str(self.lru)
        print 'num_block_or_set: ' + str(self.num_block_or_set)
        print 'block_size (bits): ' + str(self.block_size)
        print 'total_size (megabits): ' + str(self.total_size/1024)
        print 'way_set_associative: ' + str(self.way_set_associative)
        print 'tag: ' + str(self.tag)
        print 'index: ' + str(self.index)
        print 'offset: ' + str(self.offset)
        print 'hit: ' + str(self.hit)
        print 'miss: ' + str(self.miss)
