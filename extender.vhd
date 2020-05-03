library IEEE;
use IEEE.std_logic_1164.all;

use work.eecs361_gates.all;

entity extender is
	port (
		x	: in std_logic_vector(15 downto 0);
		sel : in std_logic;
		z	: out std_logic_vector(31 downto 0)
	);
end entity extender;

architecture structural of extender is
	signal MSB_and_sel : std_logic;

begin
	lower_half : for i in 0 to 15 generate
		z(i) <= x(i);	--Pass-thru of existing bits
	end generate;
	
	upper_half : for i in 16 to 31 generate
		z(i) <= MSB_and_sel;	--Sign-extend MSB
	end generate;
	
	AND_MSB_sel : and_gate port map(x(15), sel, MSB_and_sel);
		--x(15) and sel (MSB and sel)
	
end architecture structural;
