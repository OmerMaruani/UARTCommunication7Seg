

`timescale 1ns / 1ps  // Define time scale in the Verilog file


module baud_gen #(parameter SYSTEM_CLOCK = 50_000_000 ,parameter BAUD_RATE = 9600) (clk,rst_n,signal_out);
	input clk;
	input rst_n;
	output reg signal_out;
	
	
	// Tc = 0.02us, Tg = 104us
	// Tc/Tg = 5200
	
	reg [15:0] counter = 0;
	parameter [15:0] top_value = SYSTEM_CLOCK / BAUD_RATE;

	always @(posedge clk or negedge rst_n) begin
	
		if (!rst_n) begin 
			signal_out <= 0;
			counter <= 0;		
		end 
		
		else begin
			counter <= counter + 1;

			if(counter == top_value - 1)begin 
				signal_out <= 1;
				counter <= 0;
			end
			else signal_out <= 0;
		end
		
	end
	
	
endmodule
	



