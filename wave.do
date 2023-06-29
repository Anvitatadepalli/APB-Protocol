onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -radix unsigned /tb/p_clk
add wave -noupdate -radix unsigned /tb/p_reset_n
add wave -noupdate -radix unsigned /tb/p_sel
add wave -noupdate -radix unsigned /tb/p_enable
add wave -noupdate -radix unsigned /tb/p_write
add wave -noupdate -radix unsigned /tb/p_w_data
add wave -noupdate -radix unsigned /tb/p_addr
add wave -noupdate -radix unsigned /tb/p_ready
add wave -noupdate -radix unsigned /tb/p_slv_err
add wave -noupdate -radix unsigned /tb/p_r_data
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {1140 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 178
configure wave -valuecolwidth 40
configure wave -justifyvalue left
configure wave -signalnamewidth 0
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ps
update
WaveRestoreZoom {0 ps} {735 ps}
