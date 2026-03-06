
vlog ../src/Tx_module.v
vlog ../src/Tx_module_tb.v

vsim Tx_module_tb

add wave -group my_first_group Tx_module_tb/*
add wave -group UUT Tx_module_tb/DUT/*

config wave -signalnamewidth 1
radix binary

restart -f
run 300ns


