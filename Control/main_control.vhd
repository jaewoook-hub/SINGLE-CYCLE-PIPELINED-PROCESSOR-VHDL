library IEEE;
use IEEE.std_logic_1164.all;
use work.eecs361_gates.all;
use work.eecs361.all;
use work.helper.all;

entity main_control is
	port (
		opcode	: in std_logic_vector(5 downto 0);
		ALUop	: out std_logic_vector(1 downto 0);
		RegDst, ALUSrc, MemtoReg, RegWrite, MemWrite, MemRead, beq, bneq, bgtz, ExtOp	: out std_logic
	);
end entity main_control;

architecture structural of main_control is
	
	signal r_temp, addi_temp, beq_temp, bneq_temp, bgtz_temp, lw_temp, sw_temp	: std_logic;
	
	signal RegWrite_temp, ALUSrc_temp, branch_temp, ExtOp_temp	: std_logic;
	
	begin
		-- mapping opcodes
		opcode_map	: mainctrl_opcode port map (opcode => opcode, r_op => r_temp, addi_op => addi_temp, beq_op => beq_temp, bneq_op => bneq_temp, bgtz_op => bgtz_temp, lw_op => lw_temp, sw_op => sw_temp);
		
		-- set R-type to be Register Destination
		RegDst <= r_temp;
		
		-- when Addi, Lw, or Sw is 1, enable ALUSrc
		ALUSrc_temp_map : or_gate port map (x => addi_temp, y => lw_temp, z => ALUSrc_temp);
		ALUSrc_map : or_gate port map (x => ALUSrc_temp, y => sw_temp, z => ALUSrc);
		
		-- when Lw is 1, enable MemtoReg
		MemtoReg <= lw_temp;
		
		-- when R-type, Addi, or Lw is 1, enable RegWrite
		RegWrite_temp_map	: or_gate port map (x => r_temp, y => addi_temp, z => RegWrite_temp);
		RegWrite_map		: or_gate port map (x => RegWrite_temp, y => lw_temp, z => RegWrite);

		-- when Sw is 1, enable MemWrite
		MemWrite 	<= sw_temp;
		
		-- when Lw is 1, enable MemRead
		MemRead		<= lw_temp;

		-- when beq, bneq, or bgtz is 1, enable branch respectively
		beq 	<= beq_temp;
		bneq	<= bneq_temp;
		bgtz	<= bgtz_temp;
		
		-- when either Lw or Sw is 1, enable ExtOp
		ExtOp_map	: or_gate port map (x => lw_temp, y => sw_temp, z => ExtOp_temp);
		ExtOp <= ExtOp_temp;
		
		-- when R-type is 1, enable ALUop(1)
		ALUop(1) <= r_temp;
		
		-- when beq, bneq, or bgtz is 1, enable ALUop(0)
		ALUop_temp_map		: or_gate port map (x => beq_temp, y => bneq_temp, z => branch_temp);
		ALUop_map			: or_gate port map (x => branch_temp, y => bgtz_temp, z => ALUop(0));
		
end architecture structural;
		
		

	