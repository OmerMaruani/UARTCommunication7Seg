


`timescale 1ns / 1ps  // Define time scale in the Verilog file
`define CLK_PER 5



module Rx_module_tb;


	reg clk;
	reg rst_n;
	reg rx_pin;
	wire [7:0] byte_out;
	wire byte_valid;


	Rx_module #(8) DUT (.clk(clk),.rst_n(rst_n),.rx_pin(rx_pin),.byte_out(byte_out),.byte_valid(byte_valid));


	initial begin
	
		clk = 0;
		rst_n = 1;
		rx_pin = 1;
		
		
		
		
		#10; rst_n = 0;
		#10; rst_n = 1;
		
		// byte = 00110011
		#10; rx_pin = 0;	// Start bit
		
		#10; rx_pin = 1;
		#10; rx_pin = 1;
		#10; rx_pin = 0;
		#10; rx_pin = 0;
		#10; rx_pin = 1;
		#10; rx_pin = 1;
		#10; rx_pin = 0;
		#10; rx_pin = 0;
		
		#10; rx_pin = 1;	// Stop bit
		
		
		
		// byte = 00000000
		#10; rx_pin = 0;	// Start bit
		
		#10; rx_pin = 0;
		#10; rx_pin = 0;
		#10; rx_pin = 0;
		#10; rx_pin = 0;
		#10; rx_pin = 0;
		#10; rx_pin = 0;
		#10; rx_pin = 0;
		#10; rx_pin = 0;
		
		#10; rx_pin = 1;	// Stop bit
		
		
		
		// byte = 00001111
		#10; rx_pin = 0;	// Start bit
		
		#10; rx_pin = 1;
		#10; rx_pin = 1;
		#10; rx_pin = 1;
		#10; rx_pin = 1;
		#10; rx_pin = 0;
		#10; rx_pin = 0;
		#10; rx_pin = 0;
		#10; rx_pin = 0;
		
		#10; rx_pin = 1;	// Stop bit
	
	
	end



	always begin
		#(`CLK_PER) clk = ~clk;
	end



endmodule