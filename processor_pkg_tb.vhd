library ieee;
use ieee.std_logic_1164.all;
--include packages
use WORK.eecs361_gates.all;
use WORK.eecs361.all;

entity processor_pkg_tb is
	generic(
		mem_file : string := "unsigned_sum.dat"
	);
end entity processor_pkg_tb;

architecture behavioral of processor_pkg_tb is

	component processor_pkg is
		generic(
			mem_file : string
		);
		port(
			clk, rst : in std_logic
		);
	end component processor_pkg;

	
	signal clk_tb  : std_logic := '0';
	signal rst_tb : std_logic;

	
begin
	cpu_under_test : processor_pkg 
		generic map(
			mem_file => mem_file
		)
		port map(
			clk => clk_tb,
			rst => rst_tb
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
		
		--hold reset high for 15 cycles
		for i in 0 to 400 loop
			clk_tb <= not clk_tb;
			wait for 100 ns;
			clk_tb <= not clk_tb;
			wait for 100 ns;
		end loop;
		
		wait;
	end process;
	
	
end architecture behavioral;