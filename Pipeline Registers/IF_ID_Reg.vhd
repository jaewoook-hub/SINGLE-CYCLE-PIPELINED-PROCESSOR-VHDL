library IEEE;
use IEEE.std_logic_1164.all;
use work.eecs361_gates.all;
use work.eecs361.all;

entity IF_ID_Reg is
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
end entity IF_ID_Reg;


architecture structural of IF_ID_Reg is
--types
--components
--signals
	-- pc_reg : std_logic_vector(31 downto 0);
	-- instr_reg : std_logic_vector(31 downto 0);
	
begin
	--Implement 2 registers
	gen_pc_reg : for i in 0 to 31 generate
		dff_pc : dffr_a port map (
			clk	=> clk,
			arst => arst,
			aload => aload,
			adata => '0', --reset will initialize register with 0
			d => pc_in(i),
			enable => if_id_enable,
			q => pc_out(i)
		);
	end generate;
	
	gen_instr_reg : for i in 0 to 31 generate
		dff_instr : dffr_a port map (
			clk	=> clk,
			arst => arst,
			aload => aload,
			adata => '0', --reset will initialize register with 0
			d => instr_in(i),
			enable => if_id_enable,
			q => instr_out(i)
		);
	end generate;
	


end architecture structural;
