library ieee;
use ieee.std_logic_1164.all;

entity mux32_32bit_tb is
end mux32_32bit_tb;

architecture Behavior of mux32_32bit_tb is
	component mux32_32bit
		port(
			line_select : in std_logic_vector(4 downto 0);
			line00, line01, line02, line03 : in std_logic_vector(31 downto 0);
			line04, line05, line06, line07 : in std_logic_vector(31 downto 0);
			line08, line09, line0a, line0b : in std_logic_vector(31 downto 0);
			line0c, line0d, line0e, line0f : in std_logic_vector(31 downto 0);
			line10, line11, line12, line13 : in std_logic_vector(31 downto 0);
			line14, line15, line16, line17 : in std_logic_vector(31 downto 0);
			line18, line19, line1a, line1b : in std_logic_vector(31 downto 0);
			line1c, line1d, line1e, line1f : in std_logic_vector(31 downto 0);
			output : out std_logic_vector(31 downto 0));
	end component;

	signal line_select : std_logic_vector(4 downto 0);
	signal line00, line01, line02, line03 : std_logic_vector(31 downto 0);
	signal line04, line05, line06, line07 : std_logic_vector(31 downto 0);
	signal line08, line09, line0a, line0b : std_logic_vector(31 downto 0);
	signal line0c, line0d, line0e, line0f : std_logic_vector(31 downto 0);
	signal line10, line11, line12, line13 : std_logic_vector(31 downto 0);
	signal line14, line15, line16, line17 : std_logic_vector(31 downto 0);
	signal line18, line19, line1a, line1b : std_logic_vector(31 downto 0);
	signal line1c, line1d, line1e, line1f : std_logic_vector(31 downto 0);
	signal output : std_logic_vector(31 downto 0);

begin
	uut: mux32_32bit port map(
		line_select => line_select,
		line00 => line00, line01 => line01, line02 => line02, line03 => line03,
		line04 => line04, line05 => line05, line06 => line06, line07 => line07,
		line08 => line08, line09 => line09, line0a => line0a, line0b => line0b,
		line0c => line0c, line0d => line0d, line0e => line0e, line0f => line0f,
		line10 => line10, line11 => line11, line12 => line12, line13 => line13,
		line14 => line14, line15 => line15, line16 => line16, line17 => line17,
		line18 => line18, line19 => line19, line1a => line1a, line1b => line1b,
		line1c => line1c, line1d => line1d, line1e => line1e, line1f => line1f,
		output => output);
	stim_proc: process
	begin
	
		-- Initialize all 32 lines to unique values
		line00 <= x"00000000"; line01 <= x"00000001"; line02 <= x"00000002"; line03 <= x"00000003";
		line04 <= x"00000004"; line05 <= x"00000005"; line06 <= x"00000006"; line07 <= x"00000007";
		line08 <= x"00000008"; line09 <= x"00000009"; line0a <= x"0000000a"; line0b <= x"0000000b";
		line0c <= x"0000000c"; line0d <= x"0000000d"; line0e <= x"0000000e"; line0f <= x"0000000f";
		line10 <= x"00000010"; line11 <= x"00000011"; line12 <= x"00000012"; line13 <= x"00000013";
		line14 <= x"00000014"; line15 <= x"00000015"; line16 <= x"00000016"; line17 <= x"00000017";
		line18 <= x"00000018"; line19 <= x"00000019"; line1a <= x"0000001a"; line1b <= x"0000001b";
		line1c <= x"0000001c"; line1d <= x"0000001d"; line1e <= x"0000001e"; line1f <= x"0000001f";

		-- Every 10 ns, increment the line_select input
		line_select <= "00000"; wait for 10 ns;
		line_select <= "00001"; wait for 10 ns;
		line_select <= "00010"; wait for 10 ns;
		line_select <= "00011"; wait for 10 ns;
		line_select <= "00100"; wait for 10 ns;
		line_select <= "00101"; wait for 10 ns;
		line_select <= "00110"; wait for 10 ns;
		line_select <= "00111"; wait for 10 ns;
		line_select <= "01000"; wait for 10 ns;
		line_select <= "01001"; wait for 10 ns;
		line_select <= "01010"; wait for 10 ns;
		line_select <= "01011"; wait for 10 ns;
		line_select <= "01100"; wait for 10 ns;
		line_select <= "01101"; wait for 10 ns;
		line_select <= "01110"; wait for 10 ns;
		line_select <= "01111"; wait for 10 ns;
		line_select <= "10000"; wait for 10 ns;
		line_select <= "10001"; wait for 10 ns;
		line_select <= "10010"; wait for 10 ns;
		line_select <= "10011"; wait for 10 ns;
		line_select <= "10100"; wait for 10 ns;
		line_select <= "10101"; wait for 10 ns;
		line_select <= "10110"; wait for 10 ns;
		line_select <= "10111"; wait for 10 ns;
		line_select <= "11000"; wait for 10 ns;
		line_select <= "11001"; wait for 10 ns;
		line_select <= "11010"; wait for 10 ns;
		line_select <= "11011"; wait for 10 ns;
		line_select <= "11100"; wait for 10 ns;
		line_select <= "11101"; wait for 10 ns;
		line_select <= "11110"; wait for 10 ns;
		line_select <= "11111"; wait for 10 ns;
		line_select <= "00000"; wait;
		
	end process;
end;
