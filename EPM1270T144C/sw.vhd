library ieee;
use ieee.std_logic_1164.all;
 
entity sw is 
port(
		sw_in: in std_logic_vector(7 downto 0);
		sw_out : out std_logic_vector(7 downto 0)
);
end sw;

architecture a of sw is 
	begin
				sw_out<=sw_in;
end a;