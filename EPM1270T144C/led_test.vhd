library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity led_test is 
port(
		led_com : out std_logic_vector(3 downto 0);
		led_out : out std_logic_vector(7 downto 0)
);
end led_test;

architecture a of led_test is
signal led_sig : std_logic_vector (3 downto 0);
begin
led_com<="0001";
led_out<="10000000";
end a;