library IEEE;
use IEEE.std_logic_1164.all;
use work.eecs361_gates.all;
use work.eecs361.all;
use work.pipeline_reg_package.all;

entity pipeline_CPU is
	generic (
		mem_file : string --loads Data Memory & Instr Memory
		);
	port (
		clk 	: in std_logic;
		arst	: in std_logic
	);
end entity pipeline_CPU;
  
architecture structural of pipeline_CPU is

	component alu is
		port(
				A 			: in std_logic_vector(31 downto 0);
				B 			: in std_logic_vector(31 downto 0);
				sel 		: in std_logic_vector(5 downto 0);
				result 		: out std_logic_vector(31 downto 0);
				cout, overflow, zero : out std_logic
			);
	end component alu;
  
 	component ALU_control is
		port (
			ALUop	: in std_logic_vector(1 downto 0);
			funct	: in std_logic_vector(5 downto 0);
			ALUctrl	: out std_logic_vector(5 downto 0)
		);
	end component ALU_control;

	component register_32 is
		port (
			clk : in std_logic;
			arst, aload, RegWr			: in std_logic;
			Ra, Rb, Rw					: in std_logic_vector(4 downto 0);
			busW						: in std_logic_vector(31 downto 0);
			busA, busB					: out std_logic_vector(31 downto 0)
		);
	end component register_32;
  
	component IFU_multicycle is
		generic (mem_file: string);
		port(
			clk, rst	: in std_logic;
			pc_enable	: in std_logic; 
			pc_in		: in std_logic_vector(31 downto 0);
			pc_out		: out std_logic_vector(31 downto 0);
			instr_out	: out std_logic_vector(31 downto 0)
		);
	end component IFU_multicycle;
  
    component sign_ext_32 is
        port (
            x	: in std_logic_vector(15 downto 0);
            z	: out std_logic_vector(31 downto 0)
        );
    end component sign_ext_32;
  
    component adder_32 is
    port (
            a, b : in std_logic_vector(31 downto 0);
            z : out std_logic_vector(31 downto 0)
            );
    end component adder_32;
  
    component shift_left_2 is
    port (
            x : in std_logic_vector(31 downto 0);
            z : out std_logic_vector(31 downto 0)
            );
    end component shift_left_2;

	component unsign_ext_32_5 is
	port (
			x	: in std_logic_vector(4 downto 0);
			z	: out std_logic_vector(31 downto 0)
			);
	end component unsign_ext_32_5;
	
	component zero_detect_6 is
		port(
			x : in std_logic_vector(5 downto 0);
			z : out std_logic
		);
	end component zero_detect_6;
	
	component mux_3_to_1 is
		port (
			sel	: in std_logic_vector(1 downto 0);
			src00, src01, src10	: in std_logic_vector(31 downto 0);
			z	: out std_logic_vector(31 downto 0)
		);
	end component mux_3_to_1;
	
	component hazard_unit is 
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
	end component hazard_unit;

	component forwarding_unit is
		port(
			--inputs
			ID_EX_Rs, ID_EX_Rt, EX_MEM_Rd, MEM_WB_Rd : in std_logic_vector(4 downto 0);
			EX_MEM_RegWr, MEM_WB_RegWr, sll_flag : in std_logic;
			--outputs
			forwardA, forwardB : out std_logic_vector(1 downto 0)
		);
	end component forwarding_unit;
	
	component main_control is
		port (
			opcode	: in std_logic_vector(5 downto 0);
			ALUop	: out std_logic_vector(1 downto 0);
			RegDst, ALUSrc, MemtoReg, RegWrite, MemWrite, MemRead, beq, bneq, bgtz, ExtOp	: out std_logic
		);
	end component main_control;

	component gtz_detector is
		port(
			x	: in std_logic_vector(31 downto 0);
			z	: out std_logic
		);
	end component gtz_detector;

	component branch_detector is
		port(
			beq_flag, bneq_flag, bgtz_flag : in std_logic;
			zero_flag, gtz_flag : in std_logic;
			PC_Src_out : out std_logic
		);

	end component branch_detector;


--signals
	signal aload : std_logic := '0';
	signal clk_n : std_logic;
	
	--IF stage
	signal pc_Src_signal, pc_enable : std_logic;
	signal pc_plus_4, pc_plus_4_plus_imm16, pc_in, IF_instr_out : std_logic_vector(31 downto 0);
	
	--ID stage
	signal RegWr_signal, if_id_enable, hazard_mux : std_logic;
	signal ID_instr, ID_pc, read_data1, read_data2, busw_signal, sign_extended_imm16, extended_shamt: std_logic_vector(31 downto 0);
	signal ID_control_ex : std_logic_vector(3 downto 0);
	signal ID_control_wb : std_logic_vector(1 downto 0);
	signal ID_control_mem : std_logic_vector(4 downto 0);
	signal WB_rw : std_logic_vector(4 downto 0);
    signal control_mux, control_mux_out : std_logic_vector (10 downto 0);

	--EX stage
	signal ID_EX_write : std_logic;
	signal EX_bus_a_in,  EX_bus_b_in, EX_ALU_in, EX_pc_in, EX_pc_out, EX_sign_extend, EX_shamt_extend : std_logic_vector(31 downto 0);
    signal sll_flag, ALU_zero_flag: std_logic;
    signal imm16_sll_2, shamt_32, ALU_result : std_logic_vector(31 downto 0);
    signal ALUctrl : std_logic_vector(5 downto 0);
    signal instruct_rw : std_logic_vector(4 downto 0);
	signal EX_control_wb : std_logic_vector(1 downto 0);
	signal EX_control_mem : std_logic_vector(4 downto 0);
	signal ALUSrc, RegDst, sll_or_ALUsrc : std_logic;
	signal ALUOp : std_logic_vector(1 downto 0);
    signal EX_instruct_1, EX_instruct_2, fwd_unit_rs_in, fwd_unit_rt_in : std_logic_vector(4 downto 0);
    signal EX_ALU_in1, ALUSrc_mux_to_ALU : std_logic_vector(31 downto 0);

	--MEM stage
    signal MEM_control_wb : std_logic_vector(1 downto 0);
    signal MEM_beq_flag, MEM_bneq_flag, MEM_bgtz_flag, MEM_gtz_flag, MEM_zero_flag, MemRead, MemWrite : std_logic; 
	signal MEM_pc, MEM_ALU_result, MEM_bus_b_in, MEM_dout : std_logic_vector(31 downto 0);
	signal MEM_rw_in : std_logic_vector(4 downto 0);

	--WB stage
	signal WB_data_mem_in, WB_alu_result_in : std_logic_vector (31 downto 0);                                   
	signal MemtoReg, RegWrite : std_logic;
	signal WB_control : std_logic_vector(1 downto 0);
	--forwarding signals
	signal forwardA_signal, forwardB_signal : std_logic_vector(1 downto 0);
	signal ALU_forwardA, ALU_forwardB : std_logic_vector(31 downto 0);

	--branch detect
    signal br_flag_temp : std_logic;
	signal br_flag_mux : std_logic;
	signal id_ex_vec, id_ex_vec_out : std_logic_vector(10 downto 0);
	signal ex_mem_vec, ex_mem_vec_out: std_logic_vector(6 downto 0);
	signal ifid_instr_in : std_logic_vector(31 downto 0);
	signal ifid_mux_sel, exmem_mux_sel, idex_mux_sel : std_logic;

begin
	not_clk : not_gate port map(clk, clk_n);

	--IF Stage
		--Before IFU
		pcSrc_Mux : mux_32 port map(sel => pc_Src_signal, src0 => pc_plus_4, src1 => MEM_pc, z => pc_in);

  	-- Control with MUX
        control : main_control port map(
        	opcode => ID_instr(31 downto 26),
          	
          	--EX Ctrl
          	ALUSrc => id_ex_vec(0),
            ALUop => id_ex_vec(2 downto 1),
          	RegDst => id_ex_vec(3),

          	--WB Ctrl
          	MemtoReg => id_ex_vec(4),
          	RegWrite => id_ex_vec(5),

          	--MEM Ctrl
          	beq => id_ex_vec(6),
          	bneq => id_ex_vec(7),
          	bgtz => id_ex_vec(8),
          	MemRead => id_ex_vec(9),
          	MemWrite => id_ex_vec(10)  
          	--ExtOp not connected
        );
          
--        ctrl_mux_map : mux_n generic map(11) port map (hazard_mux, control_mux, "00000000000", control_mux_out);

--------------------------------------------------------------------------------------------------------------------------------------
        
		-- ID stage controls
--        id_ex_vec(1 downto 0) <= ID_control_wb;
--        id_ex_vec(6 downto 2) <= ID_control_mem;
--        id_ex_vec(10 downto 7) <= ID_control_ex;
        ID_EX_Ctrl_Mux : mux_n generic map(11) port map (sel => idex_mux_sel, src0 => id_ex_vec, src1 => "00000000000", z => id_ex_vec_out);
        
        -- EX stage controls
        ex_mem_vec(1 downto 0) <= EX_control_wb;
        ex_mem_vec(6 downto 2) <= EX_control_mem;
        EX_MEM_Ctrl_Mux : mux_n generic map(7) port map (sel => exmem_mux_sel, src0 => ex_mem_vec, src1 => "0000000", z => ex_mem_vec_out);
        
        -- IF stage controls  
        IF_ID_Zero_Mux : mux_n generic map(32) port map (sel => ifid_mux_sel, src0 => IF_instr_out, src1 =>"00000000000000000000000000000000", z => ifid_instr_in);

    --IFU
		IFU : IFU_multicycle 
          	generic map(
              	mem_file => mem_file
            ) 
          	port map(
			clk => clk,
            rst => arst,
            pc_enable => pc_enable,
			pc_in => pc_in,
			pc_out => pc_plus_4,
			instr_out => IF_instr_out
			);
	
	--IF/ID
		IF_ID_register : IF_ID_Reg port map(
          	--inputs
			clk => clk,
			arst => arst,
			aload => '0', --loads 0 on async reset
            if_id_enable => if_id_enable,
			instr_in => ifid_instr_in, -- used to be IF_instr_out --
			pc_in => pc_plus_4,
          	--outputs
			instr_out => ID_instr,
			pc_out => ID_pc
		);
--------------------------------------------------------------------------------------------------------------------------------------
	--ID Stage
		register_file : register_32 port map(
			clk => clk_n,
			arst => arst,
			aload => '0',
			RegWr => RegWrite,
			Ra => ID_instr(25 downto 21),
			Rb => ID_instr(20 downto 16),
			Rw => WB_rw,
			busW => busw_signal,
			busA => read_data1,
			busB => read_data2
		);
          
        sign_extend_imm16 : sign_ext_32 port map(x => ID_instr(15 downto 0), z => sign_extended_imm16);
        extend_shamt : unsign_ext_32_5 port map(x => ID_instr(10 downto 6), z => extended_shamt);
          
        hazard_unit_map : hazard_unit port map(
			--inputs
			--lw
         	if_id_Rs => ID_instr(25 downto 21),
         	if_id_Rt => ID_instr(20 downto 16),
         	id_ex_Rt => EX_instruct_1,
			id_ex_MemRd => EX_control_mem(3),
  			--branch
			-- MEM_beq_flag => MEM_beq_flag, 
            -- MEM_bneq_flag => MEM_bneq_flag, 
            -- MEM_bgtz_flag => MEM_bgtz_flag,
			br_flag => pc_Src_signal,
			--outputs
			PC_write => pc_enable, 
          	IF_ID_write => if_id_enable, 
			ID_EX_write => ID_EX_write,
          	IF_ID_zeros_flag => ifid_mux_sel, 
          	ID_EX_stall_flag => idex_mux_sel, 
          	EX_MEM_stall_flag => exmem_mux_sel
        );
--------------------------------------------------------------------------------------------------------------------------------------
	--ID/EX
		ID_EX_register : ID_EX_Reg port map(
          	--inputs
			clk	=> clk,
			arst => arst,
			aload => aload,
			id_ex_enable => ID_EX_write,
			control_ex => id_ex_vec_out(3 downto 0), -- used to be ID_control_ex -- 
            control_wb => id_ex_vec_out(5 downto 4), -- used to be ID_control_wb --
         	control_mem => id_ex_vec_out(10 downto 6), -- used to be ID_control_mem --
			pc_in => ID_pc,
			read_data1 => read_data1,
			read_data2 => read_data2,
			sign_ext => sign_extended_imm16,
          	shamt_ext => extended_shamt,
			instruct_1 => ID_instr(20 downto 16),
			instruct_2 => ID_instr(15 downto 11),
          	Rs_in => ID_instr(25 downto 21),
          	Rt_in => ID_instr(20 downto 16),
			--outputs
			control_wb_out => EX_control_wb,
			control_mem_out => EX_control_mem,
			ALUSrc => ALUSrc,
			ALUOp => ALUOp,
			RegDst => RegDst,
			pc_out => EX_pc_in,
			bus_a => EX_bus_a_in,
			bus_b => EX_bus_b_in,
			out_sign_ext => EX_sign_extend,
          	out_shamt_ext => EX_shamt_extend,
			out_instruct1 => EX_instruct_1, --Instr[20:16]
			out_instruct2 => EX_instruct_2,  --Instr[15:11]
          	Rs_out => fwd_unit_rs_in,
          	Rt_out => fwd_unit_rt_in
        );
--------------------------------------------------------------------------------------------------------------------------------------      
	--EX Stage
        imm16_shifter 	: shift_left_2 port map (x => EX_sign_extend, z => imm16_sll_2);
        pc_add_imm16 	: adder_32 port map (a => EX_pc_in, b => imm16_sll_2, z => EX_pc_out); 
       
        sll_detector 	: zero_detect_6 port map (x => ALUctrl, z => sll_flag); --when ALUCtrl == "000000", SLL operation is selected.
        MUX_imm16_or_shamt : mux_32 port map (sel => sll_flag, src0 => EX_sign_extend, src1 => EX_shamt_extend, z => EX_ALU_in1);
		or_ALUSrc_sll	: or_gate port map (sll_flag, ALUSrc, sll_or_ALUsrc);
        -- MUX_ALUSrc 		: mux_32 port map (sel => sll_or_ALUsrc, src0 => EX_bus_b_in, src1 => EX_ALU_in1, z => ALUSrc_mux_to_ALU);

       
        mux_forwardA	: mux_3_to_1 port map (sel => forwardA_signal, src00 => EX_bus_a_in, src01 => busw_signal, src10 => MEM_ALU_result, z => ALU_forwardA);
      		--00 : no forwarding
          	--10 : forward from prior ALU result
          	--01 : forward from data memory or an earlier ALU result (forward from Data Mem only occurs in load)
        -- mux_forwardB	: mux_3_to_1 port map (sel => forwardB_signal, src00 => ALUSrc_mux_to_ALU, src01 => busw_signal, src10 => MEM_ALU_result, z => ALU_forwardB);          
		mux_forwardB	: mux_3_to_1 port map (sel => forwardB_signal, src00 => EX_bus_b_in, src01 => busw_signal, src10 => MEM_ALU_result, z => ALU_forwardB);          
      		--00 : no forwarding
          	--10 : forward from prior ALU result
          	--01 : forward from data memory or an earlier ALU result (forward from Data Mem only occurs in load)
        MUX_ALUSrc 		: mux_32 port map (sel => sll_or_ALUsrc, src0 => ALU_forwardB, src1 => EX_ALU_in1, z => ALUSrc_mux_to_ALU);

		ALU_map			: alu port map (A => ALU_forwardA, B => ALUSrc_mux_to_ALU, sel => ALUctrl, result => ALU_result, zero => ALU_zero_flag);
        
        alu_control_map	: ALU_control port map (ALUop => ALUOp, funct => EX_sign_extend(5 downto 0), ALUctrl => ALUctrl);
        
        MUX_RegDst 		: mux_n generic map(n => 5) port map (sel => RegDst, src0 => EX_instruct_1 , src1 => EX_instruct_2, z => instruct_rw);
          	--src0 : EX_instruct_1 is Instr[20:16]
          	--src1 : EX_instruct_2 is Instr[15:11]
                                               
        forwarding_map 	: forwarding_unit port map (
          ID_EX_Rs => fwd_unit_rs_in, 
          ID_EX_Rt => fwd_unit_rt_in,
          EX_MEM_Rd => MEM_rw_in,
          MEM_WB_Rd => WB_rw,
          EX_MEM_RegWr => MEM_control_wb(1),
          MEM_WB_RegWr => RegWrite,
		  sll_flag => sll_flag,
          forwardA => forwardA_signal, 
          forwardB => forwardB_signal
        );
--------------------------------------------------------------------------------------------------------------------------------------                                                     
    --EX/MEM                                    
        EX_Mem_register : EX_MEM_Reg port map(
          --inputs
          clk => clk,
          arst => arst,
          aload => aload,
          control_wb_in => ex_mem_vec_out(1 downto 0), -- used to be EX_control_wb --
          control_mem_in => ex_mem_vec_out(6 downto 2), -- used to be EX_control_mem -- 
          pc_in => EX_pc_out,
          zero_flag_in => ALU_zero_flag,
          alu_result_in => ALU_result,
          bus_b_in => ALU_forwardB,
          rw_in => instruct_rw,
          --outputs
          control_wb_out => MEM_control_wb,
          beq_flag => MEM_beq_flag,
          bneq_flag => MEM_bneq_flag, 
          bgtz_flag => MEM_bgtz_flag, 
          MemRead => MemRead, 
          MemWrite => MemWrite,
          zero_flag_out => MEM_zero_flag,
          pc_out => MEM_pc,
          alu_result_out => MEM_ALU_result,
          bus_b_out => MEM_bus_b_in,
          rw_out => MEM_rw_in
        );
--------------------------------------------------------------------------------------------------------------------------------------                                            
    --MEM Stage
        --Data Memory component
        DataMemory : syncram 
            generic map(mem_file => mem_file)
            port map(
				clk => clk_n,
				cs => '1',
				oe => MemRead,
				we => MemWrite,
				addr => MEM_ALU_result,
				din => MEM_bus_b_in,
				dout => MEM_dout
				);
                --OE currently 1, but could be modified to output based on control logic
        gtz_detect : gtz_detector port map (x => MEM_ALU_result, z => MEM_gtz_flag);
        branch_detect : branch_detector port map(
            beq_flag => MEM_beq_flag, bneq_flag => MEM_bneq_flag, bgtz_flag => MEM_bgtz_flag,
            zero_flag => MEM_zero_flag, gtz_flag => MEM_gtz_flag, PC_Src_out => pc_Src_signal);
--------------------------------------------------------------------------------------------------------------------------------------
    --MEM/WB                                    
	MEM_WB_MAP : MEM_WB_Reg port map(
      	--inputs
		clk => clk,
		arst => arst,
		aload => aload,
		data_mem_in => MEM_dout,
		control_wb_in => MEM_control_wb,
		alu_result_in => MEM_ALU_result,
		rw_in => MEM_rw_in,
      	--outputs
		data_mem_out => WB_data_mem_in,
		-- control_wb_out => WB_control,
		control_wb_out(0) => MemToReg,
      	control_wb_out(1) => RegWrite,
		alu_result_out => WB_alu_result_in,
		rw_out => WB_rw
	);                             
	-- MemToReg <= WB_control(0);
	-- RegWrite <= WB_control(1);
--------------------------------------------------------------------------------------------------------------------------------------
    --WB Stage
    wb_mux : mux_32 port map (sel => MemToReg, src0 => WB_alu_result_in, src1 => WB_data_mem_in, z => busw_signal);	

end architecture structural;