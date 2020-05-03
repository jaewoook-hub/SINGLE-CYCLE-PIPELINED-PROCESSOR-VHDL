library IEEE;
use IEEE.std_logic_1164.all;
use work.eecs361_gates.all;
use work.eecs361.all;

entity compare_5 is
  port (
    x   : in std_logic_vector (4 downto 0);
	  y	: in std_logic_vector (4 downto 0);
    z   : out std_logic
  );
end compare_5;

architecture structural of compare_5 is

  component xor_gate is
    port (
        x   : in  std_logic;
        y   : in  std_logic;
        z   : out std_logic
    );
  end component; 

  component zero_detect_6 is
	port(
		x : in std_logic_vector(5 downto 0);
		z : out std_logic
	);
  end component;

signal x_temp : std_logic_vector(5 downto 0);
signal y_temp : std_logic_vector(5 downto 0); 
signal result_temp : std_logic_vector(5 downto 0);

begin
	x_temp <= "0" & x;
	y_temp <= "0" & y;
  -- if any of bits is 1 then it is not equal -- 
	gen_compare : for i in 0 to 5 generate
      begin
        xor_gates : xor_gate port map(x_temp(i), y_temp(i), result_temp(i));
      end generate;
    
    zero_detect : zero_detect_6 port map(result_temp, z);
	
end structural;

  
