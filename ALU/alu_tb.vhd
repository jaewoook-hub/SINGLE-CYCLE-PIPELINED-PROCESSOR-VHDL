library IEEE;
use IEEE.std_logic_1164.all;
use work.eecs361_gates.all;

entity alu_tb is
end entity alu_tb;

architecture struc_tb of alu_tb is 

	component alu_1bit is
		port(
				A : in std_logic;
				B : in std_logic;
				sel : in std_logic_vector (5 downto 0);
				result : out std_logic;
				cout, overflow, zero : out std_logic
				);
	end component alu_1bit;

	signal a_tb, b_tb, result_tb, cout_tb, overflow_tb, zero_tb	: std_logic;
	signal sel_tb : std_logic_vector (5 downto 0);
			
begin  
		
	dut : alu_1bit 
		port map(
			a_tb, 
			b_tb, 
			sel_tb, 
			result_tb, 
			cout_tb, 
			overflow_tb, 
			zero_tb
		);

	simulate1 : process is 
	
		begin
			
-- add operator

			sel_tb <= "100000";
			
			a_tb <= '0';
			b_tb <= '0';
			wait for 10 ns;
			a_tb <= '1';
			b_tb <= '0';
			wait for 10 ns;
			a_tb <= '0';
			b_tb <= '1';
			wait for 10 ns;
			a_tb <= '1';
			b_tb <= '1';
			wait for 10 ns;
			
-- sub operator

			sel_tb <= "100010";
			
			a_tb <= '0';
			b_tb <= '0';
			wait for 10 ns;
			a_tb <= '1';
			b_tb <= '0';
			wait for 10 ns;
			a_tb <= '0';
			b_tb <= '1';
			wait for 10 ns;
			a_tb <= '1';
			b_tb <= '1';
			wait for 10 ns;
			
-- and operator

			sel_tb <= "100100";
			
			a_tb <= '0';
			b_tb <= '0';
			wait for 10 ns;
			a_tb <= '1';
			b_tb <= '0';
			wait for 10 ns;
			a_tb <= '0';
			b_tb <= '1';
			wait for 10 ns;
			a_tb <= '1';
			b_tb <= '1';
			wait for 10 ns;

-- xor operator

			sel_tb <= "100110";
			
			a_tb <= '0';
			b_tb <= '0';
			wait for 10 ns;
			a_tb <= '1';
			b_tb <= '0';
			wait for 10 ns;
			a_tb <= '0';
			b_tb <= '1';
			wait for 10 ns;
			a_tb <= '1';
			b_tb <= '1';
			wait for 10 ns;
			
-- or operator 

			sel_tb <= "100101";
			
			a_tb <= '0';
			b_tb <= '0';
			wait for 10 ns;
			a_tb <= '1';
			b_tb <= '0';
			wait for 10 ns;
			a_tb <= '0';
			b_tb <= '1';
			wait for 10 ns;
			a_tb <= '1';
			b_tb <= '1';
			wait for 10 ns;
			
-- slt operator 

			sel_tb <= "101010";
			
			a_tb <= '0';
			b_tb <= '0';
			wait for 10 ns;
			a_tb <= '1';
			b_tb <= '0';
			wait for 10 ns;
			a_tb <= '0';
			b_tb <= '1';
			wait for 10 ns;
			a_tb <= '1';
			b_tb <= '1';
			wait for 10 ns;
			
-- sltu operator

			sel_tb <= "101011";
			
			a_tb <= '0';
			b_tb <= '0';
			wait for 10 ns;
			a_tb <= '1';
			b_tb <= '0';
			wait for 10 ns;
			a_tb <= '0';
			b_tb <= '1';
			wait for 10 ns;
			a_tb <= '1';
			b_tb <= '1';
			wait for 10 ns;
			
		end process;

end architecture struc_tb;