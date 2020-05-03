library IEEE;
use IEEE.std_logic_1164.all;
use work.eecs361_gates.all;
use work.eecs361.all;

entity sub32 is
	port(
			a, b 						: in std_logic_vector (31 downto 0);
			z 							: out std_logic_vector (31 downto 0);
			overflow, carryout 	: out std_logic
		);
end entity sub32;

architecture structural of sub32 is

	signal temp1 : std_logic_vector(31 downto 0);

	component add32 is
		port(
				a, b 						: in std_logic_vector (31 downto 0);
				carry_in 				: in std_logic;
				z 							: out std_logic_vector (31 downto 0);
				overflow, carry_out 	: out std_logic
			);
	end component add32;
	
	begin
		not32_map : not_gate_32 port map (b, temp1);
		add32_map : add32 port map(a, temp1, '1', z, overflow, carryout);
	
end architecture structural;
			