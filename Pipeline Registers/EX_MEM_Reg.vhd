library IEEE;
use IEEE.std_logic_1164.all;
use work.eecs361_gates.all;
use work.eecs361.all;

entity EX_MEM_Reg is 
	port(
		clk, arst, aload	: in std_logic; 
 
		control_wb_in 	 	: in std_logic_vector (1 downto 0);
			--control_wb(0) : MemToReg
			--control_wb(1) : RegWrite
		control_mem_in	: in std_logic_vector (4 downto 0); 
      		--control_mem(0): beq
      		--control_mem(1): bneq
      		--control_mem(2): bgtz
      		--control_mem(3): MemRead
      		--control_mem(4): MemWrite
		pc_in		: in std_logic_vector (31 downto 0);
		zero_flag_in		: in std_logic;
		alu_result_in   : in std_logic_vector (31 downto 0);
		bus_b_in		: in std_logic_vector (31 downto 0);
		rw_in 			: in std_logic_vector (4 downto 0);
		
		control_wb_out	: out std_logic_vector (1 downto 0);
      	
      	--control_mem signals
		beq_flag, bneq_flag, bgtz_flag, MemRead, MemWrite, zero_flag_out : out std_logic;
		
		pc_out		: out std_logic_vector (31 downto 0); 
		alu_result_out  : out std_logic_vector (31 downto 0);	
		bus_b_out		: out std_logic_vector (31 downto 0);
		rw_out 	  		: out std_logic_vector (4 downto 0)
	);
end EX_MEM_Reg;

architecture structural of EX_MEM_Reg is 

	component dffr_a is
	  port (
		clk	   : in  std_logic;
		arst   : in  std_logic;
		aload  : in  std_logic;
		adata  : in  std_logic;
		d	   : in  std_logic;
		enable : in  std_logic;
		q	   : out std_logic
	  );
	end component;
	
	component dffr_a_32bit is
      port (
	    clk	   : in  std_logic;
        arst   : in  std_logic;
        aload  : in  std_logic;
        adata  : in  std_logic_vector(31 downto 0);
	    d	   : in  std_logic_vector(31 downto 0);
        enable : in  std_logic;
	    q	   : out std_logic_vector(31 downto 0)
      );
    end component;

	-- signal wb_out_sig_temp	 	: std_logic_vector (1 downto 0);
	signal control_mem_in_temp : std_logic_vector (4 downto 0); 
	-- signal pc_out_sig_temp		: std_logic_vector (31 downto 0); 
--	signal alu_zero_out_temp	: std_logic;
--	signal alu_result_out_temp  : std_logic_vector (31 downto 0);	
--	signal bus_b_out_temp		: std_logic_vector (31 downto 0);
--	signal write_reg_out_temp 	: std_logic_vector (4 downto 0);
	
begin
	--Splitting into separate MEM control signals
	beq_flag <= control_mem_in_temp(0);
	bneq_flag <= control_mem_in_temp(1);
	bgtz_flag <= control_mem_in_temp(2);
	MemRead <= control_mem_in_temp(3);
	MemWrite <= control_mem_in_temp(4);
--	zero_flag_out <= alu_zero_out_temp;
	
	generate_wb1 : for i in 0 to 1 generate 
		wb_out_sigs : dffr_a port map(
			clk => clk, 
			arst => arst, 
			aload => aload, 
			adata => '0',
			d => control_wb_in(i), 
			enable => '1', 
			q => control_wb_out(i)
		);
	end generate;
	
	generate_mem_ctrl : for i in 0 to 4 generate 
		mem_ctrl_sigs : dffr_a port map 
			(clk, arst, aload, '0', control_mem_in(i), '1', control_mem_in_temp(i));
	end generate;
	
	generate_wr : for i in 0 to 4 generate 
		write_reg_sigs : dffr_a port map (clk, arst, aload, '0', rw_in(i), '1', rw_out(i));
	end generate;
	
	dffr_a_zero_flag : dffr_a port map(clk, arst, aload, '0', zero_flag_in, '1', zero_flag_out);
	
	dffr_a_32bit_1 : dffr_a_32bit port map
		(clk, arst, aload, "00000000000000000000000000000000", pc_in, '1', pc_out);

	dffr_a_32bit_2 : dffr_a_32bit port map
		(clk, arst, aload, "00000000000000000000000000000000", alu_result_in, '1', alu_result_out);

	dffr_a_32bit_3 : dffr_a_32bit port map
		(clk, arst, aload, "00000000000000000000000000000000", bus_b_in, '1', bus_b_out);	
end structural;
