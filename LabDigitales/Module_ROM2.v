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
								//R5->R9
          007: oInstruction = {`STO, 8'h0A, 8'h00, 8'h14}; // R10 = deselect 
          008: oInstruction = {`STO, 8'h0B, 8'h00, 8'h00}; // R11 = cont
								//R12->R13
          009: oInstruction = {`STO, 8'h0E, 8'h00, 8'h40}; // R14 = 63

          010: oInstruction = {`BEQ, 8'd15, 8'h0B, 8'h0E}; // if cont = 64 jump next
          011: oInstruction = {`CALL, 8'h00, 8'd100, 8'h00};
          012: oInstruction = {`VGA, 8'h00, 8'h0A, 8'h01}; //Print
          013: oInstruction = {`ADD, 8'h0B, 8'h0B, 8'h02}; // cont++
          014: oInstruction = {`ADD, 8'h01, 8'h01, 8'h02}; // R1++
          015: oInstruction = {`JMP, 8'd10, 8'h00, 8'h00};
//next
          016: oInstruction = {`STO, 8'h01, 8'h00, 8'h11}; //Posicion = 17
          017: oInstruction = {`CALL, 8'h00, 8'd100, 8'h00};
          018: oInstruction = {`VGA, 8'h00, 8'h03, 8'h01};

/*
          011: oInstruction = {`BEQ, 8'd15, 8'h0B, 8'h04}; //jump vertical
          012: oInstruction = {`ADD, 8'h06, 8'h0B, 8'h01};
	  013: oInstruction = {`ADD, 8'h01, 8'h01, 8'h04};
	  014: oInstruction = {`JMP, 8'd9, 8'd0, 8'd0};

//Fin vertical
          015: oInstruction = {`STO, 8'h0B, 8'h00, 8'h00};
          016: oInstruction = {`SUB, 8'h01, 8'h01, 8'h0A};
	  017: oInstruction = {`JMP, 8'd9, 8'd0, 8'd0};*/


          //005: oInstruction = {`JMP, 8'd4, 8'd0, 8'd0};
/* -----\/----- EXCLUDED -----\/-----
          006: oInstruction = {`STO, 8'h01, 8'h00, 8'h01};
          007: oInstruction = {`BEQ, 8'd10, 8'd1, 8'hFF};
          008: oInstruction = {`JMP, 8'h04, 8'h00, 8'h00};

	  009: oInstruction = {`NOP, 8'h04, 16'hFF00};
	  

	  010: oInstruction = {`RKB, 8'd1, 8'h01, 8'h01};

  011: oInstruction = {`STO, 8'h02, 8'h00, 8'h24};
	  012: oInstruction = {`BEQ, 8'd15, 8'd2, 8'd1};
	  013: oInstruction = {`JMP, 8'd4, 8'd2, 8'd1};

	  015: oInstruction = {`STO, 8'd2, 8'd0, 8'd1};
	  016: oInstruction = {`ADD, 8'd7, 8'd7, 8'd2};
	  017: oInstruction = {`VGA, 8'd4, 8'h02, 8'd2};

	  018: oInstruction = {`ADD, 8'd7, 8'd2, 8'd2};
	  019: oInstruction = {`VGA, 8'd4, 8'h02, 8'd7};

	  020: oInstruction = {`ADD, 8'd7, 8'd7, 8'd2};
	  021: oInstruction = {`VGA, 8'd4, 8'h72, 8'd7};

	  022: oInstruction = {`ADD, 8'd7, 8'd7, 8'd2};
	  023: oInstruction = {`VGA, 8'd4, 8'h71, 8'd7};
	  
	  024: oInstruction = {`JMP, 8'd4, 8'h02, 8'd7};
 -----/\----- EXCLUDED -----/\----- */
	  
	  
/* -----\/----- EXCLUDED -----\/-----
                009: oInstruction = {`NOP, 8'h00, 8'h00, 8'h00};
                010: oInstruction = {`BLE, 8'h0E, 8'h06, 8'h10}; //falta
                
011: oInstruction = {`NOP, 8'h00, 8'h00, 8'h00};
                012: oInstruction = {`ADD, 8'h10, 8'h10, 8'h07}; // contador = contador + 1
                013: oInstruction = {`JMP, 8'h09, 8'h00, 8'h00};
             
             014: oInstruction = {`JMP, 8'h04, 8'h00, 8'h00};	     
	     015: oInstruction = {`NOP, 8'h00, 8'h00, 8'h00};
             016: oInstruction = {`NOP, 8'h00, 8'h00, 8'h00}; 
	     017: oInstruction = {`JMP, 8'd16, 8'h00, 8'h00};  // Fin 

             // Secuencia para imprimir:
	                            
	     
             018: oInstruction = {`STO, 8'h12, 16'h576F}; // Parametro de PrintChar 'Hu'
             019: oInstruction = {`STO, 8'h13, 16'h0008}; // Constante   8
             020: oInstruction = {`CALL, 8'd01, 8'd104, 8'h00}; // Salta a dir 104 Proximamente con CALL
	     021: oInstruction = {`NOP, 8'h00, 8'h00, 8'h00};	     
	     022: oInstruction = {`SLL, 8'h12, 8'h13, 8'h12}; // (0x12) << 8 	     
             023: oInstruction = {`CALL, 8'd01, 8'd104, 8'h00}; // Salta a dir 104 Proximamente con CALL
             024: oInstruction = {`NOP, 8'h00, 8'h00, 8'h00};
	     
	     025: oInstruction = {`STO, 8'h12, 16'h6D62}; // Parametro de PrintChar 'ro'

	     026: oInstruction = {`NOP, 8'h00, 8'h00, 8'h00};
             027: oInstruction = {`CALL, 8'd01, 8'd104, 8'h00}; // Salta a dir 104 Proximamente con CALL
             028: oInstruction = {`NOP, 8'h00, 8'h00, 8'h00};
	     029: oInstruction = {`SLL, 8'h12, 8'h13, 8'h12};
	     030: oInstruction = {`NOP, 8'h00, 8'h00, 8'h00};
             031: oInstruction = {`CALL, 8'd01, 8'd104, 8'h00}; // Salta a dir 104 Proximamente con CALL
             032: oInstruction = {`NOP, 8'h00, 8'h00, 8'h00};

	     033: oInstruction = {`STO, 8'h12, 16'h6174}; // 'ne'
             034: oInstruction = {`CALL, 8'd01, 8'd104, 8'h00}; // Salta a dir 104 Proximamente con CALL
             035: oInstruction = {`NOP, 8'h00, 8'h00, 8'h00};
	     036: oInstruction = {`SLL, 8'h12, 8'h13, 8'h12};
	     037: oInstruction = {`NOP, 8'h00, 8'h00, 8'h00};
             038: oInstruction = {`CALL, 8'd01, 8'd104, 8'h00}; // Salta a dir 104 Proximamente con CALL
             039: oInstruction = {`NOP, 8'h00, 8'h00, 8'h00};

	     040: oInstruction = {`STO, 8'h12, 16'h73FE}; // 's '	    
             041: oInstruction = {`CALL, 8'd01, 8'd104, 8'h00}; // Salta a dir 104 Proximamente con CALL
             042: oInstruction = {`NOP, 8'h00, 8'h00, 8'h00};
	     043: oInstruction = {`SLL, 8'h12, 8'h13, 8'h12};
	     044: oInstruction = {`NOP, 8'h00, 8'h00, 8'h00};
             045: oInstruction = {`CALL, 8'd01, 8'd104, 8'h00}; // Salta a dir 104 Proximamente con CALL
             046: oInstruction = {`NOP, 8'h00, 8'h00, 8'h00};

	     047: oInstruction = {`STO, 8'h12, 16'hFEC2};  // '  '    
             048: oInstruction = {`CALL, 8'd01, 8'd104, 8'h00}; // Salta a dir 104 Proximamente con CALL
             049: oInstruction = {`NOP, 8'h00, 8'h00, 8'h00};
	     050: oInstruction = {`SLL, 8'h12, 8'h13, 8'h12};
	     051: oInstruction = {`NOP, 8'h00, 8'h00, 8'h00};
             052: oInstruction = {`CALL, 8'd01, 8'd104, 8'h00}; // Salta a dir 104 Proximamente con CALL
             053: oInstruction = {`NOP, 8'h00, 8'h00, 8'h00};           
	               
             054: oInstruction = {`NOP, 8'h00, 8'h00, 8'h00};
             055: oInstruction = {`JMP, 8'd54, 8'h00, 8'h00};
	  
	     ////////////////////////////////////////////////
	     // Imprimir un char:
	     104: oInstruction = {`NOP, 8'h00, 8'h00, 8'h00};	     
             105: oInstruction = {`LCD, 8'h00, 8'h12, 8'h00};
	     106: oInstruction = {`NOP, 8'h00, 8'h00, 8'h00};
	  
 -----/\----- EXCLUDED -----/\----- *//*
//LOOP2:
	     100: oInstruction = { `STO ,`R7,16'h0     };//R1 = 0
	     101: oInstruction = { `STO ,`R5,16'h0     };//R1 = 0

	     102: oInstruction = { `STO ,`R6,16'd2000 }; //sleep time
//LOOP1:	  
	     103: oInstruction = { `ADD ,`R5,`R5,`R2    };//R3+1
	     104: oInstruction = { `BLE ,8'd103,`R5,`R6 };//Enters First Loop

	     105: oInstruction = { `ADD ,`R7,`R7,`R2    };// R5+1
	 106: oInstruction = { `BLE ,8'd101,`R7,`R6 };//Enters Second Loop
         107: oInstruction = {`RET, 8'h00, 8'h00, 8'h00};
*/

	     // Sleep // Subrutina esperar // Utiliza los registros: R5, R6, R7, R8, R9, R0
	     100: oInstruction = {`NOP, 8'h00, 16'h0000}; //
	     101: oInstruction = {`STO, 8'h05, 16'h0001}; // Constante 1	     
             102: oInstruction = {`NOP, 8'h00, 16'h0000}; //	  
	     103: oInstruction = {`STO, 8'h08, 16'h01FF}; // Referencia 
	     104: oInstruction = {`STO, 8'h09, 16'h0000}; // Contador en R9
	     105: oInstruction = {`BLE, 8'd116, 8'h08, 8'h09}; //falta
	     
             106: oInstruction = {`ADD, 8'h09, 8'h09, 8'h05}; // contador = contador + 1
	     
             107: oInstruction = {`STO, 8'h06, 16'h1FF0}; // Referencia 
	     108: oInstruction = {`STO, 8'h07, 16'h0000}; // contador R7
             109: oInstruction = {`NOP, 8'h00, 8'h00, 8'h00};
             110: oInstruction = {`BLE, 8'd114, 8'h06, 8'h07}; //falta
             111: oInstruction = {`NOP, 8'h00, 8'h00, 8'h00};
             112: oInstruction = {`ADD, 8'h07, 8'h07, 8'h05}; // contador = contador + 1
             113: oInstruction = {`JMP, 8'd109, 8'h00, 8'h00};
             
             114: oInstruction = {`NOP, 8'h00, 8'h00, 8'h00};
	     115: oInstruction = {`JMP, 8'd105, 8'h00, 8'h00};
	     116: oInstruction = {`NOP, 8'h00, 8'h00, 8'h00};
	     117: oInstruction = {`RET, 8'h00, 8'h00, 8'h00};
            

	  default:
	    oInstruction  = { `LED ,  24'b10101010 };
	endcase
     end

endmodule
`endif //ROM_A
