library IEEE;
use IEEE.std_logic_1164.all;
use work.eecs361_gates.all;
use work.eecs361.all;
use work.helper.all;

entity ALU_control is
	port (
		ALUop	: in std_logic_vector(1 downto 0);
		funct	: in std_logic_vector(5 downto 0);
		ALUctrl	: out std_logic_vector(5 downto 0)
	);
end entity ALU_control;

architecture structural of ALU_control is
	
	signal add_temp, sub_temp, and_temp, or_temp, slt_temp, sll_temp, branch_temp, store_load_temp	: std_logic;
	signal temp1, temp2, temp3, temp4, temp5, temp6, temp7, temp8	: std_logic;
	
	begin
	
		opcode_map	: ALUopcode port map (alu_ctrl => ALUop, funct => funct, add_op => add_temp, sub_op => sub_temp, and_op => and_temp, or_op => or_temp, slt_op => slt_temp, sll_op => sll_temp, branch_op => branch_temp, store_load_op => store_load_temp);

		-- 0bit = or_op 
		ALUctrl(0) <= or_temp;
		
		-- 1bit = branch_op | sub_op | slt_op 
		ALUctrl_1bit_1 : or_gate port map (x => branch_temp, y => sub_temp, z => temp1);
		ALUctrl_1bit_2 : or_gate port map (x => temp1, y => slt_temp, z => ALUctrl(1));
		
		-- 2bit = and_op | or_op
		ALUctrl_2bit_1 : or_gate port map (x => and_temp, y => or_temp, z => ALUctrl(2));
		
		-- 3bit = slt_op 
		ALUctrl(3) <= slt_temp;
		
		-- 4bit = none
		ALUctrl(4) <= '0';
		
		-- 5bit = store_load_op | branch_op | add_op | sub_op | and_op | or_op | slt_op 
		ALUctrl_5bit_1 : or_gate port map (x => store_load_temp, y => branch_temp, z => temp3);
		ALUctrl_5bit_2 : or_gate port map (x => temp3, y => add_temp, z => temp4);
		ALUctrl_5bit_3 : or_gate port map (x => temp4, y => sub_temp, z => temp5);
		ALUctrl_5bit_4 : or_gate port map (x => temp5, y => and_temp, z => temp6);
		ALUctrl_5bit_5 : or_gate port map (x => temp6, y => or_temp, z => temp7);
		ALUctrl_5bit_6 : or_gate port map (x => temp7, y => slt_temp, z => ALUctrl(5));

end architecture structural; 		
