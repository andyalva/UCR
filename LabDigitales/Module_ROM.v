`ifndef ROM_A
`define ROM_A

`include "../Include/Definitions.v"

`timescale 1ns / 1ps
module ROM(
	   input wire [7:0] iAddress,
	   output reg [27:0] oInstruction
	   );
 always @ ( iAddress )
     begin
	case (iAddress)

          000: oInstruction = {`CALL, 8'h00, 8'd100, 8'h00}; //Salta a la funcion esperar
          001: oInstruction = {`CALL, 8'h00, 8'd100, 8'h00}; //Salta a la funcion esperar
          002: oInstruction = {`CALL, 8'h00, 8'd100, 8'h00}; //Salta a la funcion esperar 
          003: oInstruction = {`STO, 8'h01, 8'h00, 8'h00}; //R1 =Posicion
          004: oInstruction = {`STO, 8'h02, 8'h00, 8'h01}; //R2 = 1      
          005: oInstruction = {`STO, 8'h03, 8'h00, 8'h24}; //R3 = selec
          006: oInstruction = {`STO, 8'h04, 8'h00, 8'h08}; // R4 = 8
								//R5->R7
          007: oInstruction = {`STO, 8'h08, 8'h00, 8'h40}; // R8 = 63
          008: oInstruction = {`STO, 8'h0A, 8'h00, 8'h14}; // R10 = deselect 
          009: oInstruction = {`STO, 8'h0B, 8'h00, 8'h00}; // R11 = cont
								//R12->R14


          010: oInstruction = {`BEQ, 8'd15, 8'h0B, 8'h08}; // if cont = 64 jump next
          011: oInstruction = {`CALL, 8'h00, 8'd100, 8'h00};
          012: oInstruction = {`VGA, 8'h00, 8'h0A, 8'h01}; //Print
          013: oInstruction = {`ADD, 8'h0B, 8'h0B, 8'h02}; // cont++
          014: oInstruction = {`ADD, 8'h01, 8'h01, 8'h02}; // R1++
          015: oInstruction = {`JMP, 8'd10, 8'h00, 8'h00};
//next
          016: oInstruction = {`STO, 8'h01, 8'h00, 8'h11}; //Posicion = 17
          017: oInstruction = {`CALL, 8'h00, 8'd100, 8'h00}; // Sleep
          018: oInstruction = {`VGA, 8'h00, 8'h03, 8'h01}; // Print first position
          019: oInstruction = {`CALL, 8'h00, 8'd150, 8'h00}; // Read
          020: oInstruction = {`CALL, 8'h00, 8'd200, 8'h00}; // change_state
          021: oInstruction = {`JMP, 8'd019, 8'h00, 8'h00}; // Move to Read



/////////// Sleep // Subrutina esperar // Utiliza los registros: R5, R6, R7
//LOOP2:
	     100: oInstruction = { `STO ,`R7,16'h0     };//R1 = 0
	     101: oInstruction = { `STO ,`R5,16'h0     };//R1 = 0
	     102: oInstruction = { `STO ,`R6,16'd4000 }; //sleep time
//LOOP1:	  
	     103: oInstruction = { `ADD ,`R5,`R5,`R2    };//R3+1
	     104: oInstruction = { `BLE ,8'd103,`R5,`R6 };//Enters First Loop

	     105: oInstruction = { `ADD ,`R7,`R7,`R2    };// R5+1
		 106: oInstruction = { `BLE ,8'd101,`R7,`R6 };//Enters Second Loop
         107: oInstruction = {`RET, 8'h00, 8'h00, 8'h00};

/////////// Read RKB // Utiliza los registros: R12, R13

          150: oInstruction = {`STO, 8'h0C, 8'h00, 8'h00}; // R12 = 0

          151: oInstruction = {`BEQ, 8'd10 , 8'hFF, 8'h0C}; //wait tecla
          152: oInstruction = {`RKB, 8'h0D, 8'h00, 8'h00};
      //    012: oInstruction = {`BEQ, 8'd15, 8'hFF, 8'h0C}; //wait bandera
      //    013: oInstruction = {`NOP, 8'h00, 8'h00, 8'h00};
      //    014: oInstruction = {`JMP, 8'd12, 8'h00, 8'h00};
          153: oInstruction = {`LED, 8'h00, 8'h0D, 8'h00}; // leds
          154: oInstruction = {`RET, 8'h00, 8'h00, 8'h00}; // ret
            
/////////// change_state // Utiliza los registros: R14

		 200: oInstruction = { `STO, 8'h0E, 8'h00, 8'h1d}; // R14 = w
         201: oInstruction = {`BEQ, 8'd244, 8'h0D, 8'h0E}; //if w jump to w
		 202: oInstruction = { `STO, 8'h0E, 8'h00, 8'h1c}; // R14 = a
         203: oInstruction = {`BEQ, 8'd244, 8'h0D, 8'h0E}; //if a jump to a
		 204: oInstruction = { `STO, 8'h0E, 8'h00, 8'h1b}; // R14 = s
         205: oInstruction = {`BEQ, 8'd244, 8'h0D, 8'h0E}; //if s jump to s
		 206: oInstruction = { `STO, 8'h0E, 8'h00, 8'h23}; // R14 = d
         207: oInstruction = {`BEQ, 8'd244, 8'h0D, 8'h0E}; //if d jump to d
//w
		 208: oInstruction = { `STO, 8'h0E, 8'h00, 8'h07}; // R14 = 7
		 209: oInstruction = { `BLE, 8'd244, 8'h0D, 8'h0E}; // R13 < 7 -> exit
		 210: oInstruction = { `VGA, 8'h00, 8'h61, 8'h01}; // Deselect
		 211: oInstruction = { `SUB, 8'h01, 8'h01, 8'h04}; // posicion -8
		 212: oInstruction = { `VGA, 8'h00, 8'h62, 8'h01}; // select
		 213: oInstruction = { `JMP, 8'd244, 8'h00, 8'h00}; // exit

//a
		 214: oInstruction = { `STO, 8'h0E, 8'h00, 8'h00}; // R14 = 0
		 215: oInstruction = { `BLE, 8'd244, 8'h0D, 8'h0E}; // R13 < 0 -> exit
		 216: oInstruction = { `VGA, 8'h00, 8'h61, 8'h01}; // Deselect
		 217: oInstruction = { `SUB, 8'h01, 8'h01, 8'h02}; // posicion -1
		 218: oInstruction = { `VGA, 8'h00, 8'h62, 8'h01}; // select
		 219: oInstruction = { `JMP, 8'd244, 8'h00, 8'h00}; // exit		
//s
		 220: oInstruction = { `STO, 8'h0E, 8'h00, 8'h38}; // R14 = 56
		 221: oInstruction = { `BLE, 8'd223 , 8'h0D, 8'h0E}; // R13 < 56 -> next
		 222: oInstruction = { `JMP, 8'd244, 8'h00, 8'h00}; // exit	
		 223: oInstruction = { `VGA, 8'h00, 8'h61, 8'h01}; // Deselect
		 224: oInstruction = { `ADD, 8'h01, 8'h01, 8'h04}; // posicion +8
		 225: oInstruction = { `VGA, 8'h00, 8'h62, 8'h01}; // select
		 226: oInstruction = { `JMP, 8'd244 , 8'h00, 8'h00}; // exit	
//d
		 227: oInstruction = { `STO, 8'h0E, 8'h00, 8'h3E}; // R14 = 62
		 228: oInstruction = { `BLE, 8'd230, 8'h0D, 8'h0E}; // R13 < 62 -> next
		 229: oInstruction = { `JMP, 8'd244, 8'h00, 8'h00}; // exit	
		 230: oInstruction = { `VGA, 8'h00, 8'h61, 8'h01}; // Deselect
		 231: oInstruction = { `ADD, 8'h01, 8'h01, 8'h02}; // posicion +1
		 232: oInstruction = { `VGA, 8'h00, 8'h62, 8'h01}; // select
		 233: oInstruction = { `JMP, 8'd244, 8'h00, 8'h00}; // exit
//exit
         244: oInstruction = {`RET, 8'h00, 8'h00, 8'h00};

	  
	  default:
	    oInstruction  = { `LED ,  24'b10101010 };
	endcase
     end

endmodule
`endif //ROM_A
