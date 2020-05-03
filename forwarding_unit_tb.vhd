library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;
use work.eecs361_gates.all;
use work.eecs361.all;
use work.testbench_functions.all;

entity forwarding_unit_tb is 
end entity forwarding_unit_tb;

architecture behavioral of forwarding_unit_tb is
	component forwarding_unit is
		port(
			--inputs
			ID_EX_Rs, ID_EX_Rt, EX_MEM_Rd, MEM_WB_Rd : in std_logic_vector(4 downto 0);
			EX_MEM_RegWr, MEM_WB_RegWr : in std_logic;
			--outputs
			forwardA, forwardB : out std_logic_vector(1 downto 0)
		);
	end component forwarding_unit;
	
	signal ID_EX_Rs, ID_EX_Rt, EX_MEM_Rd, MEM_WB_Rd : std_logic_vector(4 downto 0) := "00000";
	signal EX_MEM_RegWr, MEM_WB_RegWr : std_logic := '0';
	signal forwardA, forwardB : std_logic_vector(1 downto 0);

begin
	dut : forwarding_unit port map(
		ID_EX_Rs => ID_EX_Rs,
		ID_EX_Rt => ID_EX_Rt,
		EX_MEM_Rd => EX_MEM_Rd,
		MEM_WB_Rd => MEM_WB_Rd,
		EX_MEM_RegWr => EX_MEM_RegWr,
		MEM_WB_RegWr => MEM_WB_RegWr,
		forwardA => forwardA,
		forwardB => forwardB
	);
	process is begin
		wait for 20 ns;
		--ForwardA(0) = 1
		EX_MEM_RegWr <= '1';
		EX_MEM_Rd <= "00100";
		ID_EX_Rs <= "00100";
		wait for 20 ns;
		--ForwardA(0) = 0
		ID_EX_Rs <= "00110";
		wait for 20 ns;
		--ForwardA(1) = 1
		ID_EX_Rt <= "00100";
		wait for 20 ns;
		MEM_WB_RegWr <= '1';
		MEM_WB_Rd <= "00010";
		EX_MEM_Rd <= "00010";
		ID_EX_Rs <= "00010";
		wait for 20 ns;
		ID_EX_Rs <= "00000";
		ID_EX_Rt <= "00010";
		wait for 20 ns;
		EX_MEM_Rd <= "00101"; 
		ID_EX_Rt <= "00101";
		wait for 20 ns;
		ID_EX_Rs <= "00101";
		wait for 20 ns;
		wait;
	end process;
end architecture behavioral;