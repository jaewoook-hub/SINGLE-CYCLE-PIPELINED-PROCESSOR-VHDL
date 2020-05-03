library ieee;
use ieee.std_logic_1164.all;
--include packages
use WORK.eecs361_gates.all;
use WORK.eecs361.all;

entity processor_pkg is
	generic(
		mem_file : string
	);
	port(
		clk, rst : in std_logic
	);
end entity processor_pkg;

architecture structural of processor_pkg is
--components
	component processor is
		generic (
			--loads Data Memory
			mem_file : string

			);
		port (
			-- clock
			clk, rst: in std_logic;
			
			-- Immediate Input Bus
			imm16 : in std_logic_vector(15 downto 0);
			
			-- Register Addr Signals -- (5-bit addr)
			Rs, Rt, Rd : in std_logic_vector(4 downto 0);
					
			-- Control Signals --
			ALU_ctrl : in std_logic_vector(5 downto 0); 
				-- temporary, since ALU_ctrl will be revised to 4 bits
			--ALU_ctrl : in std_logic_vector(3 downto 0);
			
			nPC_sel, RegDst, RegWr, ExtOp, ALU_src, MemWrite, MemToReg : in std_logic;
			
			--CPU Flags--
			cout_flag, overflow_flag, zero_flag, gtz_flag : out std_logic
			);
	end component processor;

	component final_control is
		port (
			opcode, funct	: in std_logic_vector(5 downto 0);
			
			ALUctrl			: out std_logic_vector(5 downto 0);
			
			RegDst, ALUSrc, MemtoReg, RegWrite, MemWrite, MemRead, beq, bneq, bgtz, ExtOp	: out std_logic
		);
	end component final_control;
	
	component IFU is
		generic (mem_file: string);
		port(
			clk, rst	 : in std_logic;

			-- Immed : 16 least significant bits of Instr --
			immed16 : in std_logic_vector(15 downto 0);

			-- Jump Target Addr --
			jump_addr : in std_logic_vector(25 downto 0);

			-- Contrl Signals --
			be_flag, bne_flag, bgtz_flag, jump, zero, gtz	 : in std_logic;

			instr_out	 : out std_logic_vector(31 downto 0)
		);
	end component IFU;
	
	component or3_gate is
		port(
			a : in std_logic;
			b : in std_logic;
			c : in std_logic;
			or3_out : out std_logic
		);
	end component or3_gate;

--types
--signals

signal instruction : std_logic_vector(31 downto 0);

-- Control Signals 
signal ALU_ctrl_signal : std_logic_vector(5 downto 0);
signal nPC_sel_signal, RegDst_signal, RegWr_signal : std_logic;
signal ExtOp_signal, ALU_src_signal, MemWrite_signal, MemToReg_signal : std_logic;

-- CPU flags
signal cout_flag_signal, overflow_flag_signal,  zero_flag_signal, gtz_flag_signal : std_logic;
signal branch_signal, beq_signal, bneq_signal, bgtz_signal : std_logic;

begin

	ifu_datapath : IFU 
	generic map (
		--Loads instruction memory
		mem_file => mem_file
	)
	port map (
		clk => clk,
		rst => rst,
		immed16 => instruction(15 downto 0),
		jump_addr => instruction(25 downto 0),
		be_flag => beq_signal,
		bne_flag => bneq_signal,
		bgtz_flag => bgtz_signal,
		jump => '0', --since jump not needed
		zero => zero_flag_signal,
		gtz => gtz_flag_signal, 
		instr_out => instruction
	);
	
	final_control_datapath : final_control port map (
		opcode => instruction(31 downto 26),
		funct => instruction(5 downto 0),
		ALUctrl => ALU_ctrl_signal,
		RegDst => RegDst_signal,
		ALUSrc => ALU_src_signal,
		MemToReg => MemToReg_signal,
		RegWrite => RegWr_signal,
		MemWrite => MemWrite_signal,
		-- MemRead => '1', --always read (OE = high)
		ExtOp => ExtOp_signal,
		beq => beq_signal,
		bneq => bneq_signal,
		bgtz => bgtz_signal
	);
	
	cpu_datapath : processor 
	generic map (
		--Loads data memory
		mem_file => mem_file
	)
	port map (
		clk => clk,
		rst => rst,
		
		--Signals from instruction (in) --
		Rt => instruction(20 downto 16),
		Rs => instruction(25 downto 21),
		Rd => instruction(15 downto 11),
		imm16 => instruction(15 downto 0),
		
		--Control Signals (in) --
		ALU_ctrl => ALU_ctrl_signal,
		nPC_sel => nPC_sel_signal,
		RegDst => RegDst_signal,
		RegWr => RegWr_signal,
		ExtOp => ExtOp_signal,
		ALU_src => ALU_src_signal,
		MemWrite => MemWrite_signal,
		MemToReg => MemToReg_signal,
		
		--CPU flags (out) --
		cout_flag => cout_flag_signal,
		overflow_flag => overflow_flag_signal,
		zero_flag => zero_flag_signal,
		gtz_flag => gtz_flag_signal
	);
	
	-- combine_branch : or3_gate port map (beq_signal, bneq_signal, bgtz_signal, branch_signal);




end architecture structural;