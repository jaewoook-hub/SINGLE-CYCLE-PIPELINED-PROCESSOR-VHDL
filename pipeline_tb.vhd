library IEEE;
use IEEE.std_logic_1164.all;
--include packages
use WORK.eecs361_gates.all;
use WORK.eecs361.all;
use WORK.pipeline_CPU;

entity pipeline_tb is
	generic(
		mem_file : string := "bills_branch.dat"
	);
end entity pipeline_tb;

architecture behavioral of pipeline_tb is

	component pipeline_CPU is
		generic (
			mem_file : string --loads Data Memory & Instr Memory
			);
		port (
			clk 	: in std_logic;
			arst	: in std_logic
		);
	end component pipeline_CPU;
	
	signal clk_tb  : std_logic := '0';
	signal rst_tb  : std_logic;

	
begin
	dut : pipeline_CPU 
	generic map(mem_file => mem_file)
	port map(
		clk => clk_tb,
		arst => rst_tb
	);
	
	process is
	begin
		rst_tb <= '1';
		clk_tb <= not clk_tb;
		wait for 100 ns;
		
		--hold reset high for 2 cycles
		for i in 0 to 1 loop
			clk_tb <= not clk_tb;
			wait for 100 ns;
			clk_tb <= not clk_tb;
			wait for 100 ns;
		end loop;
		
		--reset low 
		rst_tb <= '0';
		clk_tb <= not clk_tb;
		wait for 100 ns;
		
		--hold reset high for 15 x 5 cycles
		for i in 0 to 1000 loop
			clk_tb <= not clk_tb;
			wait for 100 ns;
			clk_tb <= not clk_tb;
			wait for 100 ns;
		end loop;
		
		wait;
	end process;
	
	
end architecture behavioral;
