




module ascii_to_7seg #(parameter DATA_BITS = 8) (clk,rst_n,en,ascii_in,out_7seg);

	input clk;
	input rst_n;
	input en;
	input [DATA_BITS-1:0] ascii_in;
	
	output reg [6:0] out_7seg;
	
	
	
	reg [DATA_BITS-1:0] byte_buffer; // Hold the value before the next clock
	
	
	
	
	always @(posedge clk or negedge rst_n) begin
		if(!rst_n) begin
			out_7seg <=  ~(7'b0000000); // Blank
		end
		else if(en) begin
			out_7seg <= ~byte_buffer;
		end
		
	
	end
	
	
	
	
	always @(*) begin
	
		case(ascii_in) 
			// Numbers 0-9 (ASCII 0x30 - 0x39)
			8'h30: byte_buffer = 7'b0111111; // 0
			8'h31: byte_buffer = 7'b0000110; // 1
			8'h32: byte_buffer = 7'b1011011; // 2
			8'h33: byte_buffer = 7'b1001111; // 3
			8'h34: byte_buffer = 7'b1100110; // 4
			8'h35: byte_buffer = 7'b1101101; // 5
			8'h36: byte_buffer = 7'b1111101; // 6
			8'h37: byte_buffer = 7'b0000111; // 7
			8'h38: byte_buffer = 7'b1111111; // 8
			8'h39: byte_buffer = 7'b1101111; // 9
					
			// Uppercase Letters A-Z (ASCII 0x41 - 0x5A)
			8'h41: byte_buffer = 7'b1110111; // A
			8'h42: byte_buffer = 7'b1111111; // B (Looks like 8)
			8'h43: byte_buffer = 7'b0111001; // C
			8'h44: byte_buffer = 7'b0111111; // D (Looks like 0)
			8'h45: byte_buffer = 7'b1111001; // E
			8'h46: byte_buffer = 7'b1110001; // F
			8'h47: byte_buffer = 7'b0111101; // G (Large wrap-around)
			8'h48: byte_buffer = 7'b1110110; // H
			8'h49: byte_buffer = 7'b0000110; // I (Same as 1)
			8'h4A: byte_buffer = 7'b0011110; // J
			8'h4B: byte_buffer = 7'b1110110; // K (Simplified uppercase)
			8'h4C: byte_buffer = 7'b0111000; // L
			8'h4D: byte_buffer = 7'b0110111; // M (Two arches, looks like n with top)
			8'h4E: byte_buffer = 7'b0110111; // N (Standard uppercase)
			8'h4F: byte_buffer = 7'b0111111; // O (Same as 0)
			8'h50: byte_buffer = 7'b1110011; // P
			8'h51: byte_buffer = 7'b1110011; // Q (Hard to differentiate from P)
			8'h52: byte_buffer = 7'b1110111; // R (Looks like A)
			8'h53: byte_buffer = 7'b1101101; // S (Same as 5)
			8'h54: byte_buffer = 7'b0000111; // T (Top bar and right side)
			8'h55: byte_buffer = 7'b0111110; // U
			8'h56: byte_buffer = 7'b0111110; // V (Same as U)
			8'h57: byte_buffer = 7'b0111110; // W
			8'h58: byte_buffer = 7'b1110110; // X
			8'h59: byte_buffer = 7'b1101110; // Y
			8'h5A: byte_buffer = 7'b1011011; // Z (Same as 2)
				
			default: byte_buffer = 7'b0000000; // Blank
		endcase
	end







endmodule
