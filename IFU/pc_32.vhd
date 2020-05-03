library ieee;
use ieee.std_logic_1164.all;
use work.eecs361_gates.all;
use work.eecs361.all;
-- Essentially a 30-bit rising edge flip-flop--
entity pc_32 is
  port (
	clk	: in  std_logic;
	pc_enable : in std_logic;
	d	: in  std_logic_vector(31 downto 0);
	q  	: out std_logic_vector(31 downto 0)
  );
end pc_32;

architecture structural of pc_32 is

component dffr_a is
  port (
	clk	   : in  std_logic;
    arst   : in  std_logic;
    aload  : in  std_logic;
    adata  : in  std_logic;
	d	   : in  std_logic;
    enable : in  std_logic;
	q	   : out std_logic
  );
end component;

begin
	
	generate_dffras : for i in 0 to 31 generate
		dffras : dffr_a port map(clk, '0', '0', '0', d(i), pc_enable, q(i));
	end generate;
	
end structural;
