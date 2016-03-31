library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity led_8_scan is 
port(
		clk_in:in std_logic;
		rst:in std_logic;
		clk_com_in:in std_logic_vector(2 downto 0);
		led_1:in std_logic_vector(7 downto 0);
		led_2:in std_logic_vector(7 downto 0);
		led_3:in std_logic_vector(7 downto 0);
		led_4:in std_logic_vector(7 downto 0);
		led_5:in std_logic_vector(7 downto 0);
		led_com:out std_logic_vector(4 downto 0);
		led_out:out std_logic_vector(7 downto 0)
);
end led_8_scan;

architecture a of led_8_scan is
signal clk_com_sig:std_logic_vector(2 downto 0);
signal clk_sig:std_logic; 
	begin
		process(clk_in)
			variable st : integer range 0 to 500000:=0;
			begin
				if clk_in'event and clk_in='1' then 
					if st/=500000 then 
						st:=st+1;
					else
						clk_sig<=not clk_sig;
						st:=0;
					end if;
				end if;
		end process;
		process(clk_sig)
			begin
				if clk_sig'event and clk_sig='1' then 
					if clk_com_sig=clk_com_in then 
						clk_com_sig<="001";
					else
						clk_com_sig<=clk_com_sig+1;
					end if;
				end if;
		end process;
		with clk_com_sig select 
			led_com <="00001" when "001",
					  "00010" when "010",
					  "00100" when "011",
					  "01000" when "100",
					  "10000" when "101",
					  "00000" when others; 
		with clk_com_sig select
			led_out<=led_1 when "001",
					 led_2 when "010",
					 led_3 when "011",
					 led_4 when "100",
					 led_5 when "101",
					 "00000000" when others;
end a;