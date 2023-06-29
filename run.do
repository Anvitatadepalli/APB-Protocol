vlib work

vlog APB_protocol.v
vlog APB_protocol_tb.v

vsim work.tb
add wave -r *
run -all