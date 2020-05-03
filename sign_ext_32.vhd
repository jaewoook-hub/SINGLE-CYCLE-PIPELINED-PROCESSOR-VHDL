library IEEE;
use IEEE.std_logic_1164.all;

use work.eecs361_gates.all;

entity sign_ext_32 is
	port (
		x	: in std_logic_vector(15 downto 0);
		z	: out std_logic_vector(31 downto 0)
	);
end entity sign_ext_32;

architecture structural of sign_ext_32 is
	signal MSB_and_sel : std_logic;

begin
	lower_half : for i in 0 to 15 generate
		z(i) <= x(i);	--Pass-thru of existing bits
	end generate;
	
	upper_half : for i in 16 to 31 generate
		z(i) <= x(15);	--Sign-extend MSB
	end generate;
	
end architecture structural;
