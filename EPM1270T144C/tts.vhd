library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
entity tts is 
port(	
		clk_in : in std_logic;
		sw_in : in std_logic_vector(6 downto 0);
		dc_out: out std_logic_vector(1 downto 0):="01";
		sw_ck_in : in std_logic
);
end tts;

architecture a of tts is
signal sw_st: std_logic_vector(6 downto 0);
signal dc_sig :std_logic:='0';
signal dc_out_sig: std_logic_vector(1 downto 0);
signal dc_pwm : std_logic;
begin

	process(sw_in,clk_in)
		begin
			if clk_in'event and clk_in='1' then 
				sw_st<=sw_st+1;
			end if;
			if sw_ck_in='1' then 
				dc_out_sig<=dc_sig & dc_pwm ;
			else
				dc_out_sig<=dc_pwm & dc_sig ;
			end if;
	end process;

dc_pwm<='1' when sw_st>sw_in else '0';
dc_out<=dc_out_sig;
end a;