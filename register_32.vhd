library IEEE;
use IEEE.std_logic_1164.all;
use work.eecs361_gates.all;
use work.eecs361.all;


entity register_32 is
	port (
		clk : in std_logic;
		arst, aload, regwr			: in std_logic;
		Ra, Rb, Rw					: in std_logic_vector(4 downto 0);
		busW						: in std_logic_vector(31 downto 0);
		busA, busB					: out std_logic_vector(31 downto 0)
	);
end entity register_32;

architecture structural of register_32 is
	--components
	component repeat_n is
		generic(
			n : integer
		);
		port(
			x : in std_logic;
			z : out std_logic_vector(n - 1 downto 0)
		);
	end component repeat_n;
	
	component or_32 is
		port (
			x1, x2, x3, x4, x5, x6, x7, x8, x9, x10, x11, x12, x13, x14, x15, x16, x17, x18, x19, x20, x21, x22, x23, x24, x25, x26, x27, x28, x29, x30, x31, x32	: in std_logic_vector(31 downto 0);
			z	: out std_logic_vector(31 downto 0)
		);
	end component or_32;

	--types
	type register_array is array(31 downto 0) of std_logic_vector(31 downto 0);
	signal reg : register_array;
	signal Rw_dec : register_array;
	signal Ra_dec : register_array;
	signal Rb_dec : register_array;
	--signals
	signal Rw_decoder_out_signal : std_logic_vector(31 downto 0);
	signal Ra_decoder_out_signal : std_logic_vector(31 downto 0);
	signal Rb_decoder_out_signal : std_logic_vector(31 downto 0);
	
	signal Rw_decoder_AND_signal : register_array;
	signal Ra_decoder_AND_signal : register_array;
	signal Rb_decoder_AND_signal : register_array;
	signal register_we_signal : std_logic_vector(31 downto 0);
	
begin
	Rw_decoder : dec_n generic map(5) port map (Rw, Rw_decoder_out_signal);
	Ra_decoder : dec_n generic map(5) port map (Ra, Ra_decoder_out_signal);
	Rb_decoder : dec_n generic map(5) port map (Rb, Rb_decoder_out_signal);
	
	
	generate_Ra_and : for i in 0 to 31 generate
		replicate_decoder : repeat_n generic map(32) port map (Ra_decoder_out_signal(i), Ra_dec(i));
			--repeat decoder bit 32-times (0xFFFFFFFF for true, 0x00000000 for false)
		AND_Ra_decoder : and_gate_32 port map (reg(i), Ra_dec(i), Ra_decoder_AND_signal(i));
	end generate;
	
	generate_Rb_and : for i in 0 to 31 generate
		replicate_decoder : repeat_n generic map(32) port map (Rb_decoder_out_signal(i), Rb_dec(i));
			--repeat decoder bit 32-times (0xFFFFFFFF for true, 0x00000000 for false)
		AND_Rb_decoder : and_gate_32 port map (reg(i), Rb_dec(i), Rb_decoder_AND_signal(i));
	end generate;
	
	generate_32_registers : for i in 0 to 31 generate --32 registers
		generate_register : for j in 0 to 31 generate --32bits per register
			dff_map : dffr_a port map (
				clk => clk,
				arst => arst,
				aload => aload,
				adata => '0',
				d => busW(j),
				enable => register_we_signal(i), 
				q => reg(i)(j)
			);
		end generate;
		
		we_AND_Rw_decoder : and_gate port map (Rw_decoder_out_signal(i), RegWr, register_we_signal(i));
	end generate;
	
	or_all_busA : or_32 port map (
		Ra_decoder_AND_signal(0),
		Ra_decoder_AND_signal(1),
		Ra_decoder_AND_signal(2),
		Ra_decoder_AND_signal(3),
		Ra_decoder_AND_signal(4),
		Ra_decoder_AND_signal(5),
		Ra_decoder_AND_signal(6),
		Ra_decoder_AND_signal(7),
		Ra_decoder_AND_signal(8),
		Ra_decoder_AND_signal(9),
		Ra_decoder_AND_signal(10),
		Ra_decoder_AND_signal(11),
		Ra_decoder_AND_signal(12),
		Ra_decoder_AND_signal(13),
		Ra_decoder_AND_signal(14),
		Ra_decoder_AND_signal(15),
		Ra_decoder_AND_signal(16),
		Ra_decoder_AND_signal(17),
		Ra_decoder_AND_signal(18),
		Ra_decoder_AND_signal(19),
		Ra_decoder_AND_signal(20),
		Ra_decoder_AND_signal(21),
		Ra_decoder_AND_signal(22),
		Ra_decoder_AND_signal(23),
		Ra_decoder_AND_signal(24),
		Ra_decoder_AND_signal(25),
		Ra_decoder_AND_signal(26),
		Ra_decoder_AND_signal(27),
		Ra_decoder_AND_signal(28),
		Ra_decoder_AND_signal(29),
		Ra_decoder_AND_signal(30),
		Ra_decoder_AND_signal(31),
		busA
	);
	or_all_busB : or_32 port map (
		Rb_decoder_AND_signal(0),
		Rb_decoder_AND_signal(1),
		Rb_decoder_AND_signal(2),
		Rb_decoder_AND_signal(3),
		Rb_decoder_AND_signal(4),
		Rb_decoder_AND_signal(5),
		Rb_decoder_AND_signal(6),
		Rb_decoder_AND_signal(7),
		Rb_decoder_AND_signal(8),
		Rb_decoder_AND_signal(9),
		Rb_decoder_AND_signal(10),
		Rb_decoder_AND_signal(11),
		Rb_decoder_AND_signal(12),
		Rb_decoder_AND_signal(13),
		Rb_decoder_AND_signal(14),
		Rb_decoder_AND_signal(15),
		Rb_decoder_AND_signal(16),
		Rb_decoder_AND_signal(17),
		Rb_decoder_AND_signal(18),
		Rb_decoder_AND_signal(19),
		Rb_decoder_AND_signal(20),
		Rb_decoder_AND_signal(21),
		Rb_decoder_AND_signal(22),
		Rb_decoder_AND_signal(23),
		Rb_decoder_AND_signal(24),
		Rb_decoder_AND_signal(25),
		Rb_decoder_AND_signal(26),
		Rb_decoder_AND_signal(27),
		Rb_decoder_AND_signal(28),
		Rb_decoder_AND_signal(29),
		Rb_decoder_AND_signal(30),
		Rb_decoder_AND_signal(31),
		busB
	);	
	
end architecture structural;
