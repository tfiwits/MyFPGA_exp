library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity pw is 
port(
		clk_in,sw_in: in std_logic;
		pw_out: out std_logic_vector(3 downto 0)
);
end pw; 

architecture a of pw is
signal pw_sig : std_logic_vector(3 downto 0):="0001";
	begin
		process(clk_in,sw_in)
			begin
				if clk_in'event and clk_in='1' then 
					if sw_in='1'then 
						pw_sig<=pw_sig(2 downto 0) & pw_sig(3);
					else
						pw_sig<=pw_sig(0) & pw_sig(3 downto 1);
					end if;
				end if;
		end process;
pw_out<=pw_sig;
end a;