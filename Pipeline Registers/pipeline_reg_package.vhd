library IEEE;
use IEEE.std_logic_1164.all;
use work.eecs361_gates.all;
use work.eecs361.all;

package pipeline_reg_package is

	component IF_ID_Reg is
		port (
			--Inputs
			clk : in std_logic;
			arst, aload : in std_logic;
			if_id_enable : in std_logic;
				--async reset will initialize register with 0
			instr_in : in std_logic_vector(31 downto 0);
			pc_in : in std_logic_vector(31 downto 0);
			
			--Outputs
			instr_out : out std_logic_vector(31 downto 0); 
			pc_out : out std_logic_vector(31 downto 0)
		);
	end component IF_ID_Reg;
	
	component ID_EX_Reg is 
		port ( 
			-- inputs
			clk			: in std_logic;
			arst, aload	: in std_logic;
			id_ex_enable: in std_logic;

			control_wb	: in std_logic_vector(1 downto 0);
			control_mem	: in std_logic_vector(4 downto 0);
				--control_mem(0): beq
				--control_mem(1): bneq
				--control_mem(2): bgtz
				--control_mem(3): MemRead
				--control_mem(4): MemWrite
			control_ex	: in std_logic_vector(3 downto 0);
			
			pc_in, read_data1, read_data2, sign_ext, shamt_ext	: in std_logic_vector(31 downto 0);
			instruct_1, instruct_2, Rs_in, Rt_in	: in std_logic_vector(4 downto 0);
			
			--outputs
			control_wb_out	: out std_logic_vector(1 downto 0);
			control_mem_out	: out std_logic_vector(4 downto 0);
			ALUSrc			: out std_logic;
			ALUOp			: out std_logic_vector(1 downto 0);
			RegDst			: out std_logic;
			
			pc_out, bus_a, bus_b, out_sign_ext, out_shamt_ext	: out std_logic_vector(31 downto 0);
			
			out_instruct1, out_instruct2, Rs_out, Rt_out	: out std_logic_vector(4 downto 0)
		);
	end component ID_EX_Reg;
	
	component EX_MEM_Reg is 
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
	end component;
	
	component MEM_WB_Reg is 
		port(
			clk 	: in std_logic;
			arst	: in std_logic;
			aload	: in std_logic;
	 
			data_mem_in  : in std_logic_vector (31 downto 0); 
			control_wb_in : in std_logic_vector (1 downto 0);
			alu_result_in: in std_logic_vector (31 downto 0);
			rw_in : in std_logic_vector (4 downto 0);
			
			data_mem_out  : out std_logic_vector (31 downto 0); 
			control_wb_out : out std_logic_vector(1 downto 0);
			alu_result_out: out std_logic_vector (31 downto 0);
			rw_out : out std_logic_vector (4 downto 0)
		);
	end component;

end package pipeline_reg_package;

package body pipeline_reg_package is
end package body pipeline_reg_package;
