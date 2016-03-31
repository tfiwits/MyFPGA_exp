library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity led_p is 
port(
		clk_in:in std_logic;
		rst:in std_logic;
		led_out:out std_logic_vector(7 downto 0)
);
end led_p;

architecture a of led_p is
signal sta : std_logic:='0';
signal clk_sig:std_logic;
signal led_st:std_logic_vector(3 downto 0):="0000"; 
signal led_sig: std_logic_vector(7 downto 0):="00000001";
begin
	process(clk_in)
	variable st:integer range 0 to 12500000 :=0;
		begin
			if clk_in'event and clk_in='1' then 
				if st/=12500000 then 
					st:=st+1;
				else
					clk_sig<=not clk_sig;
					st:=0;
				end if;
			end if;
	end process;
	process(rst,clk_sig)
		begin
			if rst='0' then 
				led_st<="0000";
				led_sig<="00000001";
				sta<='0';
			else
				if clk_sig'event and clk_sig='1' then  
					case sta is 
						when '0'=>
							if led_st/="0111" then 
								led_sig<=led_sig(6 downto 0) & led_sig(7);
								led_st<=led_st+1;
							else
								led_sig<=led_sig(0) & led_sig(7 downto 1);
								led_st<="0000";
								sta<='1';
							end if;
						when '1'=>
							if led_st/="0110" then 
								led_sig<=led_sig(0) & led_sig(7 downto 1);
								led_st<=led_st+1;
							else
															led_sig<=led_sig(6 downto 0) & led_sig(7);
								led_st<="0000";
								sta<='0';
							end if;
					end case;
				end if;
			end if;
	end process;
	led_out<=led_sig;
end a;