-- Import IEEE standard logic library
library ieee;
use ieee.std_logic_1164.all;

-- Entity that defines a 1-bit full adder with carry-in and carry-out
ENTITY full_adder_1bit IS
	PORT (
		Input_A : in std_logic;					-- 1-bit input A
		Input_B : in std_logic;					-- 1-bit input B
		Carry_In : in std_logic;				-- Carry-in from previous adder
		full_adder_sum_output: out std_logic;	-- 1-bit sum output 
		full_adder_carry_output: out std_logic	-- Carry-out to next adder
	);
END full_adder_1bit;

-- Architecture implements the logic for a 1-bit full adder
ARCHITECTURE adder_1bit_gates OF full_adder_1bit IS
BEGIN
	full_adder_sum_output <= (Input_A XOR Input_B) XOR Carry_In;
	full_adder_carry_output <= ((Input_A AND Input_B) OR ((Input_A XOR Input_B) AND Carry_In));
END adder_1bit_gates;