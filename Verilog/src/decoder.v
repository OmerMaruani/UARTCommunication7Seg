




module decoder #(parameter CONTROL_WIDTH = 2, parameter OUT_WIDTH = 4) (clk, rst_n, en, a, y);

	input clk;
	input rst_n;
	input en;
	input [CONTROL_WIDTH-1:0] a;
	
	output reg [OUT_WIDTH-1:0] y;
	
	
	
	
	always @(*) begin
	
		if(!rst_n) begin
			//y = 1;
			//y = { {(OUT_WIDTH-1){1'b0}}, 1'b1 };
			y = 0;
		end
		else if (en) begin
			y = (1'b1 << a);
		end
		else begin
			y = 0;
		end
	
	end
	
	
	
/*
	always @(posedge clk or negedge rst_n)
	
		if(!rst_n) begin
			y <= 4'b0001;
		end
		else begin
		
			case(a)
			
				2'b00: y <= 4'b0001;
				2'b01: y <= 4'b0010;
				2'b10: y <= 4'b0100;
				2'b11: y <= 4'b1000;
				
				default: y <= 4'b0001;
			
			endcase
		end
	
	endmodule
*/






endmodule