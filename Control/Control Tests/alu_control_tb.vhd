library IEEE;
use IEEE.std_logic_1164.all;
use work.eecs361_gates.all;
use work.eecs361.all;
use work.helper.all;

entity ALU_control_tb is
    port (
		ALUCtr : out std_logic_vector(5 downto 0)
	);
end ALU_control_tb;

architecture structural of ALU_control_tb is

    signal ALUOp : std_logic_vector(1 downto 0);
    signal func  : std_logic_vector(5 downto 0);

    begin
        ALUControl_map : ALU_control port map (ALUop  => ALUOp, funct => func, ALUctrl => ALUCtr);
      
        test_proc : process
        begin
            -- Test addi/lw/sw
            ALUOp <= "00";
            wait for 5 ns;

            -- Test beq/bne/bgtz
            ALUOp <= "01";
            wait for 5 ns;

            -- Test add
            ALUOp <= "10";
            func  <= "100000";
            wait for 5 ns;

            -- Test addu
            ALUOp <= "10";
            func  <= "100001";
            wait for 5 ns;

            -- Test sub
            ALUOp <= "10";
            func  <= "100010";
            wait for 5 ns;

			-- Test subu
            ALUOp <= "10";
            func  <= "100011";
            wait for 5 ns;
			
            -- Test and
            ALUOp <= "10";
            func  <= "100100";
            wait for 5 ns;

            -- Test or
            ALUOp <= "10";
            func  <= "100101";
            wait for 5 ns;

            -- Test slt
            ALUOp <= "10";
            func  <= "101010";
            wait for 5 ns;
			
			-- Test sltu
            ALUOp <= "10";
            func  <= "101001";
            wait for 5 ns;

            -- Test sll
            ALUOp <= "10";
            func  <= "000000";
            wait for 5 ns;

            wait;
        end process;

end architecture structural;
