library ieee;
use ieee.std_logic_1164.all;

entity dffr_a_32bit is
  port (
	clk	   : in  std_logic;
    	arst   : in  std_logic;
   	 aload  : in  std_logic;
   	 adata  : in  std_logic_vector(31 downto 0);
	d	   : in  std_logic_vector(31 downto 0);
   	 enable : in  std_logic;
	q	   : out std_logic_vector(31 downto 0)
  );
end dffr_a_32bit;

architecture behavioral of dffr_a_32bit is

begin
  proc : process (clk, arst, aload)
  begin
    if arst = '1' then
      q <= "00000000000000000000000000000000";
    elsif aload = '1' then
      q <= adata;
    elsif rising_edge(clk) then
      if enable = '1' then
	    q <= d;
      end if;
	end if;
  end process;
end behavioral;
