-- Import IEEE libraries for standard and numeric logic
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

-- Top-level entity that connects switches, push buttons, LEDs, logic operations, adders, and 7-segment displays
entity LogicalStep_Bitwise_top is
	port (
		clkin_50	: in std_logic;
		pb_n		: in std_logic_vector(3 downto 0);
		sw			: in std_logic_vector(7 downto 0);
		leds		: out std_logic_vector(7 downto 0);
		seg7_data	: out std_logic_vector(6 downto 0);
		seg7_char1	: out std_logic;
		seg7_char2	: out std_logic
	); 
end LogicalStep_Bitwise_top;

-- Architecture that instantiates and connects all submodules
architecture SimpleCircuit of LogicalStep_Bitwise_top is
	-- Declare all components used in the top-level design
	component SevenSegment
		port (
			hex			: in std_logic_vector(3 downto 0);
			sevenseg	: out std_logic_vector(6 downto 0)
		);
	end component;
	
	component segment7_mux
		port (
			clk		: in std_logic := '0';
			DIN2	: in std_logic_vector(6 downto 0);
			DIN1	: in std_logic_vector(6 downto 0);
			DOUT	: out std_logic_vector(6 downto 0);
			DIG2	: out std_logic;
			DIG1	: out std_logic
		);
	end component;
	
	component Logic_Proc
		port (
			logic_in0 	: in std_logic_vector(3 downto 0);
			logic_in1 	: in std_logic_vector(3 downto 0);
			logic_select: in std_logic_vector(1 downto 0);
			logic_out	: out std_logic_vector(3 downto 0)
		);
	end component;
	
	component PB_Inverters
		port (
			pb_n	: in std_logic_vector(3 downto 0);
			pb		: out std_logic_vector(3 downto 0)
		);
	end component;
	
	component full_adder_4bit
		port (
			Hex_D		: in std_logic_vector(3 downto 0);
			Hex_E		: in std_logic_vector(3 downto 0);
			Carry_In	: in std_logic;
			SUM			: out std_logic_vector(3 downto 0);
			Carry_Out3	: out std_logic
		);
	end component;
	
	component two_mux
		port (
			Hex_F		: in std_logic_vector(3 downto 0);
			Hex_G		: in std_logic_vector(3 downto 0);
			mux_select	: in std_logic;
			hex_out		: out std_logic_vector(3 downto 0)
		);
	end component;

	-- Internal signals to connect submodules
	signal hex_A, hex_B, hex_C	: std_logic_vector(3 downto 0);
	signal seg7_A, seg7_B		: std_logic_vector(6 downto 0);
	signal pb					: std_logic_vector(3 downto 0);
	signal hex_sum				: std_logic_vector(3 downto 0);
	signal Carry_Out			: std_logic;
	signal hex_1, hex_2			: std_logic_vector(3 downto 0);

begin
	-- Assign switch inputs to internal 4-bit buses
	hex_A <= sw(3 downto 0);
	hex_B <= sw(7 downto 4);
	hex_C <= "000" & Carry_Out;
	
	-- Component instantiations and connections
	INST1: SevenSegment		port map(hex_2, seg7_A);
	INST2: SevenSegment		port map(hex_1, seg7_B);
	INST3: segment7_mux		port map(clkin_50, seg7_A, seg7_B, seg7_data, seg7_char2, seg7_char1);
	INST4: PB_Inverters		port map(pb_n, pb);
	INST5: Logic_Proc		port map(hex_A, hex_B, pb(1 downto 0), leds(3 downto 0));
	INST6: full_adder_4bit	port map(hex_A, hex_B, '0', hex_sum, Carry_Out);
	INST7: two_mux			port map(hex_B, hex_C, pb(2), hex_1);
	INST8: two_mux			port map(hex_A, hex_sum, pb(2), hex_2); 
end SimpleCircuit;