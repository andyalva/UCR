#Andres Alvarado Velazquez
#B30316

.data
prompt: .asciiz "Ingrese el primer valor del cateto "
prompt2: .asciiz "Ingrese el segundo valor del cateto "
num1: .float 3
num2: .float 4
num3: .float 30.5
num4: .float 42.7

A1: .asciiz "El resultado de la hipotenusa de 3 y 4 es: "
A2: .asciiz "El resultado de la hipotenusa de 30.5 y 42.7 es: "
A3: .asciiz "El resultado de la hipotenusa de los valores ingresados es: "

nl: .asciiz "\n"

ftwo: .float 2.00
try: .float 10.00
fzero: .float 0.00 

.text
.globl main
main:

lwc1 $f6, try
lwc1 $f10, fzero


li $v0, 4
la $a0, prompt
syscall

li $v0, 6
syscall

add.s $f21, $f0, $f10

li $v0, 4
la $a0, prompt2
syscall

li $v0, 6
syscall

add.s $f22, $f0, $f10

lwc1 $f0, num1
lwc1 $f1, num2
lwc1 $f20, ftwo

li $v0, 4
la $a0, A1
syscall

jal Sqrt   #aplica funcion Sqrt con valores 3 y 4

li $v0, 4
la $a0, A2
syscall

lwc1 $f0, num3
lwc1 $f1, num4

jal Sqrt #aplica funcion Sqrt con valores 30.5 y 42.7

li $v0, 4
la $a0, A3
syscall

mov.s $f0, $f21
mov.s $f1, $f22

jal Sqrt #aplica funcion Sqrt con los valores ingresados por el usuario

j exit

Sqrt:
mul.s $f0, $f0, $f0  # f0 = f0^2
mul.s $f1, $f1, $f1  # f1 = f1^2
add.s $f4, $f0, $f1  # f4 = f0 + f1
addi $t0, $zero, 0  # Reset t0

Newton:
beq $t0, 20, next  #Hace 20 iteraciones
div.s $f5, $f4, $f6  # f5 = f4 / f6
add.s $f5, $f5, $f6  # f5 = f4/f6 + f6
div.s $f5, $f5, $f20 # f5 = (f4/f6 + f6) / 2

add.s $f6, $f10, $f5 # f6 = f5
addi $t0, $t0, 1     # t0 += 1
j Newton

next:

li $v0, 2
mov.s $f12, $f5
syscall

li $v0, 4
la $a0, nl
syscall

jr $ra

exit:
li $v0, 10
syscall