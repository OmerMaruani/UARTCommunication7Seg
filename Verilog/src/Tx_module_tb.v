

`timescale 1ns / 1ps  // Define time scale in the Verilog file
`define CLK_PER 5



module Tx_module_tb;



	// Declare testbench signals (inputs and outputs)
	reg clk;
	reg rst_n;
	reg start_transmit;
	reg [7:0] data_transmit;
	
	wire tx_pin;
	
	
	
	
	Tx_module #(8) DUT (.clk(clk),.rst_n(rst_n),.start_transmit(start_transmit),.data_transmit(data_transmit),.tx_pin(tx_pin));


	
	// Stimulus generation: Apply test vectors
	initial begin
		
		
		// Initialiaze the signal
		clk = 0;
		rst_n = 1;
		start_transmit =0;
		data_transmit = 8'b0000_0000;
		
	
	
	
		// Display headers for simulation outputs
		$display("Time\t clk\t rst_n\t en\t out\t");
		
		// Monitor every change of the signals
        //$monitor("Time = %0t, rate = %b, out= %b", $time,rate, out);



	

		// Apply input combinations
		#10; rst_n = 0;
		#10; rst_n = 1;
		
		
		#10; start_transmit = 1; data_transmit <= 8'b0011_0011;
		#10; start_transmit = 0;
		
		#90; start_transmit = 1; data_transmit <= 8'b00001111;
		#20; start_transmit = 0;
		
		
		
	end
	
	
	always begin
		#(`CLK_PER) clk = ~clk;
	end
		
	
		
	
endmodule