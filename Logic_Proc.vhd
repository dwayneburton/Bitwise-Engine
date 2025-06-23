-- Import IEEE standard logic library
LIBRARY ieee;
USE ieee.std_logic_1164.all;

-- Entity for a 4-bit logic unit supporting AND, OR, XOR, and XNOR operations
ENTITY Logic_Proc IS
	PORT (
		logic_in0 : in std_logic_vector(3 downto 0);	-- First 4-bit logic input
		logic_in1 : in std_logic_vector(3 downto 0);	-- Second 4-bit logic input
		logic_select: in std_logic_vector(1 downto 0);	-- 2-bit selector for logic operation
		logic_out : out std_logic_vector(3 downto 0)	-- 4-bit output result
	);
END Logic_Proc;

-- Architecture defines a combinational logic unit using a select statement
ARCHITECTURE logic_gates OF Logic_Proc IS
BEGIN
	-- Perform selected logic operation based on 2-bit selector
	with logic_select(1 downto 0) select
		logic_out <=	(logic_in0 AND logic_in1) when "00",
						(logic_in0 OR logic_in1) when "01",
						(logic_in0 XOR logic_in1) when "10",
						(logic_in0 XNOR logic_in1) when "11";
END logic_gates;