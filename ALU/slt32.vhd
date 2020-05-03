library IEEE;
use IEEE.std_logic_1164.all;
use work.eecs361_gates.all;
use work.eecs361.all;

entity slt32 is
  port (
    x, y   	: in  std_logic_vector(31 downto 0);
    z   		: out std_logic_vector(31 downto 0);
	 overflow, carryout : out std_logic
  );
end slt32;

architecture structural of slt32 is

	signal diff : std_logic_vector( 31 downto 0);
	signal temp1 : std_logic_vector( 31 downto 0) := (others => '0');
	
	component sub32 is
		port(
				a, b 						: in std_logic_vector (31 downto 0);
				z 							: out std_logic_vector (31 downto 0);
				overflow, carryout 	: out std_logic
			);
	end component sub32;
	
	begin
	
		sub32_map : sub32 port map (x, y, diff, overflow, carryout);
		
		temp1(0) <= diff(31);
		z <= temp1;

end architecture structural;