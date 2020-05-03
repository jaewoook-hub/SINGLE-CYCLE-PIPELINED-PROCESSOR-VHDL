library IEEE;
use IEEE.std_logic_1164.all;
use work.eecs361_gates.all;
use work.eecs361.all;

entity register_32bit is
  port (
    arst, clk, enable   : in  std_logic;
    d, aload       		: in  std_logic_vector(31 downto 0);
	 q       				: out  std_logic_vector(31 downto 0)
  );
end entity register_32bit;

architecture structural of register_32bit is

begin

  G0 : for i in 0 to 31 generate
      dffr_map : dffr_a port map
        (arst => arst, clk => clk, enable => enable, d => d(i), aload  => aload(i), adata => d(i), q => q(i));
   end generate G0;
  
end architecture structural;
