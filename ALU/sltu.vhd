library IEEE;
use IEEE.std_logic_1164.all;
use work.eecs361_gates.all;

entity sltu_1bit is
  port (
    x, y   						: in  std_logic;
    z, overflow, carryout	: out std_logic
  );
end sltu_1bit;

architecture structural of sltu_1bit is

	signal temp1, result : std_logic;
	
	component sub is
		port(
				a, b, carryin				: in std_logic;
				z, overflow, carryout 	: out std_logic
			);
	end component sub;
	
	begin
		sub_map : sub port map (x, y, '0', result, overflow, temp1);
		
		carryout <= temp1;
		
		not_map : not_gate port map (temp1, z);

end architecture structural;