library IEEE;
use IEEE.std_logic_1164.all;
use work.eecs361_gates.all;

entity alu32_tb is
end entity alu32_tb;

architecture struct_tb2 of alu32_tb is 

	component alu is
		port(
				A : in std_logic_vector(31 downto 0);
				B : in std_logic_vector(31 downto 0);
				sel : in std_logic_vector(5 downto 0);
				result : out std_logic_vector(31 downto 0);
				cout, overflow, zero : out std_logic
				);
	end component alu;
	
	signal a_tb, b_tb, result_tb : std_logic_vector(31 downto 0);
	signal sel_tb : std_logic_vector(5 downto 0);
	signal cout_tb, overflow_tb, zero_tb : std_logic;
			
begin  
		
	dut : alu port map(a_tb, b_tb, sel_tb, result_tb, cout_tb, overflow_tb, zero_tb);

	stim1 : process is 
		begin

-- add
			sel_tb <= "100000";
			
			a_tb <= x"00000000";
			b_tb <= x"00000001";
			wait for 10 ns;
			a_tb <= x"00000001";
			b_tb <= x"00000000";
			wait for 10 ns;
			a_tb <= x"40000001";
			b_tb <= x"40000010";
			wait for 10 ns;
			a_tb <= x"FFFFFFFF";
			b_tb <= x"0000000F";
			wait for 10 ns;
			
-- sub
			sel_tb <= "100010";
			
			a_tb <= x"00000000";
			b_tb <= x"00000001";
			wait for 10 ns;
			a_tb <= x"00000001";
			b_tb <= x"00000000";
			wait for 10 ns;
			a_tb <= x"40000001";
			b_tb <= x"40000010";
			wait for 10 ns;
			a_tb <= x"FFFFFFFF";
			b_tb <= x"0000000F";
			wait for 10 ns;
			
-- and
			sel_tb <= "100100";
			
			a_tb <= x"00000000";
			b_tb <= x"00000001";
			wait for 10 ns;
			a_tb <= x"00000001";
			b_tb <= x"00000000";
			wait for 10 ns;
			a_tb <= x"40000001";
			b_tb <= x"40000010";
			wait for 10 ns;
			a_tb <= x"FFFFFFFF";
			b_tb <= x"0000000F";
			wait for 10 ns;

-- xor
			sel_tb <= "100110";
			
			a_tb <= x"00000000";
			b_tb <= x"00000001";
			wait for 10 ns;
			a_tb <= x"00000001";
			b_tb <= x"00000000";
			wait for 10 ns;
			a_tb <= x"40000001";
			b_tb <= x"40000010";
			wait for 10 ns;
			a_tb <= x"FFFFFFFF";
			b_tb <= x"0000000F";
			wait for 10 ns;

-- or 
			sel_tb <= "100101";
			
			a_tb <= x"00000000";
			b_tb <= x"00000001";
			wait for 10 ns;
			a_tb <= x"00000001";
			b_tb <= x"00000000";
			wait for 10 ns;
			a_tb <= x"40000001";
			b_tb <= x"40000010";
			wait for 10 ns;
			a_tb <= x"FFFFFFFF";
			b_tb <= x"0000000F";
			wait for 10 ns;
			
-- sll 
			sel_tb <= "000000";
			
			a_tb <= x"00000000";
			b_tb <= x"00000001";
			wait for 10 ns;
			a_tb <= x"00000001";
			b_tb <= x"00000000";
			wait for 10 ns;
			a_tb <= x"40000001";
			b_tb <= x"40000010";
			wait for 10 ns;
			a_tb <= x"FFFFFFFF";
			b_tb <= x"0000000F";
			wait for 10 ns;
			
-- slt 
			sel_tb <= "101010";
			
			a_tb <= x"00000000";
			b_tb <= x"00000001";
			wait for 10 ns;
			a_tb <= x"00000001";
			b_tb <= x"00000000";
			wait for 10 ns;
			a_tb <= x"40000001";
			b_tb <= x"40000010";
			wait for 10 ns;
			a_tb <= x"FFFFFFFF";
			b_tb <= x"0000000F";
			wait for 10 ns;

-- sltu 
			sel_tb <= "101011";
			
			a_tb <= x"00000000";
			b_tb <= x"00000001";
			wait for 10 ns;
			a_tb <= x"00000001";
			b_tb <= x"00000000";
			wait for 10 ns;
			a_tb <= x"40000001";
			b_tb <= x"40000010";
			wait for 10 ns;
			a_tb <= x"FFFFFFFF";
			b_tb <= x"0000000F";
			wait for 10 ns;
			
	end process;

end architecture struct_tb2;