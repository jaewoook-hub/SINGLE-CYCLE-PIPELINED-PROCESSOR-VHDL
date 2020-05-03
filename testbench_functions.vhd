library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

package testbench_functions is 

function slv_to_uint(input : in std_logic_vector)
	return integer;
	
function uint_to_slv(input, size : in integer)
	return std_logic_vector;

end package testbench_functions;

package body testbench_functions is




	function slv_to_uint(input : in std_logic_vector)
		return integer is
	
		variable retval : integer;
	begin
		retval := to_integer(unsigned(input));
	
		return retval;
	end function slv_to_uint;

	
	
	
	function uint_to_slv(input, size : in integer)
		return std_logic_vector is
		
		variable retvec : std_logic_vector(size - 1 downto 0);
	begin
		retvec := std_logic_vector(to_unsigned(input, size));
		
		return retvec;
	end function uint_to_slv;

	
	
end package body testbench_functions;