library IEEE;
use IEEE.std_logic_1164.all;
use work.eecs361_gates.all;
use work.eecs361.all;

entity alu_1bit is
	port(
			A 			: in std_logic;
			B 			: in std_logic;
			sel 		: in std_logic_vector (5 downto 0);
			result 	: out std_logic;
			cout, overflow, zero : out std_logic
		);
end entity alu_1bit;

architecture structural of alu_1bit is

	-- Components
	component add is
		port(
				a, b, carryin 			: in std_logic;
				z, overflow, carryout : out std_logic
			);
	end component add;

	component sub is
		port(
				a, b, carryin				: in std_logic;
				z, overflow, carryout 	: out std_logic
			);
	end component sub;

	component slt_1bit is
		port (
				x, y   						: in  std_logic;
				z, overflow, carryout  : out std_logic
			);
	end component slt_1bit;
		
	component sltu_1bit is
			port (
				x, y   						: in  std_logic;
				z, overflow, carryout	: out std_logic
			);
	end component sltu_1bit;
	
	component mux_8_to_1 is
			port (
				sel   : in  std_logic_vector (5 downto 0);
				src0, src1, src2, src3, src4, src5, src6, src7  : in  std_logic;
				z	   : out std_logic
			);
	end component mux_8_to_1;
	
	-- Signals
	signal add1, sub1, and1, xor1, or1, slt1, sltu1 : std_logic;
	signal add_of, sub_of, slt_of, sltu_of : std_logic;
	signal add_cout, sub_cout, slt_cout, sltu_cout : std_logic;
	signal output : std_logic;

	begin
	
		add_map : add port map(A, B, '0', add1, add_of, add_cout);
		sub_map : sub port map(A, B, '0', sub1, sub_of, sub_cout);
		and_map : and_gate port map(A, B, and1);
		xor_map	: xor_gate port map(A, B, xor1);
		or_map 	: or_gate port map(A, B, or1);
		slt_map : slt_1bit port map(A, B, slt1, slt_of, slt_cout);
		sltu_map : sltu_1bit port map(A, B, sltu1, sltu_of, sltu_cout);
		
		overflow_map: mux_8_to_1 port map(sel, sub_of, '0', slt_of, sltu_of, '0', '0', add_of, '0', overflow);
		
		carryout_map : mux_8_to_1 port map(sel, sub_cout, '0', slt_cout, sltu_cout, '0', '0', add_cout, '0', cout);

		zero_map : not_gate port map (output, zero);
		
		result_map 	: mux_8_to_1 port map(sel, sub1, xor1, slt1, sltu1, and1, or1, add1, '0', output);
		result 		<= output;
		
end architecture structural;