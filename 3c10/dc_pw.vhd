library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all; 

entity dc_pw is 
port(
		clk_in:in std_logic;
		rts:in std_logic;
		sw_in:in std_logic;
		pwm_out:out std_logic
);
end dc_pw;

architecture pwm of dc_pw is 
signal n:integer range 0 to 10:=0;
signal clk_sig:std_logic;
signal pwm_clk_sig:integer range 0 to 12500000:=0;
signal pwm_sig:integer range 0 to 250000:=0;
	begin
		process(clk_in)
			begin
				if clk_in'event and clk_in='1' then
					if pwm_clk_sig=12500000 then
						clk_sig<=not clk_sig;	 
						pwm_clk_sig<=0;
					else
						pwm_clk_sig<=pwm_clk_sig+1;
					end if;
				end if;
		end process;
		process(clk_in) 
			begin
				if clk_in'event and clk_in='1' then 
					if pwm_sig=250000 then
						pwm_sig<=0;
					else
						pwm_sig<=pwm_sig+1;
					end if;
				end if;
		end process;
		process(clk_sig)
			begin
				if clk_sig'event and clk_sig='1' then 
					if n=10 then
						n<=0;
					else
						n<=n+1;
					end if;
				end if;
		end process;
		pwm_out<='1' when pwm_sig<n*25000 else '0';
end pwm;