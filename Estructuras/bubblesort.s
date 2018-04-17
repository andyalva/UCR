.data
Data: .word 87, 216, -54, 751, 1, 36, 1225, -446, -6695, -8741, 101, 9635, -9896, 4, 2008, -99, -6, 1, 544, 6, 0, 7899, 74, -42, -9
Coma: .asciiz "  ,   "

.text
.globl main

main:
#inicializar variables
addi $t5, $t5, 1 #hubo cambios o no
add $t4, $t4, $zero #contador largo de la palabra
add $t3, $t3, $zero #contador print

loop:
	la $t6, Data
	ble $t5, $zero, Print
	add $t5, $zero, $zero #reiniciar t5
	add $t4, $zero, $zero #reiniciar t4
	
Bubble:
	bgt $t4, 24, loop
	lw $t0, ($t6)
	lw $t1, 4($t6)
	
	bge $t1, $t0, Next
	
	#swap
	move $t2, $t1
	move $t1, $t0
	move $t0, $t2
	
	#Salva en el array
	sw $t0, ($t6)
	sw $t1, 4($t6)
	
	#Hubo un cambio de valores
	addi $t5, $t5, 1

Next:						
	addi $t4, $t4, 1
	addi $t6, $t6, 4
	j Bubble
	
	
Print:
	#Loop para imprimir todo lo que haya en el arreglo
	bgt $t3, 24, Exit
	
	lw $t1, ($t6) 
	
	li $v0, 1
	move $a0, $t1
	syscall
	
	li $v0, 4
	la $a0, Coma
	syscall
	
	addi $t6, $t6,  4
	addi $t3,$t3,1
	
	j Print
	
Exit:

	li $v0, 10
	syscall
