library IEEE;
use IEEE.std_logic_1164.all;
use work.eecs361_gates.all;
use work.eecs361.all;

entity mux_8_to_1 is
	port (
		sel   : in  std_logic_vector (5 downto 0);
		src0, src1, src2, src3, src4, src5, src6, src7  : in  std_logic;
		z	   : out std_logic
	);
end entity mux_8_to_1;

architecture structural of mux_8_to_1 is

	signal temp1, temp2, temp3, temp4, temp5, temp6 : std_logic;

	begin
	
		mux1_map : mux port map(sel(2), src0, src1, temp1);
		mux2_map : mux port map(sel(0), src2, src3, temp2);
		mux3_map : mux port map(sel(0), src4, src5, temp3);
		mux4_map : mux port map(sel(5), src7, src6, temp4);
		mux5_map : mux port map(sel(3), temp1, temp2, temp5);
		mux6_map : mux port map(sel(2), temp4, temp3, temp6);
		mux7_map : mux port map(sel(1), temp6, temp5, z);
		
end structural;

