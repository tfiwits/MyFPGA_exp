library ieee;
use ieee.std_logic_1164.all;

entity two_te is 
port(
		a: out std_logic_vector(1 downto 0)
);
end two_te;

architecture a of two_te is
begin
	a<="01";
end a;