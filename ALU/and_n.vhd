library IEEE;
use IEEE.std_logic_1164.all;
use work.eecs361_gates.all;
use work.eecs361.all;

entity and_n is
	generic (
		n : integer
	);
	port (
		x : in std_logic_vector(n - 1 downto 0);
		z : out std_logic
	);
end entity and_n;

-- similar to functionality of or_n.vhd

architecture structural of and_n is

	signal temp : std_logic_vector(n - 1 downto 0);
	
	begin
		
		temp(0) <= x(0);
		
		and_loop : for i in 1 to n - 1 generate
			begin
				and_map : and_gate port map (x => temp(i - 1), y => x(i), z => temp(i));
		end generate;
		
		z <= temp(n - 1);
end architecture structural;