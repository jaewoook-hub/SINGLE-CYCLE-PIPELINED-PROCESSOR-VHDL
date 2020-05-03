library ieee;
use ieee.std_logic_1164.all;

entity shift_left_2 is
port (
		x: in std_logic_vector(31 downto 0);
		z : out std_logic_vector(31 downto 0)
		);
end shift_left_2;

architecture struct of shift_left_2 is 

signal cout: std_logic_vector(31 downto 0);

begin
	z(1 downto 0) <= "00";
	shift : for i in 2 to 31 generate
		z(i) <= x(i - 2);
	end generate;
end architecture struct;
