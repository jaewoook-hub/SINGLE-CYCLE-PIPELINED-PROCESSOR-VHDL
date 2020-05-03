library ieee;
use ieee.std_logic_1164.all;
--include packages
use WORK.eecs361_gates.all;
use WORK.eecs361.all;

entity processor is
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
end entity processor;

architecture datapath of processor is
	--components
	component alu is
		port(
				A 			: in std_logic_vector(31 downto 0);
				B 			: in std_logic_vector(31 downto 0);
				sel 		: in std_logic_vector(5 downto 0);
				result 	: out std_logic_vector(31 downto 0);
				cout, overflow, zero : out std_logic
			);
	end component alu;
	
	component register32_32bits is
		port (
			clk, arst, aload, regwr, regdst	: in std_logic;
			rs, rt, rd						: in std_logic_vector(4 downto 0);
			busw							: in std_logic_vector(31 downto 0);
			busa, busb						: out std_logic_vector(31 downto 0)
		);
	end component register32_32bits;
	
	component register_32 is
		port (
			clk : in std_logic;
			arst, aload, RegWr			: in std_logic;
			Ra, Rb, Rw					: in std_logic_vector(4 downto 0);
			busW						: in std_logic_vector(31 downto 0);
			busA, busB					: out std_logic_vector(31 downto 0)
		);
	end component register_32;
	
	component extender is
		port (
			x	: in std_logic_vector(15 downto 0);
			sel : in std_logic;
			z	: out std_logic_vector(31 downto 0)
		);
	end component extender;
	
	component gtz_detector is
		port(
			x	: in std_logic_vector(31 downto 0);
			z	: out std_logic
		);
	end component gtz_detector;

	component zero_detect_6 is
		port(
			x : in std_logic_vector(5 downto 0);
			z : out std_logic
		);
	end component zero_detect_6;
	--types
	--signals
	signal Rw_signal : std_logic_vector(4 downto 0);
	signal busA_signal : std_logic_vector(31 downto 0);
	signal busB_signal : std_logic_vector(31 downto 0);
	signal busW_signal : std_logic_vector(31 downto 0);
	signal ALU_to_Mux_signal : std_logic_vector(31 downto 0);
	signal RegMux_to_ALU_signal : std_logic_vector(31 downto 0);
	signal DataMem_to_Mux_signal : std_logic_vector(31 downto 0);
	signal extender_to_Mux_signal : std_logic_vector(31 downto 0);
	signal sll_or_imm16 : std_logic_vector(15 downto 0);
	signal sll_shamt : std_logic_vector(15 downto 0);
	signal sll_flag : std_logic;
	
begin
	--Data Memory component
	DataMemory : sram 
		generic map(mem_file => mem_file)
		port map(cs => '1', oe => '1', we => MemWrite, addr => ALU_to_Mux_signal, din => busB_signal, dout => DataMem_to_Mux_signal);
			--OE currently 1, but could be modified to output based on control logic
	
	--Data Mem to Register Mux
	MUX_MemToReg : mux_32 port map(MemToReg, ALU_to_Mux_signal, DataMem_to_Mux_signal, busW_signal);
	
	--busB Mux
	MUX_RegToALU : mux_32 port map(ALU_src, busB_signal, extender_to_Mux_signal, RegMux_to_ALU_signal);
	
	--Register destination Mux
	Mux_RegDst : mux_n 
		generic map(n => 5)
		port map(RegDst, Rt, Rd, Rw_signal);
	
	sll_shamt <= "00000000000" & imm16(10 downto 6); --extract shamt
	
	--Sll_detect_operator
	sll_detect_op : zero_detect_6 port map(x => ALU_ctrl, z => sll_flag);
	
	--Sll or Imm16 Mux 
	MUX_sll_imm16 : mux_n generic map(16) port map(sll_flag, imm16, sll_shamt, sll_or_imm16);
	
	
	--Extender component
	Extender_map : extender port map(sll_or_imm16, ExtOp, extender_to_Mux_signal);
	
	--Register file (32-bit, 32 inputs)
	Register_file : register_32 port map(
		clk => clk, 
		arst => rst,
		aload => '0',
		regwr => RegWr,
		Ra => Rs,
		Rb => Rt,
		Rw => Rw_signal,
		busa => busA_signal,
		busb => busB_signal,
		busw => busW_signal
		
	);
	
	--ALU
	ALU_32 : alu port map(
		A => busA_signal,
		B => RegMux_to_ALU_signal,
		sel => ALU_ctrl,
		result => ALU_to_Mux_signal,
		cout => cout_flag,
		overflow => overflow_flag,
		zero => zero_flag
	);
	
	--Greater than 0 detector 
	gtz_detect : gtz_detector port map(ALU_to_Mux_signal, gtz_flag);
	
end datapath;