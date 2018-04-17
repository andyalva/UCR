#Andres Alvarado Velazquez
#B30316

#Tarea 6-7
.data
string: .asciiz "2 2 + P -30 + 10 + 7 - s"
err: .asciiz "No introdujo un valor adecuado"
input: .asciiz "          "
word: .word 0x00000000

.text
main:
la $a0, word

addi $s7, $zero, 2 # 2.0
sw $s7, 0($a0)
lwc1 $f26, 0($a0)
cvt.s.w $f27, $f26

addi $s7, $zero, 10 #try 10.0
sw $s7, 0($a0)
lwc1 $f26, 0($a0)
cvt.s.w $f6, $f26

addi $s7, $zero, 0 # 0.0 
sw $s7, 0($a0)
lwc1 $f26, 0($a0)
cvt.s.w $f30, $f26


addi $sp, $sp, -4
addi $s7, $zero, 0 #Posicion de la palabra
la $a0, input
addi $a1, $a1, 100 #Tamaño maximo del string
li $v0, 8 #$a0=buffer
syscall 

move $a2, $a0
jal getNumChar

calculator:
        jal Control
j calculator

exit:
	jal print		#Imprime $f5 (Resultado)
        addi $v0, $0, 10        # Exit system
        syscall



#Controlador   es el que se encarga de entender el caracter y hacer algo con el
Control:
addi $s7, $s7, 0 #Contador de posicion de la palabra
beq $s7, $s0, exit
add $a1, $a2, $s7 #Posicion del caracter a leer es: La posicion del string + la posicion de lectura

lb $t1, ($a1)
beq $t1, 32, conExit    #si hay un espacio se salta todas las preguntas
blt $t1, 48, noNumber
ble $t1, 57, getNumber

noNumber:
beq $t1, 43, Suma
beq $t1, 45, Resta
beq $t1, 42, Mul
beq $t1, 47, Div
beq $t1, 67, Clear
beq $t1, 99, Clear
beq $t1, 80, Pot
beq $t1, 112, Pot
beq $t1, 83, Sqrt
beq $t1, 115, Sqrt

conExit:
addi $s7, $s7, 1
j calculator


#Suma
Suma:

lwc1 $f1, 0($sp)
cvt.s.w $f3, $f1
add.s $f5, $f5, $f3
addi $sp, $sp, 4
addi $s1, $s1, -1 #
bne $s1, $zero, Suma #
 
addi $s7, $s7, 1
j Control

#Resta
Resta:
#Numero negativo
addi $a1, $a1, 1
lb $t4, 0($a1)
addi $a1, $a1, -1
blt $t4, 48, Fun
bgt $t4, 57, Fun
#Complemento 2
addi $s7, $s7, 1
jal getNumber

#notFirst:
lw $t4, 0($sp)
li $t6, 0xffffffff
xor $t4, $t4, $t6
addi $t4, $t4, 1
sw $t4, 0($sp)
addi $sp, $sp, 0
bne $t5, 1 endResta
lwc1 $f1, 0($sp)
cvt.s.w $f5, $f1
j endResta
#Funcion Resta
Fun:
lwc1 $f1, 0($sp)
cvt.s.w $f3, $f1
sub.s $f5, $f5, $f3
addi $sp, $sp, 4

addi $s1, $s1, -1 #
bne $s1, $zero, Fun #

endResta:
addi $s7, $s7, 1
j Control
#Division
Div:
lwc1 $f1, 0($sp)
cvt.s.w $f3, $f1
div.s $f5, $f5, $f3
addi $sp, $sp, 4

addi $s1, $s1, -1 #
bne $s1, $zero, Div #
addi $s7, $s7, 1
j Control
#Multiplicacion
Mul:
lwc1 $f1, 0($sp)
cvt.s.w $f3, $f1
mul.s $f5, $f5, $f3
addi $sp, $sp, 4

addi $s1, $s1, -1 #
bne $s1, $zero, Mul #
addi $s7, $s7, 1
j Control
#Raiz Cuadrada ###########################################

Sqrt:
addi $t0, $zero, 0  # Reset t0
mov.s $f4, $f5
Newton:
beq $t0, 20, next  #Hace 20 iteraciones

div.s $f15, $f4, $f6  # f15 = f4 / f6
add.s $f15, $f15, $f6  # f15 = f4/f6 + f6
div.s $f15, $f15, $f27 # f15 = (f4/f6 + f6) / 2

add.s $f6, $f10, $f15 # f6 = f5
addi $t0, $t0, 1     # t0 += 1
j Newton
next:
mov.s $f5, $f6
addi $s7, $s7, 1
j Control
#####################################################
#Potencia
Pot:
mul.s $f5, $f5, $f5
addi $s7, $s7, 1
j Control
#Clear
Clear:
add.s $f5, $f30, $f30
addi $s7, $s7, 1
addi $t5, $zero, 0
addi $s1, $zero, 0
j Control

#NUMBER
getNumber:
#la $a0, string
add $a1, $a2, $s7
addi $t0, $zero, 10 #reset t0
addi $s2, $zero, 0 #Reset s2


lp:
lbu $t1, 0($a1)  #lee el bit en ascii
beq $t1, $zero, exitNumber # Llego a un null
blt $t1, 48, exitNumber
bgt $t1, 57, exitNumber
addi $t1, $t1, -48 #Convierte de ascii a decimal
mul $s2, $s2, $t0
add $s2, $s2, $t1 
addi $a1, $a1, 1 #Mueve el bit
addi $s7, $s7, 1 #Contador posicion de palabra

j lp
exitNumber:

bne $t5, $zero, NotFirst # Si es el primer numero, no mueve el stack pointer.
sw $s2, 0($sp)
lwc1 $f1, 0($sp)
cvt.s.w $f5, $f1 #Transforma de int a float

addi $t5, $t5, 1 #Deja de ser el primer numero
jr $ra

NotFirst:
addi $t5, $t5, 1
addi $s1, $s1, 1
addi $sp, $sp, -4
sw $s2, 0($sp) #Salva el numero en el stack pointer


jr $ra 

#NUMCHAR
getNumChar:
li $t0, 0 # inicia el contador en cero
addi $a1, $a2, 0
loop:
lb $t1, 0($a1) # Carga el primer caracter
beq $t1, $zero, exitNumChar # busca por un NULL
addi $a1, $a1, 1 # incrementa el string lenght
addi $t0, $t0, 1 # incrementa el contador

move $s0, $t0

j loop
exitNumChar:

jr $ra

#Print
print:

li $v0, 2
mov.s $f12, $f5
syscall

jr $ra
