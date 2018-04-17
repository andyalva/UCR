#Andres Alvarado Velazquez
#B30316


.data
prompt: .asciiz "Ingrese el valor del mutliplicador "
prompt2: .asciiz "Ingrese el valor del mutliplicando "

.text
.globl main
main:

li $v0, 4
la $a0, prompt
syscall
li $v0, 5
syscall
move $s5, $v0  #Pide el valor del multiplicador y lo salva en t5

li $v0, 4
la $a0, prompt2
syscall
li $v0, 5
syscall
move $s4, $v0 #Pide el valor del multiplicando y lo salva en t4

li $t0, 1 #Mascara 00000001
li $t7, 0x80000000 #Mascara 1000000 
#inicializando varibles
add $s2, $zero, $zero # producto
add $t3, $zero, $zero # 64bits

addi $t6, $zero, 0 #contador
loop:

and $t1, $t0, $s5  #guarda el ultimo bit en t1

beq $t1, $zero, jump  # si el ultimo bit del multiplicador es 1, hace la suma, si no salta al jump

checkOverflow:
addu $t4, $s2, $s4
nor $t5, $s2, $zero
sltu $t5, $t5, $s4
bne $t5, $zero, addoverflow 

addition:
addu $s2, $s2, $s4    #Le suma el multiplicando al producto

jump:
sll $s4, $s4, 1  #mueve el multiplicando a la izq 1 bit
srl $s5, $s5, 1  #mueve el multiplicador a la derecha 1 bit

beq $t6, 32, exit  # Cuando el contador llegue a 32 saldra del ciclo
addi $t6, $t6, 1
j loop

addoverflow:
and $t5, $s4, $t7
beq $t5, $t7, temp1

next1: 

and $t2, $s2, $t7
beq $t2, $t7, temp2

next2:
addu $s2, $s2, $s4


beq $t5, $t7, sub1
next3:
beq $t5, $t7, sub2
next4:
subi $s2, $s2, 0x80000000

beq $t5, $t7, add1
next5:
beq $t5, $t7, add2
next6:

j jump

temp1:
subi $s4, $s4 0x80000000

j next1

temp2:
subi $s2, $s2 0x80000000
addi $t3, $t3, 1

j next2

sub1:
subi $s4, $s4, 0x80000000
j next3

sub2:
subi $s2, $s2, 0x80000000
j next4


add1:
addi $s4, $s4, 0x80000000
j next5

add2:
addi $s2, $s2, 0x80000000
j next6



exit:
	li $v0, 1
	move $a0, $s2
	syscall
	
	li $v0, 10
	syscall
