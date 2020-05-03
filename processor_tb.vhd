library IEEE;
use IEEE.std_logic_1164.all;
use work.testbench_functions.all;

entity processor_tb is
end entity processor_tb;

architecture test_bench of processor_tb is
	--components
	component processor is
		generic (
			--loads Data Memory
			mem_file : string
			);
		port (
			-- clock
			clk, rst : in std_logic;
			
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
	
	--types
	--signals
	signal clk_tb, rst_tb :  std_logic := '0';
	signal imm16_tb :  std_logic_vector(15 downto 0);
	signal Rs_tb, Rt_tb, Rd_tb :  std_logic_vector(4 downto 0);
	signal ALU_ctrl_tb :  std_logic_vector(5 downto 0); 
	signal nPC_sel_tb, RegDst_tb, RegWr_tb, ExtOp_tb, ALU_src_tb, MemWrite_tb, MemToReg_tb :  std_logic;
	signal c_flag_tb, overflow_flag_tb, zero_flag_tb, gtz_flag_tb :  std_logic;
		
begin

	CPU : processor 
		generic map (mem_file => "sort_corrected_branch.dat")
		port map(
			clk => 				clk_tb,
			rst => 				rst_tb,
			imm16 => 			imm16_tb,
			Rs => 				Rs_tb,
			Rt => 				Rt_tb,
			Rd => 				Rd_tb,
			ALU_ctrl =>			ALU_ctrl_tb,
			nPC_sel => 			nPC_sel_tb,
			RegDst => 			RegDst_tb,
			RegWr => 			RegWr_tb,
			ExtOp => 			ExtOp_tb,
			ALU_src => 			ALU_src_tb,
			MemWrite => 		MemWrite_tb,
			MemToReg => 		MemToReg_tb,
			cout_flag => 		c_flag_tb,
			overflow_flag => 	overflow_flag_tb,
			zero_flag => 		zero_flag_tb,
			gtz_flag => 		gtz_flag_tb
		);
	
	manual_input : process is
		-- variable clk_var :  std_logic;
		-- variable imm16_var :  std_logic_vector(15 downto 0);
		-- variable Rs_var, Rt_var, Rd_var :  std_logic_vector(4 downto 0);
		-- variable ALU_ctrl_var :  std_logic_vector(5 downto 0); 
		-- variable nPC_sel_var, RegDst_var, RegWr_var, ExtOp_var, ALU_src_var, MemWrite_var, MemToReg_var :  std_logic;
		-- variable c_flag_var, overflow_flag_var, zero_flag_var :  std_logic;
	begin	
		--addi
		clk_tb <= not clk_tb;
		rst_tb <= '1';
		wait for 100 ns;
		clk_tb <= not clk_tb;
		rst_tb <= '0';
		wait for 100 ns;
		imm16_tb <= uint_to_slv(16912, 16);
		Rs_tb <= uint_to_slv(15,5);
		Rt_tb <= uint_to_slv(0,5);
		Rd_tb <= uint_to_slv(10,5);
		ALU_ctrl_tb <= "100000";
		RegDst_tb <= '0';
		RegWr_tb <= '1';
		ExtOp_tb <= '0';
		ALU_src_tb <= '1';
		MemWrite_tb <= '0';
		MemToReg_tb <= '0';
		wait for 100 ns;
		for i in 0 to 3 loop
			clk_tb <= not clk_tb;
			imm16_tb <= uint_to_slv(16912, 16);
			Rs_tb <= uint_to_slv(0,5);
			Rt_tb <= uint_to_slv(0,5);
			Rd_tb <= uint_to_slv(10,5);
			ALU_ctrl_tb <= "100000";
			RegDst_tb <= '0';
			RegWr_tb <= '1';
			ExtOp_tb <= '0';
			ALU_src_tb <= '1';
			MemWrite_tb <= '0';
			MemToReg_tb <= '0';
			wait for 100 ns;
		end loop;
		wait;
		
		
	end process manual_input;

end architecture test_bench;