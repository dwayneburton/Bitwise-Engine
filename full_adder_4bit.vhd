-- Import IEEE standard logic library
library ieee;
use ieee.std_logic_1164.all;

-- Entity for a 4-bit ripple carry adder using 1-bit full adder components
ENTITY full_adder_4bit IS
	PORT (
		Hex_D: in std_logic_vector(3 downto 0);	-- 4-bit input A
		Hex_E: in std_logic_vector(3 downto 0);	-- 4-bit input B
		Carry_In: in std_logic;					-- Initial carry-in
		SUM: out std_logic_vector(3 downto 0);	-- 4-bit sum output
		Carry_Out3: out std_logic				-- Final carry-out
	);
END full_adder_4bit;

-- Architecture defines a 4-bit adder using chained 1-bit full adders
ARCHITECTURE adder_4bit_gates OF full_adder_4bit IS
	-- Component declaration for reusable 1-bit full adder
	component full_adder_1bit
		port (
  			Input_A					: in std_logic;
			Input_B					: in std_logic;
			Carry_In				: in std_logic;
			full_adder_sum_output	: out std_logic;
			full_adder_carry_output	: out std_logic
		);
	end component;

	-- Internal carry signals between adder stages
	signal Carry_Out0	: std_logic;
	signal Carry_Out1	: std_logic;
	signal Carry_Out2	: std_logic;
	
BEGIN
	-- Chain four 1-bit full adders to form a 4-bit ripple carry adder
	INST1: full_adder_1bit port map(Hex_D(0), Hex_E(0), Carry_In, SUM(0), Carry_Out0);
	INST2: full_adder_1bit port map(Hex_D(1), Hex_E(1), Carry_Out0, SUM(1), Carry_Out1);
	INST3: full_adder_1bit port map(Hex_D(2), Hex_E(2), Carry_Out1, SUM(2), Carry_Out2);
	INST4: full_adder_1bit port map(Hex_D(3), Hex_E(3), Carry_Out2, SUM(3), Carry_Out3);
END adder_4bit_gates;