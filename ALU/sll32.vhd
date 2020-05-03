library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use work.eecs361_gates.all;
use work.eecs361.all;

entity sll32 is
	port (
		x, y   	: in  std_logic_vector(31 downto 0);
		z   		: out std_logic_vector(31 downto 0)
	);
end entity sll32;

architecture structural of sll32 is

	signal s1: std_logic_vector(31 downto 0);
	signal s2: std_logic_vector(31 downto 0);
	signal s3: std_logic_vector(31 downto 0);
	signal s4: std_logic_vector(31 downto 0);
	signal s5: std_logic_vector(31 downto 0);
	signal s6: std_logic_vector(31 downto 0);
	signal s7: std_logic_vector(31 downto 0);
	signal s8: std_logic_vector(31 downto 0);
	signal s9: std_logic_vector(31 downto 0);
  
begin
    
    s1(31 downto 1) <= x(30 downto 0);
    s1(0) <= '0';
    mux_map1: mux_32 port map(y(0), x, s1, s2);
    
    s3(31 downto 2) <= s2(29 downto 0);
    s3(1 downto 0) <= "00";
    mux_map2: mux_32 port map(y(1), s2, s3, s4);
    
    s5(31 downto 4) <= s4(27 downto 0);
    s5(3 downto 0) <= "0000";
    mux_map3: mux_32 port map(y(2), s4, s5, s6);
    
    s7(31 downto 8) <= s6(23 downto 0);
    s7(7 downto 0) <= "00000000";
    mux_map4: mux_32 port map(y(3), s6, s7, s8);
    
    s9(31 downto 16) <= s8(15 downto 0);
    s9(15 downto 0) <= "0000000000000000";
    mux_map5: mux_32 port map(y(4), s8, s9, z);

end architecture structural;