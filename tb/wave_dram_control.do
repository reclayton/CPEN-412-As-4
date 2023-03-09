onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /tb_dramController/dut/Clock
add wave -noupdate /tb_dramController/dut/RefreshTimer
add wave -noupdate /tb_dramController/dut/RefreshTimerValue
add wave -noupdate -radix unsigned /tb_dramController/dut/CurrentState
add wave -noupdate -radix unsigned /tb_dramController/dut/NextState
add wave -noupdate -radix unsigned /tb_dramController/dut/ReturnState
add wave -noupdate -radix unsigned /tb_dramController/dut/RefreshCount
add wave -noupdate -radix hexadecimal /tb_dramController/dut/DramAddress
add wave -noupdate /tb_dramController/dut/RefreshTimerLoad_H
add wave -noupdate /tb_dramController/dut/RefreshTimerDone_H
add wave -noupdate /tb_dramController/dut/TimerLoad_H
add wave -noupdate /tb_dramController/dut/TimerDone_H
add wave -noupdate /tb_dramController/dut/Command
add wave -noupdate /tb_dramController/dut/ResetOut_L
add wave -noupdate /tb_dramController/dut/UDS_L
add wave -noupdate /tb_dramController/dut/LDS_L
add wave -noupdate /tb_dramController/dut/DramSelect_L
add wave -noupdate /tb_dramController/dut/WE_L
add wave -noupdate /tb_dramController/dut/AS_L
add wave -noupdate /tb_dramController/dut/Address
add wave -noupdate -radix hexadecimal /tb_dramController/dut/DataIn
add wave -noupdate /tb_dramController/dut/DataOut
add wave -noupdate /tb_dramController/dut/SDram_DQ
add wave -noupdate /tb_dramController/dut/SDram_Addr
add wave -noupdate /tb_dramController/dut/SDram_BA
add wave -noupdate -radix unsigned /tb_dramController/dut/DramState
add wave -noupdate /tb_dramController/dut/Dtack_L
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {115 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 259
configure wave -valuecolwidth 202
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
WaveRestoreZoom {95 ps} {149 ps}
