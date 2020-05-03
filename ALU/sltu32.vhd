library IEEE;
use IEEE.std_logic_1164.all;
use work.eecs361_gates.all;
use work.eecs361.all;

entity sltu32 is
  port (
    x, y   	: in  std_logic_vector(31 downto 0);
    z   		: out std_logic_vector(31 downto 0);
	 overflow, carryout : out std_logic
  );
end sltu32;

architecture structural of sltu32 is
	
	component sub32 is
		port(
				a, b 						: in std_logic_vector (31 downto 0);
				z 							: out std_logic_vector (31 downto 0);
				overflow, carryout 	: out std_logic
			);
	end component sub32;
	
	signal diff  : std_logic_vector( 31 downto 0);
	signal temp1 : std_logic_vector( 31 downto 0) := (others => '0');
	signal temp2 : std_logic;

	begin
	
		sub32_map : sub32 port map (x, y, diff, overflow, temp2);
		not32_map : not_gate port map (temp2, temp1(0));
		
		z 			<= temp1;
		carryout <= temp2;

end architecture structural;