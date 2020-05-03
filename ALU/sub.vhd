library IEEE;
use IEEE.std_logic_1164.all;
use work.eecs361_gates.all;
use work.eecs361.all;

entity sub is
	port(
			a, b, carryin				: in std_logic;
			z, overflow, carryout 	: out std_logic
		);
end entity sub;

architecture structural of sub is

	signal temp1 : std_logic;

	component add is
		port(
				a, b, carryin 				: in std_logic;
				z, overflow, carryout 	: out std_logic
			);
	end component add;

	begin
	
	not_map : not_gate port map (b, temp1);
	add_map : add port map(a, temp1, '1', z, overflow, carryout);
		
end architecture structural;
			