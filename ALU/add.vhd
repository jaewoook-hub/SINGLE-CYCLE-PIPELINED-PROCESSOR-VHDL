library IEEE;
use IEEE.std_logic_1164.all;
use work.eecs361_gates.all;
use work.eecs361.all;

entity add is
	port(
			a, b, carryin 				: in std_logic;
			z, overflow, carryout 	: out std_logic
		);
end entity add;

architecture structural of add is

	signal temp1, temp2, temp3, temp4 : std_logic;
	
	begin
		xor_map 	: xor_gate port map (x => a, y => b, z => temp1);
		xor_map2 : xor_gate port map (x => temp1, y => carryin, z => z);
		and_map 	: and_gate port map (x => temp1, y => carryin, z => temp2);
		and_map2 : and_gate port map (x => a, y => b, z => temp3);
		or_map  	: or_gate port map (x => temp2, y => temp3, z => temp4);
		
		xor_map3 : xor_gate port map (carryin, temp4, overflow);
		
		carryout <= temp4;
		
end architecture structural;
			
