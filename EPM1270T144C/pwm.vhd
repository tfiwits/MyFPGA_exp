library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity pwm is 
port(
		clk_in : in std_logic;
		sw_in : in std_logic_vector(7 downto 0);
		pwm_out : out std_logic
		
);
end pwm;

architecture a of pwm is 
signal sw_sig : std_logic_vector(7 downto 0);
begin
	process(clk_in)
		begin
			if clk_in'event and clk_in='1' then 
				sw_sig<=sw_sig+1;
			end if;
	end process;
pwm_out<='1' when sw_sig>sw_in else '0';
end a;
