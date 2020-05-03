library ieee;
use ieee.std_logic_1164.all;

entity adder_32 is
port (
		a, b : in std_logic_vector(31 downto 0);
		z : out std_logic_vector(31 downto 0)
		);
end adder_32;

architecture struct of adder_32 is 

component Full_Adder is
PORT (A,B,CIN: IN std_logic; COUT,SUM: OUT std_logic);
end component Full_Adder;

signal cout: std_logic_vector(31 downto 0);

begin

adders: for i in 0 to 31 generate begin

	lsb: if i = 0 generate begin	
		adders_lsb: Full_Adder port map(A=>a(i), B=>b(i), CIN=>'0', COUT=>cout(i), SUM=>z(i));
	end generate lsb;
	
	mid: if i > 0 and i < 31 generate begin	
		adders_mid: Full_Adder port map(A=>a(i), B=>b(i), CIN=>cout(i-1), COUT=>cout(i), SUM=>z(i));
	end generate mid;
	
	msb: if i = 31 generate begin	
		adders_msb: Full_Adder port map(A=>a(i), B=>b(i), CIN=>cout(i-1),SUM=>z(i));
	end generate msb;
	
end generate adders;

end architecture struct;
