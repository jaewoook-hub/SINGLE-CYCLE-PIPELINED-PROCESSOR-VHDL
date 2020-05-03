library ieee;
use ieee.std_logic_1164.all;
use work.testbench_functions.all;

entity IFU_tb is
end IFU_tb;

architecture behavioral of IFU_tb is
	component IFU is
		generic (mem_file: string);
		port(
			clk, rst	 : in std_logic;

			-- Immed : 16 least significant bits of Instr --
			immed16 : in std_logic_vector(15 downto 0);

			-- Jump Target Addr --
			jump_addr : in std_logic_vector(25 downto 0);

			-- Contrl Signals --
			branch, jump, zero, gtz	 : in std_logic;  --greater than

			instr_out	 : out std_logic_vector(31 downto 0)
		);
	end component IFU;

	signal clk_tb, rst_tb:  std_logic := '0';
	signal immed16_tb :  std_logic_vector(15 downto 0);
	signal jump_addr_tb :  std_logic_vector(25 downto 0);
	signal branch_tb, jump_tb, zero_tb, gtz_tb	 :  std_logic := '0';  --greater than
	signal instr_out_tb	 :  std_logic_vector(31 downto 0);

begin
	dut : IFU
		generic map("sort_corrected_branch.dat")
		port map (
			clk_tb, rst_tb,
			immed16_tb,
			jump_addr_tb,
			branch_tb, jump_tb, zero_tb, gtz_tb,
			instr_out_tb
		);
		
	testbench : process is
	--variables
	begin
		--reset
		immed16_tb <= x"0005";
		jump_addr_tb <= "11111111111111111111111111";
		rst_tb <= '1';
		
		--hold reset 'high' for 2 cycles
		for i in 0 to 1 loop
			wait for 100 ns;
			clk_tb <= not clk_tb;
			wait for 100 ns;
			clk_tb <= not clk_tb;
		end loop;
		rst_tb <= '0';

		--b = 0, z = 0 for 3 cycles
		branch_tb <= '0';
		zero_tb <= '0';
		for i in 0 to 3 loop
			wait for 100 ns;
			clk_tb <= not clk_tb;
			wait for 100 ns;
			clk_tb <= not clk_tb;
		end loop;
		
		--b = 1, z = 1 (branch with immed), where Immed = 0x5
		branch_tb <= '1';
		zero_tb <= '1';
		wait for 100 ns;
		clk_tb <= not clk_tb;
		wait for 100 ns;
		clk_tb <= not clk_tb;
		
		--Jump to address
		jump_tb <= '1';
		wait for 100 ns;
		clk_tb <= not clk_tb;
		wait for 100 ns;
		clk_tb <= not clk_tb;
		
		
		--b = 0, z = 0 for 3 cycles
		branch_tb <= '0';
		zero_tb <= '0';
		jump_tb <= '0';
		for i in 0 to 3 loop
			wait for 100 ns;
			clk_tb <= not clk_tb;
			wait for 100 ns;
			clk_tb <= not clk_tb;
		end loop;
		branch_tb <= '1';
		zero_tb <= '1';
		immed16_tb <= x"FFFE";
		for i in 0 to 3 loop
			wait for 100 ns;
			clk_tb <= not clk_tb;
			wait for 100 ns;
			clk_tb <= not clk_tb;
		end loop;
		wait;
		
	end process;
end behavioral;