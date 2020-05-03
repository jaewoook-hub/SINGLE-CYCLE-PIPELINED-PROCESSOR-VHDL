library IEEE;
use IEEE.std_logic_1164.all;
use work.eecs361_gates.all;
use work.eecs361.all;
use work.helper.all;

entity final_control is
	port (
		opcode, funct	: in std_logic_vector(5 downto 0);
		
		ALUctrl			: out std_logic_vector(5 downto 0);
		
		RegDst, ALUSrc, MemtoReg, RegWrite, MemWrite, MemRead, beq, bneq, bgtz, ExtOp	: out std_logic
	);
end entity final_control;

architecture structural of final_control is
	
	signal ALUop_temp : std_logic_vector(1 downto 0);
	-- signal ALUctrl_temp : std_logic_vector(5 downto 0);
	signal ALUSrc_temp, opcode_zero, funct_zero, zero_temp	: std_logic;
	
	begin
	
	main_control_map 	: main_control port map (opcode => opcode, ALUop => ALUop_temp, RegDst => RegDst, ALUSrc => ALUSrc_temp, MemtoReg => MemtoReg, RegWrite => RegWrite, MemWrite => MemWrite, MemRead => MemRead, beq => beq, bneq => bneq, bgtz => bgtz, ExtOp => ExtOp);
	
	alu_control_map		: ALU_control port map (ALUop => ALUop_temp, funct => funct, ALUctrl => ALUctrl);

	-- case for SLL 
	case1 : zero_detect_6 port map (x => opcode, z => opcode_zero);
	case2 : zero_detect_6 port map (x => funct, z => funct_zero);
	
	and_sll	: and_gate port map (x => opcode_zero, y => funct_zero, z => zero_temp);
	
	or_sll	: or_gate port map (x => ALUSrc_temp, y => zero_temp, z => ALUSrc);
	
	
	
	


end architecture structural;
