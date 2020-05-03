library IEEE;
use IEEE.std_logic_1164.all;
use work.eecs361_gates.all;
use work.eecs361.all;
use work.helper.all;

entity main_control_tb is
    port (         
        ALUOp     : out std_logic_vector(1 downto 0);
        RegDst, ALUSrc, MemtoReg, RegWrite, MemWrite, MemRead, beq, bneq, bgtz, ExtOp    : out std_logic
	);
end main_control_tb;

architecture structural of main_control_tb is

    signal op_tb  : std_logic_vector(5 downto 0);

    begin
		mainControl_map : main_control port map (
			opcode  	=> op_tb,
			ALUOp 		=> ALUOp,
			RegDst 		=> RegDst,
			ALUSrc 		=> ALUSrc,
			MemtoReg	=> MemtoReg,
			RegWrite 	=> RegWrite,
			MemWrite 	=> MemWrite,
			MemRead 	=> MemRead,
			beq			=> beq,
			bneq		=> bneq,
			bgtz		=> bgtz
			ExtOp		=> ExtOp
		);

        test_proc : process
        begin
            -- Test R-type
            op_tb <= "000000";
            wait for 5 ns;

            -- Test addi
            op_tb <= "001000";
            wait for 5 ns;

            -- Test beq
            op_tb	<= "000100";
            wait for 5 ns;

            -- Test bneq
            op_tb <= "000101";
            wait for 5 ns;
			
			-- Test bgtz
			op_tb <= "000111";
			wait for 5 ns;

            -- Test lw
            op_tb <= "100011";
            wait for 5 ns;

            -- Test sw
            op_tb <= "101011";
            wait for 5 ns;

            wait;
        end process;

end architecture structural;