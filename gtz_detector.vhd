library IEEE;
use IEEE.std_logic_1164.all;
use work.eecs361_gates.all;
use work.eecs361.all;

entity gtz_detector is
	port(
		x	: in std_logic_vector(31 downto 0);
		z	: out std_logic
	);
end entity gtz_detector;

architecture structural of gtz_detector is

	component or_32_1bit is
		port (
			x1, x2, x3, x4, x5, x6, x7, x8, x9, x10, x11, x12, x13, x14, x15, x16, x17, x18, x19, x20, x21, x22, x23, x24, x25, x26, x27, x28, x29, x30, x31, x32	: in std_logic;
			z	: out std_logic
		);
	end component or_32_1bit;
	
	signal not_val : std_logic;
	signal or_32temp : std_logic;
	
	begin
	
		level_1 : or_32_1bit port map (
			x1 => x(0),
			x2 => x(1),
			x3 => x(2),
			x4 => x(3),
			x5 => x(4),
			x6 => x(5),
			x7 => x(6),
			x8 => x(7),
			x9 => x(8),
			x10 => x(9),
			x11 => x(10),
			x12 => x(11),
			x13 => x(12),
			x14 => x(13),
			x15 => x(14),
			x16 => x(15),
			x17 => x(16),
			x18 => x(17),
			x19 => x(18),
			x20 => x(19),
			x21 => x(20),
			x22 => x(21),
			x23 => x(22),
			x24 => x(23),
			x25 => x(24),
			x26 => x(25),
			x27 => x(26),
			x28 => x(27),
			x29 => x(28),
			x30 => x(29),
			x31 => x(30),
			x32 => '0',
			z	=> or_32temp
		);
		
		invert	: not_gate port map (x => x(31), z => not_val);
		level_2 : and_gate port map (x => or_32temp, y => not_val, z => z);
	
end architecture structural;