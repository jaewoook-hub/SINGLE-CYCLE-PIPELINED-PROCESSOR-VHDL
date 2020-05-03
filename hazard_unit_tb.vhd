library IEEE;
use IEEE.std_logic_1164.all;
use work.eecs361_gates.all;
use work.eecs361.all;

entity hazard_unit_tb is
end entity hazard_unit_tb;

architecture behavioral of hazard_unit_tb is

	component hazard_unit is 
	port (
		--clk : in std_logic; 
		--lw 
		if_id_Rs, if_id_Rt, id_ex_Rt : in std_logic_vector(4 downto 0); 
		id_ex_MemRd : in std_logic;
  		--branch
		MEM_beq_flag, MEM_bneq_flag, MEM_bgtz_flag : in std_logic;
  	
		PC_write, IF_ID_write, IF_ID_zeros_flag, ID_EX_stall_flag, EX_MEM_stall_flag : out std_logic
  		--mux_select : out std_logic now called ID_EX_control_enable
  		
			);
	end component hazard_unit;


	signal id_ex_MemRd, MEM_beq_flag, MEM_bneq_flag, MEM_bgtz_flag, PC_write, IF_ID_write, IF_ID_zeros_flag, ID_EX_stall_flag, EX_MEM_stall_flag : std_logic;
	signal if_id_Rs, if_id_Rt, id_ex_Rt : std_logic_vector(4 downto 0);

begin

  	hazard_unit_map : hazard_unit port map(
		if_id_Rs => if_id_Rs, 
		if_id_Rt => if_id_Rt, 
		id_ex_Rt => id_ex_Rt, 
		id_ex_MemRd => id_ex_MemRd, 
		MEM_beq_flag => MEM_beq_flag, 
		MEM_bneq_flag => MEM_bneq_flag, 
		MEM_bgtz_flag => MEM_bgtz_flag, 
		PC_write => PC_write, 
		IF_ID_write => IF_ID_write, 
		IF_ID_zeros_flag => IF_ID_zeros_flag, 
		ID_EX_stall_flag => ID_EX_stall_flag, 
		EX_MEM_stall_flag => EX_MEM_stall_flag);
	
	hazard_test : process is 
	begin 
		--LW should be high, BR should be low
		if_id_Rs <= "01010";
		if_id_Rt <= "01010";
		id_ex_Rt <= "01010";
		id_ex_MemRd <= '1'; 
		MEM_beq_flag <= '0';
		MEM_bneq_flag <= '0';
		MEM_bgtz_flag <= '0';
		wait for 5 ns; 
		
		--LW should be high, BR should be low
		if_id_Rs <= "01010";
		if_id_Rt <= "11111";
		id_ex_Rt <= "01010";
		id_ex_MemRd <= '1'; 
		MEM_beq_flag <= '0';
		MEM_bneq_flag <= '0';
		MEM_bgtz_flag <= '0';
		wait for 5 ns;
		
		--LW should be high, BR should be low
		if_id_Rs <= "11111";
		if_id_Rt <= "01010";
		id_ex_Rt <= "01010";
		id_ex_MemRd <= '1'; 
		MEM_beq_flag <= '0';
		MEM_bneq_flag <= '0';
		MEM_bgtz_flag <= '0';
		wait for 5 ns;
		
		--LW should be low, BR should be high
		if_id_Rs <= "11111";
		if_id_Rt <= "11111";
		id_ex_Rt <= "01010";
		id_ex_MemRd <= '1'; 
		MEM_beq_flag <= '1';
		MEM_bneq_flag <= '0';
		MEM_bgtz_flag <= '0';
		wait for 5 ns;
		
		--LW should be low, BR should be high
		if_id_Rs <= "01010";
		if_id_Rt <= "01010";
		id_ex_Rt <= "01010";
		id_ex_MemRd <= '0'; 
		MEM_beq_flag <= '0';
		MEM_bneq_flag <= '1';
		MEM_bgtz_flag <= '0';
		wait for 5 ns;
		
		--LW should be low, BR should be high
		if_id_Rs <= "01010";
		if_id_Rt <= "01010";
		id_ex_Rt <= "01010";
		id_ex_MemRd <= '0'; 
		MEM_beq_flag <= '0';
		MEM_bneq_flag <= '0';
		MEM_bgtz_flag <= '1';
		wait for 5 ns;
		
		wait;
		
	end process;
end architecture;
