-- Import IEEE standard logic library
library ieee;
use ieee.std_logic_1164.all;

-- Entity that selects one of four 4-bit hexadecimal inputs based on a 2-bit selector
entity hex_mux is
port (
	hex_num3, hex_num2, hex_num1, hex_num0	:	in std_logic_vector(3 downto 0);	-- Four 4-bit hex inputs
	mux_select								:	in std_logic_vector(1 downto 0);	-- 2-bit select signal
	hex_out									:	out std_logic_vector(3 downto 0)	-- Selected 4-bit output
);
end hex_mux;

-- Architecture implements a 4-to-1 multiplexer using a selected signal
architecture mux_logic of hex_mux is
begin
	with mux_select(1 downto 0) select
		hex_out <=	hex_num0 when "00",
					hex_num1 when "01",
					hex_num2 when "10",
					hex_num3 when "11";
end mux_logic;