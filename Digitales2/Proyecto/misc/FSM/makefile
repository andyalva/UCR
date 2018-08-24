all:
	iverilog -o FSM FSM.v
	iverilog -o bpfsm bpfsm.v
	iverilog -o tbfsm tbfsm.v
	vvp tbfsm
	gtkwave prueba_FSM.vcd
	
clean:
	rm FSM bpfsm tbfsm prueba_FSM.vcd
