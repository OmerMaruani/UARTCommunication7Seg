

`timescale 1ns / 1ps  // Define time scale in the Verilog file
`define CLK_PER 25



module baud_gen_tb;



	// Declare testbench signals (inputs and outputs)
	reg clk;
	reg rst_n;
	wire signal_out;
	
	baud_gen #(50_000_000,9600) UUT (.clk(clk),.rst_n(rst_n),.signal_out(signal_out));


	
	// Stimulus generation: Apply test vectors
	initial begin
		
		
		// Initialiaze the signal
		clk = 0;
		rst_n = 1;
		
	
	
	
		// Display headers for simulation outputs
		$display("Time\t clk\t rst_n\t en\t out\t");
		
		// Monitor every change of the signals
        //$monitor("Time = %0t, rate = %b, out= %b", $time,rate, out);



	

		// Apply input combinations
		#10; rst_n = 0;
		#10; rst_n = 1;
		
		
	end
	
	
	always begin
		#(`CLK_PER) clk = ~clk;
	end
		
	
		
	
endmodule