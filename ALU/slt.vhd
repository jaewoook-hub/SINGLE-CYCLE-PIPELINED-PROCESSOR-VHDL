library IEEE;
use IEEE.std_logic_1164.all;
use work.eecs361_gates.all;

entity slt_1bit is
  port (
    x, y   						: in  std_logic;
    z, overflow, carryout  : out std_logic
  );
end slt_1bit;

architecture structural of slt_1bit is

	signal temp1, result : std_logic;
	
	component sub is
		port(
				a, b, carryin				: in std_logic;
				z, overflow, carryout 	: out std_logic
			);
	end component sub;
	
	begin

		sub_map : sub port map (x, y, '0', result, overflow, carryout);
		
		z <= result;

end architecture structural;