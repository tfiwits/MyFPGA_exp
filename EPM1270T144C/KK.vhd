library ieee;
use ieee.std_logic_1164.all;

entity kk is
port(
		clk_in: in std_logic;
		led_out:out std_logic_vector(7 downto 0)
);
end kk;

architecture a of kk is
signal ss : std_logic_vector(7 downto 0):="01010101";
signal sa : std_logic:='0';

begin
	process(clk_in)
	variable dd : integer:=7;
		begin
			IF clk_in'event and clk_in='1' then
				sa<=ss(dd);
				dd:=dd-1;
				led_out(dd)<=sa;
			end if;
	end process;
 
end a;
