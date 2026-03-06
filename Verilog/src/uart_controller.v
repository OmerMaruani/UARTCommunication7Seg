

`timescale 1ns / 1ps  // Define time scale in the Verilog file

`define PULSE_PER_CLOCKS 2  // Define the constant value


module uart_controller (clk,rst_n,rx_pin,tx_pin,byte_received,digit_0,digit_1,digit_2,digit_3);
	input clk;
	input rst_n;
	input rx_pin;
	
	output tx_pin;
	
	output [7:0] byte_received;
	output [6:0] digit_0;
	output [6:0] digit_1;
	output [6:0] digit_2;
	output [6:0] digit_3;

	
	

	// Wires for various components
	wire clock_9600;
	wire [7:0] byte_out;
	wire byte_valid;
	//wire [7:0] data_transmit;
	
	wire [1:0] decoder_control;
	wire [3:0] decoder_output;
	


	// Parameters
	parameter BOARD_FREQUENCY		= 50_000_000;
	parameter BAUD_RATE 			= 9600; // *2 ?
	parameter DATA_BITS				= 8;
	
	parameter DECODER_CONTROL_WIDTH = 2;
	parameter DECODER_OUT_WIDTH 	= 4;

	
	
	

	// Instantiate 
	// For modules: --- Rx_module, Tx_module, counter, decoder --- 
	
	// Synthesis: clk should get 9600 for 9600 baud rate
	// Simulation: clk get the system clock
	
	baud_gen #(BOARD_FREQUENCY,BAUD_RATE) baud_gen_module (.clk(clk),.rst_n(rst_n),.signal_out(clock_9600));
	Rx_module #(DATA_BITS) rx_module (.clk(clock_9600),.rst_n(rst_n),.rx_pin(rx_pin),.byte_out(byte_out),.byte_valid(byte_valid));
	Tx_module #(DATA_BITS) tx_module (.clk(clock_9600),.rst_n(rst_n),.start_transmit(byte_valid),.data_transmit(byte_out),.tx_pin(tx_pin));
	
	counter #(DECODER_CONTROL_WIDTH) counter_module (.clk(clock_9600),.rst_n(rst_n),.cnt_en(byte_valid),.cnt_out(decoder_control));
	decoder #(DECODER_CONTROL_WIDTH, DECODER_OUT_WIDTH) decoder_module (.clk(clock_9600),.rst_n(rst_n),.en(byte_valid),.a(decoder_control),.y(decoder_output));
	
	ascii_to_7seg #(DATA_BITS) ascii_to_7seg_module_3 (.clk(clk),.rst_n(rst_n),.en(decoder_output[0]),.ascii_in(byte_out),.out_7seg(digit_3));
	ascii_to_7seg #(DATA_BITS) ascii_to_7seg_module_2 (.clk(clk),.rst_n(rst_n),.en(decoder_output[1]),.ascii_in(byte_out),.out_7seg(digit_2));
	ascii_to_7seg #(DATA_BITS) ascii_to_7seg_module_1 (.clk(clk),.rst_n(rst_n),.en(decoder_output[2]),.ascii_in(byte_out),.out_7seg(digit_1));
	ascii_to_7seg #(DATA_BITS) ascii_to_7seg_module_0 (.clk(clk),.rst_n(rst_n),.en(decoder_output[3]),.ascii_in(byte_out),.out_7seg(digit_0));

	
	assign byte_received = byte_out;

										
	
endmodule
	


