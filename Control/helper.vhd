library IEEE;
use IEEE.std_logic_1164.all;
use work.eecs361_gates.all;
use work.eecs361.all;

package helper is

	-- ALU control
	component and_8_to_1 is
		port ( 
			x	:  in  std_logic_vector(7 downto 0);
			z	:  out std_logic
		);
	end component and_8_to_1; 
	
	component ALUopcode is
		port (
			alu_ctrl	: in std_logic_vector(1 downto 0);
			funct		: in std_logic_vector(5 downto 0);
			add_op, sub_op, and_op, or_op, slt_op, sll_op, branch_op, store_load_op	: out std_logic
		);
	end component ALUopcode;

	component ALU_control is
		port (
			ALUop	: in std_logic_vector(1 downto 0);
			funct	: in std_logic_vector(5 downto 0);
			ALUctrl	: out std_logic_vector(5 downto 0)
		);
	end component ALU_control;
	
	-- main control
	component and_6_to_1 is
		port ( 
			x	:  in  std_logic_vector(5 downto 0);
			z	:  out std_logic
		);
	end component and_6_to_1; 

	component mainctrl_opcode is
		port (
			opcode	: in std_logic_vector(5 downto 0);
			r_op, addi_op, beq_op, bneq_op, bgtz_op, lw_op, sw_op		: out std_logic
		);
	end component mainctrl_opcode;
	
	component main_control is
		port (
			opcode	: in std_logic_vector(5 downto 0);
			ALUop	: out std_logic_vector(1 downto 0);
			RegDst, ALUSrc, MemtoReg, RegWrite, MemWrite, MemRead, beq, bneq, bgtz, ExtOp	: out std_logic
		);
	end component main_control;
	
	component zero_detect_6 is
		port(
			x : in std_logic_vector(5 downto 0);
			z : out std_logic
		);
	end component zero_detect_6;
	
	-- final control
		component final_control is
		port (
			opcode, funct	: in std_logic_vector(5 downto 0);
			
			ALUctrl			: out std_logic_vector(5 downto 0);
			
			RegDst, ALUSrc, MemtoReg, RegWrite, MemWrite, MemRead, beq, bneq, bgtz, ExtOp	: out std_logic
		);
	end component final_control;

end package;
