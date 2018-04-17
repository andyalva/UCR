.data
prompt: .asciiz "Ingrese un valor entre 0 y 45 "
Coma: .asciiz ", "


.text
.globl main
main:

li $v0, 4
la $a0, prompt
syscall
			
li $v0, 5
syscall

move $t5, $v0

#inicializando variables
addi $t1, $t1, 1  #fibonacci 0
addi $t2, $t2, 1  #fibonacci 1
add $t4, $t4, $zero #Contador dentro del loop

#Print 1,1 
li $v0, 1
move $a0, $t1
syscall
li $v0, 4
la $a0, Coma
syscall
li $v0, 1
move $a0, $t2
syscall

addi $t5, $t5, -2 #El valor de n par cuando salir del loop, sin contar los primero 2 valores

loop:
	bge $t4, $t5, END
	add $t3, $t1, $t2 # t3 es el proximo valor de fibonacci
	move $t1, $t2     # t1 = t2
	move $t2, $t3     # t2 = t3
	addi $t4, $t4, 1  # Contador +1
	
	# Print el resto de fibonacci
	li $v0, 4
	la $a0, Coma
	syscall
	li $v0, 1
	move $a0, $t3
	syscall
	
	j loop

END:	
	#Exit syscall
	li $v0, 10
	syscall

