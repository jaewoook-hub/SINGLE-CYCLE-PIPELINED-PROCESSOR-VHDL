library IEEE;
use IEEE.std_logic_1164.all;
use work.eecs361_gates.all;
use work.eecs361.all;

entity and3_gate is
	port(
		x1, x2, x3 	: in std_logic;
		z 			: out std_logic
	);
end entity and3_gate;

architecture structural of and3_gate is

	signal temp : std_logic;
	
	begin
		
	and_gate_map0: and_gate port map(x => x1, y => x2, z => temp);
	and_gate_map1: and_gate port map(x => temp, y => x3, z => z);

end architecture structural;
