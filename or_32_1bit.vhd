library IEEE;
use IEEE.std_logic_1164.all;
use work.eecs361_gates.all;
use work.eecs361.all;

entity or_32_1bit is
	port (
		x1, x2, x3, x4, x5, x6, x7, x8, x9, x10, x11, x12, x13, x14, x15, x16, x17, x18, x19, x20, x21, x22, x23, x24, x25, x26, x27, x28, x29, x30, x31, x32	: in std_logic;
		z	: out std_logic
	);
end entity or_32_1bit;

architecture structural of or_32_1bit is

	signal temp1, temp2, temp3, temp4, temp5, temp6, temp7, temp8, temp9, temp10, temp11, temp12, temp13, temp14, temp15, temp16	: std_logic;
	signal ttemp1, ttemp2, ttemp3, ttemp4, ttemp5, ttemp6, ttemp7, ttemp8															: std_logic;
	signal tttemp1, tttemp2, tttemp3, tttemp4																						: std_logic;
	signal ttttemp1, ttttemp2																										: std_logic;
	
	begin
	
	-- level 1
	lvl1_map1 : or_gate port map (x => x1, y => x2, z => temp1);
	lvl1_map2 : or_gate port map (x => x3, y => x4, z => temp2);
	lvl1_map3 : or_gate port map (x => x5, y => x6, z => temp3);
	lvl1_map4 : or_gate port map (x => x7, y => x8, z => temp4);
	lvl1_map5 : or_gate port map (x => x9, y => x10, z => temp5);
	lvl1_map6 : or_gate port map (x => x11, y => x12, z => temp6);
	lvl1_map7 : or_gate port map (x => x13, y => x14, z => temp7);
	lvl1_map8 : or_gate port map (x => x15, y => x16, z => temp8);
	lvl1_map9 : or_gate port map (x => x17, y => x18, z => temp9);
	lvl1_map10 : or_gate port map (x => x19, y => x20, z => temp10);
	lvl1_map11 : or_gate port map (x => x21, y => x22, z => temp11);
	lvl1_map12 : or_gate port map (x => x23, y => x24, z => temp12);
	lvl1_map13 : or_gate port map (x => x25, y => x26, z => temp13);
	lvl1_map14 : or_gate port map (x => x27, y => x28, z => temp14);
	lvl1_map15 : or_gate port map (x => x29, y => x30, z => temp15);
	lvl1_map16 : or_gate port map (x => x31, y => x32, z => temp16);
	
	-- level 2
	lvl2_map1 : or_gate port map (x => temp1, y => temp2, z => ttemp1);
	lvl2_map2 : or_gate port map (x => temp3, y => temp4, z => ttemp2);
	lvl2_map3 : or_gate port map (x => temp5, y => temp6, z => ttemp3);
	lvl2_map4 : or_gate port map (x => temp7, y => temp8, z => ttemp4);
	lvl2_map5 : or_gate port map (x => temp9, y => temp10, z => ttemp5);
	lvl2_map6 : or_gate port map (x => temp11, y => temp12, z => ttemp6);
	lvl2_map7 : or_gate port map (x => temp13, y => temp14, z => ttemp7);
	lvl2_map8 : or_gate port map (x => temp15, y => temp16, z => ttemp8);
	
	-- level 3
	lvl3_map1 : or_gate port map (x => ttemp1, y => ttemp2, z => tttemp1);
	lvl3_map2 : or_gate port map (x => ttemp3, y => ttemp4, z => tttemp2);
	lvl3_map3 : or_gate port map (x => ttemp5, y => ttemp6, z => tttemp3);
	lvl3_map4 : or_gate port map (x => ttemp7, y => ttemp8, z => tttemp4);
	
	-- level 4
	lvl4_map1 : or_gate port map (x => tttemp1, y => tttemp2, z => ttttemp1);
	lvl4_map2 : or_gate port map (x => tttemp3, y => tttemp4, z => ttttemp2);
	
	-- level 5
	lvl5_map1 : or_gate port map (x => ttttemp1, y => ttttemp2, z => z);
	
end architecture structural;