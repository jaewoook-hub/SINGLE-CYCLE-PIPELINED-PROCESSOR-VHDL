library IEEE;
use IEEE.std_logic_1164.all;
use work.eecs361_gates.all;
use work.eecs361.all;

entity register_32we is
	port (
		we		 	: in std_logic;
		crtl     : in  std_logic_vector(4 downto 0);
		z        : out std_logic_vector(31 downto 0)
	);
end entity register_32we;

architecture structural of register_32we is

	signal 	r1, r2, r3, r4, r5, r6, r7, r8, r9, r10, r11, r12, r13, r14, r15, r16, r17, r18, r19, r20, r21, r22, r23, r24, r25, r26, r27, r28, r29, r30, r31, r32	: std_logic_vector(31 downto 0);

	signal	x1, x2, x3, x4, x5, x6, x7, x8, x9, x10, x11, x12, x13, x14, x15, x16	: std_logic_vector(31 downto 0);

	signal	y1, y2, y3, y4, z1, z2, z3, z4														: std_logic_vector(31 downto 0);

	signal 	a1, a2, b1, b2																				: std_logic_vector(31 downto 0);

	signal	c1, d1																						: std_logic_vector(31 downto 0);

	signal temp, we32 : std_logic_vector(31 downto 0);

begin

	r1  <= "00000000000000000000000000000001";
	r2  <= "00000000000000000000000000000010";
	r3  <= "00000000000000000000000000000100";
	r4  <= "00000000000000000000000000001000";
	r5  <= "00000000000000000000000000010000";
	r6  <= "00000000000000000000000000100000";
	r7  <= "00000000000000000000000001000000";
	r8  <= "00000000000000000000000010000000";
	r9  <= "00000000000000000000000100000000";
	r10 <= "00000000000000000000001000000000";
	r11 <= "00000000000000000000010000000000";
	r12 <= "00000000000000000000100000000000";
	r13 <= "00000000000000000001000000000000";
	r14 <= "00000000000000000010000000000000";
	r15 <= "00000000000000000100000000000000";
	r16 <= "00000000000000001000000000000000";
	r17 <= "00000000000000010000000000000000";
	r18 <= "00000000000000100000000000000000";
	r19 <= "00000000000001000000000000000000";
	r20 <= "00000000000010000000000000000000";
	r21 <= "00000000000100000000000000000000";
	r22 <= "00000000001000000000000000000000";
	r23 <= "00000000010000000000000000000000";
	r24 <= "00000000100000000000000000000000";
	r25 <= "00000001000000000000000000000000";
	r26 <= "00000010000000000000000000000000";
	r27 <= "00000100000000000000000000000000";
	r28 <= "00001000000000000000000000000000";
	r29 <= "00010000000000000000000000000000";
	r30 <= "00100000000000000000000000000000";
	r31 <= "01000000000000000000000000000000";
	r32 <= "10000000000000000000000000000000";

	-- level 1 muxes
	mux1_map	 : mux_32 port map (sel => crtl(0), src0 => r1, src1=> r17, z => x1); 
	mux2_map	 : mux_32 port map (sel => crtl(0), src0 => r2, src1=> r18, z => x2); 
	mux3_map	 : mux_32 port map (sel => crtl(0), src0 => r3, src1=> r19, z => x3); 
	mux4_map	 : mux_32 port map (sel => crtl(0), src0 => r4, src1=> r20, z => x4); 
	mux5_map	 : mux_32 port map (sel => crtl(0), src0 => r5, src1=> r21, z => x5); 
	mux6_map	 : mux_32 port map (sel => crtl(0), src0 => r6, src1=> r22, z => x6); 
	mux7_map	 : mux_32 port map (sel => crtl(0), src0 => r7, src1=> r23, z => x7); 
	mux8_map	 : mux_32 port map (sel => crtl(0), src0 => r8, src1=> r24, z => x8); 
	mux9_map	 : mux_32 port map (sel => crtl(0), src0 => r9, src1=> r25, z => x9); 
	mux10_map : mux_32 port map (sel => crtl(0), src0 => r10, src1=> r26, z => x10); 
	mux11_map : mux_32 port map (sel => crtl(0), src0 => r11, src1=> r27, z => x11); 
	mux12_map : mux_32 port map (sel => crtl(0), src0 => r12, src1=> r28, z => x12); 
	mux13_map : mux_32 port map (sel => crtl(0), src0 => r13, src1=> r29, z => x13); 
	mux14_map : mux_32 port map (sel => crtl(0), src0 => r14, src1=> r30, z => x14); 
	mux15_map : mux_32 port map (sel => crtl(0), src0 => r15, src1=> r31, z => x15); 
	mux16_map : mux_32 port map (sel => crtl(0), src0 => r16, src1=> r32, z => x16); 

	-- level 2 muxes
	mux2_1_map : mux_32 port map (sel => crtl(1), src0 => x1, src1=> x9, z => y1); 
	mux2_2_map : mux_32 port map (sel => crtl(1), src0 => x2, src1=> x10, z => y2); 
	mux2_3_map : mux_32 port map (sel => crtl(1), src0 => x3, src1=> x11, z => y3); 
	mux2_4_map : mux_32 port map (sel => crtl(1), src0 => x4, src1=> x12, z => y4); 
	mux2_5_map : mux_32 port map (sel => crtl(1), src0 => x5, src1=> x13, z => z1); 
	mux2_6_map : mux_32 port map (sel => crtl(1), src0 => x6, src1=> x14, z => z2); 
	mux2_7_map : mux_32 port map (sel => crtl(1), src0 => x7, src1=> x15, z => z3); 
	mux2_8_map : mux_32 port map (sel => crtl(1), src0 => x8, src1=> x16, z => z4); 

	-- level 3 muxes
	mux3_1_map : mux_32 port map (sel => crtl(2), src0 => y1, src1=> z1, z => a1); 
	mux3_2_map : mux_32 port map (sel => crtl(2), src0 => y2, src1=> z2, z => b1); 
	mux3_3_map : mux_32 port map (sel => crtl(2), src0 => y3, src1=> z3, z => a2); 
	mux3_4_map : mux_32 port map (sel => crtl(2), src0 => y4, src1=> z4, z => b2); 

	-- level 4 muxes
	mux4_1_map : mux_32 port map (sel => crtl(3), src0 => a1, src1=> b1, z => c1); 
	mux4_2_map : mux_32 port map (sel => crtl(3), src0 => a2, src1=> b2, z => d1);
	
  -- level 5 mux
  finalmux_map : mux_32 port map (sel => crtl(4), src0 => c1, src1=> d1, z => temp);

  -- when we is selected, mux 32bit 0s and 1s
  we_map : mux_32 port map (sel => we, src0 => "00000000000000000000000000000000", src1 => "11111111111111111111111111111111", z => we32);
  
  -- AND we32 with temp
  output_map : and_gate_32 port map (x => we32, y => temp, z => z);
    
end architecture structural;
