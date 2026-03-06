
vlog ../src/baud_gen.v
vlog ../src/baud_gen_tb.v

vsim baud_gen_tb

add wave -group my_first_group baud_gen_tb/*
add wave -group UUT baud_gen_tb/UUT/*

config wave -signalnamewidth 1
radix binary

restart -f
run 1000us


