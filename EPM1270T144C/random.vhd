library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;


entity random is 
port(
		clk_in,key_in,clk_in_ck,clk_in_t : in std_logic;
		led_out_s,led_out_t,led_com : out std_logic_vector(3 downto 0)
);
end random;

architecture a of random is
signal led_sig : std_logic;
signal led_sig_s : std_logic_vector(3 downto 0):="0000";
signal led_sig_t : std_logic_vector(3 downto 0):="0000";
begin
	process(key_in,clk_in,clk_in_t)
		begin
			if key_in='1' then 
				if clk_in'event and clk_in='1' then
					led_sig_s<=led_sig_s+1;
						if led_sig_s="1001" then 
							led_sig_s<="0000";
						end if;
				end if;
				if clk_in_t'event and clk_in_t='1' then
					led_sig_t<=led_sig_t+1;
						if led_sig_t="0100" then 
							led_sig_t<="0000";
						end if;
				end if;
					led_out_s<=led_sig_s;led_out_t<=led_sig_t;
			end if;
	end process;
	process(clk_in_ck)
		begin 
				if clk_in_ck'event and clk_in_ck='1' then
					led_sig<=not led_sig;
				end if;
	end process;
with led_sig select
 led_com<="0001" when '0',
		  "0010" when '1',
		  "0000" when others;
end a; 