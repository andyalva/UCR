main:
STO, R8, OxFF
STO, R0, 0

#Despues de una lecutra RKB hay que esperar a que el registro 0xFF sea igual a 0 para poder salir del bucle. 
#Despues de salir del bucle OxFF = 1
clear:
RKB, 0xff

VGA, 8, 0

while (0xff = 0)
{
nop
}
RKB R1 


#R0 retorno, R1 posicion
#R12, R13
Read:
while (0xff = 0)
{
nop
}
RKB R13
while (0xff = 1)
{
nop
}
###############
STO R12 0

jp:
BEQ jp 0xFF R12

RKB R13

jp2:
BEQ next 0xFF R12
NOP
JMP jp2
next:

RET R0


##############

Change_siluate:

if r13 = w
	if r1 < 8
		exit
	else 
		VGA h00 h61 h01
		r1 = r1 - 8
		VGA h00 h62 h01 #No me gusta asi
elif r13 = a
	if r1 < 1
		exit
	else 
		VGA h00 h61 h01
		r1 = r1 - 1
		VGA h00 h62 h01 #No me gusta asi

elif r13 = s
	if r1 > 55 
		exit
	else 
		VGA h00 h61 h01
		r1 = r1 + 8
		VGA h00 h62 h01 #No me gusta asi
elif r13 = d
	if r1 > 62 
		exit
	else 
		VGA h00 h61 h01
		r1 = r1 + 1
		VGA h00 h62 h01 #No me gusta asi

else 
	exit


change_state:
STO R14 "letra"
BEQ w R13 "w"
BEQ a R13 "a"
BEQ s R13 "s"
BEQ d R13 "d"
JMP exit

w:
STO R14 8
BLE exit R13 R14 #R13 < 8
VGA h00 h61 h01
SUB R1 R1 R4
VGA h00 h62 h01
JMP exit

a:
STO R14 1
BLE exit R13 R14 #R13 < 1
VGA h00 h61 h01
SUB R1 R1 R2
VGA h00 h62 h01
JMP exit

s:
STO R14 56
BLE nexts R13 R14 #R13 > 56 exit
JMP exit
nexts:
VGA h00 h61 h01
ADD R1 R1 R4
VGA h00 h62 h01
JMP exit


d:
STO R14 63
BLE nexts R13 R14 #R13 > 63 exit
JMP exit
nexts:
VGA h00 h61 h01
ADD R1 R1 R2
VGA h00 h62 h01
JMP exit

exit:
RET R0


















