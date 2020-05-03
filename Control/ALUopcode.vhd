library IEEE;
use IEEE.std_logic_1164.all;
use work.eecs361_gates.all;
use work.eecs361.all;
use work.helper.all;

entity ALUopcode is
	port (
		alu_ctrl	: in std_logic_vector(1 downto 0);
		funct		: in std_logic_vector(5 downto 0);
		add_op, sub_op, and_op, or_op, slt_op, sll_op, branch_op, store_load_op	: out std_logic
	);
end entity ALUopcode;

architecture structural of ALUopcode is 
	
	signal add_temp, addu_temp, sub_temp, subu_temp, and_temp, or_temp, slt_temp, sltu_temp, sll_temp, branch_temp, store_load_temp	: std_logic_vector (7 downto 0);
	
	signal ALU_funct	: std_logic_vector(7 downto 0);
	
	signal addop_temp, adduop_temp	: std_logic;
	signal subop_temp, subuop_temp	: std_logic;
	signal sltop_temp, sltuop_temp	: std_logic;
	
	
	begin
		ALU_funct(7 downto 6) <= alu_ctrl(1 downto 0);
		ALU_funct(5 downto 0) <= funct(5 downto 0);
		
		-- alu_ctrl is "00", funct is "xxxxxx" then proceed with store/load
		-- alu_ctrl
		store_load6_map	: not_gate port map (x => ALU_funct(6), z => store_load_temp(6));
		store_load7_map	: not_gate port map (x => ALU_funct(7), z => store_load_temp(7));
		
		and_store_load	: and_gate port map (x => store_load_temp(6), y => store_load_temp(7), z => store_load_op);
		
		-- alu_ctrl is "01" then proceed with beq, bneq, or bgtz
		-- alu_ctrl
		branch_temp(6) 	<= ALU_funct(6);
		branch7_map		: not_gate port map (x => ALU_funct(7), z => branch_temp(7));
		
		and_branch		: and_gate port map (x => branch_temp(6), y => branch_temp(7), z => branch_op);
		
		-- R-type
		
		-- add
		-- alu_ctrl is "10", funct is "100000"
		-- funct
		add0_map	: not_gate port map (x => ALU_funct(0), z => add_temp(0));
		add1_map	: not_gate port map (x => ALU_funct(1), z => add_temp(1));
		add2_map	: not_gate port map (x => ALU_funct(2), z => add_temp(2));
		add3_map	: not_gate port map (x => ALU_funct(3), z => add_temp(3));
		add4_map	: not_gate port map (x => ALU_funct(4), z => add_temp(4));
		add_temp(5) <= ALU_funct(5);
		-- alu_ctrl
		add6_map	: not_gate port map (x => ALU_funct(6), z => add_temp(6));
		add_temp(7) <= ALU_funct(7);
		
		and_add	: and_8_to_1 port map (x => add_temp, z => addop_temp);


		-- addu
		-- alu_ctrl is "10", funct is "100001"
		-- funct
		addu_temp(0) <= ALU_funct(0);
		addu1_map	: not_gate port map (x => ALU_funct(1), z => addu_temp(1));
		addu2_map	: not_gate port map (x => ALU_funct(2), z => addu_temp(2));
		addu3_map	: not_gate port map (x => ALU_funct(3), z => addu_temp(3));
		addu4_map	: not_gate port map (x => ALU_funct(4), z => addu_temp(4));
		addu_temp(5) <= ALU_funct(5);
		-- alu_ctrl
		addu6_map	: not_gate port map (x => ALU_funct(6), z => addu_temp(6));
		addu_temp(7) <= ALU_funct(7);
		
		and_addu	: and_8_to_1 port map (x => addu_temp, z => adduop_temp);
		
		or_add		: or_gate port map (x => adduop_temp, y => addop_temp, z => add_op);
		
		
		-- sub
		-- alu_ctrl is "10", funct is "100010"
		-- funct
		sub0_map	: not_gate port map (x => ALU_funct(0), z => sub_temp(0));
		sub_temp(1) <= ALU_funct(1);
		sub2_map	: not_gate port map (x => ALU_funct(2), z => sub_temp(2));
		sub3_map	: not_gate port map (x => ALU_funct(3), z => sub_temp(3));
		sub4_map	: not_gate port map (x => ALU_funct(4), z => sub_temp(4));
		sub_temp(5) <= ALU_funct(5);
		-- alu_ctrl
		sub6_map	: not_gate port map (x => ALU_funct(6), z => sub_temp(6));
		sub_temp(7) <= ALU_funct(7);	

		and_sub	: and_8_to_1 port map (x => sub_temp, z => subop_temp);


		-- subu
		-- alu_ctrl is "10", funct is "100011"
		-- funct
		subu_temp(0) <= ALU_funct(0);
		subu_temp(1) <= ALU_funct(1);
		subu2_map	: not_gate port map (x => ALU_funct(2), z => subu_temp(2));
		subu3_map	: not_gate port map (x => ALU_funct(3), z => subu_temp(3));
		subu4_map	: not_gate port map (x => ALU_funct(4), z => subu_temp(4));
		subu_temp(5) <= ALU_funct(5);
		-- alu_ctrl
		subu6_map	: not_gate port map (x => ALU_funct(6), z => subu_temp(6));
		subu_temp(7) <= ALU_funct(7);

		and_subu	: and_8_to_1 port map (x => subu_temp, z => subuop_temp);
		
		or_sub		: or_gate port map (x => subuop_temp, y => subop_temp, z => sub_op);
		
		
		-- and
		-- alu_ctrl is "10", funct is "100100"
		-- funct 
		and0_map	: not_gate port map (x => ALU_funct(0), z => and_temp(0));
		and1_map	: not_gate port map (x => ALU_funct(1), z => and_temp(1));
		and_temp(2) <= ALU_funct(2);
		and4_map	: not_gate port map (x => ALU_funct(3), z => and_temp(3));
		and5_map	: not_gate port map (x => ALU_funct(4), z => and_temp(4));
		and_temp(5) <= ALU_funct(5);
		-- alu_ctrl
		and6_map	: not_gate port map (x => ALU_funct(6), z => and_temp(6));
		and_temp(7) <= ALU_funct(7);
		
		and_and	: and_8_to_1 port map (x => and_temp, z => and_op);
		
		
		-- or
		-- alu_ctrl is "10", funct is "100101"
		-- funct
		or_temp(0)	<= ALU_funct(0);
		or1_map		: not_gate port map (x => ALU_funct(1), z => or_temp(1));
		or_temp(2)	<= ALU_funct(2);
		or3_map		: not_gate port map (x => ALU_funct(3), z => or_temp(3));
		or4_map		: not_gate port map (x => ALU_funct(4), z => or_temp(4));
		or_temp(5)	<= ALU_funct(5);
		-- alu_ctrl
		or6_map		: not_gate port map (x => ALU_funct(6), z => or_temp(6));
		or_temp(7)	<= ALU_funct(7);
		
		and_or	: and_8_to_1 port map (x => or_temp, z => or_op);
		
		
		-- sll
		-- alu_ctrl is "10", funct is "000000"
		-- funct
		sll0_map	: not_gate port map (x => ALU_funct(0), z => sll_temp(0));
		sll1_map	: not_gate port map (x => ALU_funct(1), z => sll_temp(1));
		sll2_map	: not_gate port map (x => ALU_funct(2), z => sll_temp(2));
		sll3_map	: not_gate port map (x => ALU_funct(3), z => sll_temp(3));
		sll4_map	: not_gate port map (x => ALU_funct(4), z => sll_temp(4));
		sll5_map	: not_gate port map (x => ALU_funct(5), z => sll_temp(5));
		-- alu_ctrl
		sll6_map	: not_gate port map (x => ALU_funct(6), z => sll_temp(6));
		sll_temp(7)	<= ALU_funct(7);
		
		and_sll	: and_8_to_1 port map (x => sll_temp, z => sll_op);
		
		
		-- slt
		-- alu_ctrl is "10", funct is "101010"
		-- funct
		slt0_map	: not_gate port map (x => ALU_funct(0), z => slt_temp(0));
		slt_temp(1)	<= ALU_funct(1);
		slt2_map	: not_gate port map (x => ALU_funct(2), z => slt_temp(2));
		slt_temp(3)	<= ALU_funct(3);
		slt4_map	: not_gate port map (x => ALU_funct(4), z => slt_temp(4));
		slt_temp(5)	<= ALU_funct(5);
		-- alu_ctrl
		slt6_map	: not_gate port map (x => ALU_funct(6), z => slt_temp(6));
		slt_temp(7)	<= ALU_funct(7);
		
		and_slt	: and_8_to_1 port map (x => slt_temp, z => sltop_temp);
		
		-- sltu
		-- alu_ctrl is "10", funct is "101011"
		-- funct
		sltu_temp(0)<= ALU_funct(0);
		sltu_temp(1)<= ALU_funct(1);
		--sltu1_map	: not_gate port map (x => ALU_funct(1), z => sltu_temp(1));
		sltu2_map	: not_gate port map (x => ALU_funct(2), z => sltu_temp(2));
		sltu_temp(3)<= ALU_funct(3);
		sltu4_map	: not_gate port map (x => ALU_funct(4), z => sltu_temp(4));
		sltu_temp(5)<= ALU_funct(5);
		-- alu_ctrl
		sltu6_map	: not_gate port map (x => ALU_funct(6), z => sltu_temp(6));
		sltu_temp(7)<= ALU_funct(7);
		
		and_sltu	: and_8_to_1 port map (x => sltu_temp, z => sltuop_temp);
		
		or_slt		: or_gate port map (x => sltuop_temp, y => sltop_temp, z => slt_op);
		
end architecture structural;