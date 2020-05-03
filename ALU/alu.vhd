library IEEE;
use IEEE.std_logic_1164.all;
use work.eecs361_gates.all;
use work.eecs361.all;

entity alu is
	port(
			A 			: in std_logic_vector(31 downto 0);
			B 			: in std_logic_vector(31 downto 0);
			sel 		: in std_logic_vector(5 downto 0);
			result 	: out std_logic_vector(31 downto 0);
			cout, overflow, zero : out std_logic
		);
end entity alu;

architecture structural of alu is

	-- Components
	component add32 is
		port(
			a, b 						: in std_logic_vector (31 downto 0);
			carry_in 				: in std_logic;
			z 							: out std_logic_vector (31 downto 0);
			overflow, carry_out 	: out std_logic
		);
	end component add32;

	component sub32 is
		port(
			a, b 						: in std_logic_vector (31 downto 0);
			z 							: out std_logic_vector (31 downto 0);
			overflow, carryout 	: out std_logic
		);
	end component sub32;

	component sll32 is
		port (
			x, y   	: in  std_logic_vector(31 downto 0);
			z   		: out std_logic_vector(31 downto 0)
		);
	end component sll32;


	component slt32 is
		port (
			x, y   	: in  std_logic_vector(31 downto 0);
			z   		: out std_logic_vector(31 downto 0);
			overflow, carryout : out std_logic
		);
	end component slt32;

	component sltu32 is
		port (
			x, y   	: in  std_logic_vector(31 downto 0);
			z   		: out std_logic_vector(31 downto 0);
			overflow, carryout : out std_logic
		);
	end component sltu32;
	
	component or_self is
		port (
			x   : in  std_logic_vector (31 downto 0);
			z   : out std_logic
		);
	end component or_self;
	
	component mux_8_to_1 is
		port (
			sel   : in  std_logic_vector (5 downto 0);
			src0, src1, src2, src3, src4, src5, src6, src7 : in std_logic;
			z	   : out std_logic
		);
	end component mux_8_to_1;

	component mux_32_to_1 is
		port (
			sel   : in  std_logic_vector (5 downto 0);
			src0, src1, src2, src3, src4, src5, src6, src7 : in std_logic_vector(31 downto 0);
			z	   : out std_logic_vector(31 downto 0)
		);
	end component mux_32_to_1;
	
	-- Signals
	signal add_32, sub_32, and_32, xor_32, or_32, sll_32, slt_32, sltu_32, output: std_logic_vector(31 downto 0);
	signal add_of, sub_of, slt_of, sltu_of	: std_logic;
	signal add_cout, sub_cout, slt_cout, sltu_cout, temp1 : std_logic;
	
	begin
		add32_map : add32 port map(A, B, '0', add_32, add_of, add_cout);
		sub32_map : sub32 port map(A, B, sub_32, sub_of, sub_cout);
		and32_map : and_gate_32 port map(A, B, and_32);
		xor32_map : xor_gate_32 port map(A, B, xor_32);
		or32_map  : or_gate_32 port map(A, B, or_32);
		sll32_map : sll32 port map(A, B, sll_32);
		slt32_map : slt32 port map(A, B, slt_32, slt_of, slt_cout);
		sltu32_map: sltu32 port map(A, B, sltu_32, sltu_of, sltu_cout);
		
		result_map32 	: mux_32_to_1 port map(sel, sub_32, xor_32, slt_32, sltu_32, and_32, or_32, add_32, sll_32, output);
		result 			<= output;
		
		overflow_map32 : mux_8_to_1 port map(sel, sub_of, '0', slt_of, sltu_of, '0', '0', add_of, '0', overflow);									
		
		carryout_mux32 : mux_8_to_1 port map(sel, sub_cout, '0', slt_cout, sltu_cout, '0', '0', add_cout, '0', cout);
		
		or_mux32  : or_self port map(output, temp1);
		not_mux32 : not_gate port map (temp1, zero);
	
end architecture structural;