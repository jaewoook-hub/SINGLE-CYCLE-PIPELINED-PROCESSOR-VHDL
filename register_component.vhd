library IEEE;
use IEEE.std_logic_1164.all;
use work.eecs361_gates.all;
use work.eecs361.all;

entity register_component is
	port (
		clk, rst, we      : in std_logic;
		busw    				: in  std_logic_vector(31 downto 0);
		rw, ra, rb      	: in  std_logic_vector(4 downto 0);
		busa, busb    		: out std_logic_vector(31 downto 0)
	);
end entity register_component;

architecture structural of register_component is
  
	-- components 
	
	component register_32bit is
	  port (
		 arst, clk, enable   : in  std_logic;
		 d, aload       		: in  std_logic_vector(31 downto 0);
		 q       				: out  std_logic_vector(31 downto 0)
	  );
	end component register_32bit;

	component input32_mux is
		port (
			r1, r2, r3, r4, r5, r6, r7, r8, r9, r10, r11, r12, r13, r14, r15, r16, r17, r18, r19, r20, r21, r22, r23, r24, r25, r26, r27, r28, r29, r30, r31, r32	: std_logic_vector(31 downto 0);
			crtl     : in  std_logic_vector(4 downto 0);
			z        : out std_logic_vector(31 downto 0)
		);
	end component input32_mux;

	component register_32we is
		port (
			we		 	: in std_logic;
			crtl     : in  std_logic_vector(4 downto 0);
			z        : out std_logic_vector(31 downto 0)
		);
	end component register_32we;
	
	-- signals and types

	subtype register_32 is std_logic_vector(31 downto 0);
	type register_array is array (1 to 32) of register_32;
	
	signal register_d, register_q : register_array;
	signal write32 : std_logic_vector(31 downto 0);
	
	begin

	write32_map : register_32we port map (we => we, crtl => rw, z => write32); 

	register1_map : register_32bit port map (arst => '1', clk => clk, enable => '0', d => register_d(1), aload => "00000000000000000000000000000000", q => register_q(1));

	R0 : for i in 2 to 32 generate
		register_i_map : register_32bit port map (
			arst => rst, clk => clk, enable => write32(i - 1), d => register_d(i), aload => "00000000000000000000000000000000", q => register_q(i)
		);
		register_d(i) <= busw;	
	end generate R0;

	register_a_mux_map : input32_mux port map (r1 => register_q(1), r2 => register_q(2), r3 => register_q(3), r4 => register_q(4), r5 => register_q(5), r6 => register_q(6), r7 => register_q(7), r8 => register_q(8), r9 => register_q(9), r10 => register_q(10), r11 => register_q(11), r12 => register_q(12), r13 => register_q(13), r14 => register_q(14), r15 => register_q(15), r16 => register_q(16), r17 => register_q(17), r18 => register_q(18), r19 => register_q(19), r20 => register_q(20), r21 => register_q(21), r22 => register_q(22), r23 => register_q(23), r24 => register_q(24), r25 => register_q(25), r26 => register_q(26), r27 => register_q(27), r28 => register_q(28), r29 => register_q(29), r30 => register_q(30), r31 => register_q(31), r32 => register_q(32), crtl => ra, z => busa); 
	register_b_mux_map : input32_mux port map (r1 => register_q(1), r2 => register_q(2), r3 => register_q(3), r4 => register_q(4), r5 => register_q(5), r6 => register_q(6), r7 => register_q(7), r8 => register_q(8), r9 => register_q(9), r10 => register_q(10), r11 => register_q(11), r12 => register_q(12), r13 => register_q(13), r14 => register_q(14), r15 => register_q(15), r16 => register_q(16), r17 => register_q(17), r18 => register_q(18), r19 => register_q(19), r20 => register_q(20), r21 => register_q(21), r22 => register_q(22), r23 => register_q(23), r24 => register_q(24), r25 => register_q(25), r26 => register_q(26), r27 => register_q(27), r28 => register_q(28), r29 => register_q(29), r30 => register_q(30), r31 => register_q(31), r32 => register_q(32), crtl => rb, z => busb); 

end architecture structural;
