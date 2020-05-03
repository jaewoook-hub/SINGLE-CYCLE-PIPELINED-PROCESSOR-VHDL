library ieee;
use ieee.std_logic_1164.all;
use work.eecs361_gates.all;
use work.eecs361.all;

entity or3_gate is
	port(
		a : in std_logic;
		b : in std_logic;
		c : in std_logic;
		or3_out : out std_logic
	);
end entity or3_gate;

architecture structural of or3_gate is

	signal temp : std_logic;
	
begin

	or1 : or_gate port map(a, b, temp);
	or2 : or_gate port map(temp, c, or3_out);
	
end architecture structural;
	