#Andres Alvarado Velazquez
#B30316


.data
prompt: .asciiz "Ingrese el valor del divisor "
prompt2: .asciiz "Ingrese el valor del dividendo "

.text
.globl main
main:

li $v0, 4
la $a0, prompt
syscall

li $v0, 5
syscall

move $s0, $v0  #Pide el valor del divisor y lo salva en t5

li $v0, 4
la $a0, prompt2
syscall
li $v0, 5
syscall
move $s2, $v0 #Pide el valor del Residuo y lo salva en t4

#inicializando variables de 64bits
addi $s0, $s0, 0
addi $s1, $zero, 0 #Dividendo

addi $s2, $s2, 0
addi $s3, $zero, 0 #Residuo

move $s1, $s0 #mueve los primeros 32 bits, 32 bits hacia la izq
addi $s0, $zero, 0

addi $t0, $zero, 0 #contador para el primer 1 en 32bits
addi $t1, $zero, 0x00000001
addi $t2, $zero, 0x80000000


loop:
srl $s0, $s0, 1 
and $t3, $t1, $s1  #el ultimo bit de s1 es igual a 1?
bne $t3, $t1, next #Si, si se le suma 10000000 a s0
addi $s0, $s0, 0x80000000

next: 
srl $s1, $s1, 1
bne $s1, $zero, loop

Divisor:
addi $t6, $t6, 1
beq $t6, 34, exit
bgt $s0, $s2, negativo # Divisor - Residuo > 0
bleu $s0, $s2, positivo # Divisor - Residuo < 0


negativo:
srl $s0, $s0, 1     #Rota divisor a la derecha
sll $s4, $s4, 1     #Rota resultado a la izq
j  Divisor

positivo:
sll $s4, $s4, 1   #Rota resultado a la izq
addi $s4, $s4, 1  #Le suma 1
subu $s2, $s2, $s0  # Residuo = Residuo - Divisor
srl $s0, $s0, 1
j Divisor



exit:
	li $v0, 1
	move $a0, $s4
	syscall
	
	li $v0, 10
	syscall
exit2:
	li $v0, 1
	move $a0, $s4
	syscall
	
	li $v0, 10
	syscall


