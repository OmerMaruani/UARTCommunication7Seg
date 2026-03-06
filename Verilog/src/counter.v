




module counter #(parameter DATA_WIDTH = 2) (clk,rst_n,cnt_en, cnt_out);

	input clk;
	input rst_n;
	input cnt_en;
	
	output reg [DATA_WIDTH-1:0] cnt_out;
	
	
	reg [DATA_WIDTH-1:0] counter_reg;  
	
	parameter TOP_VAL = (1 << DATA_WIDTH) - 1; 
	
	
	
	always @(posedge clk or negedge rst_n) begin
	
		if(!rst_n) begin
			cnt_out <= 0;
		end
		else begin
			cnt_out <= counter_reg;
		end
	
	
	end
	
	
	always @(posedge clk or negedge rst_n) begin
		
		if(!rst_n) begin
			counter_reg <= 0;
		end
		else if (cnt_en) begin
			
			
			if (counter_reg < TOP_VAL ) begin
				counter_reg <= counter_reg + 1;
			end
			else begin
				counter_reg <= 0;
			end
			

		end
	
	end






endmodule