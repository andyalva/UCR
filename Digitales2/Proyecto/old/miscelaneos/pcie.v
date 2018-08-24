// Incluir todos los archivos de los modulos

`include "mux_de_control_forzado/mux_de_control_forzado.v"
`include "demux/demux.v"
`include "parallel_to_serial/parallel_serial.v"
`include "serial_to_parallel/serial_parallel.v"
`include "Byte_Striping/Rx/byte_stripingRx.v"
`include "Byte_Striping/Tx/byte_stripingTx.v"
`include "clk_250hz/clk_250hz.v"
`include "clk_1Mhz/clk_1Mhz.v"
`include "cmos_cells.v"

// Union de modulos de manera estructural

module pcie(input reset,
		input RESET,
		input [3:0] CONTROL,
		input [7:0] Tx_Buffer,
		input CLK,
		output [7:0] DATA,
		output VALID_OUT);

	// Wires de conexion
	wire CLK;
	wire VALID;
	wire [7:0] OUTMUX;
	wire [7:0] data0;
	wire [7:0] data1;
	wire [7:0] data2;
	wire [7:0] data3;
	wire [7:0] paralelo0;
	wire [7:0] paralelo1;
	wire [7:0] paralelo2;
	wire [7:0] paralelo3;
	wire [7:0] dataserial0;
	wire [7:0] dataserial1;
	wire [7:0] dataserial2;
	wire [7:0] dataserial3;	
	wire [7:0] OUTSTRIPING;
	wire clk1;
	wire clk250;

	// CLK 1MHz
	CLK_1Mhz_cond clkmux (CLK, RESET, clk1);

	// Mux inicial
	mux_de_control_forzado mux (CONTROL, VALID, Tx_Buffer, clk1, OUTMUX);

	// CLK 250kHz
	CLK_250hz_cond clkbyte (CLK, RESET, clk250);

	// Byte Striping TX
	bytestripingTX byteTX (clk250, reset, VALID, OUTMUX, data0, data1, data2, data3);

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
	bytestripingRX byteRX (clk250, reset, VALID, OUTSTRIPING, paralelo0, paralelo1, paralelo2, paralelo3);

	// Demux final
	demux muxRX (OUTSTRIPING, clk1, VALID, VALID_OUT, DATA);
	
endmodule
