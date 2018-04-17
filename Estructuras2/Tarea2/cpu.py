# coding=utf-8

# Clases
from bus import Bus
from cache import Cache
# Config
from config import MESI_m, MESI_e, MESI_s, MESI_i


class CPU(object):
    """
    Clase general de un cpu. Solo se permite instanciar cuatro (4) CPUs
    """
    def __init__(self, num_cpu, set_instruction):
        """
        ptr_instr: Entero, indica la instruccion a ejecutar
        cache_l1: Objeto, instancia de Cache, es el cache tipo L1 que posee un
            cpu
        num_cpu: Entero, numero unico que para cada cpu instanciado
        all_instructions: Arreglo, contiene todas las instrucciones que el cpu
            va a ajecutar
        tmp_instructions: Arreglo, contiene las instrucciones que se ejecutan
            consecutivamente
        tmp_ptr: Entero, puntero que indica la siguiente instruccion a
            ejecutarse del tmp_instructions
        miss: Entero, indica la cantidad de veces que se tiene un miss time
        hit: Entero, indica la cantidad de veces que se tiene un hit time
        set_instruction: Entero, indica la cantidad de instrucciones
            ejecutadas consecutivamente
        """
        self.tmp_ptr = 0
        self.ptr_instr = 0
        self.num_cpu = num_cpu
        self.all_instructions = []
        self.tmp_instructions = []
        self.set_instruction = set_instruction

    def setCache(self, cache_l1):
        """
        Asocia un objeto de Cache al CPU
        """
        self.cache_l1 = cache_l1

    def setBus(self, bus):
        """
        Asocia un objeto de Bus al CPU
        """
        self.bus = bus

    def readInstruction(self):
        """
        Lee el archivo de las instrucciones que se van a correr
        Lee la cantidad de instrucciones definida en el
            set_instruction y las guarda en un atributo temporal
        Llama la funcion cache_l1.specifyDirection, para definir los tamanos
            del tag, index, offset
        """
        set_instruction = []

        if not len(self.all_instructions):
            if self.num_cpu == 1:
                self.all_instructions = open('cpu1.txt').read().split()
            elif self.num_cpu == 2:
                self.all_instructions = open('cpu2.txt').read().split()

        self.cache_l1.specifyDirection(self.all_instructions[0])

        try:
            for instruction in range(2*self.set_instruction):
                set_instruction.append(
                    self.all_instructions[self.ptr_instr + instruction])
        except IndexError:
            pass

        self.ptr_instr = self.ptr_instr + 2*self.set_instruction
        self.tmp_instructions = set_instruction

    def prAction(self):
        """
        Solicita una escritura o lectura de un bloque, lee las instrucciones
            de tmp_instructions y llama las funciones prRd y prWr dependiendo
            si se tiene escritura (S) o lectura (L)
        """
        # Direction | L or S
        instruction = [self.tmp_instructions[2*self.tmp_ptr],
                       self.tmp_instructions[2*self.tmp_ptr + 1]]

        if self.tmp_ptr == (self.set_instruction - 1):
            self.tmp_ptr = 0
        else:
            self.tmp_ptr += 1

        if instruction[1] == 'L':
            self.prRd(instruction[0])
        elif instruction[1] == 'S':
            self.prWr(instruction[0])
        else:
            raise ValueError('Instruccion no esta clara')

    def prRd(self, direction_hex, busRd_act=False):
        """
        Procesador realiza una lectura de un bloque
        direction_hex: String, representa un numero en hexadecimal
        busRd_act: Boleano, indica si prRd es activado por el busRd, en dicho
            caso True, el procesador no debe activar el bus de nuevo ya que
            debe retornar el bloque que ha leido al primer cache que activo el
            bus
        """
        block_req = self.cache_l1.cacheRd(direction_hex)

        if block_req is None:
            if not busRd_act:
                self.cache_l1.bus_active = True

                if self.num_cpu == 1:
                    block_req = self.bus.busRd(direction_hex, True, False)
                    try:
                        block_req.mesi = MESI_s
                    except AttributeError:
                        pass

                elif self.num_cpu == 2:
                    block_req = self.bus.busRd(direction_hex, False, True)
                    try:
                        block_req.mesi = MESI_s
                    except AttributeError:
                        pass

                if block_req is None:
                    data = self.bus.busRd(direction_hex, False, False)

                    # Escritura en cache
                    tag = self.cache_l1.blockPrQuery(direction_hex)[0]
                    index = self.cache_l1.blockPrQuery(direction_hex)[1]

                    lru_adr_and_block = self.cache_l1.obtainLRU(index, tag)
                    block_lru = self.cache_l1.memory[lru_adr_and_block[0]]
                    block_lru.writeBlock(tag, direction_hex+data)
                    block_lru.mesi = MESI_s

        else:
            print 'Lectura de bloque: ' + str(block_req.infoBloque())
            return block_req

    def prWr(self, direction_hex, data=None):
        """
        Procesador realiza una escritura a un bloque
        direction: String, representa un numero en hexadecimal, este debe
            convertirse a decimal
        """
        # [tag, index, offset] (en base 10)
        direction = self.cache_l1.blockPrQuery(direction_hex)

        tag_block_or_set_req = direction[0]
        index_block_or_set_req = direction[1]
        offset_block_or_set_req = direction[2]

        if not self.cache_l1.way_set_associative:
            # TODO: Implementar
            print 'Mapeo directo'
        else:
            if not self.cache_l1.lru:
                # TODO: Implementar cache N way set associative sin LRU
                return None
            else:
                # [block_adr, block_lru]
                lru_adr_and_block = \
                    self.cache_l1.obtainLRU(index_block_or_set_req,
                                            tag_block_or_set_req)

                if self.num_cpu == 1:
                    self.bus.mesiWrite(lru_adr_and_block[0],
                                       True, False, direction_hex)

                elif self.num_cpu == 2:
                    self.bus.mesiWrite(lru_adr_and_block[0],
                                       False, True, direction_hex)
