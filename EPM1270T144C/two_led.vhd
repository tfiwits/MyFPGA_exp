library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity two_led is 
port(
		clk_in: in std_logic;
		sw_in:in std_logic_vector(1 downto 0);
		com:out std_logic_vector(7 downto 0);
		scan:out std_logic_vector(7 downto 0)
);
end two_led;

architecture a of two_led is
signal st:std_logic_vector(3 downto 0):="0000";
signal com_tmp:std_logic_vector(7 downto 0):="00000001";
signal scan_r_tmp:std_logic_vector(7 downto 0):="11111110";
signal scan_g_tmp:std_logic_vector(7 downto 0):="11111101";
signal scan_o_tmp:std_logic_vector(7 downto 0):="11111100";
	begin
		process(clk_in)
			begin
				if clk_in'event and clk_in='1' then
					scan_r_tmp<=scan_r_tmp(5 downto 0) & scan_r_tmp(7 downto 6);
					scan_g_tmp<=scan_g_tmp(5 downto 0) & scan_g_tmp(7 downto 6);
					scan_o_tmp<=scan_o_tmp(5 downto 0) & scan_o_tmp(7 downto 6);
					st<=st+1;
						if st="1000" then 
							com_tmp<=com_tmp(6 downto 0) & com_tmp(7);
							st<="0000";
						end if;
				end if;
		end process;
		with sw_in select
			scan<="11111111" when "00",
					scan_r_tmp when "01",
				  scan_g_tmp when "10",
				  scan_o_tmp when "11";
				  com<=com_tmp;
end a;