library IEEE;
use IEEE.std_logic_1164.all;
use work.eecs361_gates.all;
use work.eecs361.all;

entity or_self is
	port (
		x   : in  std_logic_vector (31 downto 0);
		z   : out std_logic
	);
end or_self;

architecture structural of or_self is

	signal temp1, temp2, temp3, temp4, temp5, temp6, temp7, temp8, temp9, temp10, temp11, temp12, temp13, temp14, temp15, temp16, temp17, temp18, temp19, temp20, temp21, temp22, temp23, temp24, temp25, temp26, temp27, temp28, temp29, temp30 :std_logic;
	
	begin
		--lvl 1
		or_map1 	: or_gate port map(x(0), x(1), temp1);
		or_map2 	: or_gate port map(x(2), x(3), temp2);
		or_map3 	: or_gate port map(x(4), x(5), temp3); 
		or_map4 	: or_gate port map(x(6), x(7), temp4);
		or_map5 	: or_gate port map(x(8), x(9), temp5);
		or_map6 	: or_gate port map(x(10), x(11), temp6);
		or_map7 	: or_gate port map(x(12), x(13), temp7);
		or_map8 	: or_gate port map(x(14), x(15), temp8);
		
		-- lvl 2
		or_map9 	: or_gate port map(temp1, temp2, temp9);
		or_map10 : or_gate port map(temp3, temp4, temp10);
		or_map11 : or_gate port map(temp5, temp6, temp11);
		or_map12 : or_gate port map(temp7, temp8, temp12);
		or_map13 : or_gate port map(temp9, temp10, temp13);
		or_map14 : or_gate port map(temp11, temp12, temp14);
		
		--lvl 3
		or_map15 : or_gate port map(temp13, temp14, temp15);

		--lvl 1
		or_map16 : or_gate port map(x(16), x(17), temp16);
		or_map17 : or_gate port map(x(18), x(19), temp17);
		or_map18 : or_gate port map(x(20), x(21), temp18); 
		or_map19 : or_gate port map(x(22), x(23), temp19);
		or_map20 : or_gate port map(x(24), x(25), temp20);
		or_map21 : or_gate port map(x(26), x(27), temp21);
		or_map22 : or_gate port map(x(28), x(29), temp22);
		or_map23 : or_gate port map(x(30), x(31), temp23);
		
		--lvl 2
		or_map24 : or_gate port map(temp16, temp17, temp24);
		or_map25 : or_gate port map(temp18, temp19, temp25);
		or_map26 : or_gate port map(temp20, temp21, temp26);
		or_map27 : or_gate port map(temp22, temp23, temp27);
		or_map28 : or_gate port map(temp24, temp25, temp28);
		or_map29 : or_gate port map(temp26, temp27, temp29);
		
		--lvl 3
		or_map30 : or_gate port map(temp28, temp29, temp30);

		--lvl 4
		or_finalmap : or_gate port map(temp15, temp30, z);

end structural;
