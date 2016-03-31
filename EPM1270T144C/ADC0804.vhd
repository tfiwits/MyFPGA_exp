library ieee;
use ieee.std_logic_1164.all;

entity ADC0804 is 
port(
		clk_in : in std_logic;
		sw: in std_logic;
		CS: out std_logic;
		WR: out std_logic;
		RD: out std_logic;
		INTR:in std_logic;
		Data_in:in std_logic_vector(7 downto 0);
		Data_out: out std_logic_vector(7 downto 0)
);
end ADC0804;

architecture a of ADC0804 is
signal sta : std_logic_vector(1 downto 0);
	begin
		process(sta)
			begin
				case sta is
					when "00"=>
						cs<='0';
						wr<='0';
						rd<='1';
						if sw='1' then 
							sta<="01";
						end if;
					when "01"=>
						cs<='0';
						wr<='1';
						rd<='1';
						sta<="10";
					when "10"=>
						if intr='0' then
							cs<='1';
							wr<='1';
							rd<='1';
							sta<="11";
						end if;
					when "11"=>
						cs<='0';
						rd<='0';
						wr<='1';
						Data_out<=Data_in;
						sta<="00";
				end case;
		end process;
end a;