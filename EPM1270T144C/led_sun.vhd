library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity led_sun is 
port(
		clk_in : in std_logic;
		led_out : out std_logic_vector(7 downto 0)
);
end led_sun;

architecture a of led_sun is
signal led_sun_sig : std_logic_vector(7 downto 0):="00000000"; 
	begin
		process(clk_in)
			begin
			if clk_in'event and clk_in='1' then 
				led_sun_sig<=led_sun_sig+1;
			end if;
		end process;
led_out<=led_sun_sig;
end a;