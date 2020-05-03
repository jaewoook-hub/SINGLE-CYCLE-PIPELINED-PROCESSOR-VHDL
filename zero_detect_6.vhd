library ieee;
use ieee.std_logic_1164.all;
use work.eecs361_gates.all;
use work.eecs361.all;

entity zero_detect_6 is
	port(
		x : in std_logic_vector(5 downto 0);
		z : out std_logic
	);
end entity zero_detect_6;

architecture structural of zero_detect_6 is

	signal temp1, temp2, temp3, temp_and : std_logic;
	
begin

	nor1 : nor_gate port map(x(0), x(1), temp1);
	nor2 : nor_gate port map(x(2), x(3), temp2);
	nor3 : nor_gate port map(x(4), x(5), temp3);
	
	and1 : and_gate port map(temp1, temp2, temp_and);
	and2 : and_gate port map(temp_and, temp3, z);
	
end architecture structural;
	