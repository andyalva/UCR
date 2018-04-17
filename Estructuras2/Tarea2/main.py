# coding=utf-8

# Clases
from bus import Bus
from cpu import CPU
from cache import Cache


def main():
    # CPUs
    CPU1 = CPU(1, 3)
    CPU2 = CPU(2, 1)

    # Caches
    L1_cpu1 = Cache('L1_cpu1', 16, 32, 2, True, True)
    L1_cpu2 = Cache('L1_cpu2', 16, 32, 2, True, True)

    L2 = Cache('L2', 128, 32, 0, False, False)

    # Ligar caches a CPUs
    CPU1.setCache(L1_cpu1)
    CPU2.setCache(L1_cpu2)

    # Bus
    BUS = Bus('Bus', CPU1, CPU2, L2)

    # Ligar bus a CPUs
    CPU1.setBus(BUS)
    CPU2.setBus(BUS)

    # Lectura de instrucciones
    CPU1.readInstruction()
    CPU2.readInstruction()
    L2.specifyDirection(CPU1.all_instructions[0])

    while True:
        for instruction in range(CPU1.set_instruction):
            try:
                CPU1.prAction()
            except IndexError:
                L1_cpu1.printMemory()
                print '\n\n'
                L1_cpu2.printMemory()
                # print '\n\n'
                # L2.printMemory()
                return

        for instruction in range(CPU2.set_instruction):
            try:
                CPU2.prAction()
            except IndexError:
                L1_cpu1.printMemory()
                print '\n\n'
                L1_cpu2.printMemory()
                # print '\n\n'
                # L2.printMemory()
                return

        CPU1.readInstruction()
        CPU2.readInstruction()


if __name__ == '__main__':
    main()
