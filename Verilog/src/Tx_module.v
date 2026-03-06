




module Tx_module #(parameter DATA_BITS = 8) (clk,rst_n,start_transmit,data_transmit,tx_pin);

	input clk;
	input rst_n;
	input start_transmit;
	input [DATA_BITS-1:0] data_transmit;
	
	output reg tx_pin;
	
	
	parameter [1:0]	IDLE 	= 2'b00;
	parameter [1:0] START 	= 2'b01;
	parameter [1:0] DATA 	= 2'b10;
	parameter [1:0] STOP 	= 2'b11;
	
	reg [1:0] curr_state, next_state = 2'b00;
	reg [2:0] bit_index = 3'b000;
	
	
	reg [7:0] data_buffer;
	
	// Asynchronous next_state logic
	always @(*) begin
	
		case(curr_state) 
	
			
			IDLE: next_state  = (start_transmit)? START : IDLE;
			START: next_state = DATA;
			DATA: next_state  = (bit_index == 7)? STOP : DATA;
			STOP: next_state  = (start_transmit)? START: IDLE;
			
			default: next_state = IDLE;
		
		endcase
	end
	
	
	
	
	// Synchronous current_state register
	always @(posedge clk or negedge rst_n) begin
	
		if(!rst_n) begin
			curr_state <= IDLE;
		end
		
		else begin
			curr_state <= next_state;
		end
		
	end
	
	
	

	// Combinational output logic (Moore-style)
	always @(*) begin
	
		case(curr_state)
	
			IDLE: tx_pin = 1'b1;
			START: tx_pin = 1'b0;
			DATA: tx_pin = data_buffer[bit_index];
			STOP: tx_pin = 1'b1;
			default: tx_pin = 1'b1;
			
		endcase
	end	
	



	// Datapath logic (Registers, counters, shift, etc)
	always @(posedge clk or negedge rst_n) begin
	
		if(!rst_n) bit_index <= 3'b000;
		else begin
			case(curr_state)
				
				IDLE: bit_index <= 3'b000;
				//START:
				DATA: bit_index <= bit_index + 1; 
				STOP: bit_index <= 3'b000;
				default: bit_index <= bit_index;
	
			endcase
		end
	end
	
	
	
	
	
	
	// Data buffer to handle continously transmit
	always @(posedge clk or negedge rst_n) begin
		if(!rst_n) begin
			data_buffer <= 0;
		end
		else begin
			if(start_transmit) data_buffer <= data_transmit;
		end
	
	end
	

endmodule