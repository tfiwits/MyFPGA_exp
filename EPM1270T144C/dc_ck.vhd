library ieee;
use ieee.std_logic_1164.all;
entity dc_ck is 
port(	
		dc_out: out std_logic_vector(1 downto 0):="01";
		sw_ck_in : in std_logic
);
end dc_ck;

architecture a of dc_ck is
signal dc_out_sig: std_logic_vector(1 downto 0);
begin

	process(sw_ck_in)
		begin
			if sw_ck_in='1' then 
				dc_out_sig<="01";
			else
				dc_out_sig<="10";
			end if;
	end process;

dc_out<=dc_out_sig;
end a;