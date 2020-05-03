onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -radix hexadecimal /pipeline_tb/dut/pcSrc_Mux/sel
add wave -noupdate -radix hexadecimal /pipeline_tb/dut/pcSrc_Mux/src0
add wave -noupdate -radix hexadecimal /pipeline_tb/dut/pcSrc_Mux/src1
add wave -noupdate -radix hexadecimal /pipeline_tb/dut/pcSrc_Mux/z
add wave -noupdate /pipeline_tb/dut/IFU/pc_enable
add wave -noupdate -radix hexadecimal /pipeline_tb/dut/IFU/pc_in
add wave -noupdate -radix hexadecimal /pipeline_tb/dut/IFU/pc_out
add wave -noupdate -radix hexadecimal /pipeline_tb/dut/IFU/instr_out
add wave -noupdate /pipeline_tb/dut/IF_ID_register/if_id_enable
add wave -noupdate -radix hexadecimal /pipeline_tb/dut/IF_ID_register/instr_in
add wave -noupdate -radix hexadecimal /pipeline_tb/dut/IF_ID_register/pc_in
add wave -noupdate -radix hexadecimal /pipeline_tb/dut/IF_ID_register/instr_out
add wave -noupdate -radix hexadecimal /pipeline_tb/dut/IF_ID_register/pc_out
add wave -noupdate /pipeline_tb/dut/branch_detect/beq_flag
add wave -noupdate /pipeline_tb/dut/branch_detect/bneq_flag
add wave -noupdate /pipeline_tb/dut/branch_detect/bgtz_flag
add wave -noupdate /pipeline_tb/dut/branch_detect/zero_flag
add wave -noupdate /pipeline_tb/dut/branch_detect/gtz_flag
add wave -noupdate /pipeline_tb/dut/branch_detect/PC_Src_out
add wave -noupdate -radix decimal /pipeline_tb/dut/hazard_unit_map/if_id_Rs
add wave -noupdate -radix decimal /pipeline_tb/dut/hazard_unit_map/if_id_Rt
add wave -noupdate -radix decimal /pipeline_tb/dut/hazard_unit_map/id_ex_Rt
add wave -noupdate /pipeline_tb/dut/hazard_unit_map/id_ex_MemRd
add wave -noupdate /pipeline_tb/dut/hazard_unit_map/PC_write
add wave -noupdate /pipeline_tb/dut/hazard_unit_map/IF_ID_write
add wave -noupdate /pipeline_tb/dut/hazard_unit_map/IF_ID_zeros_flag
add wave -noupdate /pipeline_tb/dut/hazard_unit_map/ID_EX_stall_flag
add wave -noupdate /pipeline_tb/dut/hazard_unit_map/EX_MEM_stall_flag
add wave -noupdate /pipeline_tb/dut/ID_EX_register/id_ex_enable
add wave -noupdate /pipeline_tb/dut/ID_EX_register/control_wb
add wave -noupdate /pipeline_tb/dut/ID_EX_register/control_mem
add wave -noupdate /pipeline_tb/dut/ID_EX_register/control_ex
add wave -noupdate -radix hexadecimal /pipeline_tb/dut/ID_EX_register/pc_in
add wave -noupdate -radix hexadecimal /pipeline_tb/dut/ID_EX_register/pc_out
add wave -noupdate -radix hexadecimal /pipeline_tb/dut/ID_EX_register/read_data1
add wave -noupdate -radix hexadecimal /pipeline_tb/dut/ID_EX_register/read_data2
add wave -noupdate -radix hexadecimal /pipeline_tb/dut/ID_EX_register/sign_ext
add wave -noupdate -radix hexadecimal /pipeline_tb/dut/ID_EX_register/shamt_ext
add wave -noupdate /pipeline_tb/dut/ID_EX_register/instruct_1
add wave -noupdate /pipeline_tb/dut/ID_EX_register/instruct_2
add wave -noupdate -radix decimal /pipeline_tb/dut/ID_EX_register/Rs_in
add wave -noupdate -radix decimal /pipeline_tb/dut/ID_EX_register/Rt_in
add wave -noupdate /pipeline_tb/dut/ID_EX_register/control_wb_out
add wave -noupdate /pipeline_tb/dut/ID_EX_register/control_mem_out
add wave -noupdate /pipeline_tb/dut/ID_EX_register/ALUSrc
add wave -noupdate /pipeline_tb/dut/ID_EX_register/ALUOp
add wave -noupdate /pipeline_tb/dut/ID_EX_register/RegDst
add wave -noupdate -radix hexadecimal /pipeline_tb/dut/ID_EX_register/bus_a
add wave -noupdate -radix hexadecimal /pipeline_tb/dut/ID_EX_register/bus_b
add wave -noupdate -radix hexadecimal /pipeline_tb/dut/ID_EX_register/out_sign_ext
add wave -noupdate -radix hexadecimal /pipeline_tb/dut/ID_EX_register/out_shamt_ext
add wave -noupdate /pipeline_tb/dut/ID_EX_register/out_instruct1
add wave -noupdate /pipeline_tb/dut/ID_EX_register/out_instruct2
add wave -noupdate -radix decimal /pipeline_tb/dut/ID_EX_register/Rs_out
add wave -noupdate -radix decimal /pipeline_tb/dut/ID_EX_register/Rt_out
add wave -noupdate -radix decimal /pipeline_tb/dut/forwarding_map/ID_EX_Rs
add wave -noupdate -radix decimal /pipeline_tb/dut/forwarding_map/ID_EX_Rt
add wave -noupdate -radix decimal /pipeline_tb/dut/forwarding_map/EX_MEM_Rd
add wave -noupdate -radix decimal /pipeline_tb/dut/forwarding_map/MEM_WB_Rd
add wave -noupdate -radix decimal /pipeline_tb/dut/forwarding_map/EX_MEM_RegWr
add wave -noupdate -radix decimal /pipeline_tb/dut/forwarding_map/MEM_WB_RegWr
add wave -noupdate -radix decimal /pipeline_tb/dut/forwarding_map/sll_flag
add wave -noupdate -radix hexadecimal /pipeline_tb/dut/mux_forwardA/sel
add wave -noupdate -radix hexadecimal /pipeline_tb/dut/mux_forwardA/src00
add wave -noupdate -radix hexadecimal /pipeline_tb/dut/mux_forwardA/src01
add wave -noupdate -radix hexadecimal /pipeline_tb/dut/mux_forwardA/src10
add wave -noupdate -radix hexadecimal /pipeline_tb/dut/mux_forwardA/z
add wave -noupdate -radix hexadecimal /pipeline_tb/dut/mux_forwardB/sel
add wave -noupdate -radix hexadecimal /pipeline_tb/dut/mux_forwardB/src00
add wave -noupdate -radix hexadecimal /pipeline_tb/dut/mux_forwardB/src01
add wave -noupdate -radix hexadecimal /pipeline_tb/dut/mux_forwardB/src10
add wave -noupdate -radix hexadecimal /pipeline_tb/dut/mux_forwardB/z
add wave -noupdate -radix hexadecimal /pipeline_tb/dut/ALU_map/A
add wave -noupdate -radix hexadecimal /pipeline_tb/dut/ALU_map/B
add wave -noupdate /pipeline_tb/dut/ALU_map/sel
add wave -noupdate -radix hexadecimal /pipeline_tb/dut/ALU_map/result
add wave -noupdate /pipeline_tb/dut/EX_Mem_register/control_wb_in
add wave -noupdate /pipeline_tb/dut/EX_Mem_register/control_mem_in
add wave -noupdate -radix hexadecimal /pipeline_tb/dut/EX_Mem_register/pc_in
add wave -noupdate /pipeline_tb/dut/EX_Mem_register/zero_flag_in
add wave -noupdate -radix hexadecimal /pipeline_tb/dut/EX_Mem_register/alu_result_in
add wave -noupdate -radix hexadecimal /pipeline_tb/dut/EX_Mem_register/bus_b_in
add wave -noupdate /pipeline_tb/dut/EX_Mem_register/rw_in
add wave -noupdate /pipeline_tb/dut/EX_Mem_register/control_wb_out
add wave -noupdate /pipeline_tb/dut/EX_Mem_register/beq_flag
add wave -noupdate /pipeline_tb/dut/EX_Mem_register/bneq_flag
add wave -noupdate /pipeline_tb/dut/EX_Mem_register/bgtz_flag
add wave -noupdate /pipeline_tb/dut/EX_Mem_register/MemRead
add wave -noupdate /pipeline_tb/dut/EX_Mem_register/MemWrite
add wave -noupdate /pipeline_tb/dut/EX_Mem_register/zero_flag_out
add wave -noupdate -radix hexadecimal /pipeline_tb/dut/EX_Mem_register/pc_out
add wave -noupdate -radix hexadecimal /pipeline_tb/dut/EX_Mem_register/alu_result_out
add wave -noupdate -radix hexadecimal /pipeline_tb/dut/EX_Mem_register/bus_b_out
add wave -noupdate /pipeline_tb/dut/EX_Mem_register/rw_out
add wave -noupdate /pipeline_tb/dut/EX_Mem_register/control_mem_in_temp
add wave -noupdate -radix hexadecimal /pipeline_tb/dut/DataMemory/addr
add wave -noupdate -radix hexadecimal /pipeline_tb/dut/DataMemory/din
add wave -noupdate -radix hexadecimal /pipeline_tb/dut/DataMemory/dout
add wave -noupdate -radix hexadecimal /pipeline_tb/dut/MEM_WB_MAP/data_mem_in
add wave -noupdate /pipeline_tb/dut/MEM_WB_MAP/control_wb_in
add wave -noupdate -radix hexadecimal /pipeline_tb/dut/MEM_WB_MAP/alu_result_in
add wave -noupdate /pipeline_tb/dut/MEM_WB_MAP/rw_in
add wave -noupdate -radix hexadecimal /pipeline_tb/dut/MEM_WB_MAP/data_mem_out
add wave -noupdate /pipeline_tb/dut/MEM_WB_MAP/control_wb_out
add wave -noupdate -radix unsigned /pipeline_tb/dut/MEM_WB_MAP/rw_out
add wave -noupdate -radix hexadecimal /pipeline_tb/dut/MEM_WB_MAP/alu_result_out
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {4200000 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 358
configure wave -valuecolwidth 208
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
configure wave -timelineunits ns
update
WaveRestoreZoom {2721342 ps} {4199998 ps}
