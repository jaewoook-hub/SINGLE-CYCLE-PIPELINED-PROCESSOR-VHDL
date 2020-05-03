library IEEE;
use IEEE.std_logic_1164.all;
use work.eecs361_gates.all;
use work.eecs361.all;

entity or_n is
	generic (
		n : integer
	);
	port (
		x : in std_logic_vector (n - 1 downto 0);
		z : out std_logic
	);
end entity or_n;

-- list of OR gates
-- creates x amount of OR gates depending on the size of the integer
-- OR's 1bit from the inputs and 1bit from the previous or gates

architecture structural of or_n is
	
	signal temp : std_logic_vector(n - 1 downto 0);
	
	begin
		temp(0) <= x(0);
		
		or_loop : for i in 1 to n - 1 generate
			begin
				or_map : or_gate port map (x => temp(i - 1), y => x(i), z => temp(i));
		end generate;
		
		z <= temp(n - 1);
		
end architecture structural;