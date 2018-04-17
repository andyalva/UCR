#Andres Alvarado Velazquez
#B30316

#Tarea 8
.data
err: .asciiz "No introdujo un valor adecuado"
minDist: .asciiz "Las medidas que introdujo no son correctas para hacer un triangulo"
input: .asciiz "        "
nl: .asciiz "\n"
string1: .asciiz "Introduzca el primer lado del triangulo \n"
string2: .asciiz "Introduzca el segundo lado del triangulo \n"
string3: .asciiz "Introduzca el tercer lado del triangulo \n"
Hipo: .asciiz "La hipotenusa es: "
Equi:  .asciiz "Es un triangulo equilatero" 
Iso: .asciiz "Es un triangulo isosceles" 
Esca:  .asciiz "Es un triangulo escaleno" 
Perimetro: .asciiz "El perimetro del triangulo es de: "
Altura1: .asciiz "La altura del triangulo del primer 1ado: "
Altura2: .asciiz "La altura del triangulo del segundo 1ado: "
Altura3: .asciiz "La altura del triangulo del tercer 1ado: "
Area: .asciiz "El area del triangulo es: "
word: .word 0x00000000

sqrt3: .float 1.7320508

.text
main:

la $a0, word

addi $t0, $zero, 2 # 2.0
sw $t0, 0($a0)
lwc1 $f20, 0($a0)
cvt.s.w $f20, $f20

addi $s7, $zero, 10 #try 10.0
sw $s7, 0($a0)
lwc1 $f26, 0($a0)
cvt.s.w $f21, $f26

addi $sp, $sp, -4

#Pide el primer lado y lo guarda
li $v0, 4
la $a0, string1
syscall

la $a0, input
addi $a1, $a1, 100 #Tamaño maximo del string
li $v0, 8 #$a0=buffer
syscall
move $a2, $a0
jal getNum

#Pide el segundo lado y lo guarda
li $v0, 4
la $a0, string2
syscall

la $a0, input
addi $a1, $a1, 100 #Tamaño maximo del string
li $v0, 8 #$a0=buffer
syscall 
move $a2, $a0
jal getNum

#Pide el tercer lado y lo guarda
li $v0, 4
la $a0, string3
syscall

la $a0, input
addi $a1, $a1, 100 #Tamaño maximo del string
li $v0, 8 #$a0=buffer
syscall 
move $a2, $a0
jal getNum

#Calcula cual es el lado mas grande (hipotenusa)
lw $s1, 8($sp)
lw $s2, 4($sp)
lw $s3, 0($sp)

addi $sp, $sp, -12

bge $s1, $s2, pMs  #L1 > L2?
bge $s2, $s3, sHipo # L2 > L1 y L2 > L3 => L2 es la hipotenusa
j tHipo

pMs: # L1 > L2
bge $s1, $s3, pHipo #L1 > L3? si, si L1 es la hipotenusa
j tHipo #Si no, L3 es la hipotenusa

#Primer lado es la hipotenusa
pHipo:
#Acomoda los valores poniendo la hipotenusa (L1) de ultimo
add $s7, $zero, $s1
sw $s3, 0($sp)
sw $s2, 4($sp)
sw $s7, 8($sp)

j next
#segundo lado es la hipotenusa
sHipo:
#Acomoda los valores poniendo la hipotenusa (L2) de ultimo
add $s7, $zero, $s2
sw $s1, 0($sp)
sw $s3, 4($sp)
sw $s7, 8($sp)

j next
#tercer lado es la hipotenusa
tHipo:
#Acomoda los valores poniendo la hipotenusa (L3) de ultimo
add $s7, $zero, $s3
sw $s1, 0($sp)
sw $s2, 4($sp)
sw $s7, 8($sp)

next:
#Calcular si es posible el triangulo
lw $t1, 0($sp)
lw $t2, 4($sp)

add $t3, $t1, $t2 #Suma los dos catetos a ver si la suma de ellos es mayor a la hipotenusa
ble $t3, $s7, errDist #La suma de los catetos es menor o igual a la hipotenusa no se puede hacer un triangulo

#Perimetro
add $s6, $s7, $t3 #Suma de los dos catetos + hipotenusa

li $v0, 4
la $a0, Perimetro
syscall
li $v0, 1
move $a0, $s6
syscall

#Convertimos los valores de los lados en flotantes para futuro uso
lwc1 $f1, 0($sp)
cvt.s.w $f1, $f1
lwc1 $f2, 4($sp)
cvt.s.w $f2, $f2
lwc1 $f3, 8($sp)
cvt.s.w $f3, $f3


#Tipo de triangulo; el contador t4 me contara cuantos lados tienen iguales, 3 equilatero, 1 isoceles, 0 escaleno
bne $t1, $t2, jp
addi $t4, $zero, 1

jp:
bne $t1, $s7, jp2
addi $t4, $t4, 1

jp2:
bne $t2, $s7, jp3
addi $t4, $t4, 1

jp3:
beq $t4, 3, tEqui
beq $t4, 1, tIso
beq $t4, 0, tEsca

tEqui:
li $v0, 4
la $a0, nl
syscall
li $v0, 4
la $a0, Equi
syscall

j construccion

######################
tIso:
li $v0, 4
la $a0, nl
syscall
li $v0, 4
la $a0, Iso
syscall

j construccion
#######################
tEsca:
li $v0, 4
la $a0, nl
syscall
li $v0, 4
la $a0, Esca
syscall

construccion:
#Primero es pasar los valores de los catetos e hipotenusa a flotantes
lwc1 $f1, 20($sp)
cvt.s.w $f1, $f1
lwc1 $f2, 16($sp)
cvt.s.w $f2, $f2
lwc1 $f3, 12($sp)
cvt.s.w $f3, $f3

#Calcular la altura
addi $sp, $sp, -4
sw $s6, 0($sp)
lwc1 $f7, 0($sp)
cvt.s.w $f7, $f7
addi $sp, $sp, 4

div.s $f7, $f7, $f20  #semiperimetro
#ha = 2/a Sqrt (s(s-a)(s-b)(s-c))

jal forAltura  #Sqrt(s(s-a)(s-b)(s-c))
mul.s $f15, $f5, $f20 #2Sqrt(s(s-a)(s-b)(s-c))
div.s $f15, $f15, $f1 #2/aSqrt(s(s-a)(s-b)(s-c))

li $v0, 4
la $a0, nl
syscall
li $v0, 4
la $a0, Altura1
syscall
li $v0, 2
mov.s $f12, $f15
syscall

mul.s $f15, $f5, $f20 #2Sqrt(s(s-a)(s-b)(s-c))
div.s $f15, $f15, $f2 #2/bSqrt(s(s-a)(s-b)(s-c))

li $v0, 4
la $a0, nl
syscall
li $v0, 4
la $a0, Altura2
syscall
li $v0, 2
mov.s $f12, $f15
syscall


mul.s $f15, $f5, $f20 #2Sqrt(s(s-a)(s-b)(s-c))
div.s $f15, $f15, $f3 #2/cSqrt(s(s-a)(s-b)(s-c))

li $v0, 4
la $a0, nl
syscall
li $v0, 4
la $a0, Altura3
syscall
li $v0, 2
mov.s $f12, $f15
syscall
##############

#Area
#A = Sqrt(s(s-a)(s-b)(s-c)) = f5

li $v0, 4
la $a0, nl
syscall
li $v0, 4
la $a0, Area
syscall
li $v0, 2
mov.s $f12, $f5
syscall

########################################################################################################################
exit:
li $v0, 10
syscall

forAltura:
sub.s $f8, $f7, $f1  #(s-a)
sub.s $f9, $f7, $f2  #(s-b)
sub.s $f10, $f7, $f3 #(s-c)

mul.s $f4, $f8, $f9  #(s-a)(s-b)
mul.s $f4, $f4, $f10 #(s-a)(s-b)(s-c)
mul.s $f4, $f4, $f7  #s(s-a)(s-b)(s-c)
add $t7, $zero, $ra
jal Sqrt #Sqrt(s(s-a)(s-b)(s-c))
add $ra, $zero, $t7
jr $ra

Sqrt:
addi $t0, $zero, 0  # Reset t0
Newton:
beq $t0, 20, nextSqrt  #Hace 20 iteraciones
div.s $f5, $f4, $f21  # f5 = f4 / f21
add.s $f5, $f5, $f21  # f5 = f4/f21 + f21
div.s $f5, $f5, $f20 # f5 = (f4/f21 + f21) / 2

add.s $f21, $f10, $f5 # f21 = f5
addi $t0, $t0, 1     # t0 += 1
j Newton
nextSqrt:
jr $ra


errDist:
li $v0, 4
la $a0, nl
syscall

li $v0, 4
la $a0, minDist
syscall

j exit

getNum:
addi $t0, $zero, 10 #reset t0
addi $s4, $zero, 0 #Reset s2

lp:
lbu $t1, 0($a0)  #lee el bit en ascii
beq $t1, $zero, exitNumber # Llego a un null
blt $t1, 48, exitNumber
bgt $t1, 57, exitNumber
addi $t1, $t1, -48 #Convierte de ascii a decimal
mul $s4, $s4, $t0
add $s4, $s4, $t1 
addi $a0, $a0, 1 #Mueve el bit

j lp
exitNumber:

addi $sp, $sp, -4
sw $s4, 0($sp) #Salva el numero en el stack pointer
#lwc1 $f1, 0($sp)
#cvt.s.w $f1, $f1
#swc1 $f1, 0($sp)
jr $ra