library IEEE;
use IEEE.std_logic_1164.all;
use work.eecs361_gates.all;
use work.eecs361.all;

entity branch_detector is
	port(
		beq_flag, bneq_flag, bgtz_flag : in std_logic;
		zero_flag, gtz_flag : in std_logic;
		PC_Src_out : out std_logic
	);

end entity branch_detector;

architecture structural of branch_detector is
	component or3_gate is
		port(
			a : in std_logic;
			b : in std_logic;
			c : in std_logic;
			or3_out : out std_logic
		);
	end component or3_gate;

	signal not_zero_flag, branch_and_zero_signal, branch_and_nz_signal, branch_and_gtz_signal: std_logic;
	
begin
	not_zero_gate : not_gate port map(zero_flag, not_zero_flag);
	AND_branch_zero : and_gate port map(beq_flag, zero_flag, branch_and_zero_signal);
	AND_branch_nz : and_gate port map(bneq_flag, not_zero_flag, branch_and_nz_signal);
	AND_branch_gtz : and_gate port map(bgtz_flag, gtz_flag, branch_and_gtz_signal);
	or_branch_flags : or3_gate port map(branch_and_zero_signal, branch_and_nz_signal, branch_and_gtz_signal, PC_Src_out);


end architecture structural;

