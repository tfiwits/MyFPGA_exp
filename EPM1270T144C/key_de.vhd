library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
entity key_de is 
	port(
			key_in : in std_logic;
			led_out: out std_logic_vector(7 downto 0)
		);
end key_de;

architecture a of key_de is
 signal led_sun:std_logic_vector(7 downto 0); 
	begin
		process(key_in)
			begin
				if key_in='1' then 
					led_sun<=led_sun+1;
				end if;
		end process;
	led_out<=led_sun;
end a;