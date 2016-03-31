library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity led_8 is 
port(	
		led_in_s,led_in_t,led_l_in: in std_logic_vector(3 downto 0);
		led_sig_in: in std_logic_vector(3 downto 0):="0001";
		led_com: out std_logic_vector(3 downto 0);
		led_out: out std_logic_vector(7 downto 0)
); 
end led_8;

architecture a of led_8 is
signal led_in : std_logic_vector(3 downto 0);
	begin
		led_com<=led_sig_in;
		with led_sig_in select
		led_in<=led_in_s when "0001",
				led_in_t when "0010",
				"0000" when others;
		with led_in select
		led_out<="10000001" when "0000",
				 "11001111" when "0001",
				 "10010010" when "0010",
				 "10000110" when "0011",
				 "11001100" when "0100",
				 "10100100" when "0101",
				 "11100000" when "0110",
				 "10001111" when "0111",
				 "10000000" when "1000",
				 "10001100" when "1001",
				 "10110001" when "1010",
				 "10000111" when "1011",
				 "10110111" when "1100",
				 "01111111" when others;
				 

end a;