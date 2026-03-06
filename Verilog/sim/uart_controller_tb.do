
vlog ../src/baud_gen.v
vlog ../src/Rx_module.v
vlog ../src/Tx_module.v
vlog ../src/counter.v
vlog ../src/decoder.v
vlog ../src/ascii_to_7seg.v
vlog ../src/uart_controller.v
vlog ../src/uart_controller_tb.v




vsim uart_controller_tb

add wave -group my_first_group 		uart_controller_tb/*
add wave -group baud_gen 			uart_controller_tb/UUT/baud_gen_module/*
add wave -group Tx_module 			uart_controller_tb/UUT/tx_module/*
add wave -group Rx_module 			uart_controller_tb/UUT/rx_module/*
add wave -group counter 			uart_controller_tb/UUT/counter_module/*
add wave -group decoder 			uart_controller_tb/UUT/decoder_module/*
add wave -group ascii_to_7seg_0 	uart_controller_tb/UUT/ascii_to_7seg_module_0/*
add wave -group ascii_to_7seg_1 	uart_controller_tb/UUT/ascii_to_7seg_module_1/*




config wave -signalnamewidth 1
radix binary


# Change the radix for specific signals

# UUT

#radix signal sim:/vga_controller_tb/UUT/hCount_signal unsigned
#radix signal sim:/vga_controller_tb/UUT/vCount_signal unsigned




# Add a signal
#add wave sim:/vga_controller_tb/UUT/main_controller_dut/matrix_elements/mem_array
#for {set i 0} {$i < 32} {incr i} {
#    radix signal /vga_controller_tb/UUT/main_controller_dut/matrix_elements/mem_array($i) hex
#}

#add wave sim:/main_controller_tb/main_controller_dut/matrix_elements/mem_array[0]
#radix signal sim:/main_controller_tb/main_controller_dut/matrix_elements/mem_array[0] hex


restart -f
#run 10000ns
run 200ns	