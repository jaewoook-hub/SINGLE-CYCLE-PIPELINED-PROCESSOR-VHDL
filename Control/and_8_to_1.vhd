library IEEE;
use IEEE.std_logic_1164.all;
use work.eecs361_gates.all;

entity and_8_to_1 is
	port ( 
		x	:  in  std_logic_vector(7 downto 0);
		z	:  out std_logic
	);
end and_8_to_1; 

architecture structural of and_8_to_1 is
		
	signal temp1 : std_logic_vector(3 downto 0);
	signal temp2, temp3 : std_logic;
	 
	begin

	and_gate_map0: and_gate port map(x => x(0), y => x(1), z => temp1(0));
	and_gate_map1: and_gate port map(x => x(2), y => x(3), z => temp1(1));
	and_gate_map2: and_gate port map(x => x(4), y => x(5), z => temp1(2));
	and_gate_map3: and_gate port map(x => x(6), y => x(7), z => temp1(3));
	and_gate_map4: and_gate port map(x => temp1(0), y => temp1(1), z => temp2);
	and_gate_map5: and_gate port map(x => temp1(2), y => temp1(3), z => temp3);
	and_gate_map6: and_gate port map(x => temp2, y => temp3, z => z);
		
end architecture structural;