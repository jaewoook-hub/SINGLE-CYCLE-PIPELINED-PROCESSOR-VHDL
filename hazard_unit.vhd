library IEEE;
use IEEE.std_logic_1164.all;
use work.eecs361_gates.all;
use work.eecs361.all;
use work.pipeline_reg_package.all;

entity hazard_unit is 
port (
		--clk : in std_logic; 
		--lw 
		if_id_Rs, if_id_Rt, id_ex_Rt : in std_logic_vector(4 downto 0); 
		id_ex_MemRd : in std_logic;
  		--branch
		-- MEM_beq_flag, MEM_bneq_flag, MEM_bgtz_flag : in std_logic;
		br_flag : in std_logic;
		PC_write, IF_ID_write, ID_EX_write, IF_ID_zeros_flag, ID_EX_stall_flag, EX_MEM_stall_flag : out std_logic
  		--mux_select : out std_logic now called ID_EX_control_enable
  		
		);
end hazard_unit;
  
architecture struct of hazard_unit is 

  component and_1bit is
    port (
        x : in std_logic;
        y : in std_logic;
        z : out std_logic
    );
  end component;

  component or_1bit is
    port (
        x : in std_logic;
        y : in std_logic;
        z : out std_logic
    );
  end component;

  component not_gate is
    port (
        x   : in  std_logic;
        z   : out std_logic
    );
  end component;
  
  component compare_5 is
    port (
        x   : in std_logic_vector (4 downto 0);
        y	: in std_logic_vector (4 downto 0);
        z   : out std_logic
    );
  end component;

  component or3_gate is
      port(
          a : in std_logic;
          b : in std_logic;
          c : in std_logic;
          or3_out : out std_logic
      );
  end component or3_gate;
  
  component mux_3_to_1_6bits is
      port (
          sel	: in std_logic_vector(1 downto 0);
          src00, src01, src10	: in std_logic_vector(5 downto 0);
          z	: out std_logic_vector(5 downto 0)
      );
  end component mux_3_to_1_6bits;

--PC Write : 1 to enable write, 0 to disable write i.e. stall
--IF/ID Write : 1 to enable write, 0 to disable write i.e. stall
--ID/EX Write** : 1 to enable write, 0 to disable write i.e. stall
--IF/ID Empty : 1 to enable 0's to instr, 0 to continue normally
--ID/EX Ctrl : 1 to squash instr, 0 to retain instr
--EX/MEM Ctrl : 1 to squash instr, 0 to retain instr

-- constant lw_control_const : std_logic_vector(5 downto 0) := "00010"; --old
-- constant br_control_const : std_logic_vector(5 downto 0) := "11111"; --old
-- constant else_control_const : std_logic_vector(5 downto 0) := "11000"; --old

constant lw_control_const : std_logic_vector(5 downto 0) := "001010"; 
constant br_control_const : std_logic_vector(5 downto 0) := "111111"; 
constant else_control_const : std_logic_vector(5 downto 0) := "111000"; -- Continue instructions normally

-- 6 bits for zero detect --   
signal if_id_Rs_temp, if_id_Rt_temp, id_ex_Rt_temp : std_logic_vector(4 downto 0);
signal same1, same2, result : std_logic;
signal mux_sel_3to1 : std_logic_vector(1 downto 0);

signal control_output : std_logic_vector(5 downto 0);
begin

--LW detect
  	if_id_Rs_temp <= if_id_Rs;
    if_id_Rt_temp <= if_id_Rt;
    id_ex_Rt_temp <= id_ex_Rt;
	compare_5_map1 : compare_5 port map(id_ex_Rt_temp, if_id_Rs_temp, same1);
	compare_5_map2 : compare_5 port map(id_ex_Rt_temp, if_id_Rt_temp, same2);
    or_resuts : or_gate port map(same1, same2, result);
    and_results : and_gate port map(result, id_ex_MemRd, mux_sel_3to1(0));
--BR detect   
	-- or3_branch : or3_gate port map (a => MEM_beq_flag, b =>MEM_bneq_flag, c =>MEM_bgtz_flag, or3_out => mux_sel_3to1(1));
	mux_sel_3to1(1) <= br_flag;
-- choosing either lw, branch, or else
	hazard_select : mux_3_to_1_6bits port map (sel => mux_sel_3to1, src00 => else_control_const, src01 => lw_control_const, src10 => br_control_const, z => control_output);
	-- hazard_select : mux_3_to_1_5bits port map (sel => mux_sel_3to1, src00 => else_control_const, src01 => else_control_const, src10 => else_control_const, z => control_output);

-- 00 : else
-- 01 : LW
-- 10 : branch
  	PC_write <= control_output(5);
    IF_ID_write <= control_output(4);
	ID_EX_write <= control_output(3);
  	IF_ID_zeros_flag <= control_output(2);
    ID_EX_stall_flag <= control_output(1);
    EX_MEM_stall_flag <= control_output(0);

end architecture struct;