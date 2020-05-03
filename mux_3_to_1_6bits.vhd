library IEEE;
use IEEE.std_logic_1164.all;
use work.eecs361_gates.all;
use work.eecs361.all;

entity mux_3_to_1_6bits is
	port (
		sel	: in std_logic_vector(1 downto 0);
		src00, src01, src10	: in std_logic_vector(5 downto 0);
		z	: out std_logic_vector(5 downto 0)
	);
end entity mux_3_to_1_6bits;

architecture structural of mux_3_to_1_6bits is

	signal temp	: std_logic_vector(5 downto 0);
	
	begin
	
		level_1_map : mux_n generic map(6) port map (sel => sel(0), src0 => src00, src1 => src01, z => temp);
		level_2_map : mux_n generic map(6) port map (sel => sel(1), src0 => temp, src1 => src10, z => z);
		
end architecture structural;
