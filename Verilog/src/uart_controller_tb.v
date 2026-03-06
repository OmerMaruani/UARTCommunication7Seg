

`timescale 1ns / 1ps  // Define time scale in the Verilog file
`define CLK_PER 1



module uart_controller_tb;



	// Declare testbench signals (inputs and outputs)
	reg clk;
	reg rst_n;
	reg rx_pin;
	wire tx_pin;
	wire [6:0] digit_0;
	wire [6:0] digit_1;
	wire [6:0] digit_2;
	wire [6:0] digit_3;
	wire [7:0] byte_received;
	



	uart_controller UUT (.clk(clk),.rst_n(rst_n),.rx_pin(rx_pin),.tx_pin(tx_pin),.byte_received(byte_received),
				.digit_0(digit_0),.digit_1(digit_1),.digit_2(digit_2),.digit_3(digit_3));


	

	
	// Stimulus generation: Apply test vectors
	initial begin
		
		
		// Initialiaze the signal
		clk = 0;
		rst_n = 1;
		rx_pin = 1;
		
	
	
	
		// Display headers for simulation outputs
		$display("Time\t clk\t rst_n\t en\t out\t");
		
		// Monitor every change of the signals
        //$monitor("Time = %0t, rate = %b, out= %b", $time,rate, out);



	

		// Apply input combinations

			
		#10; rst_n = 0;
		#10; rst_n = 1;
		
		
		
		/*
		
		// byte = 00110011
		#2; rx_pin = 0;	// Start bit
		
		#2; rx_pin = 1;
		#2; rx_pin = 1;
		#2; rx_pin = 0;
		#2; rx_pin = 0;
		#2; rx_pin = 1;
		#2; rx_pin = 1;
		#2; rx_pin = 0;
		#2; rx_pin = 0;
		
		#2; rx_pin = 1;	// Stop bit
		*/
		
		
		send_uart_byte(8'h30);
		send_uart_byte(8'h31);
		send_uart_byte(8'h32);
		send_uart_byte(8'h33);
		
		
		send_uart_byte(8'h40);
		send_uart_byte(8'h41);
		send_uart_byte(8'h42);
		send_uart_byte(8'h43);
		
		
		
		
		
		
	end
	
	
	task send_uart_byte(input [7:0] data);
		integer i; // Verilog variable decl out of for statement unlike SystemVerilog
		
		begin
	
			rx_pin = 0; #2; // Start bit
			
			for(i =0; i< 8; i = i+1) begin
				rx_pin = data[i]; #2; // Data bits
			end
			
			rx_pin = 1; #2; // Stop bit

		end

	
	endtask
	
	
	
	
	always begin
		#(`CLK_PER) clk = ~clk;
	end
		
	
		
	
endmodule