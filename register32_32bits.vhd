library IEEE;
use IEEE.std_logic_1164.all;
use work.eecs361_gates.all;
use work.eecs361.all;

entity register32_32bits is
	port (
		clk, arst, aload, regwr, regdst	: in std_logic;
		rs, rt, rd						: in std_logic_vector(4 downto 0);
		busw							: in std_logic_vector(31 downto 0);
		busa, busb						: out std_logic_vector(31 downto 0)
	);
end entity register32_32bits;

architecture structural of register32_32bits is

	type register_array is array(31 downto 0) of std_logic_vector(31 downto 0);
	signal regwr_32 : register_array;
	
	signal rw_a, rw_b : register_array;
	
	signal zeros, dec_rw, dec_rs, dec_rt	: std_logic_vector(31 downto 0);
	signal rw								: std_logic_vector(4 downto 0);
	signal rw_en							: std_logic_vector(31 downto 0);
	
	begin
	
		zeros <= "00000000000000000000000000000000";
		regwr_32(0) <= zeros;
		
		rd_rt_selector 	: mux_n generic map(n => 5) port map (sel => regdst, src0 => rt, src1 => rd, z => rw);
		
		rw_dec_map		: dec_n generic map(n => 5) port map (src => rw, z => dec_rw);
		rs_dec_map		: dec_n generic map(n => 5) port map (src => rs, z => dec_rs);
		rt_dec_map		: dec_n generic map(n => 5) port map (src => rt, z => dec_rt);
		
		write_address	: for i in 31 downto 0 generate
			rw_enable_map	: mux port map (sel => regwr, src0 => '0', src1 => dec_rw(i), z => rw_en(i));
		end generate write_address;
		
		loop1 : for i in 1 to 31 generate
			loop2: for j in 0 to 31 generate
				dff_map : dffr_a port map (clk => clk, arst => arst, aload => aload, adata => zeros(j), d => busw(j), enable => rw_en(i), q => regwr_32(i)(j));
			end generate loop2;
		end generate loop1;
		
		bus_a_map 	: mux_32 port map (sel => dec_rs(0), src0 => "00000000000000000000000000000000", src1=> regwr_32(0)  , z => rw_a(0));
		bus_a_rest 	: for i in 1 to 31 generate
			mux32_a_map : mux_32 port map (sel => dec_rs(i), src0 => rw_a(i - 1), src1 => regwr_32(i), z => rw_a(i));
		end generate bus_a_rest;
		busa <= rw_a(31);
		
		bus_b_map	: mux_32 port map (sel => dec_rt(0), src0 => "00000000000000000000000000000000", src1=> regwr_32(0)  , z => rw_b(0));
		bus_b_rest	: for i in 1 to 31 generate
			mux32_b_map : mux_32 port map (sel => dec_rt(i), src0 => rw_b(i - 1), src1 => regwr_32(i), z => rw_b(i));
		end generate bus_b_rest;
		busb <= rw_b(31);
		
end architecture structural;
		
	