library IEEE;
use IEEE.std_logic_1164.all;
use work.eecs361_gates.all;
use work.eecs361.all;

entity repeat_n is
	generic(
		n : integer
	);
	port(
		x : in std_logic;
		z : out std_logic_vector(n - 1 downto 0)
	);
end entity repeat_n;

architecture structural of repeat_n is
--components
--types
--signals

begin

	replicate : for i in 0 to (n - 1) generate
		z(i) <= x;
	end generate;
	
end architecture structural;