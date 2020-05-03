library IEEE;
use IEEE.std_logic_1164.all;
use work.eecs361_gates.all;
use work.eecs361.all;
use work.helper.all;

entity final_control_tb is
	port (
		ALUctrl			: out std_logic_vector(5 downto 0);
		RegDst, ALUSrc, MemtoReg, RegWrite, MemWrite, MemRead, beq, bneq, bgtz	: out std_logic
	);
end entity final_control_tb;

architecture structural of final_control_tb is

	component final_control is
		port (
			opcode, funct	: in std_logic_vector(5 downto 0);
			
			ALUctrl			: out std_logic_vector(5 downto 0);
			
			RegDst, ALUSrc, MemtoReg, RegWrite, MemWrite, MemRead, beq, bneq, bgtz	: out std_logic
		);
	end component final_control;
	
	signal opcode_tb, funct_tb	: std_logic_vector(5 downto 0);
	
	begin
	
		final_control_map : final_control port map (
			opcode 		=> opcode_tb,
			funct 		=> funct_tb,
			ALUctrl 	=> ALUctrl,
			RegDst		=> RegDst,
			ALUSrc		=> ALUSrc,
			MemtoReg	=> MemtoReg,
			RegWrite	=> RegWrite,
			MemWrite	=> MemWrite,
			MemRead		=> MemRead,
			beq			=> beq,
			bneq		=> bneq,
			bgtz		=> bgtz
		);
	
	testbench_proc : process
	begin
		-- add
		opcode_tb 	<= "000000";
		funct_tb	<= "100000";
		wait for 5 ns;
		-- addu
		opcode_tb 	<= "000000";
		funct_tb	<= "100001";
		wait for 5 ns;
		
		-- sub
		opcode_tb 	<= "000000";
		funct_tb	<= "100010";
		wait for 5 ns;
		-- subu
		opcode_tb 	<= "000000";
		funct_tb	<= "100011";
		wait for 5 ns;
		
		-- and
		opcode_tb 	<= "000000";
		funct_tb	<= "100100";
		wait for 5 ns;
		-- or
		opcode_tb 	<= "000000";
		funct_tb	<= "100101";
		wait for 5 ns;
		
		-- sll
		opcode_tb 	<= "000000";
		funct_tb	<= "000000";
		wait for 5 ns;
		
		-- slt
		opcode_tb 	<= "000000";
		funct_tb	<= "101010";
		wait for 5 ns;
		
		-- sltu
		opcode_tb 	<= "000000";
		funct_tb	<= "101011";
		wait for 5 ns;
		
		-- addi
		opcode_tb	<= "001000";
		funct_tb	<= "000000";
		wait for 5 ns;
		
		-- beq
		opcode_tb	<= "000100";
		funct_tb	<= "000000";
		wait for 5 ns;
		
		-- bneq
		opcode_tb	<= "000101";
		funct_tb	<= "000000";
		wait for 5 ns;
		
		-- bgtz
		opcode_tb	<= "000111";
		funct_tb	<= "000000";
		wait for 5 ns;
		
		-- lw
		opcode_tb	<= "100011";
		funct_tb	<= "000000";
		wait for 5 ns;
		
		-- sw
		opcode_tb	<= "101011";
		funct_tb	<= "000000";
		wait for 5 ns;
		
		wait;
	end process;
	
end architecture structural;
		
		
		