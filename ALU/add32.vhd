library IEEE;
use IEEE.std_logic_1164.all;
use work.eecs361_gates.all;
use work.eecs361.all;

entity add32 is
	port(
			a, b 						: in std_logic_vector (31 downto 0);
			carry_in 				: in std_logic;
			z 							: out std_logic_vector (31 downto 0);
			overflow, carry_out 	: out std_logic
		);
end entity add32;

architecture structural of add32 is

	signal cout, overf : std_logic_vector(31 downto 0);

	component add is
		port(
				a, b, carryin 			: in std_logic;
				z, overflow, carryout : out std_logic
			);
	end component add;
	
	begin
	
	addition : for i in 0 to 31 generate begin

		case_0 : if i = 0 generate begin
			adder_0 : add port map (a(0), b(0), carry_in, z(0), overf(0), cout(0));
		end generate;
		
		case_rest : if i > 0 generate begin
			adder_rest : add port map (a(i), b(i), cout(i - 1), z(i), overf(i), cout(i));
		end generate;
		
	end generate;

	carry_out <= cout(31);
	overflow <= overf(31);
	
end architecture structural;
			