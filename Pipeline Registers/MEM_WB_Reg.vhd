library ieee;
use ieee.std_logic_1164.all;
use work.eecs361_gates.all;
use work.eecs361.all;

entity MEM_WB_Reg is 
	port(
		clk 	: in std_logic;
		arst	: in std_logic;
		aload	: in std_logic;
 
		data_mem_in  : in std_logic_vector (31 downto 0); 
		control_wb_in 	 : in std_logic_vector (1 downto 0);
		alu_result_in: in std_logic_vector (31 downto 0);
		rw_in : in std_logic_vector (4 downto 0);
		
		data_mem_out  : out std_logic_vector (31 downto 0); 
		control_wb_out : out std_logic_vector(1 downto 0);
		alu_result_out: out std_logic_vector (31 downto 0);
		rw_out : out std_logic_vector (4 downto 0)
	);
end MEM_WB_Reg;

architecture structural of MEM_WB_Reg is 

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
	
begin
	
	generate_wb : for i in 0 to 1 generate 
		wb_out_sigs : dffr_a port map 
			(clk, arst, aload, '0', control_wb_in(i), '1', control_wb_out(i));
	end generate;
	
	generate_wr : for i in 0 to 4 generate 
		write_reg_sigs : dffr_a port map 
			(clk, arst, aload, '0', rw_in(i), '1', rw_out(i));
	end generate;
	
	generate_datamem : for i in 0 to 31 generate
		data_mem_reg : dffr_a port map
			(clk, arst, aload, '0', data_mem_in(i), '1', data_mem_out(i));
	end generate;
	
	generate_aluresult : for i in 0 to 31 generate
		alu_result_reg : dffr_a port map
			(clk, arst, aload, '0', alu_result_in(i), '1', alu_result_out(i));
	end generate;
	-- dffr_a_32bit_1 : dffr_a_32bit port map
		-- (clk, arst, aload, "00000000000000000000000000000000", data_mem_in, '1', data_mem_out);
    -- dffr_a_32bit_2 : dffr_a_32bit port map
		-- (clk, arst, aload, "00000000000000000000000000000000", alu_result_in, '1', alu_result_out);
	
end structural;
