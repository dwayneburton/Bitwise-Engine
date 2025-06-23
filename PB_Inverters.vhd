-- Import IEEE standard logic library
LIBRARY ieee;
USE ieee.std_logic_1164.all;

-- Entity for inverting push button inputs
-- Converts 4 active-low inputs to active-high logic
ENTITY PB_Inverters IS
	PORT (
		pb_n	: in std_logic_vector(3 downto 0);	-- 4-bit active-low push button inputs
		pb		: out std_logic_vector(3 downto 0)	-- 4-bit active-high outputs
	);
END PB_Inverters;

-- Architecture applies bitwise inversion to all inputs
ARCHITECTURE gates OF PB_Inverters IS
BEGIN
	pb <= not(pb_n);
END gates;