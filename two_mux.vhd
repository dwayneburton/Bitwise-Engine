-- Import IEEE standard logic library
library ieee;
use ieee.std_logic_1164.all;

-- Entity declaration for a 2-to-1 multiplexer selecting between two 4-bit inputs
ENTITY two_mux IS
	PORT
	(
		Hex_F		: in std_logic_vector(3 downto 0);
		Hex_G		: in std_logic_vector(3 downto 0);
		mux_select	: in std_logic;
		hex_out		: out std_logic_vector(3 downto 0)
	);
END two_mux;

-- Architecture that implements the multiplexer logic using a conditional select
ARCHITECTURE mux_gates OF two_mux IS
BEGIN
	with mux_select select
	hex_out <= Hex_F when '0',
			   Hex_G when '1';
END mux_gates;