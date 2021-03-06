library ieee;
use ieee.std_logic_1164.all;

entity mux2_32bit is
	port(
		line_select  : in std_logic;
		line0, line1 : in std_logic_vector(31 downto 0);
		output       : out std_logic_vector(31 downto 0));
end mux2_32bit;

architecture Behavioral of mux2_32bit is
begin
	process(line_select, line0, line1)
	begin
		case line_select is
			when '0'    => output <= line0 after 5 ns;
			when '1'    => output <= line1 after 5 ns;
			when others => output <= line0 after 5 ns;
		end case;
	end process;
end Behavioral;

