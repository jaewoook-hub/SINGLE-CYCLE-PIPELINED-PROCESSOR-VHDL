Library ieee;
USE ieee.std_logic_1164.all;
use work.eecs361_gates.all;

ENTITY Full_Adder IS
PORT (A,B,CIN: IN std_logic; COUT,SUM: OUT std_logic);
END ENTITY Full_Adder;

ARCHITECTURE Full_Adder_STRUCT OF Full_Adder IS
SIGNAL XOR2_0_OUT, AND2_0_OUT, AND2_1_OUT: std_logic;

BEGIN
XOR2_0: xor_gate PORT MAP(A, B, XOR2_0_OUT);
XOR2_1: xor_gate PORT MAP(XOR2_0_OUT, CIN, SUM);
AND2_0: and_gate PORT MAP(XOR2_0_OUT, CIN, AND2_0_OUT);
AND2_1: and_gate PORT MAP(A, B, AND2_1_OUT);
OR2: or_gate PORT MAP(AND2_0_OUT, AND2_1_OUT, COUT);
END ARCHITECTURE Full_Adder_STRUCT;
