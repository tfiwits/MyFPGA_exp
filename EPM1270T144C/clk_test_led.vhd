library ieee;
use ieee.std_logic_1164.all;

entity clk_test_led is 
port(
		clk_in : in std_logic;
		led_out: out std_logic
);
end clk_test_led;

architecture a of clk_test_led is

component clk_test
generic(clk_math: integer:=1);
port(
		clk_in: in std_logic;
		clk_out_1hz: out std_logic
);
end component;
signal led_sig,clk_in_sig : std_logic:='0'; 
	begin
	a1:clk_test
		generic map(25000000)
		port map(clk_in,clk_in_sig);
			process(clk_in)
				begin
					if clk_in_sig'event and clk_in_sig='1' then 
						led_sig<=not led_sig;
					end if;
			end process;
led_out<=led_sig;
end a;