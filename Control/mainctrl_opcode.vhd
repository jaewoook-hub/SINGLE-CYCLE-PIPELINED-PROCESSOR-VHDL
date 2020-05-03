library IEEE;
use IEEE.std_logic_1164.all;
use work.eecs361_gates.all;
use work.eecs361.all;
use work.helper.all;

entity mainctrl_opcode is
	port (
		opcode	: in std_logic_vector(5 downto 0);
		r_op, addi_op, beq_op, bneq_op, bgtz_op, lw_op, sw_op		: out std_logic
	);
end entity mainctrl_opcode;

architecture structural of mainctrl_opcode is
	
	signal r_temp, addi_temp, beq_temp, bneq_temp, bgtz_temp, lw_temp, sw_temp	: std_logic_vector(5 downto 0);
	
	begin
	
	-- R-type	"000000"
	r0_map	: not_gate port map (x => opcode(0), z => r_temp(0));
	r1_map	: not_gate port map (x => opcode(1), z => r_temp(1));
	r2_map	: not_gate port map (x => opcode(2), z => r_temp(2));
	r3_map	: not_gate port map (x => opcode(3), z => r_temp(3));
	r4_map	: not_gate port map (x => opcode(4), z => r_temp(4));
	r5_map	: not_gate port map (x => opcode(5), z => r_temp(5));
	
	and_r	: and_6_to_1 port map (x => r_temp, z => r_op);
	

	-- Addi		"001000"
	addi0_map	: not_gate port map (x => opcode(0), z => addi_temp(0));
	addi1_map	: not_gate port map (x => opcode(1), z => addi_temp(1));
	addi2_map	: not_gate port map (x => opcode(2), z => addi_temp(2));
	addi_temp(3)<= opcode(3);
	addi4_map	: not_gate port map (x => opcode(4), z => addi_temp(4));
	addi5_map	: not_gate port map (x => opcode(5), z => addi_temp(5));
	
	and_addi	: and_6_to_1 port map (x => addi_temp, z => addi_op);
	
	
	-- Beq		"000100"
	beq0_map	: not_gate port map (x => opcode(0), z => beq_temp(0));
	beq1_map	: not_gate port map (x => opcode(1), z => beq_temp(1));
	beq_temp(2) <= opcode(2);
	beq3_map	: not_gate port map (x => opcode(3), z => beq_temp(3));
	beq4_map	: not_gate port map (x => opcode(4), z => beq_temp(4));
	beq5_map	: not_gate port map (x => opcode(5), z => beq_temp(5));
	
	and_beq		: and_6_to_1 port map (x => beq_temp, z => beq_op);
	
	
	-- Bneq		"000101"
	bneq_temp(0)<= opcode(0);
	bneq1_map	: not_gate port map (x => opcode(1), z => bneq_temp(1));
	bneq_temp(2)<= opcode(2);
	bneq3_map	: not_gate port map (x => opcode(3), z => bneq_temp(3));
	bneq4_map	: not_gate port map (x => opcode(4), z => bneq_temp(4));
	bneq5_map	: not_gate port map (x => opcode(5), z => bneq_temp(5));
	
	and_bneq	: and_6_to_1 port map (x => bneq_temp, z => bneq_op);
	
	
	-- Bgtz		"000111"
	bgtz_temp(0)	<= opcode(0);
	bgtz_temp(1) 	<= opcode(1);
	bgtz_temp(2) 	<= opcode(2);
	bgtz3_map		: not_gate port map (x => opcode(3), z => bgtz_temp(3));
	bgtz4_map		: not_gate port map (x => opcode(4), z => bgtz_temp(4));
	bgtz5_map		: not_gate port map (x => opcode(5), z => bgtz_temp(5));
	
	and_bgz	: and_6_to_1 port map (x => bgtz_temp, z => bgtz_op);
	
	
	-- Lw		"100011"
	lw_temp(0)	<= opcode(0);
	lw_temp(1)	<= opcode(1);
	lw2_map	: not_gate port map (x => opcode(2), z => lw_temp(2));
	lw3_map	: not_gate port map (x => opcode(3), z => lw_temp(3));
	lw4_map	: not_gate port map (x => opcode(4), z => lw_temp(4));
	lw_temp(5) <= opcode(5);
	
	and_lw	: and_6_to_1 port map (x => lw_temp, z => lw_op);
	
	
	-- Sw		"101011"
	sw_temp(0)	<= opcode(0);
	sw_temp(1)	<= opcode(1);
	sw2_map	: not_gate port map (x => opcode(2), z => sw_temp(2));
	sw_temp(3) <= opcode(3);
	sw4_map	: not_gate port map (x => opcode(4), z => sw_temp(4));
	sw_temp(5) <= opcode(5);
	
	and_sw	: and_6_to_1 port map (x => sw_temp, z => sw_op);	

end architecture structural;	