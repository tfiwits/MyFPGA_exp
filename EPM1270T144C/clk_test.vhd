library ieee;
use ieee.std_logic_1164.all;

entity clk_test is
generic(clk_math:integer:=1);
port(
		clk_in : in std_logic;
		clk_out_1hz: out std_logic
);
end clk_test;

architecture a of clk_test is
 signal clk_out_sig:std_logic:='0'; 
begin
	process(clk_in)
	variable clk_sig : integer range 0 to clk_math;
		begin
			if clk_in'event and clk_in='1' then 
				clk_sig:=clk_sig+1;
				if clk_sig=clk_math then
					clk_out_sig<=not clk_out_sig;
					clk_sig:=0;
				end if;
			end if;

	end process;
clk_out_1hz<=clk_out_sig;
end a; 