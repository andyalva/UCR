// Incluir todos los archivos de los modulos

`include "../parallel_to_serial/parallel_serial.v"
`include "../serial_to_parallel/serial_parallel.v"
`include "../Byte_Striping/Rx/byte_stripingRx.v"
`include "../Byte_Striping/Tx/byte_stripingTx.v"
`include "../clk_250hz/clk_250hz.v"
//`include "ByteTX_test.v"

// Union de modulos de manera estructural

module pcie(
		input RESET,
		input reset,
		input CLK,
		input [7:0] DATA,
		input VALID);

	// Wires de conexion
	wire CLK;
	wire VALID;
	wire [7:0] data0;
	wire [7:0] data1;
	wire [7:0] data2;
	wire [7:0] data3;
	wire [7:0] paralelo0;
	wire [7:0] paralelo1;
	wire [7:0] paralelo2;
	wire [7:0] paralelo3;
	wire [7:0] OUTSTRIPING;
	wire clk250;


	// CLK 250kHz
	CLK_250hz_cond clkbyte (CLK, reset, clk250);

	// Byte Striping TX
	bytestripingTX byteTX (clk250, RESET, VALID, DATA, data0, data1, data2, data3);

	// Paralelo a Serial TX (4 lineas, 4 modulos)
	parallel_serial_cond serial0 (data0, CLK, RESET, VALID, dataserial0);

	parallel_serial_cond serial1 (data1, CLK, RESET, VALID, dataserial1);
		
	parallel_serial_cond serial2 (data2, CLK, RESET, VALID, dataserial2);

	parallel_serial_cond serial3 (data3, CLK, RESET, VALID, dataserial3);

	// Serial a Paralelo RX (4 lineas, 4 modulos)
	serial_parallel_cond parallel0 (dataserial0, CLK, RESET, paralelo0);

	serial_parallel_cond parallel1 (dataserial1, CLK, RESET, paralelo1);

	serial_parallel_cond parallel2 (dataserial2, CLK, RESET, paralelo2);

	serial_parallel_cond parallel3 (dataserial3, CLK, RESET, paralelo3);

	// Byte Striping inverso RX
	bytestripingRX byteRX (clk250, RESET, VALID, OUTSTRIPING, paralelo0, paralelo1, paralelo2, paralelo3);

endmodule
